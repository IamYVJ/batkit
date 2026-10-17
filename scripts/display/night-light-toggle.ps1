# Toggles Night light by editing its state blob in the registry.
# This blob format is undocumented, so a future Windows update could break it.

$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\DefaultAccount\Current\default$windows.data.bluelightreduction.bluelightreductionstate\windows.data.bluelightreduction.bluelightreductionstate'

$data = [byte[]](Get-ItemProperty -Path $key -Name Data -ErrorAction Stop).Data

if ($data[18] -eq 0x15) {
    # On -> off: flip the state byte and drop the two "enabled" bytes
    $new = $data[0..22] + $data[25..($data.Length - 1)]
    $new[18] = 0x13
} elseif ($data[18] -eq 0x13) {
    # Off -> on: flip the state byte and insert the two "enabled" bytes
    $new = $data[0..22] + [byte[]](0x10, 0x00) + $data[23..($data.Length - 1)]
    $new[18] = 0x15
} else {
    Write-Host 'Unrecognised Night light state format; nothing changed.'
    exit 1
}

# Bump the timestamp so Windows picks up the change
for ($i = 10; $i -lt 15; $i++) {
    if ($new[$i] -ne 0xff) { $new[$i]++; break }
}

Set-ItemProperty -Path $key -Name Data -Value ([byte[]]$new) -Type Binary
