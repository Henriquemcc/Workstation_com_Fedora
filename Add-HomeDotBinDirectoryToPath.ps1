# Defining bashrc file path
$bashrcFile = [System.IO.Path]::Combine($env:HOME, ".bashrc")

# Defining string to be written
$exportPathString = "export PATH=`"$`HOME/.bin:$`PATH`""

# Creating fileStream and streamReader
$fileStream = [System.IO.FileStream]::new($bashrcFile, [System.IO.FileMode]::OpenOrCreate, [System.IO.FileAccess]::ReadWrite)
$streamReader = [System.IO.StreamReader]::new($fileStream)

# Detecting if file contains exportPathString
$containsExportPathString = $false
while ((-not$containsExportPathString) -and (-not$streamReader.EndOfStream)) {
    $line = $streamReader.ReadLine()

    if (($null -ne $line) -and $line.Contains($exportPathString)) {
        $containsExportPathString = $true
    }
}
$streamReader.Close()
$fileStream.Close()

# Appending exportPathString
if (-not$containsExportPathString) {
    $fileStream = [System.IO.FileStream]::new($bashrcFile, [System.IO.FileMode]::Append, [System.IO.FileAccess]::Write)
    $streamWriter = [System.IO.StreamWriter]::new($fileStream)
    $streamWriter.WriteLine($exportPathString)
    $streamWriter.Close()
    $fileStream.Close()
}