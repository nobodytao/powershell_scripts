import-module activedirectory
#Reset variables before starting the program
$GroupInAD=$null
$users=$null

#Here we set the full let to the text file with the list of accounts:
$PathToFile="C: UsersNames.txt"

#Here we specify the name of the group from which we will remove users:
$GroupName="YourGroupName"

#Find a group in AD. If found, the message is returned - found. If not, an error is returned and a message is not found.
$GroupInAD=Get-ADGroup -Identity $GroupName
if (!($GroupInAD -eq $null)) 
    {echo "Group $GroupName found"

    #Next, if a group is found, for each row in the users.txt file, do the following:
    foreach ($FIO in get-content $PathToFile)
    {
        $users = Get-ADUser -Filter {samaccountname -like $FIO} -SearchBase "DC=dom,DC=com" #find a record with this name
        if (!($users -eq $null))
            {
            foreach ($us in $users)
                {   
                Remove-ADGroupMember -Identity $GroupInAD -Members $us -Confirm:$false #remove the account from the group
                echo "User $FIO removed from $GroupName" #displays the result
                }
            }
        else #If no such user is found, then a message about it is displayed on the screen
            {
            echo "User $FIO not found" #displays the result
            }
    }
} 
else 
{echo "Group $GroupName not found"}