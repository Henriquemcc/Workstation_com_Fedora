class IpAddressInfo {
    [System.Net.IPAddress]$IpAddress
    [System.UInt16]$Prefix

    IpAddressInfo([System.Net.IPAddress]$IpAddress, [System.UInt16]$Prefix) {
        $this.IpAddress = $IpAddress
        $this.Prefix = $Prefix
    }

    IpAddressInfo([System.String]$IpAddress, [System.UInt16]$Prefix) {
        $this.IpAddress = [System.Net.IPAddress]::Parse($IpAddress)
        $this.Prefix = $Prefix
    }

    [System.String]ToString() {
        return "$($this.IpAddress)/$($this.Prefix)"
    }
}

class Server {
    [System.Collections.Generic.List[IpAddressInfo]]$Address
    [System.String]$Endpoint
    [System.UInt16]$Port
    [System.String]$OutputInterfaceName
    [System.String]$PrivateKey

    Server([System.Collections.Generic.List[IpAddressInfo]]$Address, [System.String]$Endpoint, [System.UInt16]$Port, [System.String]$OutputInterfaceName, [System.String]$PrivateKey) {
        $this.Address = $Address
        $this.Endpoint = $Endpoint
        $this.Port = $Port
        $this.OutputInterfaceName = $OutputInterfaceName
        $this.PrivateKey = $PrivateKey
    }

    Server([System.String]$Endpoint, [System.String]$OutputInterfaceName) {
        $this.Address = @([IpAddressInfo]::new("10.100.0.1", 24), [IpAddressInfo]::new("fd08:4711::1", 64))
        $this.Endpoint = $Endpoint
        $this.Port = 51820
        $this.OutputInterfaceName = $OutputInterfaceName
        $this.PrivateKey = GeneratePrivateKey
    }

    Server([System.String]$Endpoint, [System.UInt16]$Port, [System.String]$OutputInterfaceName) {
        $this.Address = @([IpAddressInfo]::new("10.100.0.1", 24), [IpAddressInfo]::new("fd08:4711::1", 64))
        $this.Endpoint = $Endpoint
        $this.Port = $Port
        $this.OutputInterfaceName = $OutputInterfaceName
        $this.PrivateKey = GeneratePrivateKey
    }

    [System.String] GetPublicKey() {
        return GeneratePublicKey -PrivateKey $this.PrivateKey
    }

}

class Client {
    [System.String]$Name
    [System.Collections.Generic.List[IpAddressInfo]]$Address
    [System.String]$PrivateKey
    [System.String]$PresharedKey
    [System.Collections.Generic.List[System.Net.IPAddress]]$DnsServers
    [System.Collections.Generic.List[IpAddressInfo]]$AllowedIps

    Client([System.String]$Name) {

        $this.PrivateKey = GeneratePrivateKey
        $this.PresharedKey = GeneratePresharedKey
        $this.DnsServers = @([System.Net.IPAddress]::Parse("9.9.9.9"), [System.Net.IPAddress]::Parse("149.112.112.112"),[System.Net.IPAddress]::Parse("2620:fe::fe"),[System.Net.IPAddress]::Parse("2620:fe::9"),[System.Net.IPAddress]::Parse("1.1.1.2"),[System.Net.IPAddress]::Parse("1.0.0.2"),[System.Net.IPAddress]::Parse("2606:4700:4700::1112"),[System.Net.IPAddress]::Parse("2606:4700:4700::1002"),[System.Net.IPAddress]::Parse("8.8.8.8"),[System.Net.IPAddress]::Parse("8.8.4.4"),[System.Net.IPAddress]::Parse("2001:4860:4860::8888"),[System.Net.IPAddress]::Parse("2001:4860:4860::8844"))
        $this.AllowedIps = @([IpAddressInfo]::new("0.0.0.0", 0), [IpAddressInfo]::new("::", 0))
        $this.Name = $Name
        $this.Address = $null
    }

