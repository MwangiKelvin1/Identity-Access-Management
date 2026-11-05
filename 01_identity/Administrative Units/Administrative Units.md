# Microsoft Entra Administrative Units

An **Administrative Unit (AU)** is a Microsoft Entra resource that provides a **management boundary** for users, groups, or devices. It allows an organization to assign certain Microsoft Entra administrative roles with a scope limited to the objects contained in the Administrative Unit rather than the entire tenant.

For example, FinTrust Financial Services can create an `FT-HR` Administrative Unit containing HR users and then assign an administrator a role scoped only to that Administrative Unit. The administrator can manage supported objects within that scope without receiving the same administrative permissions across the entire tenant.

Administrative Units therefore solve a specific administrative problem:

> **How can an organization delegate administration over only part of the directory without giving the administrator tenant-wide permissions?**

---

# 1. Definition

## What is an Administrative Unit?

An Administrative Unit is a **container and administrative scope** in Microsoft Entra ID.

It can contain:

* Users
* Groups
* Devices

The most important purpose of an Administrative Unit is not simply organizing objects. Its primary purpose is to provide a **scope for administrative permissions**.

```text
                         Microsoft Entra Tenant
                                  │
                 ┌────────────────┼────────────────┐
                 │                │                │
             FT-HR            FT-Finance        FT-IT
          Administrative       Administrative   Administrative
              Unit                 Unit             Unit
                 │                │                │
             HR Users        Finance Users       IT Users
                 │                │                │
                 └────────────────┼────────────────┘
                                  │
                         Scoped Administration
```

### Why Administrative Units exist

Without Administrative Units, a role such as User Administrator is normally assigned at the directory/tenant level.

That can give the administrator a much broader management scope than required.

Administrative Units allow the organization to create a narrower boundary:

```text
Tenant-wide role
      ↓
All applicable objects in tenant


AU-scoped role
      ↓
Only applicable objects in the Administrative Unit
```

### Why an Identity Administrator needs to understand AUs

An SC-300 administrator should understand AUs because they are used for:

* Delegated administration
* Department-level administration
* Regional administration
* School/faculty administration
* Business-unit administration
* Limiting administrative privileges
* Applying supported administrative roles to a defined subset of users, groups, or devices

---

# 2. Core Concept

The most important mental model is:

```text
                  Administrator
                       │
                       │
                 Microsoft Entra
                    Role
                       │
                       ↓
              Administrative Unit
                       │
             ┌─────────┼─────────┐
             │         │         │
           User      Group     Device
             │
             ↓
       Managed object
```

The AU does **not** itself give an administrator permissions.

Instead:

```text
Administrative Unit
        +
Microsoft Entra Role
        +
Role Assignment Scoped to AU
        ↓
Scoped Administrative Permission
```

For example:

```text
Brian
  │
  │ User Administrator
  │
  │ Scope = FT-HR
  ↓
FT-HR Administrative Unit
  │
  ├── Alice
  ├── Mary
  └── David
```

Brian's role is not automatically tenant-wide.

The important relationship is:

```text
Role
  ↓
Scope
  ↓
Administrative Unit
  ↓
Objects inside the AU
```

---

# 3. Administrative Unit Membership Types

Administrative Units can use different membership approaches.

| **Membership Type** | **How it works**                                 | **Typical Use**                            | **Important Characteristic**   |
| ------------------- | ------------------------------------------------ | ------------------------------------------ | ------------------------------ |
| Assigned            | Administrator manually adds/removes members      | Small or controlled departments            | Membership is manually managed |
| Dynamic User        | Microsoft Entra evaluates a rule against users   | Automatically grouping users by attributes | Membership is rule-driven      |
| Dynamic Device      | Microsoft Entra evaluates a rule against devices | Automatically grouping devices             | Membership is rule-driven      |

The important distinction is:

```text
Assigned AU

Administrator
     ↓
Add User
     ↓
AU Membership


Dynamic AU

User attributes
     ↓
Membership rule
     ↓
Microsoft Entra evaluation
     ↓
AU Membership
```

Dynamic Administrative Units can use rules based on attributes available to dynamic membership rules.

For example:

```text
(user.department -eq "Finance")
```

could be used to create an AU whose membership is dynamically evaluated for users in Finance.

Dynamic Administrative Units can be created for **users or devices**, but a dynamic AU cannot currently use a rule to include multiple object types at the same time. Dynamic group membership for groups is not supported for Administrative Units.

---

# 4. Main Components

| **Component**              | **What it means**                             | **FinTrust Example**                    |
| -------------------------- | --------------------------------------------- | --------------------------------------- |
| Administrative Unit        | Administrative boundary                       | `FT-HR`                                 |
| Display name               | Name shown in Entra                           | `FT-HR`                                 |
| Description                | Explains the purpose of the AU                | `HR department administrative boundary` |
| Members                    | Objects contained in the AU                   | HR users                                |
| Membership type            | Determines how members are selected           | Assigned                                |
| Membership rule            | Rule used for dynamic membership              | `(user.department -eq "HR")`            |
| Membership rule processing | Determines whether the dynamic rule is active | `On`                                    |
| Scoped role                | Microsoft Entra role assigned with AU scope   | User Administrator                      |
| Scoped administrator       | Person/group receiving the scoped role        | Brian                                   |
| Directory scope            | Defines where the role applies                | `/administrativeUnits/{AU-ID}`          |
| Visibility                 | Controls AU membership visibility             | Public or HiddenMembership              |
| Restricted management      | Provides stronger protection for AU members   | Optional                                |

---

# 5. How Administrative Units Work

The operational flow is:

