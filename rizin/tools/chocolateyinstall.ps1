$ErrorActionPreference = 'Stop'

$version = 'v0.3.1'
$url = "https://github.com/rizinorg/rizin/releases/download/$version/rizin_installer-$version-x86.exe"
$url64 = "https://github.com/rizinorg/rizin/releases/download/$version/rizin_installer-$version-x86_64.exe"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $env:ChocolateyPackageFolder
  filetype       = 'exe'
  silentArgs     = '/VERYSILENT /CURRENTUSER /NORESTART'
  url            = $url
  url64bit       = $url64
  checksum       = '8DF563C9BDBC92388189219200334DAE496A31A4958ADF3F966197E60B3DB6DC'
  checksumType   = 'sha256'
  checksum64     = '2A3E76A7B536B051A0BCA56DF8F8EE1670604453340B5367FFA77AA36B632815'
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs
