Import-Module ActiveDirectory

$Group_name="group.dom.com"
$OU_DN="OU=Name,DC=dom,DC=com"

$objSearcher = New-Object System.DirectoryServices.DirectorySearcher ([ADSI]"LDAP://$OU_DN)
$objSearcher.Filter = "((objectClass=group))"                                  
$objSearcher.SearchScope = [System.DirectoryServices.SearchScope]::Subtree
$objSearcher.PageSize = $MaxUsers
$colResult = $objSearcher.FindAll()
foreach ($DomainGroup in $colResult)                                               
        {echo "$DomainGroup"
        $UCPath=$DomainGroup.Path                                       
        $GroupConn =[ADSI]"$UCPath" 
        $Members = @($GroupConn.psbase.Invoke("Members"))              
         ForEach ($Member In $Members)
            {
            $Path = $Member.GetType().InvokeMember("Adspath", "GetProperty", $Null, $Member, $Null)          
            if ($Path.ToString() -like $Group_name)      
                {
                $Name = $Member.GetType().InvokeMember("Name", "GetProperty", $Null, $Member, $Null)             
                $Class = $Member.GetType().InvokeMember("Class", "GetProperty", $Null, $Member, $Null)           
                echo "$UCPath;    $Name;    $Path;    $Class" >> c:\listofgroups.txt
                }
            
            }
        }


