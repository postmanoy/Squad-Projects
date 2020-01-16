Function Test-MemoryUsage {
[cmdletbinding()]
Param()
 
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

$os | Select @{Name = "Status   ";Expression = {$Status}},
@{Name = "Used%"; Expression = {100-$pctFree}},
@{Name = "UsedGB";Expression = {[math]::Round(($_.TotalVisibleMemorySize/1mb)-($_.FreePhysicalMemory/1mb),2)}},
@{Name = "TotalGB";Expression = {[int]($_.TotalVisibleMemorySize/1mb)}}
 
}

Function Test-CpuUsage {
[cmdletbinding()]
Param()
 
#getting the CPU% of Deep Security Prcoesses
$CpuCores = (Get-WMIObject Win32_ComputerSystem).NumberOfLogicalProcessors
$getDSA_cpu1 = [Math]::Round((((Get-Counter ("\Process(dsa*)\% Processor Time")).CounterSamples.CookedValue) / $cpu_cores), 2)
$getCoreService_cpu1 = [Math]::Round((((Get-Counter ("\Process(coreServiceShell*)\% Processor Time")).CounterSamples.CookedValue) / $cpu_cores), 2)
$getDsMonitor_cpu1 = [Math]::Round((((Get-Counter ("\Process(ds_monitor*)\% Processor Time")).CounterSamples.CookedValue) / $cpu_cores), 2)
$getNotifier_cpu1 = [Math]::Round((((Get-Counter ("\Process(Notifier)\% Processor Time")).CounterSamples.CookedValue) / $cpu_cores), 2)

#Test output the CPU Usage
echo "CPU Usage %"
echo " "
echo "DSA  $getDSA_cpu1 %"
echo "CoreServiceShell $getCoreService_cpu1 %"
echo "DS Monitor  $getDsMonitor_cpu1 %"
echo "Notifier $getDSA_cpu1 %"

}



#Performance Test
#Windows Platform
echo ""
echo "Windows CPU Performance test"
echo ""
echo "Initial Performance Information"
echo ""
#CPU Usage Test
Test-CpuUsage
echo ""
#Memory Usage Test
echo "Memory Usage"
echo ""
Test-MemoryUsage
echo ""
echo ""
echo "Starting Manual Scan"
echo ""

& $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -m AntimalwareManualScan:true

Start-Sleep -s 5
echo " "
echo "Running Malware Scan for five minutes"
echo ""
Start-Sleep -s 100

echo "### First Performance Information while Anti-Malware is Running ###"
echo ""
#CPU Usage Test
Test-CpuUsage
echo ""
#Memory Usage Test
echo "Memory Usage"
echo ""
echo "Status    Used% UsedGB TotalGB"
echo "--------- ----- ------ -------"
Test-MemoryUsage
echo ""

Start-Sleep 100

echo "### Second Performance Information while Anti-Malware is Running ###"
echo ""
#CPU Usage Test
Test-CpuUsage
echo ""
#Memory Usage Test
echo "Memory Usage"
echo ""
echo "Status    Used% UsedGB TotalGB"
echo "--------- ----- ------ -------"
Test-MemoryUsage
echo ""

Start-Sleep 100

echo "Ending Malware Scan"
echo ""

& $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -m AntimalwareCancelManualScan:true

Start-Sleep 10

echo "End of Malware Scan"
echo ""
echo ""

echo "Starting Rebuild of Baseline"

& $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -m RebuildBaseline:true

Start-Sleep -s 5
echo "Running Rebuild of Baseline"
echo ""
Start-Sleep -s 60

echo "### Performance Information while Rebuilding Baseline ###"
echo ""
#CPU Usage Test
Test-CpuUsage
echo ""
#Memory Usage Test
echo "Memory Usage"
echo ""
echo "Status    Used% UsedGB TotalGB"
echo "--------- ----- ------ -------"
Test-MemoryUsage
echo ""

Start-Sleep 60

echo "### Second Performance Information while Rebuilding Baseline ###"
echo ""
#CPU Usage Test
Test-CpuUsage
echo ""
#Memory Usage Test
echo "Memory Usage"
echo ""
echo "Status    Used% UsedGB TotalGB"
echo "--------- ----- ------ -------"
Test-MemoryUsage
echo ""

Start-Sleep 100

echo "End of Rebuilding Baseline"
echo ""
echo ""

echo "Starting Recommendation Scan"

& $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -m RecommendationScan:true

Start-Sleep -s 5
echo "Running Running Recommendation Scan"
echo ""
Start-Sleep -s 100

echo "### Performance Information while Recommendation Scan is Running ###"
echo ""
#CPU Usage Test
Test-CpuUsage
echo ""
#Memory Usage Test
echo "Memory Usage"
echo ""
echo "Status    Used% UsedGB TotalGB"
echo "--------- ----- ------ -------"
Test-MemoryUsage
echo ""

Start-Sleep 60
echo "Ending Test"
