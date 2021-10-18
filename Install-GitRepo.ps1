using module "./Add-HomeDotBinDirectoryToPath.ps1"

function Install-GitRepo
{
    # Installing GitRepo
    Invoke-Expression "bash Install-GitRepo.sh"

    # Adding ~/.bin folder to path
    Add-HomeDotBinDirectoryToPath
}