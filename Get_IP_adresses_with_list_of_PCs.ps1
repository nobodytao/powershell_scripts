$Domain_OU = 

foreach ($user in get-content C:\PC.txt)
{ 

$Comp = Get-ADComputer -Filter {(cn -like $user)} -SearchBase "$Domain_OU" -Properties lastlogon, lastlogontimestamp, distinguishedName
$Llog=[datetime]::FromFileTime($Comp.lastlogon)
$LlogTS=[datetime]::FromFileTime($Comp.lastlogontimestamp)
$DN=$Comp.distinguishedName

Try
{
$IP = [System.Net.Dns]::GetHostAddresses("$user")
$IPval=$IP.IPAddressToString
echo "$user	$IPval	$Llog 	$LlogTS	$DN" >> c:\pklog.txt

}
Catch
{
echo "$user	NoIP	$Llog 	$LlogTS	$DN" >> c:\pklog.txt

}

} 