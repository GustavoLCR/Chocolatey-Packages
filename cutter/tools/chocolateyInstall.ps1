$ErrorActionPreference = 'Stop';
$installDir = $env:ChocolateyPackageFolder

$zipFile = "$installDir\\Cutter-v1.10.1-x64.Windows.zip"

$packageArgs = @{
  PackageName    = $env:ChocolateyPackageName
  Destination    = $installDir
  FileFullPath64 = $zipFile
}

New-Item "$installDir\\cutter.exe.gui" -type file -force | Out-Null
New-Item "$installDir\\vc_redist.x64.exe.ignore" -type file -force | Out-Null

Get-ChocolateyUnzip @packageArgs

$shortcutArgs = @{
  Description = "Open Cutter"
  TargetPath  = "$installDir\\cutter.exe"
  WorkingDirectory = $installDir
}
$shortcutName = '\Cutter.lnk'

$doCreateShortcut = Read-Host "Do you want to create a shortcut in the Desktop? (Y/n)"
if (!$doCreateShortcut -or $doCreateShortcut.Contains('y')) {
  Install-ChocolateyShortcut @shortcutArgs -ShortcutFilePath  $([Environment]::GetFolderPath("Desktop") + "$shortcutName")
}

$doCreateShortcut = Read-Host "Do you want to create a shortcut in the Start Menu? (Y/n)"
if (!$doCreateShortcut -or $doCreateShortcut.Contains('y')) {
  Install-ChocolateyShortcut @shortcutArgs -ShortcutFilePath $([Environment]::GetFolderPath("StartMenu") + $shortcutName)
}

Remove-Item -Path $zipFile -ErrorAction SilentlyContinue
