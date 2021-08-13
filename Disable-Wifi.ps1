function Disable-Wifi
{
    Invoke-Expression -Command "nmcli radio wifi off"
}