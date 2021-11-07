<#
.SYNOPSIS
    Installs GitHub Cli.
.DESCRIPTION
    Installs GitHub command line interface.
#>

./Add-DnfRepository.ps1 -Repository "https://cli.github.com/packages/rpm/gh-cli.repo"

./Install-DnfPackage.ps1 -Package @("gh", "git", "git-lfs")