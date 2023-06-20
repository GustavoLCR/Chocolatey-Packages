$ErrorActionPreference = 'Stop';

$version = "v2.2.1"
$packageName = "Cutter-$version-Windows-x86_64"
$zipFile = "$packageName.zip"
$isAdmin = Test-ProcessAdminRights
if ($isAdmin) {
  $installRootDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
}
else {
  $installRootDir = "$env:LOCALAPPDATA\\RizinOrg"
}
$installDir = "$installRootDir\\$packageName"

$packageArgs = @{
  PackageName    = $env:ChocolateyPackageName
  unzipLocation  = $installRootDir
  url64bit       = "https://github.com/rizinorg/cutter/releases/download/$version/$zipFile"
  checksum64     = '2871E93E01881BA31E1C3FBDC7E4CCFB3114B3D95CAD64A93FEFA933846CADB4'
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

if ($isAdmin) {
  $common = 'Common'
}

$doCreateShortcut = Read-Host "Do you want to create a shortcut in the Desktop? (Y/n)"
if (!$doCreateShortcut -or $doCreateShortcut.Contains('y')) {
  Install-ChocolateyShortcut @shortcutArgs -ShortcutFilePath  $([Environment]::GetFolderPath($common + 'DesktopDirectory') + $shortcutName)
}

$doCreateShortcut = Read-Host "Do you want to create a shortcut in the Start Menu? (Y/n)"
if (!$doCreateShortcut -or $doCreateShortcut.Contains('y')) {
  Install-ChocolateyShortcut @shortcutArgs -ShortcutFilePath $([Environment]::GetFolderPath($common + 'StartMenu') + '\Programs' + $shortcutName)
}

Remove-Item -Path "$installRootDir\\$zipFile" -ErrorAction SilentlyContinue
