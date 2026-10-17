# Sets the default playback device to the first active one whose name contains -Name.
# Run without -Name to list the available devices.
param([string]$Name)

Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;

// Undocumented Windows interface used by the Sound control panel; only SetDefaultEndpoint is called.
[Guid("f8679f50-850a-41cf-9c72-430f290290c8"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
interface IPolicyConfig {
    int Unused1(); int Unused2(); int Unused3(); int Unused4(); int Unused5();
    int Unused6(); int Unused7(); int Unused8(); int Unused9(); int Unused10();
    int SetDefaultEndpoint([MarshalAs(UnmanagedType.LPWStr)] string deviceId, int role);
}

[ComImport, Guid("870af99c-171d-4f9e-af0d-e63df40c2bc9")]
class CPolicyConfigClient {}

public static class AudioSwitch {
    public static void SetDefault(string deviceId) {
        var config = (IPolicyConfig)new CPolicyConfigClient();
        // Roles: 0 = console, 1 = multimedia, 2 = communications
        for (int role = 0; role < 3; role++) {
            Marshal.ThrowExceptionForHR(config.SetDefaultEndpoint(deviceId, role));
        }
    }
}
'@

$root = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Render'
$devices = Get-ChildItem $root | ForEach-Object {
    if ((Get-ItemProperty $_.PSPath).DeviceState -ne 1) { return }  # 1 = active
    $props = Get-ItemProperty "$($_.PSPath)\Properties"
    [pscustomobject]@{
        Name = '{0} ({1})' -f $props.'{a45c254e-df1c-4efd-8020-67d146a850e0},2', $props.'{b3f8fa53-0004-438e-9003-51a46e139bfc},6'
        Id   = '{0.0.0.00000000}.' + $_.PSChildName
    }
}

if (-not $Name) {
    Write-Host 'Active playback devices:'
    $devices | ForEach-Object { Write-Host "  $($_.Name)" }
    exit 0
}

$match = $devices | Where-Object { $_.Name -like "*$Name*" } | Select-Object -First 1
if (-not $match) {
    Write-Host "No active playback device matches '$Name'. Available:"
    $devices | ForEach-Object { Write-Host "  $($_.Name)" }
    exit 1
}

[AudioSwitch]::SetDefault($match.Id)
Write-Host "Default playback device: $($match.Name)"
