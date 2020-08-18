$ErrorActionPreference = 'Stop';
$installDir = $env:ChocolateyPackageFolder

$zipFile = "$installDir\\Cutter-v1.11.1-x64.Windows.zip"

$packageArgs = @{
  PackageName    = $env:ChocolateyPackageName
  unzipLocation  = $installDir
  softwareName   = 'cutter*'
  url64bit       = 'https://github.com/radareorg/cutter/releases/download/v1.11.1/Cutter-v1.11.1-x64.Windows.zip'
  checksum64     = '1872A8F4A2424A7146E32762C0DB426568801923754648C14024230E589787B1'
  checksumType64 = 'sha256'
}

New-Item "$installDir\\cutter.exe.gui" -type file -force | Out-Null
New-Item "$installDir\\vc_redist.x64.exe.ignore" -type file -force | Out-Null

Install-ChocolateyZipPackage @packageArgs

$shortcutArgs = @{
  Description = "Open Cutter"
  TargetPath  = "$installDir\\cutter.exe"
  WorkingDirectory = $installDir
}
$shortcutName = "\\Cutter.lnk"

$doCreateShortcut = Read-Host "Do you want to create a shortcut in the Desktop? (Y/n)"
if (!$doCreateShortcut -or $doCreateShortcut.Contains('y')) {
  Install-ChocolateyShortcut @shortcutArgs -ShortcutFilePath  $([Environment]::GetFolderPath("Desktop") + "$shortcutName")
}

$doCreateShortcut = Read-Host "Do you want to create a shortcut in the Start Menu? (Y/n)"
if (!$doCreateShortcut -or $doCreateShortcut.Contains('y')) {
  Install-ChocolateyShortcut @shortcutArgs -ShortcutFilePath $([Environment]::GetFolderPath("StartMenu") + $shortcutName)
}

Remove-Item -Path $zipFile -ErrorAction SilentlyContinue
