$ErrorActionPreference = 'Stop'
$installDir = $env:ChocolateyPackageFolder

$version = "5.4.2"
$packageName32 = "radare2-$version-w32"
$packageName64 = "radare2-$version-w64"
$zipFile32 = "$installDir\\$packageName32.zip"
$zipFile64 = "$installDir\\$packageName64.zip"
$url32 = "https://github.com/radareorg/radare2/releases/download/$version/$packageName32.zip"
$url64 = "https://github.com/radareorg/radare2/releases/download/$version/$packageName64.zip"
$checksum32 = "2C79342EC28B695BD60813E4FFFC8E1AFC142DE17C172C4C1255E376B83AFD36"
$checksum64 = "303811F388B81138C615D1AF4837F2A8A715B66939DA211DE186386986C4C5AD"

$packageArgs = @{
  PackageName    = $env:ChocolateyPackageName
  unzipLocation  = $installDir
  softwareName   = 'r*'
  url            = $url32
  checksum       = $checksum32
  checksumType   = 'sha256'
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

if ([Environment]::Is64BitOperatingSystem) {
  Install-BinFile -Name r2 -Path "$installDir\\$packageName64\\bin\\radare2.exe"
  Remove-Item -Path $zipFile64 -ErrorAction SilentlyContinue
}
else {
  Install-BinFile -Name r2 -Path "$installDir\\$packageName32\\bin\\radare2.exe"
  Remove-Item -Path $zipFile32 -ErrorAction SilentlyContinue
}
