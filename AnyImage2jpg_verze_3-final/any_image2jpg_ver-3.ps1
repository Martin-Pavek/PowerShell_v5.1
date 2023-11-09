cls

# any_image2jpg_ver-3.ps1

#$magick = ("C:\Program Files (x86)\ImageMagick-7.1.1-Q16\magick.exexx") # test
$magick = ("C:\Program Files (x86)\ImageMagick-7.1.1-Q16\magick.exe")
# jestli nasel soubor magick.exe
if (-not (Test-Path $magick)){
Write-Warning "nenalezen soubor $magick"
sleep 5
Exit
}

[string] $pwd2 = Get-Location # kdyz nejni [string] dela kraviny
#$pwd2+="\"
# kdyz jsem na ramdisku je pak cesta "R:\\", jinde je zase napr. "R:\aaa\"
if ($pwd2.Length -ne 3){
# dela vsude stejny tzn "R:\" ; "R:\aaa\"; "E:\"; "E:\aaa\"
$pwd2+="\"
}


$pripony_obrazku = @("png", "tif", "jpeg", "pcx", "bmp", "gif", "tiff") # co chybi tak jeste doplnit
#                     ^ pozor aby nebylo 2x totez, dela to pak kraviny, dlouho jsem pak hledal chybu !!!

$znak_rozdelovac = "."
$pripona_jpg=".jpg"
$pocitadlo = 1

$renames=@("") # pole pro ukladani jiz pouzitych nazvu souboru pri konverzi ( nazvy bez pripon pouze )

$files = Get-ChildItem -path $pwd2 -Name -File
#                                         ^ jenom soubory, ne podadresare

Write-host -ForegroundColor yellow "Imagemagick for Windows, any_image2jpg (verze 3)"
foreach($file in $files){
#echo $file

$delka_file = $file.Length
#echo $delka_file

$nalezeno_rozdelovac = $file.IndexOf($znak_rozdelovac)
#echo $nalezeno_rozdelovac

$file_name = $file.Substring(0,$nalezeno_rozdelovac)
#echo $file_name

$file_pripona = $file.Substring($nalezeno_rozdelovac + 1,$delka_file - $nalezeno_rozdelovac - 1 )
#echo $file_pripona

# kontrola jestli pripona je obrazek aby se nesnazil convertovat avi do jpg apod. paklize je v adresari mix
# pusti k dalsimu zpracovani jenom to co je v poly $pripony_obrazku
# paklize je pripona obrazku napr. "nazev.PNG" tak ho bere taky nerozlisuje velka a mala pismena
# tzn. ze pole pripony_obrazku nemusi vypadat treba takto @("png", "tiff", "jpeg" ,"PNG", "TIFF", "JPEG")
# vlaste by bylo lepsi kdyto to tam nebylo...
for ($aa = 0; $aa -le ($pripony_obrazku.length - 1); $aa ++) {
if ($file_pripona -like $pripony_obrazku[$aa] ) {

#echo $file"<<"
#$pocitadlo++

$delka_file = $file.Length
#echo $delka_file

$nalezeno_rozdelovac = $file.IndexOf($znak_rozdelovac)
#echo $nalezeno_rozdelovac

$file_name = $file.Substring(0,$nalezeno_rozdelovac)
#echo $file_name

$file_pripona = $file.Substring($nalezeno_rozdelovac + 1,$delka_file - $nalezeno_rozdelovac - 1 )
#echo $file_pripona

[string] $pocitadlo2=$pocitadlo # prevede int na string
$d_pocitadlo_2=$pocitadlo2.Length
#echo $d_pocitadlo_2
if ($d_pocitadlo_2 -lt 2 ){
$pocitadlo2="0"+$pocitadlo2+") "
}else{
$pocitadlo2+=") "
}

$nasel=0
# vyreseni problemu z duplicitnimy nazvy souboru viz obr1.jpg
for ($bb = 0; $bb -le ($renames.length - 1); $bb ++) {

if ($file_name -like $renames[$bb] ) {
#echo "nasel"
$nasel++
#$target='"'+$pwd2+$file_name+"("+$file_pripona+")"+$pripona_jpg+'"'
}

} # bb


$source='"'+$pwd2+$file+'"'


#echo $nasel
[string] $nasel2=$nasel
#echo $nasel2

if ($nasel -lt 1 ){
$target='"'+$pwd2+$file_name+$pripona_jpg+'"'
}else{
#$target='"'+$pwd2+$file_name+"("+$file_pripona+")"+$pripona_jpg+'"'
$target='"'+$pwd2+$file_name+"("+$nasel2+")"+$pripona_jpg+'"'
}


echo "$pocitadlo2$source --> $target"
#echo $source
#echo $target

& $magick "$source" "$target"
# provadi prevod


if ( $args[0] -like "-delete" ){
#po prevodu do *.jpg maze z adresare vsechy source file
$smaz_source="$pwd2$file"
#echo $smaz_source
Remove-Item -Path $smaz_source
}



$renames+=$file_name # jiz pouziti target nazev prida do pole $renames, pro dalsi kontrolu
# aby se zabranilo duplicitnim nazvum a tim prepisovani convertovanych souboru

$pocitadlo++

}
}
}

#sleep 10