```text
1. Create Administrative Unit
             ↓
2. Add users/groups/devices
             ↓
3. Select an appropriate Microsoft Entra role
             ↓
4. Assign the role with AU scope
             ↓
5. Administrator signs in
             ↓
6. Administrator performs supported management task
             ↓
7. Microsoft Entra checks role + scope
             ↓
8. Operation is allowed or denied
```

## Example

Suppose FinTrust has:

```text
FT-HR
│
├── Alice
├── Mary
└── Brian
```

FinTrust wants Brian to administer HR users.

The configuration becomes:

```text
Brian
   │
   │ User Administrator
   │
   │ Scope
   ↓
FT-HR
   │
   ├── Alice
   ├── Mary
   └── Brian
```

If Brian attempts to perform a supported user-management action against an applicable user inside `FT-HR`, the AU scope can allow it.

If he attempts the same scoped administrative operation against a user outside his AU scope, the operation is outside that role assignment's scope.

---

# 6. Important Properties / Settings

| **Setting / Property**          | **Meaning**                        | **Example / Effect**           |
| ------------------------------- | ---------------------------------- | ------------------------------ |
| `displayName`                   | Name of the AU                     | `FT-HR`                        |
| `description`                   | Description of the AU              | `HR administrative boundary`   |
| `membershipType`                | Assigned or Dynamic                | `Assigned`                     |
| `membershipRule`                | Rule used for dynamic membership   | `(user.department -eq "HR")`   |
| `membershipRuleProcessingState` | Controls dynamic rule processing   | `On` or `Paused`               |
| `visibility`                    | Controls membership visibility     | `Public` or `HiddenMembership` |
| `isMemberManagementRestricted`  | Creates a restricted management AU | `true` or `false`              |

## `membershipType`

```text
Assigned
```

means administrators manually manage the membership.

```text
Dynamic
```

means Microsoft Entra evaluates the configured membership rule.

---

## `membershipRule`

A dynamic AU can use a membership rule.

Example:

```text
(user.department -eq "HR")
```

Conceptually:

```text
User.department
       ↓
     equals
       ↓
      HR
       ↓
User becomes AU member
```

---

## `membershipRuleProcessingState`

| **Value** | **Meaning**                             |
| --------- | --------------------------------------- |
| `On`      | Dynamic membership processing is active |
| `Paused`  | Dynamic membership processing is paused |

When an AU uses dynamic membership, normal manual add/remove membership operations are not used to control the membership. The dynamic membership engine determines membership according to the rule.

---

## `visibility`

An Administrative Unit can have public visibility or `HiddenMembership`.

`HiddenMembership` can be used when the organization wants AU membership to be hidden from users who are not members.

This is different from administrative scope.

```text
Visibility
    ≠
Administrative permission scope
```

---

# 7. Administrative Unit and Role Scope

This is the most important SC-300 concept.

A role can be assigned at different scopes.

```text
Tenant Scope
     ↓
Entire tenant


Administrative Unit Scope
     ↓
Specific Administrative Unit
```

For example:

```text
User Administrator
       │
       ├── Tenant scope
       │      ↓
       │   Broad directory scope
       │
       └── FT-HR scope
              ↓
          FT-HR boundary
```

A role assignment scoped to an Administrative Unit applies only to supported management operations involving objects in that Administrative Unit.

It does **not** give the administrator authority over tenant-wide configuration.

---

# 8. Roles That Can Be Scoped to Administrative Units

Microsoft Entra supports Administrative Unit scope for specific built-in roles and suitable custom roles.

Examples include:

| **Role**                     | **Possible AU-scoped use**                                                     |
| ---------------------------- | ------------------------------------------------------------------------------ |
| User Administrator           | Manage supported user operations within the AU                                 |
| Groups Administrator         | Manage supported groups within the AU                                          |
| Authentication Administrator | Manage supported authentication methods for applicable users                   |
| Helpdesk Administrator       | Perform supported helpdesk operations within scope                             |
| License Administrator        | Manage supported licensing operations within scope                             |
| Device-related roles         | Manage supported device operations within scope                                |
| Custom role                  | Can be scoped when its permissions are applicable to users, groups, or devices |

The exact permissions depend on the role.

Therefore:

> **An AU does not make every Microsoft Entra role automatically scoped.**

Always check whether the particular role supports Administrative Unit scope.

---

# 9. Administrative Unit Scope vs Tenant Scope

| **Area**                | **Tenant Scope**            | **Administrative Unit Scope**  |
| ----------------------- | --------------------------- | ------------------------------ |
| Scope                   | Entire tenant               | Specific AU                    |
| Administrative boundary | Organization-wide           | Defined subset                 |
| Typical purpose         | Central administration      | Delegated administration       |
| User management         | Broad                       | Applicable users in AU         |
| Group management        | Broad                       | Applicable groups in AU        |
| Device management       | Broad where supported       | Applicable devices in AU       |
| Tenant-wide settings    | Can apply depending on role | Not granted simply by AU scope |
| Least privilege         | Usually broader             | More granular                  |
| Example                 | Global IT administrator     | HR administrator               |

The important point is:

```text
AU scope limits the scope of a role.
It does not redefine what the role itself can do.
```

---

# 10. Administrative Units and Groups

Groups and Administrative Units are easy to confuse because both can contain users.

They serve different purposes.

| **Area**                                    | **Group**                                                            | **Administrative Unit**     |
| ------------------------------------------- | -------------------------------------------------------------------- | --------------------------- |
| Primary purpose                             | Organize users/resources and enable access/assignment scenarios      | Define administrative scope |
| Main use                                    | Membership, access, licensing, application assignment, collaboration | Delegated administration    |
| Gives administrative permissions by itself? | No                                                                   | No                          |
| Can contain users?                          | Yes                                                                  | Yes                         |
| Can contain groups?                         | Yes                                                                  | Yes                         |
| Can contain devices?                        | Depending on group type/scenario                                     | Yes                         |
| Used as administrative boundary?            | Not in the same way                                                  | Yes                         |
| Can scope Microsoft Entra roles?            | Not by itself                                                        | Yes                         |

### Key distinction

```text
GROUP

User
 ↓
Group
 ↓
Access / membership-based function


ADMINISTRATIVE UNIT

User
 ↓
Administrative Unit
 ↓
Administrative role scope
```

---

# 11. Critical Group Interaction

This is one of the most important Administrative Unit rules.

Suppose:

```text
FT-HR
  │
  └── FT-HR-Users
          │
          ├── Alice
          ├── Mary
          └── Brian
```

If the **group itself** is added to the Administrative Unit:

```text
FT-HR
  │
  └── FT-HR-Users
```

the group is inside the Administrative Unit's management scope.

The users inside the group are **not automatically placed inside the AU**.

Therefore:

```text
AU
 ↓
Group
 ↓
Users
```

does **not** mean:

```text
AU
 ↓
Group
 ↓
Users automatically become AU members
```

The distinction is critical.

---

# 12. What Happens When a Group Is Added to an AU?

| **Operation**                                                                                 | **Scoped administrator can do it?**       |
| --------------------------------------------------------------------------------------------- | ----------------------------------------- |
| Manage supported properties of the group                                                      | Yes                                       |
| Manage group membership                                                                       | Yes, where supported by the assigned role |
| Manage an individual user's properties merely because the user belongs to that group          | No                                        |
| Reset an individual group member's password merely because they belong to that group          | No                                        |
| Manage an individual member's authentication methods merely because they belong to that group | No                                        |

If an administrator needs to manage the users themselves through the AU scope, those users must be members of the AU themselves.

```text
CORRECT FOR USER ADMINISTRATION

FT-HR
├── Alice
├── Mary
└── Brian


GROUP ONLY

FT-HR
└── FT-HR-Users
      ├── Alice
      ├── Mary
      └── Brian

The group is scoped.
The individual users are not automatically scoped.
```

---

# 13. Administrative Units and Dynamic Membership

An Administrative Unit can use dynamic membership for users or devices.

Example:

```text
User attribute
      ↓
department = HR
      ↓
Dynamic membership rule
      ↓
FT-HR Administrative Unit
      ↓
Matching users
```

Example rule:

```text
(user.department -eq "HR")
```

If a user's department changes:

```text
Finance
   ↓
HR
```

the dynamic membership engine can reevaluate the user against the rule.

This means the AU membership is based on the attribute rather than an administrator manually adding every user.

---

# 14. Assigned vs Dynamic Administrative Units

| **Area**                            | **Assigned AU**                                      | **Dynamic AU**                                                    |
| ----------------------------------- | ---------------------------------------------------- | ----------------------------------------------------------------- |
| Membership management               | Manual                                               | Rule-based                                                        |
| Administrator adds members          | Yes                                                  | No, once dynamic processing controls membership                   |
| Uses membership rule                | No                                                   | Yes                                                               |
| Good for                            | Small controlled populations                         | Attribute-based populations                                       |
| Example                             | Selected HR administrators                           | All users whose department is HR                                  |
| Membership changes automatically    | No                                                   | Yes, based on rule evaluation                                     |
| Multiple object types               | Manual membership can include users, groups, devices | Dynamic AU currently targets users or devices, not both in one AU |
| Dynamic group membership for groups | Not applicable                                       | Not supported                                                     |

---

# 15. Administrative Unit Membership Is Not the Same as Group Membership

Do not confuse these two concepts.

```text
GROUP MEMBERSHIP

User
 ↓
Group
 ↓
Access / assignment / collaboration


ADMINISTRATIVE UNIT MEMBERSHIP

User
 ↓
Administrative Unit
 ↓
Potential administrative scope
```

An object can belong to:

```text
Groups
+
Administrative Units
```

at the same time.

For example:

```text
Alice
│
├── FT-HR-Users
├── FT-All-Employees
└── FT-HR Administrative Unit
```

These memberships have different purposes.

---

# 16. Important Behaviour / Rules

| **Behaviour / Rule**           | **What Happens**                                    | **Important Note**                                                    |
| ------------------------------ | --------------------------------------------------- | --------------------------------------------------------------------- |
| AU contains users              | Users become members of the AU                      | Supported administrative roles can be scoped to them                  |
| AU contains groups             | Group itself is in scope                            | Group members do not automatically become AU members                  |
| AU contains devices            | Device is in AU scope                               | Device management depends on role and supported operation             |
| User belongs to multiple AUs   | User can be a member of multiple AUs                | AUs are not mutually exclusive                                        |
| AU contains another AU         | Not supported                                       | Administrative Units cannot be nested                                 |
| Role assigned without AU scope | Scope is tenant-wide for that role assignment       | AU membership does not automatically restrict it                      |
| Role assigned with AU scope    | Scope is limited to the AU for supported operations | Tenant-wide settings are not granted by the scoped assignment         |
| Dynamic AU                     | Membership follows rule processing                  | Manual membership management is not used in the normal way            |
| Dynamic rule paused            | Membership processing stops                         | Rule can be resumed                                                   |
| Group added to AU              | Group itself is managed within scope                | Its members are not automatically in scope                            |
| AU deleted                     | AU and its administrative boundary are removed      | Users/groups/devices are not deleted simply because the AU is deleted |
| User leaves dynamic criteria   | Dynamic membership can remove the user              | Membership follows the rule                                           |
| User enters dynamic criteria   | Dynamic membership can add the user                 | Membership follows the rule                                           |

