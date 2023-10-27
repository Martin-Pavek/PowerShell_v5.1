# Windows 10 PoweShell ver. 1.0
Clear-Host #cls
$adresar_kam="C:\Users\DELL\Documents\zaloha\save_hry\Shadow Warrior Classic Redux\"
$exist = Test-Path -Path $adresar_kam
#echo $exist
if ( $exist -ilike "False" ){
echo "chyby cilovy adresar pro zalohu  - $adresar_kam"
Timeout /t 3
Exit
}

$datum = "{0:dd_MM_yyyy-HH_mm_ss}" -f (Get-Date)

$name="$datum-Shadow Warrior Classic Redux_save-backup.zip"

echo $adresar_kam$name

Compress-Archive -Path "C:\GOG Games\Shadow Warrior Classic Redux\*.sav" -CompressionLevel Optimal -DestinationPath "$adresar_kam$name"
Start-Sleep -Seconds 3
