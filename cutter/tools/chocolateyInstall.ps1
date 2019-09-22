$ErrorActionPreference = 'Stop';
$installDir = $env:ChocolateyPackageFolder

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installDir
  softwareName  = 'cutter*'
  url64bit      = 'https://github.com/radareorg/cutter/releases/download/v1.9.0/Cutter-v1.9.0-x64.Windows.zip'
  checksum64    = '5dc2d2199f0ef2cc2483fc4f6dc4af6e7a3f0d410bc5aeaeba8b0ad2403da6a0'
  checksumType64= 'sha256'
}

New-Item "$installDir\\cutter.gui" -type file -force | Out-Null
New-Item "$installDir\\vc_redist.x64.exe.ignore" -type file -force | Out-Null

Install-ChocolateyZipPackage @packageArgs

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
