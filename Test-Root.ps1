function Test-Root
{
    $currentUser = Invoke-Expression -Command "whoami"
    $currentUser = $currentUser.ToLower()
    return $currentUser -eq "root"
}