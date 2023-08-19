Get-Content C:\PC_IPs.txt | ForEach-Object {
    $hash = @{ IPAddress = $_
        hostname = "n/a"}
   Try
	{
 	$hash.hostname = ([system.net.dns]::GetHostByAddress($_)).hostname
    	$object = New-Object psobject -Property $hash
    	echo "$object" >> c:\PCNames.txt
	}
   Catch
	{
	echo "NoName" >> c:\PCNames.txt
	}
} 