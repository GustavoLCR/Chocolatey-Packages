$ErrorActionPreference = 'Stop'

$version = 'v0.4.0'
$url = "https://github.com/rizinorg/rizin/releases/download/$version/rizin_installer-$version-x86.exe"
$url64 = "https://github.com/rizinorg/rizin/releases/download/$version/rizin_installer-$version-x86_64.exe"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $env:ChocolateyPackageFolder
  filetype       = 'exe'
  silentArgs     = '/VERYSILENT /CURRENTUSER /NORESTART'
  url            = $url
  url64bit       = $url64
  checksum       = 'DE561F05766B01F23231F800E99C84DB9C8169E1ABC32ACB12A3572ECAF9EE49'
  checksumType   = 'sha256'
  checksum64     = 'B6EE42207AA50A3C62704763C3127A8029467EF753C162F7BC04A1790927D4FA'
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs
