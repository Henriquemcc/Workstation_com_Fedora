class MenuOption
{
    [System.String]$Name
    [System.Management.Automation.ScriptBlock]$Script

    MenuOption(
            [System.String]$Name,
            [System.Management.Automation.ScriptBlock]$Script
    )
    {
        $this.Name = $Name
        $this.Script = $Script
    }
}