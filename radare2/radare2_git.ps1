$ErrorActionPreference = 'Stop'
Import-Module -Name "$PSScriptRoot\..\tools\download_artifacts.ps1"

$nuspecPath = "$PSScriptRoot\radare2.nuspec"
$chocolateyinstallPath = "$PSScriptRoot\tools\chocolateyinstall.ps1"
$jobName = 'Environment: builder=vs2017_64_dyn, PYTHON=C:\\Python37, INNO_SETUP=C:\\Program Files (x86)\\Inno Setup 5, APPVEYOR_BUILD_WORKER_IMAGE=Visual Studio 2017, BUILD_DIR=build, RUN_TESTS=false'

$downloadedFile = Get-AppVeyorArtifacts -Account "radareorg" -Project "radare2" -Branch "master" -JobName $jobName

if ($downloadedFile -and (Test-Path $downloadedFile.Target)) {
    $hash = Get-FileHash -Algorithm SHA256 $downloadedFile.Target
    $date = Get-Date -format "yyyyMMdd"
    $version = $downloadedFile.Target.Split("-")[2]
    $prereleaseVersion = "$version.$date-git"

    [xml]$nuspec = Get-Content $nuspecPath
    $nuspec.package.metadata.version = $prereleaseVersion
    $nuspec.package.metadata.releaseNotes = ""
    $nuspec.Save($nuspecPath)

    $installScript = Get-Content $chocolateyinstallPath
    $installScript = $installScript -replace '^\$version.+', "`$version = `"$version`""
    $installScript = $installScript -replace '^\$url.+', "`$url = `"$($downloadedFile.Source)`""
    $installScript = $installScript -replace '^\$checksum.+', "`$checksum = `"$($hash.Hash)`""
    $installScript = $installScript -replace '^\$zipFolder.+', "`$zipFolder = `"$($downloadedFile.FileName -replace '.zip$', '')`""
    $installScript = $installScript -replace '^  url', "  url64"
    $installScript = $installScript -replace '^  checksum ', "  checksum64 "
    $installScript = $installScript -replace '^  checksumType', "  checksumType64"
    Set-Content -Path $chocolateyinstallPath -Value $installScript -Encoding utf8BOM
}
