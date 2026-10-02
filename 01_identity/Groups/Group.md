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

# 1. Why Groups Are Used

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

A **Security group** is primarily used to manage access and permissions for a collection of identities.

Security groups can contain supported members such as:

* Users
* Devices
* Service principals and other supported identities, depending on the scenario

A security group can be used as a common target when access needs to be managed for multiple members.

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

The administrator can manage the group rather than repeatedly managing every employee.

---

# 4. Microsoft 365 Groups

A **Microsoft 365 group** is designed primarily for collaboration.

It can provide a shared membership model for Microsoft 365 collaboration services.

Depending on the services enabled and how the group is used, Microsoft 365 groups can be associated with resources such as:

* Microsoft Teams
* SharePoint
* Outlook
* Planner

The important distinction is:

```text
Security Group
      ↓
Primarily access and permission management

Microsoft 365 Group
      ↓
Primarily collaboration
```

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

Instead of manually adding every user, the administrator defines a membership rule.

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

Mary is responsible for managing the group, while the listed users are members.

The same person could also appear as a member if required.

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

# 23. Creating a Security Group

In the Microsoft Entra admin center, an administrator can create a group and configure properties such as:

* Group type
* Group name
* Group description
* Membership type
* Owners
* Members

A typical configuration might be:

```text
Group type:
Security

Group name:
FT-Finance-Users

Membership type:
Assigned
```

The administrator can then add the required members.

---

# 24. Creating a Microsoft 365 Group

A Microsoft 365 group can be created when the purpose is collaboration.

Example:

```text
Group type:
Microsoft 365

Name:
FT-Cybersecurity-Team
```

Members can then collaborate through supported Microsoft 365 services associated with the group.

The important point is to choose the group type based on the intended purpose.

---

# 25. Adding Members

Members can be added individually.

Example:

```text
FT-Finance-Users

Add:
Alice Wanjiku
```

The group then becomes:

```text
FT-Finance-Users
    └── Alice Wanjiku
```

Additional members can be added as needed.

---

# 26. Removing Members

Members can also be removed.

Example:

```text
FT-Finance-Users

Current:
- Alice
- Brian
- David
- Grace
```

Remove:

```text
Brian
```

Result:

```text
FT-Finance-Users

Members:
- Alice
- David
- Grace
```

Removing a user from a group changes that user's membership in the group.

---

# 27. Bulk Membership Management

When an organization has many users, adding members individually can become inefficient.

For example:

```text
FT-Finance-Users

32 users
```

Instead of manually processing every user through the portal, administrators can use supported bulk-management methods.

The important concept is:

```text
Small group
→ Individual management may be practical

Large group
→ Bulk management or automation becomes useful
```

---

# 28. Groups in FinTrust

FinTrust has the following departments:

```text
Finance
HR
IT
Cybersecurity
Customer Support
Loans
Management
```

The initial security groups are:

```text
FT-Finance-Users
FT-HR-Users
FT-IT-Users
FT-Cybersecurity-Users
FT-Loans-Users
FT-CustomerSupport-Users
FT-Management-Users
```

Each group represents a department population.

---

# 29. FinTrust Group Structure

```text
                    FINTRUST GROUPS
                          │
        ┌─────────────────┼─────────────────┐
        │                 │                 │
     Finance              HR                IT
        │                 │                 │
FT-Finance-Users    FT-HR-Users      FT-IT-Users

        │
        ├── Cybersecurity
        │   FT-Cybersecurity-Users
        │
        ├── Loans
        │   FT-Loans-Users
        │
        ├── Customer Support
        │   FT-CustomerSupport-Users
        │
        └── Management
            FT-Management-Users
```

The groups provide a structured way to organize FinTrust identities.

---

# 30. Assigned FinTrust Groups

For the first implementation, FinTrust can use assigned membership.

Example:

```text
FT-Finance-Users

Membership:
Assigned
```

Members are deliberately selected:

```text
Alice Wanjiku
Brian Otieno
David Kamau
```

The administrator controls membership manually.

---

# 31. Dynamic FinTrust Groups

FinTrust can also create dynamic groups where membership follows user attributes.

For example:

```text
FT-Finance-Dynamic
```

Rule:

```text
Department = Finance
```

Then:

```text
Finance users
      ↓
Department attribute
      ↓
Dynamic membership rule
      ↓
FT-Finance-Dynamic
```

