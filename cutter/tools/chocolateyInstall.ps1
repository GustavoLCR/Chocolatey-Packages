$ErrorActionPreference = 'Stop';
$installDir = $env:ChocolateyPackageFolder

$zipFile = "$installDir\\Cutter-v1.12.0-x64.Windows.zip"

$packageArgs = @{
  PackageName    = $env:ChocolateyPackageName
  unzipLocation  = $installDir
  softwareName   = 'cutter*'
  url64bit       = 'https://github.com/rizinorg/cutter/releases/download/v2.0.2/Cutter-v2.0.2-x64.Windows.zip'
  checksum64     = 'E2D7E8FDA40BFFE62C4F35E1E34694687C0BC31BC8620ADBE9BD7BEDE7B6AF25'
  checksumType64 = 'sha256'
}

New-Item "$installDir\\cutter.exe.gui" -type file -force | Out-Null
New-Item "$installDir\\vc_redist.x64.exe.ignore" -type file -force | Out-Null

Install-ChocolateyZipPackage @packageArgs

$shortcutArgs = @{
  Description      = "Open Cutter"
  TargetPath       = "$installDir\\cutter.exe"
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
