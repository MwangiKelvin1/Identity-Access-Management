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