---

# 17. What Works and What Does Not

## Where Administrative Units work

| **Scenario**                                                        | **Supported / Works?** | **What Happens**                                                         |
| ------------------------------------------------------------------- | ---------------------- | ------------------------------------------------------------------------ |
| Create an AU                                                        | Yes                    | AU is created                                                            |
| Add a user                                                          | Yes                    | User becomes an AU member                                                |
| Add a group                                                         | Yes                    | Group becomes an AU member                                               |
| Add a device                                                        | Yes                    | Device becomes an AU member                                              |
| Assign supported Entra role with AU scope                           | Yes                    | Role is limited to AU                                                    |
| Dynamic users                                                       | Yes                    | Membership is rule-driven                                                |
| Dynamic devices                                                     | Yes                    | Membership is rule-driven                                                |
| Dynamic groups as AU membership                                     | No                     | Dynamic AU membership for groups is not supported                        |
| Nest one AU inside another                                          | No                     | AUs cannot be nested                                                     |
| Manage Intune devices through AU scope                              | Not supported          | Device management in Intune is outside the current AU-supported scenario |
| Manage tenant-wide settings through AU-scoped role                  | No                     | AU scope does not grant tenant-wide administration                       |
| Manage group members' user properties merely because group is in AU | No                     | Users must be directly in AU for applicable user administration          |

---

# 18. Administrative Units and Permissions

An AU does not replace a Microsoft Entra role.

Think of the configuration as:

```text
WHO?
  ↓
Brian

WHAT ROLE?
  ↓
User Administrator

WHERE?
  ↓
FT-HR Administrative Unit

RESULT
  ↓
User Administrator permissions
within the supported FT-HR scope
```

Without the role:

```text
Brian
  +
FT-HR AU
```

does not automatically make Brian an administrator.

With a tenant-wide role:

```text
Brian
  +
User Administrator
  +
Tenant scope
```

the AU does not automatically reduce Brian's tenant-wide role.

The role assignment itself must be scoped appropriately.

---

# 19. Important Principle: Scope Does Not Change the Role

Suppose the role is:

```text
User Administrator
```

and it is assigned with:

```text
Scope = FT-HR
```

The AU does not transform the User Administrator role into a new role.

Instead:

```text
User Administrator
        +
     FT-HR scope
        ↓
User Administrator
limited to supported FT-HR management operations
```

This distinction is important for SC-300 scenario questions.

---

# 20. Administrative Units and Tenant-Wide Settings

An AU-scoped role is intended for management of objects within the AU.

It does not automatically grant permission to configure tenant-wide settings.

For example, a Groups Administrator scoped to an AU can manage supported groups within the AU, but that does not mean the administrator can change organization-wide group settings such as tenant-level naming or expiration policies.

Mental model:

```text
AU-scoped role
      ↓
Object-level administration
      ↓
Specific AU

NOT

AU-scoped role
      ↓
Entire tenant configuration
```

---

# 21. Administrative Units and Multiple Membership

A user can belong to more than one Administrative Unit.

Example:

```text
                 Alice
                /     \
               /       \
              ↓         ↓
        FT-Nairobi    FT-Finance
           AU             AU
```

This allows an organization to define different administrative boundaries.

For example:

```text
FT-Nairobi
    ↓
Users located in Nairobi


FT-Finance
    ↓
Finance users
```

Alice could belong to both.

This means Administrative Units do not necessarily represent a single hierarchy.

---

# 22. Administrative Units Cannot Be Nested

You cannot create:

```text
FT-Finance
    │
    └── FT-Accounts
            │
            └── Users
```

where `FT-Accounts` is another Administrative Unit nested inside `FT-Finance`.

Administrative Units are not hierarchical containers.

Instead, use separate AUs:

```text
FT-Finance
FT-Accounts
FT-Nairobi
FT-Management
```

A user may belong to multiple AUs where appropriate.

---

# 23. Restricted Management Administrative Units

A **Restricted Management Administrative Unit** is a stronger protection model for sensitive objects.

It is designed for situations where the organization wants management of the AU members to be limited to administrators specifically scoped to that restricted AU.

Example:

```text
FinTrust
   │
   └── FT-Executive
          │
          ├── CEO
          ├── CFO
          └── CIO
```

FinTrust may treat these identities as sensitive.

A Restricted Management AU can provide an additional protection boundary around those members.

The key concept is:

```text
Normal AU

Scoped administrators
        ↓
AU members


Restricted Management AU

Specific scoped administrators
        ↓
Protected AU members
```

The restricted-management property is set when the AU is created and is immutable afterward.

Use this feature carefully because it changes which tenant-scoped administrators can manage the protected objects.

---

# 24. License Requirements

Administrative Unit licensing is important for real-world administration and SC-300 scenarios.

| **Requirement**                                     | **License**                                          |
| --------------------------------------------------- | ---------------------------------------------------- |
| Creating Administrative Units                       | Microsoft Entra ID Free                              |
| AU members                                          | Microsoft Entra ID Free                              |
| Administrator assigned directory role over AU scope | Microsoft Entra ID P1                                |
| Dynamic AU membership for users                     | Microsoft Entra ID P1 requirement                    |
| Dynamic AU membership for devices                   | No P1 license is required for the devices themselves |
| Dynamic AU administrator                            | Microsoft Entra ID P1 or P2                          |

The important exam distinction is:

> **Creating an AU and using AU-scoped administrative roles are not the same licensing requirement.**

A tenant can therefore allow AU creation under Free licensing while a lab requiring AU-scoped administrative delegation may require the appropriate Premium licensing.

---

# 25. FinTrust Example

FinTrust Financial Services has:

```text
FinTrust Financial Services
│
├── Finance
├── HR
├── IT
├── Cybersecurity
├── Loans
├── Customer Support
└── Management
```

FinTrust wants the HR team to manage HR identities without giving them tenant-wide User Administrator permissions.

The design is:

```text
FT-HR Administrative Unit
│
├── Alice Wanjiku
├── Mary Achieng
└── Other HR users
```

Then:

```text
Brian Otieno
      │
      │ User Administrator
      │
      │ Scope = FT-HR
      ↓
FT-HR Administrative Unit
      │
      ├── Alice
      ├── Mary
      └── HR users
```

Brian can then perform supported user-management operations within his assigned scope.

The important security principle is:

```text
Do not give Brian:

User Administrator
+
Tenant-wide scope

when he only needs:

User Administrator
+
FT-HR scope
```

---

# 26. FinTrust Scenario

## Scenario

FinTrust Financial Services has 32 employees.

The organization has a central IAM team but wants the HR department to handle routine identity administration for HR employees.

The requirement is:

* HR administrators should manage supported HR user operations.
* They should not receive tenant-wide User Administrator permissions.
* The HR population should be represented by an Administrative Unit.
* The administrative boundary should be clearly documented.
* The IAM team should retain broader tenant administration.

### Design

```text
Central IAM
    │
    │ Tenant-level administration
    ↓
Microsoft Entra Tenant
    │
    └── FT-HR
          │
          ├── HR User 1
          ├── HR User 2
          ├── HR User 3
          └── HR User 4

HR Administrator
    │
    │ User Administrator
    │ Scope = FT-HR
    ↓
FT-HR
```

### Key lesson

The Administrative Unit defines **where** the administrator can operate.

The Microsoft Entra role defines **what** the administrator can do.

The administrator assignment identifies **who** receives those permissions.

```text
WHO + WHAT + WHERE

Brian
  +
User Administrator
  +
FT-HR
  ↓
Scoped administration
```

---

# 27. Practical Lab

# Practical Lab — FinTrust HR Administrative Unit

## Objective

Create an Administrative Unit for FinTrust HR users and use it to understand scoped administration.

The lab should demonstrate:

1. Creating an Administrative Unit.
2. Adding users.
3. Understanding AU membership.
4. Assigning an administrator role with AU scope.
5. Testing the scope.
6. Comparing AU membership with group membership.
7. Documenting the results.

---

## Environment

```text
Tenant:
FinTrust Financial Services

Administrative Unit:
FT-HR

Users:
Alice Wanjiku
Brian Otieno
Mary Achieng

Microsoft Entra:
Microsoft Entra admin center

Management method:
Portal + Microsoft Graph PowerShell
```

---

## Task 1 — Create the Administrative Unit

Create:

```text
Name:
FT-HR

Description:
FinTrust HR administrative boundary
```

Portal path:

```text
Microsoft Entra admin center
        ↓
Entra ID
        ↓
Roles & admins
        ↓
Admin units
        ↓
Add
```

Expected result:

```text
FT-HR
```

appears in the Administrative Units list.

---

## Task 2 — Add HR Users

Add the appropriate HR users to:

```text
FT-HR
```

For example:

```text
FT-HR
│
├── Alice Wanjiku
├── Mary Achieng
└── Brian Otieno
```

Verify that the users appear as direct AU members.

---

## Task 3 — Add the HR Group

If the FinTrust group exists:

```text
FT-HR-Users
```

add the group to the AU.

Then inspect the AU membership.

You should understand the difference:

```text
FT-HR
│
├── Alice
├── Mary
├── Brian
│
└── FT-HR-Users
      │
      ├── Alice
      ├── Mary
      └── Brian
```

The group being in the AU does not automatically make its members AU members.

---

## Task 4 — Assign an AU-Scoped Administrator

Assign an appropriate Microsoft Entra role to the administrator with:

```text
Scope:
FT-HR
```

Conceptually:

```text
Administrator
     ↓
Microsoft Entra role
     ↓
FT-HR scope
     ↓
Supported objects in FT-HR
```

Do not test this with an account that already has a tenant-wide role that would invalidate the scope test.

---

## Task 5 — Test an In-Scope User

Using the delegated administrator account, test a supported administrative operation against:

```text
Alice Wanjiku
```

Alice should be inside:

```text
FT-HR
```

Record:

```text
User:
Alice Wanjiku

AU:
FT-HR

Role:
[Assigned role]

Expected:
Supported operation succeeds
```

---

## Task 6 — Test an Out-of-Scope User

Select a user who is deliberately outside:

```text
FT-HR
```

For example:

```text
Peter Kariuki
```

if Peter is not an FT-HR AU member.

Attempt the same supported administrative operation.

Expected learning:

```text
FT-HR
   │
   ├── Alice → In scope
   ├── Mary  → In scope
   └── Brian → In scope

Peter
   ↓
Outside FT-HR
   ↓
Outside this role assignment's AU scope
```

---

## Task 7 — Test the Group Boundary

Place:

```text
FT-HR-Users
```

inside:

```text
FT-HR
```

but do not directly add one of its users to the AU.

Then test whether the AU-scoped administrator can manage that user's individual properties merely because the user belongs to the group.

Expected concept:

```text
AU
 ↓
Group
 ↓
User

The group is in scope.

The individual user is not automatically in scope.
```

