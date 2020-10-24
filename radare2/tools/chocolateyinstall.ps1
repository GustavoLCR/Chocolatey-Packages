$ErrorActionPreference = 'Stop'
$installDir = $env:ChocolateyPackageFolder

$version = "4.5.1"
$zipFile = "$installDir\\radare2-win-$version.zip"
$zipFolder = "radare2-install"
$url = "https://github.com/radareorg/radare2/releases/download/$version/radare2-windows-static-$version.zip"
$checksum = "98C68F4B705CE221AEEC5357AC19E594383CDD99D6F0179753BEC1CF44E85C17"

$packageArgs = @{
  PackageName    = $env:ChocolateyPackageName
  unzipLocation  = $installDir
  softwareName   = 'bin\\r*'
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-BinFile -Name r2 -Path "..\lib\radare2\$zipFolder\bin\radare2.exe"

Remove-Item -Path $zipFile -ErrorAction SilentlyContinue
