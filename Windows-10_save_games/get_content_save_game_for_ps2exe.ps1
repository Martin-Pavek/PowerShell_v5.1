cls

#Invoke-ps2exe C:\Users\DELL\Documents\ps1\save_game\abe_exodus_save-backup.ps1 C:\Users\DELL\Documents\ps1\save_game\abe_exodus_save-backup.exe

$cesta = "C:\Users\DELL\Documents\ps1\save_game\"

$files = Get-ChildItem -path $cesta -filter "*.ps1" -Name

#$file_out="R:\xxx.txt"
$file_out="vloz_me_na_konec_souboru_ps2exe.ps1.txt"

$table_out=@("# tyto radky vlozit na konec souboru ps2exe.ps1")


foreach($file in $files) { 

$d_file = $file.Length

$out = ""
for ($aa = 0; $aa -le $d_file - 4; $aa++){

$znak = $file[$aa]
$out+=$znak
}

$out+="exe"
$file2="Invoke-ps2exe "+$cesta+$file
#$out2=$cesta+$out
$out2=$cesta+"exe\"+$out
#echo "$file2 $out2"
$out3="$file2 $out2"
echo $out3
$table_out+=$out3
}

Set-Content -Path $file_out -Encoding ASCII -Value $table_out

