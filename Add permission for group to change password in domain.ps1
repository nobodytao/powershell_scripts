$ParentOu = "OU=Test,DC=dom,DC=com" 
$Group = "NameOfGroup"

$ADSI = [ADSI]"LDAP://$ParentOu"
$NTAccount = New-Object System.Security.Principal.NTAccount($Group)
$IdentityReference = $NTAccount.Translate([System.Security.Principal.SecurityIdentifier])


$ObjectGUID = new-object Guid  00299570-246d-11d0-a768-00aa006e0529 # GUID “Reset Password”

$InheritedObjectGUID = new-object Guid  bf967aba-0de6-11d0-a285-00aa003049e2 # schemaIDGuid for user account

$ADRights = [System.DirectoryServices.ActiveDirectoryRights] "ExtendedRight" 

$Type = [System.Security.AccessControl.AccessControlType] "Allow" 

$InheritanceType = [System.DirectoryServices.ActiveDirectorySecurityInheritance] "Descendents" 

$ACE = new-object System.DirectoryServices.ActiveDirectoryAccessRule $IdentityReference,$ADRights,$Type,$ObjectGUID,$InheritanceType,$InheritedObjectGUID

$ADSI.psbase.ObjectSecurity.SetAccessRule($ACE)
$ADSI.psbase.commitchanges()


<#_____________________________
Comments:
_____________________________
#>

<#
_____________________________
Active Directory Rights:
_____________________________

AccessSystemSecurity	16777216 The right to get or set the SACL in the object security descriptor.

CreateChild	1 The right to create children of the object.

Delete	65536 The right to delete the object.

DeleteChild	2 The right to delete children of the object.

DeleteTree	64 The right to delete all children of this object, regardless of the permissions of the children.

ExtendedRight	256 A customized control access right. For a list of possible extended rights, see the topic "Extended Rights" in the MSDN Library at http://msdn.microsoft.com. For more information about extended rights, see the topic "Control Access Rights" in the MSDN Library at http://msdn.microsoft.com.

GenericAll	983551 The right to create or delete children, delete a subtree, read and write properties, examine children and the object itself, add and remove the object from the directory, and read or write with an extended right.

GenericExecute	131076 The right to read permissions on, and list the contents of, a container object.

GenericRead	131220 The right to read permissions on this object, read all the properties on this object, list this object name when the parent container is listed, and list the contents of this object if it is a container.

GenericWrite	131112 The right to read permissions on this object, write all the properties on this object, and perform all validated writes to this object.

ListChildren	4 The right to list children of this object. For more information about this right, see the topic "Controlling Object Visibility" in the MSDN Library http://msdn.microsoft.com/library.

ListObject	128	The right to list a particular object. For more information about this right, see the topic "Controlling Object Visibility" in the MSDN Library at http://msdn.microsoft.com/library.

ReadControl	131072	The right to read data from the security descriptor of the object, not including the data in the SACL.

ReadProperty	16	The right to read properties of the object.

Self	8	The right to perform an operation that is controlled by a validated write access right.

Synchronize	1048576	The right to use the object for synchronization. This right enables a thread to wait until that object is in the signaled state.

WriteDacl	262144	The right to modify the DACL in the object security descriptor.

WriteOwner	524288	The right to assume ownership of the object. The user must be an object trustee. The user cannot transfer the ownership to other users.

WriteProperty	32	The right to write properties of the object.
#>

<#_____________________________
GUID rights
_____________________________

$guidChangePassword      = new-object Guid ab721a53-1e2f-11d0-9819-00aa0040529b

$guidLockoutTime         = new-object Guid 28630ebf-41d5-11d1-a9c1-0000f80367c1

$guidPwdLastSet          = new-object Guid bf967a0a-0de6-11d0-a285-00aa003049e2

$guidComputerObject      = new-object Guid bf967a86-0de6-11d0-a285-00aa003049e2

$guidUserObject          = new-object Guid bf967aba-0de6-11d0-a285-00aa003049e2

$guidLinkGroupPolicy     = new-object Guid f30e3bbe-9ff0-11d1-b603-0000f80367c1

$guidGroupPolicyOptions  = new-object Guid f30e3bbf-9ff0-11d1-b603-0000f80367c1

$guidResetPassword       = new-object Guid 00299570-246d-11d0-a768-00aa006e0529

$guidGroupObject         = new-object Guid BF967A9C-0DE6-11D0-A285-00AA003049E2                                          

$guidContactObject       = new-object Guid 5CB41ED0-0E4C-11D0-A286-00AA003049E2

$guidOUObject            = new-object Guid BF967AA5-0DE6-11D0-A285-00AA003049E2

$guidPrinterObject       = new-object Guid BF967AA8-0DE6-11D0-A285-00AA003049E2

$guidWriteMembers        = new-object Guid bf9679c0-0de6-11d0-a285-00aa003049e2

$guidNull                = new-object Guid 00000000-0000-0000-0000-000000000000

$guidPublicInformation   = new-object Guid e48d0154-bcf8-11d1-8702-00c04fb96050

$guidGeneralInformation  = new-object Guid 59ba2f42-79a2-11d0-9020-00c04fc2d3cf

$guidPersonalInformation = new-object Guid 77B5B886-944A-11d1-AEBD-0000F80367C1

$guidGroupMembership     = new-object Guid bc0ac240-79a9-11d0-9020-00c04fc2d4cf
#>