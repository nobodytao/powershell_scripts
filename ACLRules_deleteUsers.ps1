
$MyOU = "OU=unitname,DC=domname,DC=domname" 

$Filename = "C:\temp\OU_Clean.log"

echo "AD_Object	IdentityReferenceType	IdentityReference	AccessControlType	ActiveDirectoryRights	InheritanceFlags	InheritanceType	IsInherited	ObjectFlags	ObjectType	PropagationFlags" > $Filename

$Separator='\\'

$AD_Objects = Get-ADOrganizationalUnit -SearchBase $MyOU -SearchScope Subtree -Filter *  -Properties nTSecurityDescriptor

foreach ($AD_Object in $AD_Objects)
    {
    $Access_Rules = Get-Acl -Path "AD:\$AD_Object"

    $ouacl=$AD_Object.nTSecurityDescriptor

    foreach ($Access_Rule in $Access_Rules.access)
        {
        $OuAccessControlType=$Access_Rule.AccessControlType               #Allow\Deny 
        $OuActiveDirectoryRights=$Access_Rule.ActiveDirectoryRights       #Rights
        $OuIdentityReference=$Access_Rule.IdentityReference               #User, Group or other
        $OuIdentityReferenceName=$OuIdentityReference -split $Separator   #split DomainName\UserOrGroupName on "DomainName" and "UserOrGroupName"
        $OuIdentityReferenceDomain=$OuIdentityReferenceName[0]
        $OuIdentityReferenceType="NotUser"
        if (($OuIdentityReferenceDomain.Length -lt 5)-and($OuIdentityReferenceDomain -ne "domname")-and($OuIdentityReferenceDomain -ne "Everyone")) #is it domain or not
            {
            $OuIdentityReferenceObject=$OuIdentityReferenceName[1]
            if (Get-ADUser -Filter {SamAccountName -eq $OuIdentityReferenceObject} -Server "$OuIdentityReferenceDomain.oao.rzd") 
                {
                $OuIdentityReferenceType="User"
                $ouacl.RemoveAccessRule($Access_Rule)    #If it's user, then delete this rule
                Set-ADOrganizationalUnit $AD_Object -Replace @{nTSecurityDescriptor = $ouacl}
                }
            } 

        $OuInheritanceFlags=$Access_Rule.InheritanceFlags
        $OuInheritanceType=$Access_Rule.InheritanceType                   
        $OuInheritedObjectType=$Access_Rule.InheritedObjectType          
        $OuIsInherited=$Access_Rule.IsInherited
        $OuObjectFlags=$Access_Rule.ObjectFlags
        $OuObjectType=$Access_Rule.ObjectType
        $OuPropagationFlags=$Access_Rule.PropagationFlags

        echo "$AD_Object	$OuIdentityReferenceType	$OuIdentityReference"   #Show log on screen
        echo "$AD_Object $OuIdentityReferenceType $OuIdentityReference $OuActiveDirectoryRights $OuInheritanceFlags $OuInheritanceType $OuIsInherited $OuObjectFlags $OuObjectType $OuPropagationFlags" >> $Filename
        }
    }
