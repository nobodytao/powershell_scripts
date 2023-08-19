$TodayDateTime_3months=(Get-Date).addMonths(-3)

$users = Get-ADUser -Filter * -SearchBase "DC=dom,DC=com" -properties SamAccountName, Pwdlastset, Enabled
foreach ($user in $users)
    {
    $PassLastSet=[datetime]::FromFileTime($user.pwdlastset)
    $SamAccName=$user.SamAccountName
    $IsEnabled=$user.Enabled
    if ($PassLastSet -lt $TodayDateTime_3months)
        {
        echo "$SamAccName	$user	$PassLastSet	$IsEnabled" >> c:\spisok\PwdLastSet_3MonthsAgo.txt
        }
    }