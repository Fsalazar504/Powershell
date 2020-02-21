#Grabs Printers with Status 
$PrinterStatus = Get-Printer | Where-Object PrinterStatus -like '*offline*' | Select name, printerstatus
(Get-Printer | Select-Object -Property Name, Shared, PrinterStatus) | Where-Object {$_.PrinterStatus -notlike "*Normal*"} 
(Get-Printer | Select-Object -Property Name, Shared, PrinterStatus) | Where-Object {$_.PrinterStatus -like "*TonerLow*"} 


#Create and convert txt to Html file
$PrinterStatus | ConvertTo-Html | Out-File -FilePath C:\SomePath\Printers.txt #For "SomePath" enter a desired destination

#Sends mail
$Body = Get-Content -Path C:\SomePath\Printers.txt
Send-MailMessage -From PrinterAdmin@email.com -To User@email.com ` #Enter your own email fields for each @email.com variable
 -Subject 'Printer Error Report' -Body "<font size= 5><b>This is a test of printer status</b></font> <p>$Body</p>" -BodyAsHtml `
 -Priority High -DeliveryNotificationOption OnSuccess, OnFailure -SmtpServer 'smtp.server.com' #For -SmtpServer enter smtp server of choice

