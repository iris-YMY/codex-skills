# Brief：在 Windows 上为 Codex 接入飞书私聊机器人

## 目标

在当前 Windows 用户会话中运行“飞书私聊 → 本机 Codex CLI → 飞书回复”桥接。第一版仅响应白名单用户的 `p2p` 文本消息，支持连续对话、`/new` 和 `/status`。

## 安全边界

- Codex 固定使用 `read-only` 沙箱和独立的空工作目录。
- 只允许配置文件中的飞书 `open_id`；群聊和其他发送者直接忽略。
- 不记录 App Secret、access token、完整消息正文或完整授权响应。
- 使用 `event_id` 去重，最多保存 1000 条；回复使用稳定幂等键。
- 每个 `chat_id` 串行处理，避免同一 Codex 会话并发恢复。
- 不使用未经当前 Codex 版本验证的内部 HTTP provider。

## 目录

```text
C:\Users\jm014934\AppData\Local\LarkCodexBridge\
├── bridge.py
├── config.json
├── run-bridge.cmd
├── workspace\
├── state\
│   ├── sessions.json
│   └── processed.json
└── logs\
```

状态文件必须以“临时文件写入后原子替换”的方式保存。配置文件只保存非敏感参数；凭据由官方 Lark CLI 自己管理。

## 1. 安装官方飞书 CLI

使用飞书官方 npm 包：

```powershell
npx @larksuite/cli@latest install
lark-cli --version
```

不得安装名称相近的第三方包。安装后记录 `lark-cli` 的绝对路径，常驻任务不依赖交互式 shell 的 PATH。

## 2. 配置应用与授权

```powershell
lark-cli config init --new
lark-cli auth login --recommend
lark-cli auth status
lark-cli doctor
```

命令给出网页链接时，由用户在浏览器中创建或选择飞书应用并完成授权。确认机器人能力、应用可用范围和以下权限：

- 订阅 `im.message.receive_v1`
- `im:message.p2p_msg:readonly`
- 发送及回复消息所需权限
- `im:message.reactions:write_only`

## 3. 飞书能力验证

```powershell
lark-cli event consume im.message.receive_v1 --as bot --timeout 10s
lark-cli im +messages-send --as bot --user-id <OPEN_ID> --text "桥接测试"
lark-cli im +messages-reply --as bot --message-id <MESSAGE_ID> --text "回复测试"
```

必须看到事件消费者 ready/connected，并实际完成一次接收、主动发送和原消息回复。

## 4. Codex 调用验证

使用桌面应用附带的 Codex CLI，并将绝对路径写入配置。新会话：

```powershell
codex exec --skip-git-repo-check --ignore-user-config `
  -C <ISOLATED_WORKSPACE> -s read-only --json `
  -o <LAST_MESSAGE_FILE> -
```

解析 JSONL 中的会话 ID并保存。恢复会话前必须实测确认当前版本会继承原会话的工作目录和只读沙箱；如果无法证明，则桥接程序不得启用连续会话。

## 5. 桥接行为

1. 启动 `lark-cli event consume im.message.receive_v1 --as bot` 子进程。
2. 逐行解析 NDJSON，校验 `p2p`、白名单和 `event_id`。
3. `/status` 本地回复；`/new` 原子删除当前会话映射。
4. 普通消息添加临时 `Typing` reaction，同时调用 Codex。
5. 将最长约 5500 字符的回复分片，以稳定且不同的幂等键回复原消息。
6. 无论成功或失败，在 `finally` 中删除机器人创建的 reaction。
7. 子进程退出时采用有限指数退避重启，避免无限高速重启。

## 6. Windows 常驻任务

使用 Windows 任务计划程序创建当前用户任务 `LarkCodexBridge`：

- 用户登录时启动；
- 运行 `run-bridge.cmd` 的绝对路径；
- 工作目录固定为桥接目录；
- 失败后按间隔重试；
- 不在任务参数中保存密钥；
- 不强制终止仍在优雅退出的实例；
- 日志写入 `logs`，并限制大小和保留数量。

## 7. 验收

依次验证事件 ready/connected、主动发送、`/status`、普通提问、Typing reaction、Codex 正文回复、reaction 清理、事件去重、会话映射、`/new`、任务计划程序重启恢复。最终明确说明第一版不支持群聊、附件理解或写入本机文件。
