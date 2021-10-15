using module "./Install-DnfPackage.ps1"

function Install-MySQLWorkBench{

    <#
    .SYNOPSIS
        Installs MySQL WorkBench.
    .DESCRIPTION
        Installs MySQL WorkBench.
    #>

    Install-DnfPackage -Package "https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-8.0.26-1.fc34.x86_64.rpm"
}