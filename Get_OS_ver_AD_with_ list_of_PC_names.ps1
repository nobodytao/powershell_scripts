foreach ($user in get-content C:\PC.txt)
{ 

$Comp = Get-ADComputer -Filter {(cn -like $user)} -SearchBase "DC=dom,DC=com" -Properties lastlogon, lastlogontimestamp, distinguishedName, operatingSystem, operatingsystemversion

$CompOS = $Comp.operatingSystem

    $CompName = $Comp.SamAccountName
    #$CompOSSP = $Comp.operatingSystemServicePack
    $CompOSVer = $Comp.operatingsystemversion
    echo "$Comp	$CompName	$CompOS	$CompOSVer" >> c:\PCsOSandOSVersion.txt
} 