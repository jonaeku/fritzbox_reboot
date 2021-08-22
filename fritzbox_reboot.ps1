#First you have to allow running local scripts
#Start Powershell as Administartor
#Type : Set-ExecutionPolicy RemoteSigned

# How to make this script double clickable ;) 
# Press right mouse button on Desktop and choose "Neue Verknüpfung" (new link) 
# Type : %windir%\System32\WindowsPowerShell\v1.0\powershell.exe -noexit -File "[Dateipfad]\fritzbox_reboot.ps1


#--- The credentials of the fritzbox - user youve created before ---
$credentials = Get-Credential

#--- The IP's of the fritz devices you want to restart (in chronological order -> main fritzbox last)
$IPS = "192.168.178.1"

$headers = @{}
$headers.Add("Content-Type","text/xml; charset='utf-8'")
$headers.Add("SoapAction", "urn:dslforum-org:service:DeviceConfig:1#Reboot")

foreach ($IP in $IPS) {
    Invoke-WebRequest -Method Post -Uri http://$($IP):49000/upnp/control/deviceconfig -Headers $headers -Credential $credentials -Body "<?xml version='1.0' encoding='utf-8'?><s:Envelope s:encodingStyle='http://schemas.xmlsoap.org/soap/encoding/' xmlns:s='http://schemas.xmlsoap.org/soap/envelope/'><s:Body><u:Reboot xmlns:u='urn:dslforum-org:service:DeviceConfig:1'></u:Reboot></s:Body></s:Envelope>"   
}




