# Azure AD App Role Assignment

PowerShell script to automate Azure AD Enterprise App role assignments using Microsoft Graph API. Assigns users to specific app roles (e.g., "User") in bulk via CSV.

## 📌 Features
- Bulk assign users from a CSV file
- Checks for duplicate assignments
- Supports delegated or application permissions
- Error handling & logging

## ⚙️ Prerequisites
- PowerShell 7+
- Microsoft.Graph module (`Install-Module Microsoft.Graph`)
- Azure AD permissions (User.ReadWrite.All, AppRoleAssignment.ReadWrite.All)

## 🚀 Usage
1. **Prepare a CSV file** (`users.csv`) with `UserPrincipalName` column.
2. **Update the script** with your `$appId`.
3. **Run the script**: | If you continue to have issues, try: Running with application permissions (Connect-MgGraph -Scopes "Application.ReadWrite.All")
   ```powershell
   .\Assign-AppRoles.ps1