Import-Module ActiveDirectory

$ParentOu = "CN=Name,DC=dom,DC=com"                   

$OUs= (Get-ChildItem -Path AD:\$ParentOu -recurse| where {($_.objectclass -eq “computer”)}) 

foreach ($OU in $OUs)                                              
    {
    $AccList = (Get-Acl -Path "AD:\$OU")
        foreach ($AccL in $AccList)
        {
        $Own=$AccL.Owner                     
        $NamePK=$OU.name
        echo "$NamePK     $Own"
    }
        }

