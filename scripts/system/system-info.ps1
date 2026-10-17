# Prints a short summary of this PC: Windows version, CPU, memory, uptime and disk space.

$os  = Get-CimInstance Win32_OperatingSystem
$cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
$up  = (Get-Date) - $os.LastBootUpTime

# Memory sizes from Win32_OperatingSystem are in KB; dividing by 1MB (1048576) gives GB.
$totalGb = $os.TotalVisibleMemorySize / 1MB
$usedGb  = ($os.TotalVisibleMemorySize - $os.FreePhysicalMemory) / 1MB

'{0,-9} {1}' -f 'Windows', "$($os.Caption) (build $($os.BuildNumber))"
'{0,-9} {1}' -f 'CPU', $cpu.Name.Trim()
'{0,-9} {1:N1} GB used of {2:N1} GB' -f 'Memory', $usedGb, $totalGb
'{0,-9} {1}d {2}h {3}m' -f 'Uptime', $up.Days, $up.Hours, $up.Minutes
''
Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' | ForEach-Object {
    '{0,-9} {1:N1} GB free of {2:N1} GB' -f $_.DeviceID, ($_.FreeSpace / 1GB), ($_.Size / 1GB)
}
