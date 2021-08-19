function Read-Int64 {

    param(
        [Parameter(Mandatory = $false)] [String] $Prompt
    )

    $int64Read = $null
    while (($null -eq $int64Read) -or ($int64Read -isnot [System.Int64])) {
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

            $int64Read = [System.Int64]::Parse($inputString)
        }

        catch {
            Write-Error $_
        }
    }

    return $int64Read
}