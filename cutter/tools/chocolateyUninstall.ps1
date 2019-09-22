$doDeleteCfg = Read-Host "Do you wish to delete your configuration profile? (y/N)"
if ($doDeleteCfg.Contains("y")) {
	Remove-Item -Path "$env:APPDATA\\RadareOrg\\*cutter*" -Recurse -ErrorAction SilentlyContinue
}

$shortcutName = "\Cutter.lnk"

Remove-Item -Path $([Environment]::GetFolderPath("Desktop") + $shortcutName) -ErrorAction SilentlyContinue
Remove-Item -Path $([Environment]::GetFolderPath("StartMenu") + $shortcutName) -ErrorAction SilentlyContinue
