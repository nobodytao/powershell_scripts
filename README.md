These are the PowerShell scripts I've employed for my professional tasks:
<br><br>
<b>&#x2022;&nbsp;ACLRules_deleteUsers.ps1</b>
<blockquote>
Description: This script deletes individual domain accounts in the ACL OU (Security tab in OU Properties) that are not members of groups, leaving only domain groups and built-in domain accounts.
</blockquote>
<br>
<b>&#x2022;&nbsp;Get_OS_ver_AD_with_list_of_PC_names.ps1</b>
<blockquote>
Description: Retrieve operating system information and versions from Active Directory using a list of PC names from a text file.
</blockquote>
<br>
<b>&#x2022;&nbsp;Get_PCs_names_with_list_of_IPs.ps1</b>
<blockquote>
Description: Gather information about PC IP addresses using a list of PC names from a text file.
</blockquote>
<br>
<b>&#x2022;&nbsp;Get_user_SID_create_REG_ADD_command.ps1</b>
<blockquote>
Description: Generate a REG ADD command, including a user SID from Active Directory, for use in other tasks.
</blockquote>
<br>
<b>&#x2022;&nbsp;Get_users_not_change_password_3_MM.ps1</b>
<blockquote>
Description: Search for domain users who have not changed their password for more than 3 months.
</blockquote>
<br>
<b>&#x2022;&nbsp;Group_from_Domain1_in_Domain2_groups_recursive_ADSI.ps1</b>
<blockquote>
Description: Retrieve information about group membership from one domain in groups of another domain. It performs a recursive search through all groups in the current domain to determine if a group from another domain is included.
</blockquote>
<br>
<b>&#x2022;&nbsp;Organize_Workspace.ps1</b>
<blockquote>
Description: This script arranges the windows of all open cmd.exe instances on the right side of the screen, ensuring they occupy 9/20 of the screen width. The height is divided equally among the open cmd.exe windows. The placement is based on the set screen resolution.
<br>
Additionally, it positions windows of msedge.exe on the left side of the screen, utilizing 11/20 of the width while occupying the full height of the screen.
<br>
Within the script body, the "Set-Window" function is used. Author: Boe Prox.
<br>
<a href=https://github.com/proxb/PowerShell_Scripts/blob/master/Set-Window.ps1>Set-Window.ps1 by Boe Prox.</a>
</blockquote>
<br>
<b>&#x2022;&nbsp;Owners_of_PCs_in_OU_Active_Directory_recursive.ps1</b>
<blockquote>
Description: Collect information about the owners of PC accounts in the domain.
</blockquote>
<br>
<b>&#x2022;&nbsp;Permission_group_to_change_passwords.ps1</b>
<blockquote>
Description: Retrieve information about domain groups that have the right to change passwords for domain accounts.
</blockquote>
<br>
<b>&#x2022;&nbsp;RAM_HDD_Processor_list_of_PCs.ps1</b>
<blockquote>
Description: Collect information about RAM, HDD, and Processor from a list of PCs using WMI.
</blockquote>
<br>
<b>&#x2022;&nbsp;Remove_users_from_group_with_list_of_usernames.ps1</b>
<blockquote>
Description: Remove user accounts from a domain group based on a list from a txt file.
</blockquote>
<br>
<b>&#x2022;&nbsp;Set_pass_to_users_from_CSV-file.ps1</b>
<blockquote>
Description: Set passwords for user accounts in Active Directory based on a list in a CSV file. The first column contains SamaccountName from Active Directory, and the second column contains the corresponding password.
</blockquote>
<br>
<b>&#x2022;&nbsp;Subgroups_in_group_from_all_domains_in_forest_recursive.ps1</b>
<blockquote>
Description: Build a tree of subgroups within a specified domain group, including subgroups from other forest domains in a recursive manner. This script finds all groups from all domains that are part of the specified group in the specified domain.
</blockquote>
<b>&#x2022;&nbsp;PowerShell_DSC</b>
<br>
<blockquote>
Description: 
<br>
- Scripts for installing and configuring PowerShell DSC (Desired State Configuration): "DSCInstall.ps1", "DSCConfigEnvPath.ps1".
<br>
- DSC configuration file "DSCforRegistry.ps1" for changing registry keys on remote PCs, the compilation script "CompileDCSscript.ps1" and the script for applying the configuration "Start_DSCforRegistry.ps1".
<br>
- MOF files obtained during the application of the script.
</blockquote>
