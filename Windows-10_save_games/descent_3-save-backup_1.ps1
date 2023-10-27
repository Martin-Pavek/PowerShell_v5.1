Clear-Host #cls
$adresar_kam="C:\Users\DELL\Documents\zaloha\save_hry\descent_3\"
$exist = Test-Path -Path $adresar_kam
#echo $exist
if ( $exist -ilike "False" ){
echo "chyby cilovy adresar pro zalohu  - $adresar_kam"
Timeout /t 3
Exit
}

$datum = "{0:dd_MM_yyyy-HH_mm_ss}" -f (Get-Date)

$name="$datum-descent-3_save-backup.zip"

echo $adresar_kam$name

Compress-Archive -Path "C:\GOG Games\Descent 3\savegame"  -CompressionLevel Optimal -DestinationPath "$adresar_kam$name"
Compress-Archive -Update -Path "C:\GOG Games\Descent 3\*.tga"  -DestinationPath "$adresar_kam$name"

Start-Sleep -Seconds 3
# [regex] Compress  file folder
