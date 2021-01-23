$ErrorActionPreference = 'Stop'

$url64 = 'https://github.com/rizinorg/rizin/releases/download/v0.1.0/rizin-windows-static-v0.1.0.zip'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $env:ChocolateyPackageFolder
  url64bit       = $url64
  checksum64     = 'D09A8DEE4C74BF26D4642F93CD263DC635238D355BE621F16D6554ACA5AA9021'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