---

## Task 8 — Document the Scope

Create a table in your GitHub documentation:

| **Object**  | **Direct AU Member?** | **Role Scope** | **Expected Administration** |
| ----------- | --------------------: | -------------- | --------------------------- |
| Alice       |                   Yes | FT-HR          | In scope                    |
| Mary        |                   Yes | FT-HR          | In scope                    |
| Brian       |                   Yes | FT-HR          | In scope                    |
| FT-HR-Users |                   Yes | FT-HR          | Group itself in scope       |
| Peter       |                    No | FT-HR          | Outside scope               |

---

# 28. Dynamic Administrative Unit Lab

After completing the assigned-membership lab, create a second AU:

```text
FT-Finance-Dynamic
```

Use:

```text
Membership Type:
Dynamic User
```

Example rule:

```text
(user.department -eq "Finance")
```

Conceptual flow:

```text
User
 │
 └── department = Finance
             ↓
       Dynamic rule
             ↓
FT-Finance-Dynamic
             ↓
      Matching users
```

---

## Dynamic AU Tasks

1. Create the AU.
2. Select Dynamic User membership.
3. Create the membership rule.
4. Enable membership processing.
5. Wait for membership evaluation.
6. Verify the resulting members.
7. Change a test user's department.
8. Observe the membership behavior.
9. Document the result.

---

# 29. Dynamic AU Verification

Example rule:

```text
(user.department -eq "Finance")
```

Before the change:

```text
Alice
department = HR

FT-Finance-Dynamic
    ↓
Alice is not a member
```

Change:

```text
Alice.department
HR
 ↓
Finance
```

Then Microsoft Entra evaluates the rule.

Expected model:

```text
Alice
  ↓
department = Finance
  ↓
Rule matches
  ↓
FT-Finance-Dynamic
```

This demonstrates why dynamic Administrative Units are useful when membership should follow directory attributes.

---

# 30. Evidence for GitHub

Capture evidence showing:

### Screenshot 1 — AU creation

Show:

```text
FT-HR
```

and its description.

### Screenshot 2 — AU membership

Show:

```text
FT-HR
 ├── Alice
 ├── Mary
 └── Brian
```

### Screenshot 3 — Role scope

Show the role assignment and:

```text
Scope:
FT-HR
```

### Screenshot 4 — In-scope test

Show the successful supported administrative operation against an AU member.

### Screenshot 5 — Out-of-scope test

Show the failed or unavailable operation against a user outside the AU, where the selected operation and role support such a scope test.

### Screenshot 6 — Group interaction

Show:

```text
FT-HR
└── FT-HR-Users
```

and document that group membership does not automatically place individual users into the AU.

### Screenshot 7 — Dynamic AU

Show:

```text
Membership type:
Dynamic User

Rule:
(user.department -eq "Finance")
```

---

# 31. CLI / PowerShell / Microsoft Graph

Administrative Units can be managed through:

```text
Portal
   ↓
Microsoft Entra admin center


PowerShell
   ↓
Microsoft Graph PowerShell
   ↓
Microsoft Graph
   ↓
Microsoft Entra ID


Direct API
   ↓
Microsoft Graph API
   ↓
Microsoft Entra ID
```

The important distinction is:

> **Microsoft Graph PowerShell is PowerShell being used as a client for Microsoft Graph.**

It is not a completely separate directory technology.

---

# 32. Microsoft Graph PowerShell

For current Microsoft Entra administration, use the Microsoft Graph PowerShell modules rather than treating older Azure AD/MSOnline cmdlets as the model for current administration.

Install the relevant module if required:

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
```

Connect:

```powershell
Connect-MgGraph -Scopes "AdministrativeUnit.ReadWrite.All"
```

The account used must have the appropriate permissions for the operation.

---

# 33. Create an Administrative Unit with Microsoft Graph PowerShell

Example:

```powershell
$params = @{
    displayName = "FT-HR"
    description = "FinTrust HR administrative boundary"
    membershipType = "Assigned"
}

New-MgDirectoryAdministrativeUnit -BodyParameter $params
```

### What the parameters mean

| **Parameter**    | **Purpose**                            |
| ---------------- | -------------------------------------- |
| `displayName`    | Name displayed for the AU              |
| `description`    | Describes the AU                       |
| `membershipType` | Determines assigned/dynamic membership |

---

# 34. Create a Dynamic Administrative Unit

Example:

```powershell
$params = @{
    displayName = "FT-Finance-Dynamic"
    description = "FinTrust Finance dynamic administrative unit"
    membershipType = "Dynamic"
    membershipRule = '(user.department -eq "Finance")'
    membershipRuleProcessingState = "On"
}

New-MgDirectoryAdministrativeUnit -BodyParameter $params
```

The important part is:

```powershell
membershipType = "Dynamic"
```

combined with:

```powershell
membershipRule = '(user.department -eq "Finance")'
```

and:

```powershell
membershipRuleProcessingState = "On"
```

---

# 35. List Administrative Units

Use:

```powershell
Get-MgDirectoryAdministrativeUnit
```

To inspect a specific AU:

```powershell
Get-MgDirectoryAdministrativeUnit |
    Where-Object {$_.DisplayName -eq "FT-HR"}
```

---

# 36. Store the AU ID

An Administrative Unit has a unique ID.

Example:

```powershell
$au = Get-MgDirectoryAdministrativeUnit |
    Where-Object {$_.DisplayName -eq "FT-HR"}

$au.Id
```

You will use this ID when working with Graph operations involving the AU.

Conceptually:

```text
FT-HR
  ↓
