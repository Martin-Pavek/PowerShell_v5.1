cls
[string] $scriptName = pwd
$scriptName += "\"
$scriptName += $MyInvocation.MyCommand.Name
$host.UI.RawUI.WindowTitle = $scriptName

$adresar_kam="C:\Users\DELL\Documents\zaloha\save_hry\phantasmagoria\"
$exist = Test-Path -Path $adresar_kam
#echo $exist
if ( $exist -ilike "False" ){
echo "chyby cilovy adresar pro zalohu  - $adresar_kam"
sleep 3
Exit
}

$datum = "{0:dd_MM_yyyy-HH_mm_ss}" -f (Get-Date)
$name = "$datum-phantasmagoria_save-backup.zip"
echo $adresar_kam$name

Compress-Archive -Path "C:\Program Files (x86)\GOG.com\Phantasmagoria\*.*" -CompressionLevel Optimal -DestinationPath "$adresar_kam$name"
# *.* jen soubory bez vnorenejch adresaru
sleep 2
Compress-Archive -Path "C:\Program Files (x86)\GOG.com\Phantasmagoria\DOSBOX\" -CompressionLevel Optimal -Update -DestinationPath "$adresar_kam$name"
sleep 2
Compress-Archive -Path "C:\Program Files (x86)\GOG.com\Phantasmagoria\PATCHES\" -CompressionLevel Optimal -Update -DestinationPath "$adresar_kam$name"
sleep 3

<#
 Compress-Archive -Path C:\Reference\*.* -DestinationPath C:\Archives\Draft.zip
    
    `Compress-Archive` uses the Path parameter to specify the root directory, `C:\Reference` with a star-dot-star (` . `) wildcard.
     The DestinationPath parameter specifies the location for the archive file. The `Draft.zip` archive only contains the `Referenc
    e` root directory's files and the root directory is excluded.

    # ---------

        $compress = @{
      Path = "C:\Reference\Draftdoc.docx", "C:\Reference\Images\*.vsd"
      CompressionLevel = "Fastest"
      DestinationPath = "C:\Archives\Draft.Zip"
    }
    Compress-Archive @compress

    Compress-Archive -Path C:\Reference -Update -DestinationPath C:\Archives\Draft.Zip

#>



