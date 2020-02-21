#Grabs Printers with Status 
$PrinterStatus = Get-Printer | Where-Object PrinterStatus -like '*offline*' | Select name, printerstatus
(Get-Printer | Select-Object -Property Name, Shared, PrinterStatus) | Where-Object {$_.PrinterStatus -notlike "*Normal*"} 
(Get-Printer | Select-Object -Property Name, Shared, PrinterStatus) | Where-Object {$_.PrinterStatus -like "*TonerLow*"} 


#Create and convert txt to Html file
$PrinterStatus | ConvertTo-Html | Out-File -FilePath C:\Options\Printers.txt

#Sends mail
$Body = Get-Content -Path C:\Options\Printers.txt
Send-MailMessage -From LBLPrint-Status@lbl.gov -To embedded-It@lbl.gov `
 -Subject 'Printer Error Report' -Body "<font size= 5><b>This is a test of printer status</b></font> <p>$Body</p>" -BodyAsHtml `
 -Priority High -DeliveryNotificationOption OnSuccess, OnFailure -SmtpServer 'smtp.lbl.gov'

