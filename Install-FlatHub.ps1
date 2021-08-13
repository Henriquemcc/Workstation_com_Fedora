using module "./Add-FlatpakRepository.ps1"
function Install-FlatHub
{
    Add-FlatpakRepository -name "flathub" -location "https://flathub.org/repo/flathub.flatpakrepo"
}