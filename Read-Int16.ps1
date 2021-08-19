function Read-Int16 {

    param(
        [Parameter(Mandatory = $false)] [String] $Prompt
    )

    $int16Read = $null
    while (($null -eq $int16Read) -or ($int16Read -isnot [System.Int16])) {
        try {

            $inputString = $null
            if (($null -eq $Prompt) -or ($Prompt.Length -le 0)) {
                $inputString = Read-Host
            }
            else {
                $inputString = Read-Host -Prompt $Prompt
            }

            if (($null -eq $inputString) -or ($inputString.Length -le 0)) {
                throw "Input is null or with length less equal to zero"
            }

            $int16Read = [System.Int16]::Parse($inputString)
        }

        catch {
            Write-Error $_
        }
    }

    return $int16Read


}