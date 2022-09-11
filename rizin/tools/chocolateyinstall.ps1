$ErrorActionPreference = 'Stop'

$version = 'v0.4.1'
$url = "https://github.com/rizinorg/rizin/releases/download/$version/rizin_installer-$version-x86.exe"
$url64 = "https://github.com/rizinorg/rizin/releases/download/$version/rizin_installer-$version-x86_64.exe"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $env:ChocolateyPackageFolder
  filetype       = 'exe'
  silentArgs     = '/VERYSILENT /CURRENTUSER /NORESTART'
  url            = $url
  url64bit       = $url64
  checksum       = '4476E42DE1DFBA64B70427C811F908E01509BE182491556790EFFDB48215B484'
  checksumType   = 'sha256'
  checksum64     = 'C29E8E83FC235E3603F9731C13DCFE915971871871390C766E4F2505D31BB613'
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs
