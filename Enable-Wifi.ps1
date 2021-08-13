function Enable-Wifi
{
    Invoke-Expression -Command "nmcli radio wifi on"
}