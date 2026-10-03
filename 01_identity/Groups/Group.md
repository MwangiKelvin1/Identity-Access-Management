# Group 

A Group is a container of users or identities that can be assigned security privileges or restrictions. Often used to control access to specific shared resource to a set of accounts instead of assigning individually.

For example, instead of assigning the same access to 20 Finance employees one by one, an administrator can create a Finance group, add the employees to it, and manage the group as a unit.

```text
Individual management

Alice  → Access
Brian  → Access
David  → Access
Grace  → Access
Peter  → Access


Group-based management

Alice  ─┐
Brian  ─┤
David  ─┤
Grace  ─┤→ FT-Finance-Users → Access
Peter  ─┘
```

The group becomes the common management point for its members.

---

# 1. Why do we use Groups?

Groups make identity administration easier when several identities require the same treatment.

Without groups, an administrator may need to configure the same setting repeatedly:

```text
User 1 → configure
User 2 → configure
User 3 → configure
User 4 → configure
User 5 → configure
```

With a group:

```text
User 1 ─┐
User 2 ─┤
User 3 ─┤→ Group → configure once
User 4 ─┤
User 5 ─┘
```

Groups can therefore help with:

* Organizing identities
* Managing access collectively
* Assigning licenses
* Managing application access
* Applying supported configurations to multiple members
* Reducing repetitive administration
* Supporting department-based access structures
* Automating membership through rules

---

# 2. Group Types

Microsoft Entra ID provides different group types.

The two major group types are:

1. **Security groups**
2. **Microsoft 365 groups**

They serve different purposes.

---

# 3. Security Groups

A **Security group** is primarily used to manage *access* and permissions for a collection of identities.

Security groups can contain supported members such as:

* Users
* Devices
* Service principals and other supported identities, depending on the scenario

A security group can be used as a common target when **access** needs to be managed for multiple members.

### Example

FinTrust has several employees in the Finance department.

Instead of individually managing:

```text
Alice
Brian
David
Grace
Peter
```

FinTrust creates:

```text
FT-Finance-Users
```

The Finance employees can then be members of that group.

```text
Alice ─┐
Brian ─┤
David ─┤
Grace ─┤→ FT-Finance-Users
Peter ─┘
```

Situations:
* Finance staff must access the Finance app"
* Give everyone in IT a license
* Require MFA for all staff
* 


The administrator can manage the group rather than repeatedly managing every employee.

---

# 4. Microsoft 365 Groups

A **Microsoft 365 group** is designed primarily for *collaboration*.

It can provide a shared membership model for Microsoft 365 collaboration services to users only; no devices, no nesting groups.

Depending on the services enabled and how the group is used, Microsoft 365 groups can be associated with resources such as:

* Microsoft Teams
* SharePoint
* Outlook
* Planner

The important distinction is:

```text
Security Group
      ↓
Primarily access and permission management(For access not limited to Azure Resources)

Microsoft 365 Group
      ↓
Primarily collaboration (Microsoft 365 apps)
```
Situations:
* The Loans team needs a Teams channel and shared files

The administrator should therefore understand the purpose of the group before choosing its type.

---

# 5. Security Group vs Microsoft 365 Group

| Feature                 | Security Group                    | Microsoft 365 Group                      |
| ----------------------- | --------------------------------- | ---------------------------------------- |
| Main purpose            | Access and security management    | Collaboration                            |
| Common use              | Permissions and access            | Teams, SharePoint, Outlook collaboration |
| Users can be members    | Yes                               | Yes                                      |
| Devices can be members  | Supported in applicable scenarios | Not generally used as device groups      |
| Dynamic membership      | Supported                         | Supported                                |
| Group-based licensing   | Supported                         | Supported                                |
| Collaboration resources | Not its primary purpose           | Yes                                      |
| Best suited for         | Security/access scenarios         | Collaboration scenarios                  |

The key question is:

> **What is the purpose of the group?**

If the purpose is primarily security and access management, a **Security group** is commonly appropriate.

If the purpose is collaboration around shared Microsoft 365 resources, a **Microsoft 365 group** may be appropriate.

---

# 6. Group Membership

**Membership** determines which identities belong to a group.

For example:

```text
FT-HR-Users

Members:
- Mary Achieng
- James Mwangi
- Grace Njeri
```

The members inherit whatever group-based configuration or access is associated with that group.

Membership can be managed in different ways.

The two important membership types for SC-300 are:

* Assigned
* Dynamic

---

# 7. Assigned Membership

With **Assigned membership**, an administrator or authorized group manager manually adds or removes members.

Example:

```text
FT-IT-Users

Members:
- Brian Otieno
- David Kamau
- Peter Kariuki
```

If a new employee joins IT:

```text
New employee
      ↓
Administrator adds employee
      ↓
FT-IT-Users
```

If the employee leaves IT:

```text
Employee
      ↓
Administrator removes employee
      ↓
FT-IT-Users
```

The administrator directly controls membership.

---

# 8. Advantages of Assigned Membership

Assigned membership is useful when:

* Membership is small
* Membership does not follow a predictable attribute
* Administrators need direct control
* Membership changes are relatively infrequent
* A group contains specific individuals selected manually

Example:

```text
FT-SC300-Lab-Users

Members:
- Alice
- Brian
- David
```

The administrator deliberately chooses the members.

---

# 9. Dynamic Membership

With **Dynamic membership**, Microsoft Entra can automatically determine group membership using rules.

Instead of manually adding every user, the administrator defines a membership rule. Click Here to learn more about the rules in dynamic membership.

[Click Here to learn more about the rules in dynamic membership.](<Dynamic Group.md>)

For example:

```text
Department = "Finance"
```

Microsoft Entra evaluates the users against the rule.

```text
User attributes
      ↓
Membership rule
      ↓
Microsoft Entra evaluates users
      ↓
Matching users become members
```

For example:

```text
Rule:

user.department -eq "Finance"
```

Users whose department attribute matches the rule can become members of the group.

---

# 10. Dynamic Group Example

FinTrust has:

```text
Alice
Department = Finance

Brian
Department = IT

Mary
Department = HR

Peter
Department = Finance
```

The administrator creates:

```text
FT-Finance-Dynamic
```

with a rule based on the department:

```text
Department = Finance
```

The resulting membership becomes:

```text
FT-Finance-Dynamic

Members:
- Alice
- Peter
```

Brian and Mary are not members because their department values do not match the rule.
---

# 11. Dynamic Membership Changes

One of the major benefits of dynamic membership is that membership can change when the attributes used by the rule change.

Suppose:

```text
Alice
Department = Finance
```

Alice is therefore a member of:

```text
FT-Finance-Dynamic
```

If Alice's department changes to:

```text
IT
```

Microsoft Entra can reevaluate the rule.

The result can become:

```text
FT-Finance-Dynamic

Alice → removed
```

Alice may then become a member of a dynamic IT group if a corresponding rule exists.

This creates an automated relationship:

```text
User attribute
      ↓
Dynamic rule
      ↓
Group membership
```

---

# 12. Assigned vs Dynamic Membership

#### Key rules: 

* A group has one membership type. You cannot mix manual and rule-based members: in a dynamic group you cannot add or remove members by hand.
* A dynamic group is either user or device, never both.
* You can convert between assigned and dynamic membership for security groups and M365 groups. Existing members are re-evaluated against the rule when switched to dynamic.
* Role-assignable groups cannot be dynamic.
* Rule results are not instant. Processing can take minutes to hours in a large tenant. Check the group's Dynamic membership rules page for processing status.
* The portal has a Validate Rules tab to test a rule against specific users before saving.
* Membership processing can be set to On or Paused. Pausing freezes the current membership.

| Area                              | Assigned              | Dynamic                 |
| --------------------------------- | --------------------- | ----------------------- |
| Membership                        | Manually managed      | Automatically evaluated |
| Administrator adds members        | Yes                   | Usually unnecessary     |
| Administrator removes members     | Yes                   | Usually unnecessary     |
| Uses membership rules             | No                    | Yes                     |
| Suitable for changing populations | Less automated        | More automated          |
| Requires accurate attributes      | Not necessarily       | Yes                     |
| Example                           | Selected project team | All Finance users       |

The most important distinction is:

> **Assigned membership is manually controlled, while dynamic membership is rule-based.**

---

# 13. Group Owners

A **group owner** is a user responsible for managing aspects of a group.

Owners can help manage the group without requiring every group-management task to be performed by a central administrator.

For example:

```text
Group:
FT-Finance-Users

Owner:
Alice Wanjiku
```

The owner may have appropriate permissions to manage membership and other group properties, depending on the group configuration and assigned permissions.

---

# 14. Group Members

A **member** is an identity that belongs to the group.

Example:

```text
Group:
FT-Finance-Users

Owner:
Alice Wanjiku

Members:
- Brian Otieno
- David Kamau
- Grace Njeri
- Peter Kariuki
```

Owner and member are different concepts.

```text
Owner
  ↓
Manages the group

Member
  ↓
Belongs to the group
```

A user can potentially be both an owner and a member.

---

# 15. Owners vs Members

| Role   | Meaning                |
| ------ | ---------------------- |
| Owner  | Helps manage the group |
| Member | Belongs to the group   |

Example:

```text
FT-HR-Users

Owner:
Mary Achieng

Members:
- James Mwangi
- Grace Njeri
- Peter Kariuki
```
| **Area** | **Owners** | **Members** |
|---|---|---|
| **Role** | Manage the group | Belong to the group |
| **Can edit group settings** | Yes | No |
| **Can add/remove members in assigned groups** | Yes | No |
| **Gets the group's access** | Only if also a member | Yes |
| **Can be** | Users and service principals | Users, devices, service principals, and groups in supported security-group scenarios |

Mary is responsible for managing the group, while the listed users are members.

The same person could also appear as a member if required.

Owner guidance:

* Owners are not automatically members. Add them as members too if they need the access.
* Give every group at least two owners so ownership survives someone leaving. Ownerless groups are an audit finding.
* Owners should be the business people who know who belongs (e.g. the HR manager owns the HR group), not only IT.
* Dynamic groups: owners can edit the rule and settings, but cannot add members by hand.
* Role-assignable groups are tightly restricted: only highly privileged admins (Global Administrator, * Privileged Role Administrator) can manage them.
* Who may create groups is a tenant setting (Groups > General): you can restrict users from creating security groups or M365 groups.

---

# 16. Group-Based Licensing

Groups can also be used for **group-based licensing**.

Instead of assigning a license individually:

```text
Alice → License
Brian → License
David → License
Grace → License
```

a license can be associated with a supported group:

```text
FT-Employees
      ↓
License
      ↓
Members receive the license
```

When users become members of the group, the license assignment can be applied according to the group's licensing configuration.

When membership changes, licensing can change accordingly.

---

# 17. Group-Based Licensing Example

FinTrust wants a particular Microsoft license assigned to Finance employees.

The organization has:

```text
FT-Finance-Users
```

The group contains:

```text
Alice
Brian
David
Grace
```

The administrator configures the supported license assignment for the group.

The relationship becomes:

```text
FT-Finance-Users
        ↓
License assignment
        ↓
Group members
```

If another employee becomes a member, that employee can receive the group-based license.

If a member is removed, the corresponding license assignment can be removed according to Microsoft's licensing rules and requirements.

---

# 18. Groups and Licensing: Important Idea

Group-based licensing separates:

```text
WHO receives the license
```

from:

```text
HOW the license is individually assigned
```

Instead of repeatedly assigning licenses to individual users, membership in the appropriate group becomes the basis for the assignment.

This is especially useful when an organization has many users.

---

# 19. Nested Groups

A **nested group** is a group that contains another group as a member.

For example:

```text
FT-All-Finance
      ↓
FT-Finance-Managers
      ↓
Users
```

Conceptually:

```text
Parent Group
    ↓
Child Group
    ↓
Users
```

Nested groups can help organize group structures, but they must be designed carefully because support and behavior can differ depending on the specific Entra feature being used.

---

# 20. Example of Group Nesting

FinTrust has:

```text
FT-Finance-Users
FT-Finance-Managers
```

The organization may have a broader group containing a more specific group:

```text
FT-Finance
   ├── FT-Finance-Users
   └── FT-Finance-Managers
```

The structure helps represent organizational relationships.

However, administrators should not assume that every Entra feature automatically follows every nested membership relationship.

#### Where Nesting Works and Where It Does Not

| **Scenario** | **Nested Membership Honoured?** | **What It Means** |
|---|---|---|
| **Azure RBAC role assignment** | **Yes** | Users can receive the assigned role through supported nested group membership. |
| **Group membership listing** | **Yes** | Transitive membership views can show users who belong through nested groups. |
| **Group-based licensing** | **No** | Only direct members of the licensed group receive the license. |
| **App assignment — Enterprise applications** | **No** | Assign the application to the group that directly contains the users. |
| **Role-assignable groups** | **No** | Role-assignable groups cannot contain other groups; users do not inherit roles through group nesting. |
| **Microsoft 365 groups** | **No** | Microsoft 365 groups cannot be nested inside other groups. |
| **Conditional Access targeting** | **Verify before relying on it** | Do not assume nested membership will work for the specific Conditional Access scenario; test and verify the current tenant behavior. |


Design guidance: 
* Nest for organisation, not for convenience. Deep nesting makes "why does this user have access?" hard to answer.
* Keep nesting shallow (one level is usually enough).
* Never nest groups where a feature does not honour it (licensing and app assignment are the classic traps).
* Prefer a dynamic parent group over a nested hierarchy for "everyone in X".

```text
Exam tip: "Users in a nested group are not getting a license / app access" is a standard scenario. The fix is to add users directly to the group that holds the license/assignment, or assign the license/app to the child group.
```
Always check the supported membership and nesting behavior for the specific feature.

---

# 21. Group Naming

A consistent naming standard makes groups easier to identify and manage.

FinTrust uses:

```text
FT-
```

as the organizational prefix.

Examples:

```text
FT-Finance-Users
FT-HR-Users
FT-IT-Users
FT-Cybersecurity-Users
FT-Loans-Users
FT-CustomerSupport-Users
FT-Management-Users
```

Dynamic groups can also be identified clearly:

```text
FT-Finance-Dynamic
FT-IT-Dynamic
FT-HR-Dynamic
```

The name should communicate the group's purpose.

---

# 22. Group Naming Components

A useful naming structure is:

```text
Organization - Department - Purpose
```

For example:

```text
FT-Finance-Users
```

means:

```text
FT
↓
FinTrust

Finance
↓
Department

Users
↓
Purpose
```

Another example:

```text
FT-Finance-Dynamic
```

communicates:

```text
FT
↓
FinTrust

Finance
↓
Target population

Dynamic
↓
Membership method
```

---