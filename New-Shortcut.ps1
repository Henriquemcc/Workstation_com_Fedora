using module "./DesktopEntryType.ps1"

function New-Shortcut
{
    param(
        [Parameter(Mandatory = $true)][DesktopEntryType]$Type,
        [Parameter(Mandatory = $false)]$Version = $null,
        [Parameter(Mandatory = $true)]$Name,
        [Parameter(Mandatory = $false)]$GenericName = $null,
        [Parameter(Mandatory = $false)]$NoDisplay = $null,
        [Parameter(Mandatory = $false)]$Comment = $null,
        [Parameter(Mandatory = $false)]$Icon = $null,
        [Parameter(Mandatory = $false)]$Hidden = $null,
        [Parameter(Mandatory = $false)]$OnlyShowIn = $null,
        [Parameter(Mandatory = $false)]$NotShowIn = $null,
        [Parameter(Mandatory = $false)]$DBusActivatable = $null,
        [Parameter(Mandatory = $false)]$TryExec = $null,
        [Parameter(Mandatory = $false)]$Exec = $null,
        [Parameter(Mandatory = $false)]$Path = $null,
        [Parameter(Mandatory = $false)]$Terminal = $null,
        [Parameter(Mandatory = $false)]$Actions = $null,
        [Parameter(Mandatory = $false)]$MimeType = $null,
        [Parameter(Mandatory = $false)]$Categories = $null,
        [Parameter(Mandatory = $false)]$Implements = $null,
        [Parameter(Mandatory = $false)]$Keywords = $null,
        [Parameter(Mandatory = $false)]$StartupNotify = $null,
        [Parameter(Mandatory = $false)]$StartupWMClass = $null,
        [Parameter(Mandatory = $false)]$URL = $null,
        [Parameter(Mandatory = $false)]$PrefersNonDefaultGPU = $null,
        [Parameter(Mandatory = $false)][Switch]$AllUsers,
        [Parameter(Mandatory = $true)]$FileName
    )

    if (($null -ne $TryExec) -and ($Type -ne [DesktopEntryType]::Application))
    {
        throw "Parameter TryExec requires parameter 'Type' to be 'Application'"
    }

    if (($null -ne $Exec) -and ($Type -ne [DesktopEntryType]::Application))
    {
        throw "Parameter Exec requires parameter 'Type' to be 'Application'"
    }

    if (($null -ne $Path) -and ($Type -ne [DesktopEntryType]::Application))
    {
        throw "Parameter Path requires parameter 'Type' to be 'Application'"
    }

    if (($null -ne $Terminal) -and ($Type -ne [DesktopEntryType]::Application))
    {
        throw "Parameter Terminal requires parameter 'Type' to be 'Application'"
    }

    if (($null -ne $Actions) -and ($Type -ne [DesktopEntryType]::Application))
    {
        throw "Parameter Actions requires parameter 'Type' to be 'Application'"
    }

    if (($null -ne $MimeType) -and ($Type -ne [DesktopEntryType]::Application))
    {
        throw "Parameter MimeType requires parameter 'Type' to be 'Application'"
    }

    if (($null -ne $Categories) -and ($Type -ne [DesktopEntryType]::Application))
    {
        throw "Parameter Categories requires parameter 'Type' to be 'Application'"
    }

    if (($null -ne $Implements) -and ($Type -ne [DesktopEntryType]::Application))
    {
        throw "Parameter Implements requires parameter 'Type' to be 'Application'"
    }

    if (($null -ne $Keywords) -and ($Type -ne [DesktopEntryType]::Application))
    {
        throw "Parameter Keywords requires parameter 'Type' to be 'Application'"
    }

    if (($null -ne $StartupNotify) -and ($Type -ne [DesktopEntryType]::Application))
    {
        throw "Parameter StartupNotify requires parameter 'Type' to be 'Application'"
    }

    if (($null -ne $StartupWMClass) -and ($Type -ne [DesktopEntryType]::Application))
    {
        throw "Parameter StartupWMClass requires parameter 'Type' to be 'Application'"
    }

    if (($null -ne $URL) -and ($Type -ne [DesktopEntryType]::Link))
    {
        throw "Parameter URL requires parameter 'Type' to be 'Link'"
    }

    if (($null -ne $PrefersNonDefaultGPU) -and ($Type -ne [DesktopEntryType]::Application))
    {
        throw "Parameter PrefersNonDefaultGPU requires parameter 'Type' to be 'Application'"
    }

    $desktopFile = [System.IO.File]::OpenWrite($FileName)
    $streamWriterDesktopFile = [System.IO.StreamWriter]::new($desktopFile)

    $streamWriterDesktopFile.WriteLine("[Desktop Entry]")

    if ($Type -eq [DesktopEntryType]::Application)
    {
        $streamWriterDesktopFile.WriteLine("Type=Application")
    }
    elseif($Type -eq [DesktopEntryType]::Directory)
    {
        $streamWriterDesktopFile.WriteLine("Type=Directory")
    }
    elseif($Type -eq [DesktopEntryType]::Link)
    {
        $streamWriterDesktopFile.WriteLine("Type=Link")
    }

    if ($null -ne $Version)
    {
        $streamWriterDesktopFile.WriteLine("Version=$Version")
    }

    $streamWriterDesktopFile.WriteLine("Name=$Name")

    if ($null -ne $GenericName)
    {
        $streamWriterDesktopFile.WriteLine("GenericName=$GenericName")
    }

    if ($true -eq $NoDisplay)
    {
        $streamWriterDesktopFile.WriteLine("NoDisplay=true")
    }
    elseif($false -eq $NoDisplay)
    {
        $streamWriterDesktopFile.WriteLine("NoDisplay=false")
    }

    if ($null -ne $Comment)
    {
        $streamWriterDesktopFile.WriteLine("Comment=$Comment")
    }

    if ($null -ne $Icon)
    {
        $streamWriterDesktopFile.WriteLine("Icon=$Icon")
    }

    if ($true -eq $Hidden)
    {
        $streamWriterDesktopFile.WriteLine("Hidden=true")
    }
    elseif ($false -eq $Hidden)
    {
        $streamWriterDesktopFile.WriteLine("Hidden=false")
    }

    if ($null -ne $OnlyShowIn)
    {
        $stringOnlyShowIn = ""
        foreach ($o in $OnlyShowIn)
        {
            $stringOnlyShowIn += "$o; "
        }
        $stringOnlyShowIn = $stringOnlyShowIn.Substring(0,$stringOnlyShowIn.LastIndexOf("; "))

        $streamWriterDesktopFile.WriteLine("OnlyShowIn=$stringOnlyShowIn")
    }

    if ($null -ne $NotShowIn)
    {
        $stringNotShowIn = ""
        foreach ($n in $NotShowIn)
        {
            $stringNotShowIn += "$n; "
        }
        $stringNotShowIn = $stringNotShowIn.Substring(0,$stringNotShowIn.LastIndexOf("; "))

        $streamWriterDesktopFile.WriteLine("NotShowIn=$stringNotShowIn")
    }

    if ($true -eq $DBusActivatable)
    {
        $streamWriterDesktopFile.WriteLine("DBusActivatable=true")
    }
    elseif($false -eq $DBusActivatable)
    {
        $streamWriterDesktopFile.WriteLine("DBusActivatable=false")
    }

    if ($null -ne $TryExec)
    {
        $streamWriterDesktopFile.WriteLine("TryExec=$TryExec")
    }

    if ($null -ne $Exec)
    {
        $streamWriterDesktopFile.WriteLine("Exec=$Exec")
    }

    if ($null -ne $Path)
    {
        $streamWriterDesktopFile.WriteLine("Path=$Path")
    }

    if ($true -eq $Terminal)
    {
        $streamWriterDesktopFile.WriteLine("Terminal=true")
    }
    elseif($false -eq $Terminal)
    {
        $streamWriterDesktopFile.WriteLine("Terminal=false")
    }

    if ($null -ne $Actions)
    {
        $stringActions = ""
        foreach ($a in $Actions)
        {
            $stringActions += "$a; "
        }
        $stringActions = $stringActions.Substring(0,$stringActions.LastIndexOf("; "))

        $streamWriterDesktopFile.WriteLine("Actions=$stringActions")
    }

    if ($null -ne $MimeType)
    {
        $stringMimeType = ""
        foreach ($m in $MimeType)
        {
            $stringMimeType += "$m; "
        }
        $stringMimeType = $stringMimeType.Substring(0,$stringMimeType.LastIndexOf("; "))

        $streamWriterDesktopFile.WriteLine("MimeType=$stringMimeType")
    }

    if ($null -ne $Categories)
    {
        $stringCategories = ""
        foreach ($c in $Categories)
        {
            $stringCategories += "$c; "
        }
        $stringCategories = $stringCategories.Substring(0,$stringCategories.LastIndexOf("; "))

        $streamWriterDesktopFile.WriteLine("Categories=$stringCategories")
    }

    if ($null -ne $Implements)
    {
        $stringImplements = ""
        foreach ($i in $Implements)
        {
            $stringImplements += "$i; "
        }
        $stringImplements = $stringImplements.Substring(0,$stringImplements.LastIndexOf("; "))

        $streamWriterDesktopFile.WriteLine("Implements=$stringImplements")
    }

    if ($null -ne $Keywords)
    {
        $stringKeywords = ""
        foreach ($k in $Keywords)
        {
            $stringKeywords += "$k; "
        }
        $stringKeywords = $stringKeywords.Substring(0,$stringKeywords.LastIndexOf("; "))

        $streamWriterDesktopFile.WriteLine("Keywords=$stringKeywords")
    }

    if ($true -eq $StartupNotify)
    {
        $streamWriterDesktopFile.WriteLine("StartupNotify=true")
    }
    elseif($false -eq $StartupNotify)
    {
        $streamWriterDesktopFile.WriteLine("StartupNotify=false")
    }

    if ($null -ne $StartupWMClass)
    {
        $streamWriterDesktopFile.WriteLine("StartupWMClass=$StartupWMClass")
    }

    if ($null -ne $URL)
    {
        $streamWriterDesktopFile.WriteLine("URL=$URL")
    }

    if ($true -eq $PrefersNonDefaultGPU)
    {
        $streamWriterDesktopFile.WriteLine("PrefersNonDefaultGPU=true")
    }
    elseif($false -eq $PrefersNonDefaultGPU)
    {
        $streamWriterDesktopFile.WriteLine("PrefersNonDefaultGPU=false")
    }

    $streamWriterDesktopFile.WriteLine()


    $streamWriterDesktopFile.Close()
    $desktopFile.Close()


    $currentLocation = Get-Location
    $desktopFileLocation = Join-Path -ChildPath $FileName -Path $currentLocation


    if ($AllUsers)
    {
        $pathDestinationFolder = "/usr/share/applications"
        $newDesktopFileLocation = Join-Path -Path $pathDestinationFolder -ChildPath $FileName
        Invoke-Expression "sudo mv ""$desktopFileLocation"" ""$newDesktopFileLocation"""
        Invoke-Expression "sudo chmod 755 ""$newDesktopFileLocation"""
    }
    else
    {
        $pathDestinationFolder = "$( $env:HOME )/.local/share/applications"
        $newDesktopFileLocation = Join-Path -Path $pathDestinationFolder -ChildPath $FileName
        Move-Item -Path $desktopFileLocation -Destination $newDesktopFileLocation
    }
}