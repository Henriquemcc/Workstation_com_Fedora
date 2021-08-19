function Enable-Wifi
{
    Invoke-Expression -Command "sudo nmcli radio wifi on"
}