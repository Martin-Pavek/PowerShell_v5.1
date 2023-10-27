cls
<#PSScriptInfo
{
    "VERSION": "1.0.0",
    "GUID": "eb890351-6757-40fa-b65a-c0f5ec794576",
    "FILENAME": "Sort-UsingQuickSort.ps1"
}
PSScriptInfo#>
function Sort-UsingQuickSort
{
    <#
    .DESCRIPTION
        This function sorts objects using the quick sort algorithm
    .PARAMETER Name
        Description
    .EXAMPLE
        Sort-UsingQuickSort
        Description of example
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingCmdletAliases', '', Justification = 'False positive, get-partition is not implictly called. partition is a internal function')]
    [CmdletBinding()] # Enabled advanced function support
    param(
        [parameter(ValueFromPipeline, Mandatory)]$InputObject,
        [parameter()][string]$Property,
        [parameter()][int]$Top,
        [parameter()][int]$Bottom,
        [parameter()][switch]$Descending
    )

    BEGIN
    {
        $Unsorted = [collections.arraylist]::New()
        $script:Swaps = 0
        $script:Compares = 0
    }

    PROCESS
    {
        $InputObject | ForEach-Object {
            $null = $Unsorted.Add($PSItem)
        }
    }

    END
    {
        # Determine default sort property
        if ($null -ne $Unsorted[0].PSStandardMembers.DefaultKeyPropertySet)
        {
            Write-Warning -Message 'This object has a default sorting specified'
        }

        function quicksort
        {
            param (
                $array,
                $low,
                $high
            )

            if ($low -lt $high)
            {
                $p = partition -array $array -low $low -high $high
                quicksort -array $array -low $low -high ($p - 1)
                quicksort -array $array -low ($P + 1) -high $high
            }
        }
        function partition
        {
            param(
                $array,
                $low,
                $high
            )
            $pivot = $array[$high]
            $i = $low
            for ($j = $low; $j -le $high; $j++)
            {
                $script:Compares++
                if ($array[$j] -lt $pivot)
                {
                    swap -array $array -position $i -with $j
                    $i = $i + 1 
                }
            }
            swap -array $array -position $i -with $high
            return $i
        }
        function swap
        {
            param(
                $array,
                $position,
                $with
            )
            $temp = $array[$position]
            $array[$position] = $array[$with]
            $array[$with] = $temp
            $script:Swaps++
        }

        quicksort -array $Unsorted -low 0 -high ($Unsorted.count - 1)
        Write-Verbose ('QuickSort | Array length: {0} | Passes: N/A | Swaps: {2} | Compares: {3}' -f $Unsorted.count, $script:Passes, $script:swaps, $script:compares)
        return $Unsorted
    }

}
#endregion

# odsud moje

$array_rnd = @()

$max = 100000  # zde menit <<<<<<<<<<<<<<<<<<<<<<<<<

$minimum = -1000
$maximum = 1000


for ($aa = 1; $aa -le $max; $aa++) {
#$rnd =  Get-Random -Minimum -1000.0 -Maximum 1000.0
$rnd =  Get-Random -Minimum $minimum -Maximum $maximum
$array_rnd += $rnd

}

$poc = 1

$StartTime = get-date # start timer

$out2=Sort-UsingQuickSort $array_rnd # funkce quicksort

$RunTime = New-TimeSpan -Start $StartTime -End (get-date)  # stop timer


for ($bb = 0; $bb -le $max-1; $bb++){

[string] $out3 = $poc
$out3 += "  "
$out3 += $array_rnd[$bb]
$out3 += "  "
$out3 += $out2[$bb]
echo $out3
$poc++
}
 
"Execution time was {0} hours, {1} minutes, {2} seconds and {3} milliseconds." -f $RunTime.Hours,  $RunTime.Minutes,  $RunTime.Seconds,  $RunTime.Milliseconds
# print timer


Remove-Variable array_rnd
Remove-Variable out2
Remove-Variable out3
Remove-Variable StartTime
Remove-Variable RunTime
Remove-Variable poc

sleep 10

<#

PowerShell quicksort algoritmus
cisla od -1000 do 1000 pocet cisel = 100000
puvodni  setridene

Execution time was 0 hours, 2 minutes, 41 seconds and 578 milliseconds.


#>

