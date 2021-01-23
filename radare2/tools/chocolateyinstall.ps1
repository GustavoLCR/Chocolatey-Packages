$ErrorActionPreference = 'Stop'
$installDir = $env:ChocolateyPackageFolder

$version = "5.0.0"
$zipFile = "$installDir\\radare2-win-$version.zip"
$url = "https://github.com/radareorg/radare2/releases/download/$version/radare2-windows-$version.zip"
$checksum = "A595A09C132E58FEBBD339DFD246E09811C45028B6130C552A1CC7C3C977D654"

$packageArgs = @{
  PackageName   = $env:ChocolateyPackageName
  unzipLocation = $installDir
  softwareName  = 'bin\\r*'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-BinFile -Name r2 -Path "..\lib\radare2\bin\radare2.exe"

Remove-Item -Path $zipFile -ErrorAction SilentlyContinue
