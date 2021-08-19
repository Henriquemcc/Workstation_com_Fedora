function Read-Int32
{
    param(
        [Parameter(Mandatory = $false)] [String] $Prompt
    )

    $int32Read = $null
    while (($null -eq $int32Read) -or ($int32Read -isnot [System.Int32]))
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

            $int32Read = [System.Int32]::Parse($inputString)
        }

        catch
        {
            Write-Error $_
        }
    }

    return $int32Read
}