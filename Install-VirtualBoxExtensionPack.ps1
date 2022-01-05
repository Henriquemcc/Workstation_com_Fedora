$virtualboxIsInstalled = ./Test-Expression.ps1 -Command "VBoxManage"
if (-not$virtualboxIsInstalled) {
    ./Install-VirtualBox.ps1
}

# Downloading VirtualBox extension pack
$extensionPackUri = "https://download.virtualbox.org/virtualbox/6.1.26/Oracle_VM_VirtualBox_Extension_Pack-6.1.26.vbox-extpack"
$licenseUid = "33d7284dc4a0ece381196fda3cfe2ed0e1e8e7ed7f27b9a9ebc4ee22e24bd23c"

$extensionPackFile = Split-Path -Path $extensionPackUri -Leaf
$extensionPackFileExists = Test-Path -Path $extensionPackFile -PathType Leaf
if (-not$extensionPackFileExists) {
    Invoke-WebRequest -Uri $extensionPackUri -OutFile $extensionPackFile
}

# Installing VirtualBox extension pack
Invoke-Expression -Command "sudo VBoxManage extpack install --replace --accept-license=$licenseUid $extensionPackFile"