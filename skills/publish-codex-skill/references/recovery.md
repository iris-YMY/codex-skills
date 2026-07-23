# Idempotent GitHub recovery

Load this reference only after a Git or GitHub write reports a timeout, disconnect, empty response, or another ambiguous result.

## Branch push

1. Record the intended local commit SHA.
2. Query the exact remote head with `git ls-remote --heads origin <branch>`.
3. If the remote SHA matches, treat the push as successful.
4. If the ref is absent or differs, retry the same push without changing the commit.
5. For repeated HTTP/2 transport failures, retry once with `git -c http.version=HTTP/1.1 push -u origin <branch>`.

Never force push as a recovery shortcut.

## Draft PR

Before retrying creation, query open and closed PRs for the exact head branch and repository. Reuse the existing PR when found. Create a new Draft PR only when no matching PR exists.

## Final verification

Confirm repository visibility, remote branch SHA, Draft status, base/head branches, and changed files. A successful command exit alone is insufficient when an earlier result was ambiguous.
