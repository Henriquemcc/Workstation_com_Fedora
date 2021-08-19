using module "./Add-FlatpakRepository.ps1"
function Install-FlatHub {

    Add-FlatpakRepository -Name "flathub" -Location "https://flathub.org/repo/flathub.flatpakrepo"
}