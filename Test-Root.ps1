<#
.SYNOPSIS
    Tests wheter the current user is root.
.DESCRIPTION
    This function tests wheter the current user running is root.
#>

$currentUser = Invoke-Expression -Command "whoami"
$currentUser = $currentUser.ToLower()
return $currentUser -eq "root"