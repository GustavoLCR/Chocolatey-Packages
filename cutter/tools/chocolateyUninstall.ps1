$doDeleteCfg = Read-Host "Do you wish to delete your configuration profile? (Y/n)"
if (!$doDeleteCfg -or $doDeleteCfg.Contains("y")) {
	Remove-Item -Path "$env:APPDATA\\RizinOrg\\*cutter*" -Recurse -ErrorAction SilentlyContinue
}

$shortcutName = "\Cutter.lnk"

Remove-Item -Path $([Environment]::GetFolderPath("Desktop") + $shortcutName) -ErrorAction SilentlyContinue
Remove-Item -Path $([Environment]::GetFolderPath("StartMenu") + $shortcutName) -ErrorAction SilentlyContinue