This removes the need to manually maintain every member when the relevant attribute is maintained correctly.

---

# 32. Group Membership Scenario

Suppose FinTrust has:

```text
Alice
Department = Finance

Brian
Department = IT

Mary
Department = HR
```

A dynamic group uses:

```text
Department = Finance
```

Membership becomes:

```text
FT-Finance-Dynamic

Alice
```

Brian and Mary are not included because their department values do not match the rule.

---

# 33. Changing Membership Through Attributes

Suppose Brian initially has:

```text
Department = IT
```

Therefore:

```text
FT-IT-Dynamic
```

contains Brian.

Later his department changes to:

```text
Finance
```

The dynamic group rules can be reevaluated.

The expected membership relationship becomes:

```text
Brian
  ↓
Department = Finance
  ↓
FT-Finance-Dynamic
```

The important concept is that dynamic membership follows the configured rule rather than a manual add/remove operation.

---

# 34. Group Lifecycle

Groups also have a lifecycle.

A simplified lifecycle is:

```text
Plan
 ↓
Create
 ↓
Configure
 ↓
Add owners
 ↓
Add members
 ↓
Use
 ↓
Review
 ↓
Modify
 ↓
Remove members
 ↓
Delete when no longer required
```

Group administration does not end when the group is created.

Groups should continue to be managed throughout their useful life.

---

# 35. Group Description

A useful group description explains its purpose.

Example:

```text
FT-Finance-Users

Description:
Security group for FinTrust Finance department users.
```

Another example:

```text
FT-Finance-Dynamic

Description:
Dynamic security group containing users whose
department attribute is Finance.
```

Descriptions help administrators understand why a group exists.

---

# 36. Group Administration Checklist

When creating a group, consider:

```text
[ ] What is the purpose?
[ ] Security group or Microsoft 365 group?
[ ] What should the group be called?
[ ] What membership type is required?
[ ] Who owns the group?
[ ] Who should be members?
[ ] Should membership be assigned or dynamic?
[ ] If dynamic, what rule determines membership?
[ ] Does the group require licensing?
[ ] Is the group still required?
```

---

# 37. Common Group Mistakes

### Mistake 1 — Choosing the wrong group type

Creating a Microsoft 365 group when the requirement is primarily security/access management can create unnecessary complexity.

---

### Mistake 2 — Using manual membership when membership should be automatic

If the membership population is determined by a reliable user attribute, dynamic membership may be appropriate.

---

### Mistake 3 — Using dynamic membership without reliable attributes

Dynamic groups depend on the attributes used in their rules.

If the attributes are inaccurate:

```text
Incorrect attribute
      ↓
Incorrect rule evaluation
      ↓
Incorrect membership
```

---

### Mistake 4 — No group owner

Groups should have appropriate ownership and administration.

---

### Mistake 5 — Poor naming

Names such as:

```text
Group1
Test
NewGroup
Group2
```

do not clearly communicate purpose.

Prefer meaningful names such as:

```text
FT-Finance-Users
FT-HR-Users
FT-IT-Users
```

---

### Mistake 6 — Creating unnecessary groups

Every group should have a clear purpose.

Before creating one, ask:

> Why does this group need to exist?

---

# 38. Groups and PowerShell

Groups can be managed through automation.

Administrators can use PowerShell to:

* Create groups
* Retrieve groups
* Add members
* Remove members
* Retrieve members
* Manage group properties

For Microsoft Entra administration, Microsoft Graph PowerShell provides commands for interacting with Microsoft Graph.

Example concept:

```text
PowerShell
     ↓
Microsoft Graph PowerShell
     ↓
Microsoft Graph
     ↓
Microsoft Entra ID
     ↓
Groups
```

This is useful when managing many groups or automating repetitive administration.

---

# 39. Groups and Microsoft Graph

Microsoft Graph provides APIs for working with Microsoft Entra groups.

Conceptually:

```text
Script
  ↓
Microsoft Graph
  ↓
Groups
  ├── Create
  ├── Read
  ├── Update
  ├── Delete
  ├── Add members
  └── Remove members
```

This allows administrators to move from manual portal administration toward repeatable automation.

---

# 40. Groups and Azure CLI

Groups can also be managed using command-line tools.

The important concept is that the portal is not the only administration method.

An administrator can work with groups through:

```text
Microsoft Entra portal
        OR
PowerShell / Microsoft Graph
        OR
Azure CLI
```

