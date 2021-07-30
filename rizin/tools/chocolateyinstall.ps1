$ErrorActionPreference = 'Stop'

$url = 'https://github.com/rizinorg/rizin/releases/download/v0.2.1/rizin_installer-v0.2.1-x86.exe'
$url64 = 'https://github.com/rizinorg/rizin/releases/download/v0.2.1/rizin_installer-v0.2.1-x86_64.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $env:ChocolateyPackageFolder
  filetype       = 'exe'
  silentArgs     = '/VERYSILENT /CURRENTUSER /NORESTART'
  url            = $url
  url64bit       = $url64
  checksum       = '91B3A5954F2FB252EDB9FF06304DFE7F3DC4B0D35208A17A156C66CBB1D039F9'
  checksumType   = 'sha256'
  checksum64     = '6C4E75AD777E1B16B2C18BDC46184F3523B376A3C45316C211FAB91507A930A7'
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs
