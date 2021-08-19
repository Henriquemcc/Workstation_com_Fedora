function Write-Title
{
    param(
        [Parameter(Mandatory = $true)] [String] $Title
    )

    $line = "********************************************************************************"

    Write-Host $line
    Write-Host $Title
    Write-Host $line
}