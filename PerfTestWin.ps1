#Performance Test
#Windows Platform

echo "Windows CPU Performance test"



# To match the CPU usage to for example Process Explorer you need to divide by the number of cores
$cpu_cores = (Get-WMIObject Win32_ComputerSystem).NumberOfLogicalProcessors

# We now get the CPU percentage
(Get-Counter "\Process(*)\% Processor Time").CounterSamples | Select InstanceName, @{Name="CPU %";Expression={[Decimal]::Round(($_.CookedValue / $CpuCores), 2)}}



 
#Get-Counter -ListSet *memory* | Select-Object -ExpandProperty Counter

Get-WmiObject Win32_PerfFormattedData_PerfProc_Process `
    | Where-Object { $_.name -inotmatch '_total|idle' } `
    | ForEach-Object { 
        "Process = {0,-25} Memory_Usage_(MB) = {2,-5} MB" -f `
            $_.Name,$_.PercentProcessorTime,([math]::Round($_.WorkingSetPrivate/1Mb,2))
    }


$os = Get-Ciminstance Win32_OperatingSystem
$pctFree = [math]::Round(($os.FreePhysicalMemory/$os.TotalVisibleMemorySize)*100,2)
 
if ($pctFree -ge 45) {
$Status = "OK"
}
elseif ($pctFree -ge 15 ) {
$Status = "Warning"
}
else {
$Status = "Critical"
}
 
$os | Select @{Name = "Status";Expression = {$Status}},
@{Name = "PctFree"; Expression = {$pctFree}},
@{Name = "FreeGB";Expression = {[math]::Round($_.FreePhysicalMemory/1mb,2)}},
@{Name = "TotalGB";Expression = {[int]($_.TotalVisibleMemorySize/1mb)}}