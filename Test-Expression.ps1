function Test-Expression{
    param(
        [Parameter(Mandatory = $true)][System.String]$Command
    )

    <#
    .SYNOPSIS
        Tests a expression
    .DESCRIPTION
        Tests if a command or cmdlet exists.
    .EXAMPLE
        PS /> Test-Expression -Command "cat"
        True
    #>

    $commandInformation = Get-Command -Name $Command -ErrorAction SilentlyContinue

    return $null -ne $commandInformation
}