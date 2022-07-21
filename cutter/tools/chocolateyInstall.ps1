$ErrorActionPreference = 'Stop';

$version = "v2.1.0"
$packageName = "Cutter-$version-Windows-x86_64"
$zipFile = "$packageName.zip"
$installRootDir = $env:ChocolateyPackageFolder
$installDir = "$installRootDir\\$packageName"

$packageArgs = @{
  PackageName    = $env:ChocolateyPackageName
  unzipLocation  = $installRootDir
  url64bit       = "https://github.com/rizinorg/cutter/releases/download/$version/$zipFile"
  checksum64     = '73329193663E219354D4BC65937F4323875EB2524CDDF2FD013B202F0BCFCD8B'
  checksumType64 = 'sha256'
}

New-Item "$installDir\\cutter.exe.gui" -type file -force | Out-Null
New-Item "$installDir\\vc_redist.x64.exe.ignore" -type file -force | Out-Null

Install-ChocolateyZipPackage @packageArgs

$shortcutArgs = @{
  Description      = "Open Cutter"
  TargetPath       = "$installDir\\cutter.exe"
  WorkingDirectory = "$installDir"
}
$shortcutName = '\Cutter.lnk'

$doCreateShortcut = Read-Host "Do you want to create a shortcut in the Desktop? (Y/n)"
if (!$doCreateShortcut -or $doCreateShortcut.Contains('y')) {
  Install-ChocolateyShortcut @shortcutArgs -ShortcutFilePath  $([Environment]::GetFolderPath("Desktop") + $shortcutName)
}

$doCreateShortcut = Read-Host "Do you want to create a shortcut in the Start Menu? (Y/n)"
if (!$doCreateShortcut -or $doCreateShortcut.Contains('y')) {
  Install-ChocolateyShortcut @shortcutArgs -ShortcutFilePath $([Environment]::GetFolderPath("StartMenu") + $shortcutName)
}

Remove-Item -Path "$installRootDir\\$zipFile" -ErrorAction SilentlyContinue
