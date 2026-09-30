## 3. Group Implementation
### 3.1 Naming Convention

The FinTrust group naming convention is:

**FT**-**Department**-**Purpose**

Examples:

- FT-Finance-Users
- FT-HR-Users
- FT-IT-Users
- FT-Cybersecurity-Users
- FT-Loans-Users
- FT-CustomerSupport-Users
- FT-Management-Users

### Understanding Groups

In Microsoft Entra ID, Security groups and Microsoft 365 groups are two different group types because they serve different organizational purposes.

1. #### Security group
A Security group is primarily used to control access and permissions.
In our case a group like **FT-Finance-Users** will be used by **Finance users** who have Access to **Finance resources**

> #### More of what a security group can be used for:

> - Assigning access to applications
> - Assigning Azure resources
> - Controlling access to files/resources
> - Group-based licensing
> - Organizing users for administration

2. #### Microsoft 365 group

A Microsoft 365 group is designed more for collaboration.
It can provide a shared collaboration environment for members, depending on the Microsoft 365 services available in the tenant.

> As a Junior IAM analyst this was the take away: **Security Group** is when need to organize users so I can manage access while **Microsoft 365 group** is when I need a team to collaborate around shared Microsoft 365 resources.

| Membership Type | What It Means | Managed By | Example |
|---|---|---|---|
| Assigned | Members are manually added or removed | Administrator | Add Alice to Finance group |
| Dynamic User | Users are automatically added or removed based on user attributes and rules | Microsoft Entra ID | `department = Finance` |
| Dynamic Device | Devices are automatically added or removed based on device attributes and rules | Microsoft Entra ID | `operatingSystem = Windows` |

**Assigned** is appropriate in small organisation because you're deliberately controlling who belongs to each departmental group.<br>
**Dynamic User** and **Dynamic Device** This is extremely useful in larger organizations. I will dive more into creating this policies in a future project.
