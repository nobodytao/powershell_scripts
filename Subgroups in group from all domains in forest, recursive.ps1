#--------------------------------------------------
# Function for recursive search subgroups in domain
#--------------------------------------------------

function GetGroupMemberOf{
param($GroupName,$DomainName,$ParentGroupName)
  Begin{
       }
    Process{
            $GroupInAD = Get-ADGroup $GroupName -Server "$DomainName"
            $GroupInADName=$GroupInAD.samaccountName
            
            #Get non-recursive memebers in the group
            $members = @(Get-ADGroupMember $GroupInAD | Where-Object {$_.objectClass -eq "group"})
            $membersCount=$members.Count
            
            if ($membersCount -ne 0)
                {
                echo "$membersCount subgroups to $GroupInADName :"
                echo "--------------------------------------------------------------------"
                }

            foreach ($member in $members)
                {
                #DistinguishedName of domain group
                $MemberDistinguishedName=$member.distinguishedName
                $MemberName=$member.samaccountName

                #Split DistinguishedName to find domain name
                $Separator=",DC="
                $MemberDistinguishedNameSplit=$MemberDistinguishedName -split $Separator
                #Get count of parts in the splitted string
                $MemberDistinguishedNameSplitCount=$MemberDistinguishedNameSplit.Count
                #Get domain name from splitted string
                $MemberDomainName=$MemberDistinguishedNameSplit[$MemberDistinguishedNameSplitCount-3]+'.'+$MemberDistinguishedNameSplit[$MemberDistinguishedNameSplitCount-2]+'.'+$MemberDistinguishedNameSplit[$MemberDistinguishedNameSplitCount-1]
                
                echo "Group: $member	CN: $MemberName	Domain: $MemberDomainName"
                echo "--------------------------------------------------------------------"

                if ($MemberName -eq $ParentGroupName) 
                    {
                    echo "!!! $GroupInAD and $ParentGroupName are included in one another !!!"
                    echo "--------------------------------------------------------------------"
                    continue
                    }
                #Recursive call to the next group
                GetGroupMemberOf $MemberName $MemberDomainName $GroupInADName
                }

           }
  End
     {
     }
}


#--------------------------------------------------
# Main program
#--------------------------------------------------


GetGroupMemberOf "group_name" "domain_name" ""
