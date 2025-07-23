$backup = Get-VBRBackup -Name "your_backup_name"
#Get the latest restore point
$restorePoint = Get-VBRRestorePoint -BackUp $backup -Name "your_restore_point_name" | Sort-Object CreationTime -Descending | Select-Object -First 1
$server = Get-VBRServer -Name "name_of_your_server_to_restore_backup_to"
$session = Start-VBRLinuxFileRestore -RestorePoint $restorepoint -MountServer $server

#Go throught the saved tree structure of your linux files and directories to get file or directory you want to restore
$rootdir = Get-VBRLinuxGuestItem -LinuxFlrObject $session | Where-Object { $_.Name -eq '/' }
$homedir = Get-VBRLinuxGuestItem -LinuxFlrObject $session -ParentItem $rootdir | Where-Object { $_.Name -eq "home" }
$userdir = Get-VBRLinuxGuestItem -LinuxFlrObject $session -ParentItem $homedir | Where-Object { $_.Name -eq "my_user" }
$backdir = Get-VBRLinuxGuestItem -LinuxFlrObject $session -ParentItem $userdir | Where-Object { $_.Name -eq "my_directory" }

$creds = Get-VBRCredentials | Where-Object { $_.Name -eq "my_user" }

Start-VBRLinuxGuestItemRestore -LinuxFlrObject $session -Item $backdir -GuestCredentials $creds -Overwrite

Stop-VBRLinuxFileRestore -LinuxFlrObject $session
