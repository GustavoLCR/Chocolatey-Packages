$ErrorActionPreference = 'Stop'

$version = 'v0.3.0'
$url = "https://github.com/rizinorg/rizin/releases/download/$version/rizin_installer-$version-x86.exe"
$url64 = "https://github.com/rizinorg/rizin/releases/download/$version/rizin_installer-$version-x86_64.exe"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $env:ChocolateyPackageFolder
  filetype       = 'exe'
  silentArgs     = '/VERYSILENT /CURRENTUSER /NORESTART'
  url            = $url
  url64bit       = $url64
  checksum       = 'DF11C38902FBB07D45AFF36F64BD4D6143DA072C3239E67EDC3E5CE24AB016E7'
  checksumType   = 'sha256'
  checksum64     = '68DED4368FBEBA1A2CEFC81AFCBB19FD0D3DEF8152A57354E92B746A31F5C1CF'
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs
