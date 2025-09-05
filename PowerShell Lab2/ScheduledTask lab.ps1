###########################################################################
# Scenario: An IT administrator Job

##  Run a PowerShell script every day at 14:30
##  Collect event log information from your pc
##  Save the output to a CSV file
##  The script needs to run under a service account
##  Email the CSV file to a specified email address at completion

# Set the name of the service account to run the task under
$ServiceAccount = "InsertDomain\ServiceAccount"

# Set the path to the PowerShell script
$ScriptPath = "InsertAbsolutePathHere\Script\CollectEventLog.ps1"

# Set the path to save the CSV file
$CSVPath = "InsertAbsolutePathHere\EventLogs.csv"

# Set the email address to send the CSV file to
$EmailAddress = "InsertEmailAddressHere"

# Create the scheduled task action
$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -WindowStyle Hidden -File $ScriptPath"

# Create the scheduled task trigger
$Trigger = New-ScheduledTaskTrigger -Daily -At 14:30PM

# Create the scheduled task settings
$Settings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable

# Create the scheduled task principal
$Principal = New-ScheduledTaskPrincipal -UserID $ServiceAccount -LogonType ServiceAccount -RunLevel Highest
#$Principal = New-ScheduledTaskPrincipal -UserID $ServiceAccount -LogonType Password -RunLevel Highest

# Create the scheduled task
$Task = New-ScheduledTask -Action $Action -Trigger $Trigger -Settings $Settings -Principal $Principal

# Register the scheduled task
Register-ScheduledTask -TaskName "CollectEventLog" -InputObject $Task


