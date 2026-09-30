Users.

### User - A single personal verifiable identity in Microsoft Entra ID.

> Objective: FinTrust has a new employees. To create and onboard these identities to Microsoft Entra ID!

FinTrust is hiring employees across Finance, HR, IT, Cybersecurity, Loans and Customer Support.<br>

The IAM administrator must be able to onboard:<BR><BR>

- One employee quickly;
- Dozens/hundreds of employees;
- Users through automation;
- Users originating from an HR process.

The administrator must also understand what happens after creation:<BR>

HR request<BR>
    ↓<BR>
Create identity<BR>
    ↓<BR>
Configure identity<BR>
    ↓<BR>
Assign groups<BR>
    ↓<BR>
Assign appropriate access<BR>
    ↓<BR>
Authentication requirements<BR>
    ↓<BR>
User starts work<BR>


#### How do we onboard users in Microsoft Entra: There are 5 practical onboarding approaches.

1. Portal — single-user creation & bulk user creation
2. Azure CLI — scripted user creation
3. Microsoft Graph — API-based user creation
4. Automation/lifecycle — understand how HR-driven onboarding works


#### Single-user Creation

This is the simplest method.<br>

Go to: Microsoft Entra admin center → Identity → Users → All users → New user<br>

This is my first FinTrust employee.<BR>

Use something like:

Property	Value
Display name	Alice Wanjiku
User principal name	AliceW@domain.onmicrosoft.com
Job title	Finance Officer
Department	Finance Resources
Usage location	Kenya
Account status	Enabled

![alt text](<../../Screenshots/01_first-user _AliceW.png>)<BR>


#### Bulk-user Creation

Now imagine HR sends you 10 new employees.<br>

Creating them individually would be repetitive.<br>

Microsoft Entra provides bulk user operations using CSV.<br>


![alt text](<../../Screenshots/001_csv_bulk users.png>)<br>

Uplaod in the bilk user creation section.<br>

![alt text](../../Screenshots/02_Creating_users_in_bulk.png)

The the users in bulk using CSV results.<br>
![alt text](/Screenshots/03_See_my_first_batch_of_new_users.png)<br>
Check them out.

###### Troubleshooting.

I create a file With an error to check what will happen when I upload it.<br>Check the last person UPN it has .con instead of .com.
![alt text](../../Screenshots/06_error_photo_csv.png)<br>
 Boom! It was rejected.<br>
![alt text](../../Screenshots/06_error_csv.png)


#### Azure CLI — scripted user creation

We can create user directly with CLI.<br>

![alt text](../../Screenshots/08_powershell_single_user.png)<br>

Bulk users<br>
[text](../../CLI/w1-bulk-create-users.sh)<br>
![alt text](../../Screenshots/09_bulk_users_cli.png)<br>


#### Graph Powershell