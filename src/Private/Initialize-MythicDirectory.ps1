function Initialize-MythicDirectory {
    <#
    .SYNOPSIS
    Ensures a directory exists.

    .DESCRIPTION
    Creates the requested path if needed and returns the resolved directory path.

    .PARAMETER Path
    The directory path to create or confirm.

    .OUTPUTS
    System.String
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Path
    )

    process {
        try {
            $item = New-Item -ItemType Directory -Path $Path -Force -ErrorAction Stop
            return $item.FullName
        }
        catch {
            throw "Unable to ensure mythic directory '$Path'. $($_.Exception.Message)"
        }
    }
}
