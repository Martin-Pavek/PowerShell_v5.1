cls

#$magick = ("C:\Program Files (x86)\ImageMagick-7.1.1-Q16\magick.exexx") # test
$magick = ("C:\Program Files (x86)\ImageMagick-7.1.1-Q16\magick.exe")
# jestli nasel soubor magick.exe
if (-not (Test-Path $magick)){
Write-Warning "nenalezen soubor $magick"
sleep 5
Exit
}

[string] $pwd2 = Get-Location # kdyz nejni [string] dela kraviny

$pripony_obrazku = @("png", "tif", "jpeg", "pcx", "bmp") # co chybi tak jeste doplnit

$znak_rozdelovac = "."
$pripona_jpg=".jpg"
$pocitadlo = 1

$files = Get-ChildItem -path $pwd -Name -File
#                                        ^ jenom soubory a ne podadresare

#echo "Imagemagick for Windows"
Write-host -ForegroundColor yellow "Imagemagick for Windows"
foreach($file in $files){

#
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

#echo $pocitadlo" -- pocitadlo"
#$pocitadlo++

#echo $file

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

echo "$pocitadlo2$pwd2$file --> $pwd2$file_name$pripona_jpg"

$out1='"'+$pwd2+$file+'"'
$out2='"'+$pwd2+$file_name+$pripona_jpg+'"'

#echo $out1
#echo $out2

& $magick "$out1" "$out2"
# provadi prevod

$pocitadlo++
}
}
}

#sleep 10
