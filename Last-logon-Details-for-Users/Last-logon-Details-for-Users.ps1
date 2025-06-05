connect-exchangeonline
 
$report = @()
$Users = Get-Mailbox -ResultSize Unlimited
Foreach ($User in $Users)
{
  $Row = "" | Select DisplayName,EmailAddress,LastLogOnTime
  $Row.DisplayName = $User.DisplayName
  $Row.EmailAddress = $User.PrimarySmtpAddress
  $Row.LastLogOnTime = (Get-MailboxStatistics -Identity $User.PrimarySMTPaddress).LastLogonTime
  $report += $Row
}
$report | Export-Csv "C:\lastlogonbrook.csv"

###################################################################################
$report = @()
 
$Users = Get-Mailbox -ResultSize Unlimited
 
foreach ($User in $Users) {
    $MailboxType = if ($User.RecipientTypeDetails -eq "UserMailbox") { "User Mailbox" } else { $User.RecipientTypeDetails }
    
    $Row = "" | Select-Object DisplayName, EmailAddress, LastLogOnTime, MailboxType
    
    $Row.DisplayName = $User.DisplayName
    $Row.EmailAddress = $User.PrimarySmtpAddress
    $Row.LastLogOnTime = (Get-MailboxStatistics -Identity $User.PrimarySmtpAddress).LastLogonTime
    $Row.MailboxType = $MailboxType
    
    $report += $Row
}
 
$report | Export-Csv "C:\lastlogonmhada.csv" -NoTypeInformation

