
if (!([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}
if (!(Test-Path "$PSScriptRoot/hdl_dump.exe")) {
    Write-Host "The file $PSScriptRoot/hdl_dump.exe is missing."
    Read-Host "Press Enter to Exit"
    exit
}
$HDLQuery = & "$PSScriptRoot/hdl_dump.exe" "query"
$HDLDriveCount = ($HDLQuery -join "" -split "Playstation 2 HDD").Count - 1

if ($HDLDriveCount -eq 1) {
    foreach ($TempLine in $HDLQuery) {
        if ($TempLine -match "Playstation 2 HDD") {
            $HDLTargetDrive = ($TempLine -split ":")[0].Trim() + ":"
            $HDLTOC = & "$PSScriptRoot/hdl_dump.exe" "hdl_toc" $HDLTargetDrive
            Set-Content -Path "$PSScriptRoot/hdl_toc.txt" -Value $HDLTOC -Encoding UTF8
            Write-Host "The HDL table of contents has been saved to $PSScriptRoot/hdl_toc.txt"
            Read-Host "Press Enter to Exit"
            exit
        }
    }
}
elseif ($HDLDriveCount -le 0) {
    Write-Host "Failed to detect any disk drives formatted as an APA PlayStation 2 HDD."
}
else {
    Write-Host "$DriveCount HDDs were detected, this powershell script only supports 1."
}
Read-Host "Press Enter to Exit"