Administrative Unit ID
  ↓
Graph API operations
```

---

# 37. Add a User to an Administrative Unit

Microsoft Graph represents the AU membership as a relationship between the AU and the directory object.

A Graph request has the form:

```http
POST https://graph.microsoft.com/v1.0/directory/administrativeUnits/{administrativeUnitId}/members/$ref
```

For a user, the request body identifies the user's directory object.

Conceptually:

```json
{
    "@odata.id": "https://graph.microsoft.com/v1.0/users/{user-id}"
}
```

This adds the user as a direct AU member.

---

# 38. List AU Members

Graph:

```http
GET https://graph.microsoft.com/v1.0/directory/administrativeUnits/{administrativeUnitId}/members
```

The result can contain:

```text
Users
Groups
Devices
```

depending on the AU's membership.

PowerShell can be used to retrieve and inspect the corresponding directory objects.

---

# 39. Assigning a Role with AU Scope

The important concept in Graph PowerShell is the directory scope.

Tenant-wide scope:

```text
/
```

Administrative Unit scope:

```text
/administrativeUnits/{administrativeUnitId}
```

Conceptually:

```text
Role assignment
      │
      ├── Principal
      │      ↓
      │   Brian
      │
      ├── Role definition
      │      ↓
      │   User Administrator
      │
      └── Directory scope
             ↓
       /administrativeUnits/{id}
```

This is what makes the assignment scoped to the AU rather than tenant-wide.

---

# 40. Portal vs Graph PowerShell

| **Method**                 | **What you are doing**                    | **Best learning value**            |
| -------------------------- | ----------------------------------------- | ---------------------------------- |
| Entra admin center         | Configure through GUI                     | Understand administrative workflow |
| Microsoft Graph PowerShell | Automate Graph operations from PowerShell | Learn practical automation         |
| Microsoft Graph API        | Call directory APIs directly              | Understand underlying API model    |

For your SC-300 project:

```text
Portal
  +
Graph PowerShell
  +
Understanding Graph API
```

is a useful combination.

The portal shows **what the administrator does**.

Graph PowerShell shows **how the task can be automated**.

Graph API shows **what the underlying directory operation represents**.

---

# 41. Troubleshooting

| **Problem**                                        | **Possible Cause**                                      | **What to Check**                                    |
| -------------------------------------------------- | ------------------------------------------------------- | ---------------------------------------------------- |
| AU cannot be created                               | Insufficient permissions                                | Check assigned Entra role                            |
| Cannot add existing user                           | Insufficient permissions                                | Check AU/member-management permissions               |
| User is not appearing                              | Membership not added or dynamic rule has not matched    | Check AU membership                                  |
| Group appears but its users cannot be managed      | Group was added, not individual users                   | Add users directly to AU if required                 |
| Scoped administrator can manage unexpected objects | Administrator has another broader role                  | Review all role assignments                          |
| Scoped administrator cannot manage an AU member    | Role may not support required operation                 | Check role permissions                               |
| Dynamic AU membership is not changing              | Rule processing or user attributes                      | Check rule and processing state                      |
| Dynamic AU cannot be manually edited               | Dynamic membership controls membership                  | Modify the rule instead                              |
| User outside AU cannot be managed                  | Expected scope restriction                              | Confirm the role assignment scope                    |
| Tenant-wide setting cannot be changed              | AU-scoped role does not provide tenant-wide permissions | Use appropriately scoped tenant-level administration |
| AU nesting attempt fails                           | AUs cannot be nested                                    | Use separate AUs                                     |
| Intune device management unavailable through AU    | AU device support does not extend to Intune management  | Use the appropriate Intune management model          |
| Scoped test gives unexpected result                | Test account has another role                           | Review effective permissions                         |

---

# 42. Common Mistakes

| **Mistake**                                                       | **Why It Is Wrong**                                                      | **Correct Approach**                           |
| ----------------------------------------------------------------- | ------------------------------------------------------------------------ | ---------------------------------------------- |
| Thinking an AU is just a group                                    | AU's primary purpose is administrative scope                             | Think management boundary                      |
| Giving an administrator tenant-wide User Administrator            | Grants broader scope than required                                       | Assign the role with AU scope when appropriate |
| Adding only a group to an AU and expecting its users to be scoped | Group membership does not automatically scope individual users           | Add users directly to the AU                   |
| Assuming AU membership grants permissions                         | AU membership alone does not make someone an administrator               | Assign an appropriate role                     |
| Assuming AU scope changes the role's permissions                  | Scope limits where the role applies, not what the role is                | Understand role + scope                        |
| Assuming all Entra roles support AU scope                         | Only supported roles/custom roles can be scoped appropriately            | Check role support                             |
| Treating AUs as hierarchical                                      | AUs cannot be nested                                                     | Use separate AUs                               |
| Manually editing a dynamic AU                                     | Dynamic membership is rule-controlled                                    | Change the membership rule                     |
| Assuming AU scope grants tenant-wide configuration access         | AU scope is intentionally limited                                        | Use appropriate tenant-level administration    |
| Assuming an AU automatically hides all objects                    | Visibility and administrative scope are different concepts               | Understand `visibility` separately             |
| Testing with a Global Administrator                               | Global Administrator can invalidate a scope test                         | Use a dedicated test administrator             |
| Assuming Free licensing provides every AU capability              | Scoped administration and dynamic membership have licensing requirements | Check the relevant licensing requirement       |

---

# 43. Exam-Focused Knowledge

# What You Should Be Able to Explain

### 1. What is an Administrative Unit?

An Administrative Unit is a Microsoft Entra container and administrative boundary that can contain users, groups, or devices and can be used to scope supported administrative roles.

### 2. Why is an AU used?

To delegate supported administration over a defined subset of directory objects rather than automatically giving the administrator tenant-wide scope.

### 3. Does an AU itself grant administrative permissions?

No.

The AU provides the scope. A suitable Microsoft Entra role provides the permissions.

### 4. What is the difference between role and scope?

```text
Role
 ↓
