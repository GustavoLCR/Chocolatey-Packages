$ErrorActionPreference = 'Stop';
$installDir = $env:ChocolateyPackageFolder

$zipFile = "$installDir\\Cutter-v1.10.2-x64.Windows.zip"

$packageArgs = @{
  PackageName    = $env:ChocolateyPackageName
  unzipLocation  = $installDir
  softwareName   = 'cutter*'
  url64bit       = 'https://github.com/radareorg/cutter/releases/download/v1.10.2/Cutter-v1.10.2-x64.Windows.zip'
  checksum64     = '1090FB7A3919F7EB7F899EB804E32448797E8265DEB56C701F2F32AF94AE8878'
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
