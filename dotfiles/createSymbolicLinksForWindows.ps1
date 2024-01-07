# Run with admin permissions
# powershell -executionpolicy bypass -File .\createSymbolicLinksForWindows.ps1

$nvimPath = ${env:LOCALAPPDATA} + "\nvim"
if (!(Test-Path $nvimPath)) {
    Write-Host "Creating link at: '$nvimPath'"
    New-Item -ItemType SymbolicLink -Path $nvimPath -Target .\nvim
}
else {
    Write-Host "'$nvimPath' already exists."
}
