function Read-Char
{
    param(
        [Parameter(Mandatory = $false)] [String] $Prompt
    )

    $charRead = $null
    while (($null -eq $charRead) -or ($charRead -isnot [System.Char]))
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

            $charRead = $inputString[0]
        }

        catch
        {
            Write-Error $_
        }
    }

    return $charRead
}