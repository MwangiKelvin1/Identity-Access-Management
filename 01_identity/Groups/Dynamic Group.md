### Anatomy of a Rule

| Component | Example | Purpose |
|---|---|---|
| **Property** | `user.department` | Attribute being evaluated |
| **Operator** | `-eq` | Comparison being performed |
| **Value** | `"Finance"` | Value the property is compared against |
| **Joiner** | `-and` / `-or` | Combines multiple conditions |

Example:

```text
(user.department -eq "Finance") and (user.accountEnabled -eq true)
       └─ Property ─┘ └Operator┘ └Value┘
                                           └──── Joiner ────┘

 | Method                   | Description                                                                                     | When to use                                                                          |
| ------------------------ | ----------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| **Basic rule builder**   | Select **Property**, **Operator**, and **Value**, then combine conditions with **And** / **Or** | Simple rules with a limited number of expressions                                    |
| **Rule syntax text box** | Enter the dynamic membership expression directly                                                | Complex rules, many expressions, `-match`, multi-value properties, `-any`, or `-all` |



| Operator       | Meaning                                    | Example                                             |
| -------------- | ------------------------------------------ | --------------------------------------------------- |
| `-eq`          | Equals                                     | `user.department -eq "HR"`                          |
| `-ne`          | Not equals                                 | `user.department -ne "HR"`                          |
| `-startsWith`  | Begins with                                | `user.displayName -startsWith "FT-"`                |
| `-contains`    | Contains a substring                       | `user.jobTitle -contains "Manager"`                 |
| `-notContains` | Does not contain a substring               | `user.jobTitle -notContains "Intern"`               |
| `-match`       | Matches a regular expression               | `user.mail -match ".*@fintrust.*"`                  |
| `-notMatch`    | Does not match a regular expression        | `user.mail -notMatch ".*@fintrust.*"`               |
| `-in`          | Value exists in a list                     | `user.department -in ["Finance","Loans"]`           |
| `-notIn`       | Value does not exist in a list             | `user.department -notIn ["Finance","Loans"]`        |
| `-any`         | Tests values in a multi-value property     | `user.proxyAddresses -any (_ -contains "fintrust")` |
| `-all`         | Tests all values in a multi-value property | `user.proxyAddresses -all (_ -contains "fintrust")` |
| `-and`         | Both conditions must be true               | `(...) -and (...)`                                  |
| `-or`          | At least one condition must be true        | `(...) -or (...)`                                   |
| `-not`         | Negates a condition                        | `-not (...)`                                        |



| Goal                            | Type   | Dynamic Membership Rule                                              |
| ------------------------------- | ------ | -------------------------------------------------------------------- |
| All Finance users               | User   | `(user.department -eq "Finance")`                                    |
| Active Finance users only       | User   | `(user.department -eq "Finance") and (user.accountEnabled -eq true)` |
| Finance or Loans users          | User   | `(user.department -in ["Finance","Loans"])`                          |
| All employees, excluding guests | User   | `(user.userType -eq "Member") and (user.accountEnabled -eq true)`    |
| All guests                      | User   | `(user.userType -eq "Guest")`                                        |
| All managers                    | User   | `(user.jobTitle -contains "Manager")`                                |
| All Windows devices             | Device | `(device.deviceOSType -eq "Windows")`                                |
| Company-owned devices           | Device | `(device.deviceOwnership -eq "Company")`                             |



| Behaviour                  | What happens                                                                                                                                       |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Attribute changes**      | Membership can change when an attribute used by the rule changes.                                                                                  |
| **Department changes**     | A user can leave one dynamic group and enter another after membership processing.                                                                  |
| **Blank attributes**       | If a required attribute is blank, the user normally does not match a rule requiring a specific value.                                              |
| **Directory data quality** | Dynamic groups depend on accurate and populated directory attributes.                                                                              |
| **String values**          | String values should be enclosed in quotation marks, e.g. `"Finance"`.                                                                             |
| **Property names**         | Property names are case-insensitive.                                                                                                               |
| **Attribute values**       | Values should match the intended value exactly where exact comparison is used.                                                                     |
| **Negative rules**         | Rules using `-ne` or similar negative logic should be tested carefully because users with blank attributes may unexpectedly satisfy the condition. |
| **Evaluation**             | Dynamic membership is evaluated automatically according to the configured rule.                                                                    |
| **Approval**               | There is no approval step for dynamic membership.                                                                                                  |
| **Processing time**        | Membership changes occur after Microsoft Entra processes the dynamic membership rule.                                                              |


| Step  | Process                                         |
| ----- | ----------------------------------------------- |
| **1** | User or device has directory attributes         |
| **2** | Administrator creates a dynamic membership rule |
| **3** | Microsoft Entra evaluates the rule              |
| **4** | Matching identities become group members        |
| **5** | Attributes change                               |
| **6** | Microsoft Entra reevaluates membership          |
| **7** | Membership is updated according to the rule     |



Directory Attributes
        ↓
Dynamic Membership Rule
        ↓
Microsoft Entra Evaluation
        ↓
Group Membership
        ↓
Attribute Changes
        ↓
Re-evaluation
        ↓
Updated Membership















