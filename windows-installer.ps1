# Run with admin permissions
# powershell.exe -executionpolicy bypass -File createSymbolicLinksForWindows.ps1

$nvimPath = ${env:LOCALAPPDATA} + "\nvim"
if (!(Test-Path $nvimPath)) {
  Write-Host "Creating link at: '$nvimPath'"
  New-Item -ItemType SymbolicLink -Path $nvimPath -Target .\dotfiles\nvim
}
else {
  Write-Host "'$nvimPath' already exists."
}

$weztermPath = ${env:USERPROFILE} + "\.config\wezterm"
if (!(Test-Path $weztermPath)) {
  Write-Host "Creating link at: '$weztermPath'"
  New-Item -ItemType SymbolicLink -Path $weztermPath -Target .\dotfiles\wezterm
}
else {
  Write-Host "'$weztermPath' already exists."
}

winget import .\winget.json

# Installing LLVM via winget doesn't add it to the PATH so it's added here for now.
$llvmPath = "C:\Program Files\LLVM\bin"
$regexllvmPath = [regex]::Escape($llvmPath)
$arrPath = $env:Path -split ';'
if ($arrPath -contains $llvmPath) {
  Write-Host "'$llvmPath' already included in PATH."
} else {
  Write-Host "Add '$llvmPath' to the PATH."
  [Environment]::SetEnvironmentVariable("Path", $env:Path + ";$llvmPath", "User")
}

