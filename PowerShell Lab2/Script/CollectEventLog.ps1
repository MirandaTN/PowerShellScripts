
# Define the CSV file path
$CSVPath = "InsertAbsolutePathHere\EventLogs.csv"

# Collect the event log information from your laptop
Get-EventLog -LogName System -EntryType Error, Warning -Newest 100 |
    Export-Csv -Path $CSVPath -NoTypeInformation -Force

# Define the email parameters
$SMTPServer = "smtp.gmail.com"
$SMTPPort = 587
$SMTPUser = "YourEmailAddress"
$EmailAddress = "YourEmailAddress"
$SMTPPassword = "YourGoogoleAppPassword"  # Use an app password for Gmail, NOT YOUR GOOGLE ACCOUNT PASSWORD
$EmailSubject = "Event Log Collection Results"
$EmailBody = "Please find attached the CSV file with the collected event log information."

# Send the email with the CSV file attached
if (Test-Path $CSVPath) {
    Send-MailMessage -To $EmailAddress -From $SMTPUser -Subject $EmailSubject -Body $EmailBody `
        -Attachments $CSVPath -SmtpServer $SMTPServer -Port $SMTPPort `
        -Credential (New-Object PSCredential($SMTPUser,(ConvertTo-SecureString $SMTPPassword -AsPlainText -Force))) `
        -UseSsl
    Write-Host "Email sent successfully to $EmailAddress." -ForegroundColor Green
} else {
    Write-Host "CSV file not found, skipping email." -ForegroundColor Yellow
}
