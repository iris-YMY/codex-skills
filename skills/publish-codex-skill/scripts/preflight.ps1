[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$SkillPath,

    [Parameter(Mandatory = $true)]
    [string]$ValidatorPath
)

$ErrorActionPreference = 'Stop'
$resolvedSkill = (Resolve-Path -LiteralPath $SkillPath).Path
$resolvedValidator = (Resolve-Path -LiteralPath $ValidatorPath).Path
$excludedDirectories = @('.git', '.venv', 'venv', 'node_modules', '__pycache__', '.pytest_cache', '.mypy_cache', 'dist', 'build')
$blockedNames = @('.env', 'credentials.json')
$textExtensions = @('.md', '.txt', '.yaml', '.yml', '.json', '.toml', '.ps1', '.py', '.js', '.ts', '.sh')

$items = @(Get-ChildItem -LiteralPath $resolvedSkill -Force -Recurse)
$files = @($items | Where-Object { -not $_.PSIsContainer })
$directories = @($items | Where-Object { $_.PSIsContainer })
$findings = [System.Collections.Generic.List[object]]::new()

$fileInventory = foreach ($file in $files) {
    $relative = $file.FullName.Substring($resolvedSkill.Length).TrimStart('\', '/')
    [pscustomobject]@{
        path = $relative.Replace('\', '/')
        bytes = $file.Length
        sha256 = (Get-FileHash -Algorithm SHA256 -LiteralPath $file.FullName).Hash.ToLowerInvariant()
    }
}

foreach ($item in $items) {
    $relative = $item.FullName.Substring($resolvedSkill.Length).TrimStart('\', '/')
    if (($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
        $findings.Add([pscustomobject]@{ severity = 'block'; category = 'symlink_or_reparse_point'; path = $relative })
    }
}

foreach ($directory in $directories) {
    $relative = $directory.FullName.Substring($resolvedSkill.Length).TrimStart('\', '/')
    if ($directory.Name -eq '.git') {
        $findings.Add([pscustomobject]@{ severity = 'block'; category = 'nested_git_repository'; path = $relative })
    } elseif ($excludedDirectories -contains $directory.Name) {
        $findings.Add([pscustomobject]@{ severity = 'block'; category = 'generated_or_cache_directory'; path = $relative })
    }
}

foreach ($file in $files) {
    $relative = $file.FullName.Substring($resolvedSkill.Length).TrimStart('\', '/')
    if (($blockedNames -contains $file.Name) -or $file.Extension -in @('.pem', '.pfx', '.p12', '.key')) {
        $findings.Add([pscustomobject]@{ severity = 'block'; category = 'credential_shaped_file'; path = $relative })
    }

    if ($textExtensions -contains $file.Extension.ToLowerInvariant()) {
        try {
            $text = Get-Content -Raw -Encoding utf8 -LiteralPath $file.FullName
            if ($text -match '(?i)C:\\Users\\[^\\\s]+') {
                $findings.Add([pscustomobject]@{ severity = 'review'; category = 'user_specific_windows_path'; path = $relative })
            }
            if ($text -match '(?i)-----BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY-----') {
                $findings.Add([pscustomobject]@{ severity = 'block'; category = 'private_key_material'; path = $relative })
            }
            if ($text -match '(?i)(password|passwd|api[_-]?key|access[_-]?token|client[_-]?secret)\s*[:=]\s*[^\s<>{}\[\]]{8,}') {
                $findings.Add([pscustomobject]@{ severity = 'block'; category = 'credential_shaped_assignment'; path = $relative })
            }
        } catch {
            $findings.Add([pscustomobject]@{ severity = 'review'; category = 'utf8_read_failed'; path = $relative })
        }
    }
}

$previousErrorPreference = $ErrorActionPreference
$ErrorActionPreference = 'Continue'
$validationOutput = (& python $resolvedValidator $resolvedSkill 2>&1 | Out-String).Trim()
$validationExitCode = $LASTEXITCODE
$ErrorActionPreference = $previousErrorPreference
$result = [pscustomobject]@{
    skill_path = $resolvedSkill
    file_count = $files.Count
    total_bytes = ($files | Measure-Object -Property Length -Sum).Sum
    validation = [pscustomobject]@{
        passed = ($validationExitCode -eq 0)
        exit_code = $validationExitCode
        output = $validationOutput
    }
    findings = @($findings)
    files = @($fileInventory)
}

$result | ConvertTo-Json -Depth 6
if (($validationExitCode -ne 0) -or (@($findings | Where-Object { $_.severity -eq 'block' }).Count -gt 0)) {
    exit 2
}
