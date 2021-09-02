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

    <#
    .SYNOPSIS
        Generates a new .desktop shortcut.
    .DESCRIPTION
        This function generates a new .desktop shortcut recieving all .desktop atributes.
        More information: https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html#recognized-keys
    .PARAMETER Type
        This specification defines 3 types of desktop entries: Application (type 1), Link (type 2) and Directory (type 3). To allow the addition of new types in the future, implementations should ignore desktop entries with an unknown type.
    .PARAMETER Version
        Version of the Desktop Entry Specification that the desktop entry conforms with. Entries that confirm with this version of the specification should use 1.5. Note that the version field is not required to be present.
    .PARAMETER Name
        Specific name of the application, for example "Mozilla".
    .PARAMETER GenericName
        Generic name of the application, for example "Web Browser".	
    .PARAMETER NoDisplay
        NoDisplay means "this application exists, but don't display it in the menus". This can be useful to e.g. associate this application with MIME types, so that it gets launched from a file manager (or other apps), without having a menu entry for it (there are tons of good reasons for this, including e.g. the netscape -remote, or kfmclient openURL kind of stuff).
    .PARAMETER Comment
        Tooltip for the entry, for example "View sites on the Internet". The value should not be redundant with the values of Name and GenericName.
    .PARAMETER Icon
        Icon to display in file manager, menus, etc. If the name is an absolute path, the given file will be used. If the name is not an absolute path, the algorithm described in the [Icon Theme Specification](http://freedesktop.org/wiki/Standards/icon-theme-spec) will be used to locate the icon.
    .PARAMETER Hidden
        Hidden should have been called Deleted. It means the user deleted (at his level) something that was present (at an upper level, e.g. in the system dirs). It's strictly equivalent to the .desktop file not existing at all, as far as that user is concerned. This can also be used to "uninstall" existing files (e.g. due to a renaming) - by letting make install install a file with Hidden=true in it.
    .PARAMETER OnlyShowIn
        A list of strings identifying the desktop environments that should display a given desktop entry.
        By default, a desktop file should be shown, unless an OnlyShowIn key is present, in which case, the default is for the file not to be shown.
    .PARAMETER NotShowIn
        A list of strings identifying the desktop environments that should A list of strings identifying the desktop environments that should.
    .PARAMETER DBusActivatable
        A boolean value specifying if D-Bus activation is supported for this application. If this key is missing, the default value is false.
    .PARAMETER TryExec
        Path to an executable file on disk used to determine if the program is actually installed. If the path is not an absolute path, the file is looked up in the $PATH environment variable. If the file is not present or if it is not executable, the entry may be ignored (not be used in menus, for example).
    .PARAMETER Exec
        Program to execute, possibly with arguments. See the [Exec](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html#exec-variables) key for details on how this key works. The Exec key is required if DBusActivatable is not set to true. Even if DBusActivatable is true, Exec should be specified for compatibility with implementations that do not understand DBusActivatable.
    .PARAMETER Path
        If entry is of type Application, the working directory to run the program in.
    .PARAMETER Terminal
        Whether the program runs in a terminal window.
    .PARAMETER Actions
        Identifiers for application actions. This can be used to tell the application to make a specific action, different from the default behavior. The [Application actions](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html#extra-actions) section describes how actions work.
    .PARAMETER MimeType
        The MIME type(s) supported by this application.
    .PARAMETER Categories
        Categories in which the entry should be shown in a menu (for possible values see the [Desktop Menu Specification](http://www.freedesktop.org/Standards/menu-spec)).
    .PARAMETER Implements
        A list of interfaces that this application implements. By default, a desktop file implements no interfaces. See [Interfaces](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html#interfaces) for more information on how this works.
    .PARAMETER Keywords
        A list of strings which may be used in addition to other metadata to describe this entry. This can be useful e.g. to facilitate searching through entries. The values are not meant for display, and should not be redundant with the values of Name or GenericName.
    .PARAMETER StartupNotify
        If true, it is KNOWN that the application will send a "remove" message when started with the DESKTOP_STARTUP_ID environment variable set. If false, it is KNOWN that the application does not work with startup notification at all (does not shown any window, breaks even when using StartupWMClass, etc.). If absent, a reasonable handling is up to implementations (assuming false, using StartupWMClass, etc.). (See the [Startup Notification Protocol Specification](http://www.freedesktop.org/Standards/startup-notification-spec) for more details).
    .PARAMETER StartupWMClass
        If specified, it is known that the application will map at least one window with the given string as its WM class or WM name hint (see the [Startup Notification Protocol Specification](http://www.freedesktop.org/Standards/startup-notification-spec) for more details).
    .PARAMETER URL
        If entry is Link type, the URL to access.	
    .PARAMETER PrefersNonDefaultGPU
        If true, the application prefers to be run on a more powerful discrete GPU if available, which we describe as “a GPU other than the default one” in this spec to avoid the need to define what a discrete GPU is and in which cases it might be considered more powerful than the default GPU. This key is only a hint and support might not be present depending on the implementation.
    .PARAMETER AllUsers
        Wheter the .desktop shortcut should be available to all users (root required).
    .PARAMETER FileName
        Name of the .desktop file.
    #>

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

    if (-not($FileName.ToLower().EndsWith(".desktop")))
    {
        $FileName += ".desktop"
    }

    $desktopFile = [System.IO.File]::OpenWrite($FileName)
    $streamWriterDesktopFile = [System.IO.StreamWriter]::new($desktopFile)

    $streamWriterDesktopFile.WriteLine("[Desktop Entry]")

    if ($Type -eq [DesktopEntryType]::Application)
    {
        $streamWriterDesktopFile.WriteLine("Type=Application")
    }
    elseif ($Type -eq [DesktopEntryType]::Directory)
    {
        $streamWriterDesktopFile.WriteLine("Type=Directory")
    }
    elseif ($Type -eq [DesktopEntryType]::Link)
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
    elseif ($false -eq $NoDisplay)
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
    elseif ($false -eq $DBusActivatable)
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
    elseif ($false -eq $Terminal)
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
    elseif ($false -eq $StartupNotify)
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
    elseif ($false -eq $PrefersNonDefaultGPU)
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