# Windows 10 PoweShell ver. 1.0
Clear-Host #cls
$adresar_kam="C:\Users\DELL\Documents\zaloha\save_hry\game_over\"
$exist = Test-Path -Path $adresar_kam
#echo $exist
if ( $exist -ilike "False" ){
echo "chyby cilovy adresar pro zalohu  - $adresar_kam"
Timeout /t 3
Exit
}

[string] $d = (Get-Date).Day # zmeni typ int na strings
[string] $me = (Get-Date).Month
[string] $h = (Get-Date).Hour
[string] $m = (Get-Date).Minute
[string] $s = (Get-Date).Second
[string] $y = (Get-Date).Year

$d_d = $d.Length
$d_me = $me.Length
$d_h = $h.Length
$d_m = $m.Length
$d_s = $s.Length
$d_y = $y.Length

if( $d_d -eq "1" ){
$d = "0$d"
}
if( $d_me -eq "1" ){
$me = "0$me"
}
if( $d_h -eq "1" ){
$h = "0$h"
}
if( $d_m -eq "1" ){
$m = "0$m"
}if( $d_s -eq "1" ){
$s = "0$s"
}

$name="$d-$me-$y--$h-$m-$s--game-over_save-backup.zip"

echo $adresar_kam$name

Compress-Archive -Path "C:\Users\DELL\Documents\GameOver" -CompressionLevel Optimal -DestinationPath "$adresar_kam$name"
Start-Sleep -Seconds 3
