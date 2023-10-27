Clear-Host #cls
$adresar_kam="C:\Users\DELL\Documents\zaloha\save_hry\hexen_2\"
$exist = Test-Path -Path $adresar_kam
#echo $exist
if ( $exist -ilike "False" ){
echo "chyby cilovy adresar pro zalohu  - $adresar_kam"
Timeout /t 3
Exit
}

$datum = "{0:dd_MM_yyyy-HH_mm_ss}" -f (Get-Date)

$name="$datum-hexen-2_save-backup.zip"

echo $adresar_kam$name

Compress-Archive -Path "C:\Program Files (x86)\jsHexen II\Portals\quick" -CompressionLevel Optimal -DestinationPath "$adresar_kam$name"
Compress-Archive -Update -Path "C:\Program Files (x86)\jsHexen II\Portals\s?" -DestinationPath "$adresar_kam$name"
# kdyby tam byl treba adresar "sa" tak ho zapakuje taky totez u "s??" podivat se po nekajim ereg apod.jestli nejni neco
Compress-Archive -Update -Path "C:\Program Files (x86)\jsHexen II\Portals\s??" -DestinationPath "$adresar_kam$name"
Compress-Archive -Update -Path "C:\Program Files (x86)\jsHexen II\Portals\shots" -DestinationPath "$adresar_kam$name"

Start-Sleep -Seconds 3

