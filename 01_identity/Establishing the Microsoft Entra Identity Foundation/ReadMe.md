# 01 — Establishing the Microsoft Entra Identity Foundation

---

## 1. Project Objective

Today we establish the initial Microsoft Entra ID identity foundation for FinTrust Financial Services.

The implementation will focus on:

- Users
- Groups
- Administrative Units
- Microsoft Entra roles
- Identity organization
- Group membership
- Basic Microsoft Graph operations
- Identity troubleshooting
- Least-privilege administration

The objective is to gain practical experience performing identity administration in a scenario that represents a real organization.

---

# 2. FinTrust Environment

Our Fictional FinTrust Financial Services has the following departments:

| Department | Purpose |
|---|---|
| Finance | Financial operations and accounting |
| Human Resources | Employee and personnel management |
| IT | Infrastructure and technical support |
| Cybersecurity | Security monitoring and security operations |
| Customer Support | Customer-facing support |
| Loans | Loan processing and management |
| Management | Business and executive management |

Microsoft Entra ID will serve as the central identity platform for the organization's workforce.

---

# 3. Identity Architecture

The initial identity structure is:

```text
FINTRUST
│
├── Users
│
├── Groups
│
├── Devices
│
├── Applications
│
├── Service Principals
│
├── Administrative Units
│
└── Microsoft Entra Roles

The intended departmental structure is:

FINTRUST
│
├── Finance
├── Human Resources
├── IT
├── Cybersecurity
├── Customer Support
├── Loans
└── Management

# 4. Tenant Information

4.1 Tenant Details
Item	Value
Tenant Name	TODO
Tenant ID	TODO
Primary Domain	TODO
Tenant Type	Workforce
Subscription	TODO
Region	TODO

Do not publish secrets, passwords, access tokens, private keys, or other sensitive information in this repository.

5. User Implementation
5.1 Representative Users

The following fictional identities will be used for the FinTrust lab.

| Name | Department	| Job Title	| Account Type	| Status |
|---|---|
| Alice Wanjiku | Finance | Finance Officer | Member	| TODO |
| Brian Otieno	| Human Resources	| HR Officer	| Member	| TODO |
| David Kamau	| IT	| IT Administrator |	Member | 	TODO |
| Grace Njeri | Cybersecurity |   	Security Analyst	| Member	| TODO |
| James Mwangi	| Loans | Loan Officer	| Member | TODO |
| Mary Achieng	| Customer Support	| Customer Support Officer	| Member | TODO |
| Peter Kariuki	| Management	| Manager	| Member	| TODO|

All identities used in this project are fictional.

5.2 User Attributes

For each user, investigate and configure appropriate attributes such as:

Display name
User principal name
Department
Job title
Account status
Manager
User type
Object ID
Evidence

Screenshot:

screenshots/01-users-created.png
6. Group Implementation
6.1 Naming Convention

The FinTrust group naming convention is:

FT-<Department>-<Purpose>

Examples:

FT-Finance-Users
FT-HR-Users
FT-IT-Users
FT-Cybersecurity-Users
FT-Loans-Users
FT-CustomerSupport-Users
FT-Management-Users
6.2 Groups Created
Group	Type	Membership	Purpose	Status
FT-Finance-Users	Security	Assigned	Finance users	TODO
FT-HR-Users	Security	Assigned	HR users	TODO
FT-IT-Users	Security	Assigned	IT users	TODO
FT-Cybersecurity-Users	Security	Assigned	Cybersecurity users	TODO
FT-Loans-Users	Security	Assigned	Loans users	TODO
FT-CustomerSupport-Users	Security	Assigned	Customer Support users	TODO
FT-Management-Users	Security	Assigned	Management users	TODO
6.3 Group Membership
Group	Expected Members	Verified
FT-Finance-Users	Alice Wanjiku	TODO
FT-HR-Users	Brian Otieno	TODO
FT-IT-Users	David Kamau	TODO
FT-Cybersecurity-Users	Grace Njeri	TODO
FT-Loans-Users	James Mwangi	TODO
FT-CustomerSupport-Users	Mary Achieng	TODO
FT-Management-Users	Peter Kariuki	TODO
7. Group Design Decision
Why use groups?

FinTrust should avoid managing access by assigning permissions individually to every user whenever a group-based approach is appropriate.

The intended model is:

User
  ↓
Group
  ↓
Resource / Application / Permission

Instead of:

User
  ↓
Individual Permission

This improves:

Manageability
Consistency
Access reviews
User onboarding
User offboarding
Least-privilege administration
Scalability
8. Assigned vs Dynamic Groups

During the lab, investigate the difference between:

Assigned membership

Membership is manually assigned by an administrator.

Administrator
      ↓
Group
      ↓
User
Dynamic membership

Membership is determined using rules based on user or device attributes.

User attributes
      ↓
Dynamic membership rule
      ↓
Group membership
Lab investigation

Record what you discovered:

Assigned membership:

TODO

Dynamic membership:

TODO

When would FinTrust use dynamic membership?

TODO

9. Administrative Units

Administrative Units can be used to create administrative boundaries within the organization.

Potential FinTrust AUs:

AU-Finance
AU-HR
AU-IT
AU-Cybersecurity
Administrative Units Created
Administrative Unit	Scope	Created	Purpose
AU-Finance	Finance identities	TODO	TODO
AU-HR	HR identities	TODO	TODO
AU-IT	IT identities	TODO	TODO
AU-Cybersecurity	Security identities	TODO	TODO

If the tenant does not provide the required functionality or licensing, document that instead of attempting to bypass the limitation.

10. Administrative Boundary Investigation

For each AU, investigate:

Which users can be included?
Which devices can be included?
What administration can be scoped?
Which roles can be assigned with AU scope?
Why would delegated administration be useful?
Findings

TODO

11. Microsoft Entra Roles

Investigate the following roles:

Global Administrator
User Administrator
Groups Administrator
Authentication Administrator
Helpdesk Administrator
Security Administrator
11.1 Role Investigation
Role	Purpose	Appropriate FinTrust Responsibility
Global Administrator	TODO	Highly restricted
User Administrator	TODO	User administration
Groups Administrator	TODO	Group administration
Authentication Administrator	TODO	Authentication administration
Helpdesk Administrator	TODO	Support operations
Security Administrator	TODO	Security administration
12. Least Privilege

FinTrust should follow the principle of least privilege.

The administrator should receive only the permissions required to perform their assigned responsibilities.

The lab should demonstrate why:

Global Administrator
        ≠
Default administrator role for everyone

Instead:

Responsibility
      ↓
Required permission
      ↓
Appropriate Entra role
Lab finding

What did you learn about assigning the minimum required administrative permissions?

TODO

13. Azure RBAC vs Microsoft Entra Roles

Investigate the difference between:

Microsoft Entra roles

Used primarily to manage:

Microsoft Entra ID
Users
Groups
Applications
Identity settings
Directory objects
Azure RBAC

Used to control access to Azure resources such as:

Virtual Machines
Storage Accounts
Virtual Networks
Key Vaults
Resource Groups
Subscriptions
Investigation Result

Microsoft Entra role:

TODO

Azure RBAC role:

TODO

Key difference:

TODO

14. Microsoft Graph Investigation

Microsoft Graph provides programmatic access to Microsoft 365 and Microsoft Entra resources.

Initial investigation:

GET https://graph.microsoft.com/v1.0/users

Then:

GET https://graph.microsoft.com/v1.0/groups

The relationship being investigated is:

Microsoft Entra Admin Center
          ↓
   Microsoft Graph
          ↓
   Identity Objects
14.1 Graph Results
Users request
GET /v1.0/users

Result:

TODO

Groups request
GET /v1.0/groups

Result:

TODO

Graph observation

TODO

15. Troubleshooting Scenario
Scenario

A Finance user has accidentally been placed in the IT group.

The affected identity is:

User: Alice Wanjiku
Expected group: FT-Finance-Users
Incorrect group: FT-IT-Users
15.1 Problem

TODO

15.2 Investigation

Follow the identity relationship:

User
 ↓
Group membership
 ↓
Assigned permissions/access
 ↓
Administrative boundary
Investigation steps
Locate the affected user.
Review the user's group memberships.
Identify the incorrect group.
Determine how the membership was assigned.
Check whether the membership creates additional access.
Remove the incorrect membership if appropriate.
Verify the correction.
Document the result.
15.3 Root Cause

TODO

15.4 Correction

TODO

15.5 Verification

TODO

15.6 Lesson Learned

TODO

16. Testing

The following tests should be completed before closing Day 1.

Test	Expected Result	Actual Result	Status
User creation	User exists	TODO	TODO
User attributes	Correct attributes	TODO	TODO
Finance group membership	Alice belongs to Finance	TODO	TODO
HR group membership	Brian belongs to HR	TODO	TODO
IT group membership	David belongs to IT	TODO	TODO
Cybersecurity group membership	Grace belongs to Cybersecurity	TODO	TODO
Loans group membership	James belongs to Loans	TODO	TODO
Customer Support membership	Mary belongs to Customer Support	TODO	TODO
Management membership	Peter belongs to Management	TODO	TODO
Administrative Units	Expected AUs exist or limitation documented	TODO	TODO
Role investigation	Roles understood	TODO	TODO
Graph users request	Request investigated	TODO	TODO
Graph groups request	Request investigated	TODO	TODO
Troubleshooting scenario	Incorrect membership corrected	TODO	TODO
17. Evidence

Screenshots should demonstrate meaningful work rather than simply showing the portal.

Recommended evidence:

Screenshot 1 — Tenant Overview
screenshots/01-tenant-overview.png
Screenshot 2 — Users
screenshots/02-users.png
Screenshot 3 — Groups
screenshots/03-groups.png
Screenshot 4 — Administrative Units
screenshots/04-administrative-units.png
Screenshot 5 — Roles
screenshots/05-roles.png
Screenshot 6 — Graph Explorer
screenshots/06-graph-explorer.png
Screenshot 7 — Troubleshooting Evidence
screenshots/07-troubleshooting.png

Only retain screenshots that contain useful evidence. Do not expose passwords, tokens, secrets, or other sensitive information.

18. Problems Encountered

Document problems encountered during implementation.

Problem	Investigation	Resolution
TODO	TODO	TODO
TODO	TODO	TODO
19. Knowledge Gaps

Record concepts that were not fully understood.

Concept	What I Don't Understand	Investigation	Final Understanding
TODO	TODO	TODO	TODO
TODO	TODO	TODO	TODO
20. SC-300 Concepts Demonstrated

This project provides practical exposure to:

Microsoft Entra tenant architecture
User management
User attributes
Member accounts
Guest identities
Security groups
Group membership
Assigned membership
Dynamic membership
Administrative Units
Microsoft Entra roles
Role assignment
Least privilege
Delegated administration
Microsoft Graph
Identity troubleshooting
21. End-of-Day Knowledge Check

Before marking Day 1 complete, explain each concept without looking at notes.

 What is Microsoft Entra ID?
 What is an Entra tenant?
 What is the difference between a tenant and an Azure subscription?
 What is a user object?
 What is a member user?
 What is a guest user?
 What is a security group?
 What is assigned membership?
 What is dynamic membership?
 Why use groups for access management?
 What is an Administrative Unit?
 Administrative Unit vs group?
 What is a Microsoft Entra role?
 Entra role vs Azure RBAC?
 What is least privilege?
 Why should Global Administrator access be restricted?
 What does User Administrator do?
 What does Groups Administrator do?
 What is Microsoft Graph?
 How does Graph interact with Entra?
 How would you investigate incorrect group membership?
 How would you document an identity administration problem?
22. Final Reflection
What I implemented

TODO

What I understood

TODO

What challenged me

TODO

What failed

TODO

How I fixed it

TODO

What I would do differently in a production environment

TODO

Most important lesson from Day 1

TODO

23. Day 1 Completion Criteria
Knowledge
 Tenant
 Users
 Groups
 Dynamic groups
 Administrative Units
 Entra roles
 Least privilege
 Microsoft Graph basics
Hands-on
 Navigated Microsoft Entra admin center
 Created/tested users
 Created groups
 Tested group membership
 Investigated Administrative Units
 Investigated Entra roles
 Used Graph Explorer
 Performed troubleshooting scenario
Portfolio
 README completed
 Implementation documented
 Testing documented
 Troubleshooting documented
 3–5 meaningful screenshots captured
 Sensitive information removed
 Git commit created
 GitHub repository updated
Exam Preparation
 Microsoft Learn knowledge checks completed
 SC-300 practice questions completed
 Mistake log updated
 Knowledge gaps recorded
24. Git Commit

Suggested commit message:

git add .
git commit -m "Day 1: establish FinTrust Entra identity foundation"
git push
25. Project Status

Day 1 Status: IN PROGRESS

Implementation: TODO

Testing: TODO

Troubleshooting: TODO

Documentation: TODO

GitHub: TODO

SC-300 readiness: TODO



