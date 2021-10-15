using module "./Add-DnfRepository.ps1"
using module "./Install-DnfPackage.ps1"

function Install-GitHubCli {

    <#
    .SYNOPSIS
        Installs GitHub Cli.
    .DESCRIPTION
        Installs GitHub command line interface.
    #>

    Add-DnfRepository -Repository "https://cli.github.com/packages/rpm/gh-cli.repo"

    Install-DnfPackage -Package @("gh", "git", "git-lfs")
}