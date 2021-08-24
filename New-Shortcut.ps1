enum DesktopEntryType
{
    Application = 1
    Link = 2
    Directory = 3
}

function New-Shortcut
{
    param(
        [Parameter(Mandatory = $true)][DesktopEntryType]$Type,
        [Parameter(Mandatory = $false)][System.String]$Version = $null,
        [Parameter(Mandatory = $true)][System.String]$Name,
        [Parameter(Mandatory = $false)][System.String]$GenericName = $null,
        [Parameter(Mandatory = $false)][System.Boolean]$NoDisplay = $null,
        [Parameter(Mandatory = $false)][System.String]$Comment = $null,
        [Parameter(Mandatory = $false)][System.String]$Icon = $null,
        [Parameter(Mandatory = $false)][System.Boolean]$Hidden = $null,
        [Parameter(Mandatory = $false)][System.Collections.ICollection]$OnlyShowIn = $null,
        [Parameter(Mandatory = $false)][System.Collections.ICollection]$NotShowIn = $null,
        [Parameter(Mandatory = $false)][System.Boolean]$DBusActivatable = $null,
        [Parameter(Mandatory = $false)][System.String]$TryExec = $null,
        [Parameter(Mandatory = $false)][System.String]$Exec = $null,
        [Parameter(Mandatory = $false)][System.String]$Path = $null,
        [Parameter(Mandatory = $false)][System.Boolean]$Terminal = $null,
        [Parameter(Mandatory = $false)][System.Collections.ICollection]$Actions = $null,
        [Parameter(Mandatory = $false)][System.Collections.ICollection]$MimeType = $null,
        [Parameter(Mandatory = $false)][System.Collections.ICollection]$Categories = $null,
        [Parameter(Mandatory = $false)][System.Collections.ICollection]$Implements = $null,
        [Parameter(Mandatory = $false)][System.Collections.ICollection]$Keywords = $null,
        [Parameter(Mandatory = $false)][System.Boolean]$StartupNotify = $null,
        [Parameter(Mandatory = $false)][System.String]$StartupWMClass = $null,
        [Parameter(Mandatory = $false)][System.String]$URL = $null,
        [Parameter(Mandatory = $false)][System.Boolean]$PrefersNonDefaultGPU = $null,
        [Parameter(Mandatory = $false)][Switch]$AllUsers = $false,
        [Parameter(Mandatory = $true)][System.String]$FileName
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
        Invoke-Command "sudo mv $desktopFileLocation $newDesktopFileLocation"
        Invoke-Command "sudo chmod 644 ""$newDesktopFileLocation"""
    }
    else
    {
        $pathDestinationFolder = "$( $env:HOME )/.local/share/applications"
        $newDesktopFileLocation = Join-Path -Path $pathDestinationFolder -ChildPath $FileName
        Move-Item -Path $desktopFileLocation -Destination $newDesktopFileLocation
    }
}