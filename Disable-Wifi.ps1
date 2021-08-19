function Disable-Wifi
{
    Invoke-Expression -Command "sudo nmcli radio wifi off"
}