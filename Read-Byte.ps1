function Read-Byte
{
    param(
        [Parameter(Mandatory = $false)] [String] $Prompt
    )

    $byteRead = $null
    while (($null -eq $byteRead) -or ($byteRead -isnot [System.Byte]))
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

            $byteRead = [System.Byte]::Parse($inputString)
        }

        catch
        {
            Write-Error $_
        }
    }

    return $byteRead
}