The underlying identity service remains Microsoft Entra ID.

---

# 41. Group Administration Through the Portal

The Microsoft Entra admin center provides a graphical interface for group management.

Typical tasks include:

```text
Groups
  ↓
View groups
  ↓
Select group
  ↓
Manage:
  - Overview
  - Members
  - Owners
  - Properties
  - Membership
  - Licenses
```

The exact available options depend on the group type and configuration.

---

# 42. Group Properties

Groups have properties that describe or control the group.

Examples include:

* Display name
* Description
* Group type
* Membership type
* Owners
* Members

These properties help administrators identify and manage the group.

---

# 43. Group Membership Rules

Dynamic groups depend on membership rules.

Conceptually:

```text
IF user satisfies condition
        ↓
Include user in group
```

Example:

```text
IF Department = Finance
        ↓
FT-Finance-Dynamic
```

Another possible rule could be based on another supported user or device attribute.

The important point is:

> **A dynamic group does not require the administrator to manually maintain every member.**

---

# 44. Dynamic User Groups

Dynamic user groups determine membership using user attributes.

Concept:

```text
User
 ↓
User attributes
 ↓
Membership rule
 ↓
Dynamic group
```

Example:

```text
Department = HR
```

Result:

```text
FT-HR-Dynamic
```

containing users whose relevant attribute satisfies the rule.

---

# 45. Dynamic Device Groups

Dynamic membership can also be used with supported device group scenarios.

Conceptually:

```text
Device attributes
       ↓
Dynamic rule
       ↓
Dynamic device group
```

For example, a group could be designed around a supported device attribute.

The key distinction is:

```text
Dynamic user group
→ evaluates user attributes

Dynamic device group
→ evaluates device attributes
```

---

# 46. Group-Based Organization

Groups can represent organizational populations.

For FinTrust:

```text
Department
     ↓
Group
     ↓
Members
```

Example:

```text
Finance
   ↓
FT-Finance-Users
   ↓
Finance employees
```

This provides a consistent organizational structure.

---

# 47. Groups Are Not Just Lists

A group is not merely a list of names.

It can become a management boundary for a collection of identities.

For example:

```text
List:

Alice
Brian
David
```

is simply a list.

But:

```text
FT-Finance-Users
```

is an identity-management object that can have:

* Owners
* Members
* Membership type
* Description
* Licensing configuration
* Group-based access relationships
* Administrative lifecycle

Therefore, group design is an important part of identity administration.

---

# 48. Group Design Principle

A good group should answer three questions:

### 1. Why does the group exist?

Example:

```text
Finance department users
```

### 2. Who should belong to it?

Example:

```text
Users whose department is Finance
```

### 3. How should membership be managed?

Example:

```text
Assigned
```

or:

```text
Dynamic
```

This gives the group a clear purpose.

---

# 49. FinTrust Group Design

The initial FinTrust design is:

| Group                      | Purpose                | Membership |
| -------------------------- | ---------------------- | ---------- |
| `FT-Finance-Users`         | Finance users          | Assigned   |
| `FT-HR-Users`              | HR users               | Assigned   |
| `FT-IT-Users`              | IT users               | Assigned   |
| `FT-Cybersecurity-Users`   | Cybersecurity users    | Assigned   |
| `FT-Loans-Users`           | Loans users            | Assigned   |
| `FT-CustomerSupport-Users` | Customer Support users | Assigned   |
| `FT-Management-Users`      | Management users       | Assigned   |

Dynamic versions can be created later for populations that can reliably be identified using supported attributes.

---

# 50. Practical Lab — Day 1

## Create Groups

Create the FinTrust security groups:

```text
FT-Finance-Users
FT-HR-Users
FT-IT-Users
FT-Cybersecurity-Users
FT-Loans-Users
FT-CustomerSupport-Users
FT-Management-Users
```

For each group:

```text
Group type:
Security

Membership:
Assigned
```

Record:

```text
Group name
Description
Group type
Membership type
Owner
```

---

# 51. Practical Lab — Day 2

## Manage Members and Owners

For each group:

```text
1. Add an owner
2. Add members
3. View members
4. Remove a member
5. Add the member again
6. Change the owner where appropriate
```

Document the changes.

Example:

```text
FT-Finance-Users

Owner:
Alice Wanjiku

Members:
- Brian Otieno
- David Kamau
- Grace Njeri
```

---

# 52. Practical Lab — Day 3

