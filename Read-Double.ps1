function Read-Double
{
    param(
        [Parameter(Mandatory = $false)] [String] $Prompt
    )

    $doubleRead = $null
    while (($null -eq $doubleRead) -or ($doubleRead -isnot [System.Double]))
    {
        try
        {
            $inputString = $null
            if (($null -eq $Prompt) -or ($Prompt.Length -le 0))
            {
                $inputString = Read-Host
            }
            else
            {
                $inputString = Read-Host -Prompt $Prompt
            }

            if (($null -eq $inputString) -or ($inputString.Length -le 0))
            {
                throw "Input is null or with length less equal to zero"
            }

            $doubleRead = [System.Double]::Parse($inputString)
        }

        catch
        {
            Write-Error $_
        }
    }

    return $doubleRead

}