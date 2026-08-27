# Identity and permissions

## Standard official flow

1. Register as a developer and complete enterprise identity requirements.
2. Create the application for the correct business type.
3. Complete application review.
4. Obtain AppKey/AppSecret and store them outside Skill files, project files, logs, and reports.
5. Request the required interface permission package.
6. Obtain user authorization through OAuth2 when required.
7. Use the official SDK or documented signed gateway request.
8. Validate in test state, then publish according to the platform rules.

## Business identities

| Identity | Meaning | Typical scope |
|---|---|---|
| `vender` | shop / POP merchant | the authorized shop |
| `supplier` | VC self-operated supplier code | the authorized supplier entity |
| `userPin` | supplier account | the authorized supplier account |

Interface existence is not entitlement. Mark every capability as one of:

- `documented_candidate`: official interface page found;
- `permission_visible`: interface appears in the current application's permission scope;
- `authenticated_success`: minimum call succeeded;
- `production_verified`: expected data and metric scope verified;
- `unavailable`: unsupported identity, missing permission, retired interface, or failed validation.

Never downgrade from `unavailable` to browser private requests. Use Shangzhi export or user files instead.
