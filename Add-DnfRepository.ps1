function Add-DnfRepository
{
    param (
        [Parameter(Mandatory = $true)]$Repository
    )

    <#
    .SYNOPSIS
        Adds a repository to DNF package manager.
    .DESCRIPTION
        This function adds and enables a DNF package manager repository.
    .PARAMETER Repository
        DNF repository url.
    .EXAMPLE
        PS /> Add-DnfRepository -Repository "https://cli.github.com/packages/rpm/gh-cli.repo"
        This example adds GitHub cli repository to DNF package manager.
    #>

    Invoke-Expression -Command "sudo dnf --assumeyes config-manager --add-repo=$Repository"
}