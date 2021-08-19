function Read-Boolean
{
    param(
        [Parameter(Mandatory = $false)] [String] $Prompt
    )

    $booleanRead
    while (($null -eq $booleanRead) -or ($booleanRead -isnot [System.Boolean]))
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

            $booleanRead = [System.Boolean]::Parse($inputString)
        }

        catch
        {
            Write-Error $_
        }
    }

    return $booleanRead
}