What the administrator can do

Scope
 ↓
Where the administrator can do it
```

### 5. Can an AU contain users?

Yes.

### 6. Can an AU contain groups?

Yes.

### 7. Can an AU contain devices?

Yes.

### 8. If a group is placed in an AU, are all group members automatically in the AU?

No.

The group itself is in the AU's management scope. Its individual members are not automatically AU members.

### 9. Can a user belong to multiple AUs?

Yes.

### 10. Can AUs be nested?

No.

### 11. Can an AU use dynamic membership?

Yes, for supported dynamic user or device membership.

### 12. Can dynamic AU membership contain users and devices in the same dynamic AU?

No. A dynamic AU is currently configured for users or devices rather than both together.

### 13. Can groups use dynamic membership rules inside an AU?

Dynamic membership rules for groups as AU membership are not supported.

### 14. Does an AU-scoped role provide tenant-wide permissions?

No.

The role assignment is scoped to the Administrative Unit for supported operations.

### 15. Can an AU-scoped administrator change tenant-wide settings?

Not merely because the role is assigned at AU scope.

### 16. What happens if a role is assigned without AU scope?

The role assignment is generally tenant-wide rather than limited to an AU.

### 17. What license is required for an AU administrator using directory roles over the AU?

Microsoft Entra ID P1 is required for each administrative unit administrator assigned directory roles over the AU scope.

### 18. What is a Restricted Management Administrative Unit?

It is an Administrative Unit designed to provide stronger protection for sensitive members by restricting management of those members to appropriately scoped administrators.

---

# 44. Scenario Recognition

| **If the question says...**                                                  | **Think about...**                        |
| ---------------------------------------------------------------------------- | ----------------------------------------- |
| "Delegate administration over only the HR users"                             | Administrative Unit                       |
| "Allow an administrator to manage users in one department"                   | AU-scoped role                            |
| "The administrator must not have tenant-wide User Administrator permissions" | AU-scoped User Administrator              |
| "The HR group is in the AU but its users cannot be managed"                  | Group vs direct AU membership             |
| "Automatically include users whose department is Finance"                    | Dynamic Administrative Unit               |
| "Automatically include Windows devices"                                      | Dynamic device Administrative Unit        |
| "The administrator needs tenant-wide group settings"                         | AU scope is insufficient                  |
| "Protect sensitive executives from ordinary tenant-scoped management"        | Restricted Management Administrative Unit |
| "Create an AU and manually select members"                                   | Assigned membership                       |
| "Change membership based on user attributes"                                 | Dynamic membership                        |
| "Place one Administrative Unit inside another"                               | Not supported                             |
| "A user belongs to two administrative boundaries"                            | Multiple AU membership                    |

---

# 45. The Most Important Scenario Pattern

When an SC-300 question contains:

```text
"Only"
"Specific department"
"Specific region"
"Subset of users"
"Delegated administration"
"Without tenant-wide permissions"
"Manage users in one organizational unit"
```

think:

```text
Administrative Unit
        +
AU-scoped Microsoft Entra role
```

Do not immediately think:

```text
Group
```

because the question is about **administration**, not merely membership.

---

# 46. AU vs Group — Final Exam Comparison

| **Requirement**                                                       | **Think**                                 |
| --------------------------------------------------------------------- | ----------------------------------------- |
| Users need access to an application                                   | Group                                     |
| Users need a license through group-based licensing                    | Group                                     |
| Users need to be managed as a collection for access                   | Group                                     |
| Automatically include users based on attributes for membership/access | Dynamic Group                             |
| Delegate administration over only a subset of users                   | Administrative Unit                       |
| Scope User Administrator to HR users                                  | Administrative Unit                       |
| Scope supported group administration to a defined set of groups       | Administrative Unit                       |
| Protect a sensitive administrative population                         | Restricted Management Administrative Unit |

The key question is:

```text
Is the requirement about ACCESS/MEMBERSHIP?

        ↓
       GROUP


Is the requirement about ADMINISTRATION/SCOPE?

        ↓
ADMINISTRATIVE UNIT
```

---

# 47. Final Mental Model

```text
                 ADMINISTRATIVE UNIT
                         │
             Defines an administrative
                    boundary
                         │
          ┌──────────────┼──────────────┐
          │              │              │
        Users          Groups         Devices
          │
          ↓
    Scoped role can
    manage supported
    operations
          │
          ↓
   Microsoft Entra Role
          │
          ↓
      Administrator
```

The complete model is:

```text
                    WHO?
                     │
              Administrator
                     │
                     ↓
                    WHAT?
                     │
             Microsoft Entra Role
                     │
                     ↓
                    WHERE?
                     │
          Administrative Unit
                     │
                     ↓
                  OBJECTS
          ┌──────────┼──────────┐
          │          │          │
        Users      Groups     Devices
```

## The five concepts to remember

```text
1. AU = administrative boundary

2. Role = permissions

3. AU scope = where those permissions apply

4. Group membership ≠ AU membership

5. AU membership alone ≠ administrative permission
```

### One-sentence mental model

> **An Administrative Unit is a scoped management boundary that allows supported Microsoft Entra roles to be delegated over selected users, groups, or devices without automatically granting the administrator the same permissions across the entire tenant.**
