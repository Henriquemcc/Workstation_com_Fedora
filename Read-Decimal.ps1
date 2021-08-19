function Read-Decimal
{
    param(
        [Parameter(Mandatory = $false)] [String] $Prompt
    )

    $decimalRead = $null
    while (($null -eq $decimalRead) -or ($decimalRead -isnot [System.Decimal]))
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

            $decimalRead = [System.Decimal]::Parse($inputString)
        }

        catch
        {
            Write-Error $_
        }
    }

    return $decimalRead
}