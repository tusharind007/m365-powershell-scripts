# Connect to Microsoft Graph
Connect-MgGraph

# Set the Application (Enterprise App) Object ID
$appId = "Your-App-ID"

# Import the CSV file containing user details
$users = Import-Csv -Path "your-Users-csv"

# Get the Service Principal (Enterprise Application)
$servicePrincipal = Get-MgServicePrincipal -Filter "appId eq '$appId'"

# Get the "User" app role
$appRole = $servicePrincipal.AppRoles | Where-Object { $_.DisplayName -eq "User" }

if (-not $appRole) {
    Write-Host "Error: 'User' app role not found."
    exit
}

# Assign Users to the "User" App Role
foreach ($user in $users) {
    try {
        $userObj = Get-MgUser -UserId $user.UserPrincipalName -ErrorAction Stop
        Write-Host "Processing user: $($user.UserPrincipalName)"
        
        # Check if assignment already exists
        $existingAssignment = Get-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $servicePrincipal.Id | 
            Where-Object { $_.PrincipalId -eq $userObj.Id -and $_.AppRoleId -eq $appRole.Id }
        
        if ($existingAssignment) {
            Write-Host "User $($user.UserPrincipalName) already has the 'User' role assigned"
            continue
        }

        # Create the assignment
        $params = @{
            PrincipalId = $userObj.Id
            ResourceId = $servicePrincipal.Id
            AppRoleId = $appRole.Id
        }
        
        New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $servicePrincipal.Id -BodyParameter $params -ErrorAction Stop
        Write-Host "Successfully assigned 'User' role to $($user.UserPrincipalName)"
    }
    catch {
        Write-Host "Error processing $($user.UserPrincipalName): $_" -ForegroundColor Red
    }
}
