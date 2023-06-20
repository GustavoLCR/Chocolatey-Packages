$ErrorActionPreference = 'Stop'

$version = 'v0.5.2'
$url = "https://github.com/rizinorg/rizin/releases/download/$version/rizin_installer-$version-x86.exe"
$url64 = "https://github.com/rizinorg/rizin/releases/download/$version/rizin_installer-$version-x86_64.exe"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  filetype       = 'exe'
  silentArgs     = '/SP- /VERYSILENT /NORESTART'
  url            = $url
  url64bit       = $url64
  checksum       = 'D24EE7618B190197C5B5D1156B838D1EA8F1CB08E458C97E466AA2A2534699C8'
  checksumType   = 'sha256'
  checksum64     = '70C9E49C1E859E7588D7BD41889285E831E51679FAEB026D1A290D5372C74E62'
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs
