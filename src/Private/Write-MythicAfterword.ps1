function Write-MythicAfterword {
    <#
    .SYNOPSIS
    Writes a human-readable afterword for an archive entry.

    .DESCRIPTION
    Creates a lore-flavored text file that records the sigil, hash, object type, and object path for
    the archived object.

    .PARAMETER ArchiveRoot
    The archive root directory.

    .PARAMETER Sigil
    The generated sigil.

    .PARAMETER Hash
    The SHA-256 hash used to derive the sigil.

    .PARAMETER TypeName
    The archived object type name.

    .PARAMETER ObjectPath
    The path to the archived Clixml file.

    .OUTPUTS
    System.String
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$ArchiveRoot,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Sigil,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Hash,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$TypeName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$ObjectPath
    )

    process {
        $afterwordDirectory = Initialize-MythicDirectory -Path (Join-Path -Path $ArchiveRoot -ChildPath 'afterwords')
        $afterwordPath = Join-Path -Path $afterwordDirectory -ChildPath "$Sigil.txt"

        $content = @"
Mythic Afterword
Sigil: $Sigil
Hash: $Hash
Type: $TypeName
Object Path: $ObjectPath
Archived At: $((Get-Date).ToUniversalTime().ToString('o'))

The archive has been sealed in the keeper's ledger.
May the sigil remain luminous for future rites.
"@

        Set-Content -Path $afterwordPath -Value $content -Encoding utf8
        return $afterwordPath
    }
}
