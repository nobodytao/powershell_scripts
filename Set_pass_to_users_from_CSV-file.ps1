$Filename="c:\UsersPasswords.csv" #CSV with users' list. First column - SamaccountName. Second column - password.

$Domain="your.dom.com"


$FileContent=Import-Csv -Path "$Filename" -Delimiter ";" -Header Samacc,Pass 
        foreach($Str in $FileContent)
            {
            $User_Samaccountname=$Str.Samacc
            $User_Password=$Str.Pass
            $User_Pass_SecureString = ConvertTo-SecureString "$User_Password" -AsPlainText -Force 
            $ADUser = Get-ADUser $User_Samaccountname -Server $Domain
            Set-ADAccountPassword -Identity $ADUser -NewPassword $User_Pass_SecureString –Reset
            echo "$User_Samaccountname	$User_Password $ADUser"
            }

