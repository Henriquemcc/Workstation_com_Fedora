function Read-Single {

    param(
        [Parameter(Mandatory = $false)] [String] $Prompt
    )

    $singleRead = $null
    while (($null -eq $singleRead) -or ($singleRead -isnot [System.Single])) {
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

            $singleRead = [System.Single]::Parse($inputString)
        }

        catch {
            Write-Error $_
        }
    }

    return $singleRead

}