import-module activedirectory

$User="UserName"

$ADUser = Get-ADUser $User -Properties objectSID
$SidUser='cmd /c REG ADD "HKEY_USERS\'+$ADUser.objectSID.Value+'\Software\Microsoft\Windows\CurrentVersion\WinTrust\Trust Providers\Software Publishing" /v "State" /t REG_DWORD /d 0x00023c00 /f'

echo "$SidUser"

