class Option : System.IComparable {
    [System.String]$Name
    [System.Management.Automation.ScriptBlock]$Script

    Option(
        [System.String]$Name,
        [System.Management.Automation.ScriptBlock]$Script
    ) {
        $this.Name = $Name
        $this.Script = $Script
    }

    [System.Int32] CompareTo([System.Object]$other) {
        $difference = 0

        if ($other -isnot [Option]) {
            $difference = [System.Int32]::MaxValue
        }
        else {
            $difference = $this.CompareTo([Option]($other))
        }

        return $difference
    }

    [System.Int32] CompareTo([Option]$other) {
        return $this.Name.CompareTo($other.Name)
    }
}