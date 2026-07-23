# Codex 桌面端 Reconnecting（1/5–5/5）Windows 诊断与修复任务

请在当前 Windows 电脑上执行本任务。目标是诊断并修复 Codex 桌面端未正确继承本机代理，导致 WebSocket 长连接反复重连的问题。

## 安全与执行原则

1. 先诊断、后修改，不直接套用示例端口。
2. 只使用真实处于监听状态且能确认属于 Clash Verge、Clash、Mihomo、FlClash 等代理软件的端口。
3. 区分 HTTP、SOCKS、mixed、控制、DNS 和 API 端口；不得把控制端口或 DNS 端口作为代理端口。
4. 修改用户环境变量前记录原值；如果已有非空值，先导出备份。
5. 不显示、覆盖或删除无关密钥、令牌和配置。
6. 多个候选端口或协议无法确认时停止修改并报告。

## 第一步：诊断

检查以下项目：

- 当前进程、用户级和系统级的 `HTTP_PROXY`、`HTTPS_PROXY`、`ALL_PROXY`、`NO_PROXY` 及小写变量。
- Windows 系统代理：`HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings`。
- WinHTTP 代理：`netsh winhttp show proxy`。
- Clash、Mihomo、FlClash、V2Ray、Xray、sing-box 等代理进程。
- 本机监听端口及其 PID，重点检查 `7890–7899`、`1080`、`1087`、`8080`，但以实际监听结果为准。

可使用：

```powershell
Get-ChildItem Env: | Where-Object Name -match '^(?i)(HTTP_PROXY|HTTPS_PROXY|ALL_PROXY|NO_PROXY)$'
Get-Process | Where-Object ProcessName -match 'clash|mihomo|flclash|verge|v2ray|xray|sing-box'
Get-NetTCPConnection -State Listen
netstat -ano
Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings'
netsh winhttp show proxy
```

## 第二步：确认代理

将监听端口 PID 与代理进程对应。若代理提供 HTTP 或 mixed 端口，以 `127.0.0.1:<PORT>` 作为代理地址。通过 HTTP `CONNECT chatgpt.com:443` 或等效的短超时 HTTPS 请求进行验证。未获得成功响应时不要修改配置。

## 第三步：写入用户环境变量

Windows 桌面应用通常从启动它的用户环境继承代理。确认端口后，写入以下用户级变量，不修改系统级变量：

```text
HTTP_PROXY=http://127.0.0.1:<PORT>
HTTPS_PROXY=http://127.0.0.1:<PORT>
ALL_PROXY=http://127.0.0.1:<PORT>
NO_PROXY=localhost,127.0.0.1,::1
http_proxy=http://127.0.0.1:<PORT>
https_proxy=http://127.0.0.1:<PORT>
all_proxy=http://127.0.0.1:<PORT>
no_proxy=localhost,127.0.0.1,::1
```

使用 `[Environment]::SetEnvironmentVariable(<名称>, <值>, 'User')` 写入。完成后重新读取用户级变量并确认端口，同时确认代理进程仍在监听。不要把代理凭据写入日志。

> 不把 `~/.codex/.env` 作为默认修复入口，除非当前 Codex 版本的官方说明明确确认会读取该文件。

## 第四步：重启与复查

报告代理程序、真实端口、原环境变量、备份位置和最终变更。提醒用户完全退出并重新打开 Codex；使用 VS Code Codex 插件时也要完全重启 VS Code。不要代替用户强制关闭应用。

如果重启后仍出现以下日志，继续只读检查 DNS、公司网络策略、TLS/HTTPS 解密和 WebSocket 拦截，不要反复更换端口：

```text
stream disconnected - retrying sampling request (1/5 ... 5/5)
failed to connect to wss://chatgpt.com/... after 30s
```
