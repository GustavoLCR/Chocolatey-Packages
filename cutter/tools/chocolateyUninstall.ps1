$doDeleteCfg = Read-Host "Do you wish to delete your configuration profile? (y/N)"
if ($doDeleteCfg.Contains("y")) {
	Remove-Item -Path "$env:APPDATA\\rizin\\cutter*" -Recurse -ErrorAction SilentlyContinue
}

$shortcutName = '\Cutter.lnk'

Remove-Item -Path $([Environment]::GetFolderPath('DesktopDirectory') + $shortcutName) -ErrorAction SilentlyContinue
Remove-Item -Path $([Environment]::GetFolderPath('StartMenu') + '\Programs' + $shortcutName) -ErrorAction SilentlyContinue
Remove-Item -Path $([Environment]::GetFolderPath('CommonDesktopDirectory') + $shortcutName) -ErrorAction SilentlyContinue
Remove-Item -Path $([Environment]::GetFolderPath('CommonStartMenu') + '\Programs' + $shortcutName) -ErrorAction SilentlyContinue