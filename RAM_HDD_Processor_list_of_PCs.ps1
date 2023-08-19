 
  function Decode {
    If ($args[0] -is [System.Array]) {
        [System.Text.Encoding]::ASCII.GetString($args[0])
    }
    Else {
        "Not Found"
    }
}

foreach ($computer in get-content C:\PC.txt)
    { 
    $RAM=Get-WmiObject Win32_PhysicalMemory -ComputerName $computer
    $RAMCap=$OZU.Capacity
    $HDD=Get-WmiObject Win32_logicaldisk  -ComputerName $computer
    $HDDSize=$HDD.Size
    $Proc=Get-WmiObject Win32_processor  -ComputerName $computer
    $ProcName=$Proc.Description
    $ProcFrec=$Proc.MaxClockSpeed
    echo "$computer	$ProcFrec" >> c:\proc.txt
    echo "$computer	$HDDSize" >> c:\disk.txt
    echo "$computer	$RAMCap" >> c:\ram.txt

    #$OSys = gwmi Win32_OperatingSystem -ComputerName $computer


    }


   