    Client([System.String]$Name, [System.Collections.Generic.List[IpAddressInfo]]$Address) {

        $this.PrivateKey = GeneratePrivateKey
        $this.PresharedKey = GeneratePresharedKey
        $this.DnsServers = @([System.Net.IPAddress]::Parse("9.9.9.9"), [System.Net.IPAddress]::Parse("149.112.112.112"),[System.Net.IPAddress]::Parse("2620:fe::fe"),[System.Net.IPAddress]::Parse("2620:fe::9"),[System.Net.IPAddress]::Parse("1.1.1.2"),[System.Net.IPAddress]::Parse("1.0.0.2"),[System.Net.IPAddress]::Parse("2606:4700:4700::1112"),[System.Net.IPAddress]::Parse("2606:4700:4700::1002"),[System.Net.IPAddress]::Parse("8.8.8.8"),[System.Net.IPAddress]::Parse("8.8.4.4"),[System.Net.IPAddress]::Parse("2001:4860:4860::8888"),[System.Net.IPAddress]::Parse("2001:4860:4860::8844"))
        $this.AllowedIps = @([IpAddressInfo]::new("0.0.0.0", 0), [IpAddressInfo]::new("::", 0))
        $this.Name = $Name
        $this.Address = $Address
    }

    Client(
        [System.String]$Name, [System.Collections.Generic.List[IpAddressInfo]]$Address, [System.String]$PrivateKey, [System.String]$PresharedKey, [System.Collections.Generic.List[System.Net.IPAddress]]$DnsServers, [System.Collections.Generic.List[IpAddressInfo]]$AllowedIps) {
        $this.Name = $Name
        $this.Address = $Address
        $this.PrivateKey = $PrivateKey
        $this.PresharedKey = $PresharedKey
        $this.DnsServers = $DnsServers
        $this.AllowedIps = $AllowedIps
    }

    [System.String] GetPublicKey() {
        return GeneratePublicKey -PrivateKey ($this.PrivateKey)
    }
}

function GeneratePrivateKey() {
    return $(wg genkey)
}

function GeneratePublicKey([System.String]$PrivateKey) {
    return $($PrivateKey | wg pubkey)
}

function GeneratePresharedKey() {
    return $(wg genpsk)
}

function GenerateServerConfiguration([Server]$Server, [System.Collections.Generic.List[Client]]$Clients) {
    $stringBuilder = [System.Text.StringBuilder]::new()

    [void]$stringBuilder.AppendLine("[Interface]")
    [void]$stringBuilder.AppendLine("Address = $($Server.Address -join ", ")")
    [void]$stringBuilder.AppendLine("ListenPort = $($Server.Port)")
    [void]$stringBuilder.AppendLine("PostUp = iptables -w -t nat -A POSTROUTING -o $($Server.OutputInterfaceName) -j MASQUERADE; ip6tables -w -t nat -A POSTROUTING -o $($Server.OutputInterfaceName) -j MASQUERADE")
    [void]$stringBuilder.AppendLine("PostDown = iptables -w -t nat -D POSTROUTING -o $($Server.OutputInterfaceName) -j MASQUERADE; ip6tables -w -t nat -D POSTROUTING -o $($Server.OutputInterfaceName) -j MASQUERADE")
    [void]$stringBuilder.AppendLine("PrivateKey = $($Server.PrivateKey.ToString())")
    [void]$stringBuilder.AppendLine()

    foreach ($client in $Clients) {
        [void]$stringBuilder.AppendLine("[Peer]")
        [void]$stringBuilder.AppendLine("# Name = $($client.Name)")
        [void]$stringBuilder.AppendLine("PublicKey = $($client.GetPublicKey())")
        [void]$stringBuilder.AppendLine("PresharedKey = $($client.PresharedKey)")
        [void]$stringBuilder.AppendLine("AllowedIPs = $($client.Address -join ", ")")
        [void]$stringBuilder.AppendLine()
    }

    return $stringBuilder.ToString()
}

function GenerateClientConfiguration([Server]$Server, [Client]$Client) {
    $stringBuilder = [System.Text.StringBuilder]::new()

    [void]$stringBuilder.AppendLine("[Interface]")
    [void]$stringBuilder.AppendLine("# Name = $($Client.Name)")
    [void]$stringBuilder.AppendLine("Address = $($Client.Address -join ", ")")
    [void]$stringBuilder.AppendLine("DNS = $($Client.DnsServers -join ", ")")
    [void]$stringBuilder.AppendLine("PrivateKey = $($Client.PrivateKey)")
    [void]$stringBuilder.AppendLine()

    [void]$stringBuilder.AppendLine("[Peer]")
    [void]$stringBuilder.AppendLine("AllowedIPs = $($Client.AllowedIps -join ", ")")
    [void]$stringBuilder.AppendLine("Endpoint = $($Server.Endpoint):$($Server.Port)")
    [void]$stringBuilder.AppendLine("PublicKey = $($Server.GetPublicKey())")
    [void]$stringBuilder.AppendLine("PresharedKey = $($Client.PresharedKey)")

    return $stringBuilder.ToString()
}