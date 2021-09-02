function Write-Title
{
    <#
    .SYNOPSIS
        Writes a title on the console.
    .DESCRIPTION
        This function writes a title on the console.
    .PARAMETER Title
        Title which will be written on the console.
    #>
    param(
        [Parameter(Mandatory = $true)] [String] $Title
    )

    $line = "********************************************************************************"

    Write-Host $line
    Write-Host $Title
    Write-Host $line
}