## Dynamic Groups

Create a dynamic user group.

Example:

```text
FT-Finance-Dynamic
```

Use a supported rule based on the user's department.

Concept:

```text
Department = Finance
```

Test the result.

Document:

```text
Group name
Membership type
Rule
Expected members
Actual members
```

---

# 53. Practical Lab — Day 4

## Group-Based Management

Practice:

```text
1. Create a group
2. Add members
3. Add an owner
4. Configure supported group-based licensing
5. Review membership
6. Review group properties
```

The objective is to understand how a group becomes a management unit rather than simply a collection of users.

---

# 54. Practical Lab — Day 5

## FinTrust Group Scenario

Design the final FinTrust group structure.

Start with:

```text
Finance
HR
IT
Cybersecurity
Loans
Customer Support
Management
```

Create corresponding groups.

Then determine:

```text
Which groups should use Assigned membership?

Which groups could use Dynamic membership?

Who should own each group?

Who should be members?

What is the purpose of each group?
```

Document the reasoning for each decision.

---

# 55. Group Troubleshooting

When a group does not behave as expected, check:

```text
[ ] Is the correct group selected?
[ ] Is the group type correct?
[ ] Is the membership type correct?
[ ] Is the user actually a member?
[ ] Is the user an owner or only a member?
[ ] Is the dynamic rule correct?
[ ] Are the attributes used by the rule correct?
[ ] Has dynamic membership been processed?
[ ] Is the relevant group-based configuration supported?
```

For dynamic groups, especially check:

```text
User attribute
       ↓
Rule
       ↓
Membership evaluation
       ↓
Group membership
```

---

# 56. Groups — Core Mental Model

The entire topic can be summarized as:

```text
                GROUP
                  │
        ┌─────────┼─────────┐
        │         │         │
      Type    Membership   Owners
        │         │         │
   ┌────┴───┐ ┌───┴────┐    │
   │        │ │        │    │
Security   M365     Assigned Dynamic
                    │        │
                    │        │
                 Manual     Rule
                    │        │
                    └───┬────┘
                        │
                     Members
                        │
                Group-based
                management
```

---

# 57. What You Should Be Able to Explain

After completing the Groups topic, you should be able to explain:

### 1. What is a group?

A group is a collection of supported identities managed as a unit.

### 2. Why are groups useful?

They reduce repetitive identity administration and provide a common management target.

### 3. What is a Security group?

A group primarily intended for security and access management.

### 4. What is a Microsoft 365 group?

A group primarily designed around Microsoft 365 collaboration.

### 5. What is assigned membership?

Membership manually controlled by an administrator or authorized group manager.

### 6. What is dynamic membership?

Membership automatically evaluated according to configured rules.

### 7. What is a group owner?

A user responsible for managing aspects of the group.

### 8. What is a group member?

An identity that belongs to the group.

### 9. What is group-based licensing?

A method of assigning supported licenses through group membership.

### 10. What is a nested group?

A group that contains another group as a member.

---

# 58. Final Group Scenario

FinTrust has 32 employees.

The company has:

```text
Finance
HR
IT
Cybersecurity
Loans
Customer Support
Management
```

The administrator creates:

```text
FT-Finance-Users
FT-HR-Users
FT-IT-Users
FT-Cybersecurity-Users
FT-Loans-Users
FT-CustomerSupport-Users
FT-Management-Users
```

The administrator must decide:

```text
Who owns each group?

Who belongs to each group?

Which groups use Assigned membership?

Which groups could use Dynamic membership?

Which groups require group-based licensing?

Are any groups nested?

How will membership be maintained?
```

The final structure should be documented and tested.

---

# 59. Groups — Final Summary

The essential Group concepts are:

```text
Groups
│
├── Security Groups
│
├── Microsoft 365 Groups
│
├── Membership
│   ├── Assigned
│   └── Dynamic
│
├── Owners
│
├── Members
│
├── Group-Based Licensing
│
├── Nested Groups
│
├── Group Naming
│
├── Group Lifecycle
│
└── Group Administration
```

The central idea is:

> **A group allows an administrator to manage a collection of identities as a unit instead of repeatedly managing each identity individually.**

For SC-300, you should be comfortable creating groups, choosing the appropriate group type, managing owners and members, understanding assigned and dynamic membership, configuring supported group-based licensing, understanding group nesting, and administering groups through the portal and supported automation tools.
