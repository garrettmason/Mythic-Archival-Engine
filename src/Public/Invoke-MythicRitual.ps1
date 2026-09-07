function Invoke-MythicRitual {
    <#
    .SYNOPSIS
    Performs the mythic archival ritual.

    .DESCRIPTION
    Wraps Save-MythicObject with ceremonial progress output so the archival flow feels like a rite
    while still returning the deterministic sigil.

    .PARAMETER InputObject
    The object to archive.

    .PARAMETER ArchiveRoot
    The root directory for the archival rite.

    .OUTPUTS
    System.String

    .EXAMPLE
    PS> Invoke-MythicRitual -InputObject @{ Name = 'Aegis' }

    Archives the object and returns the resulting sigil.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNull()]
        [object]$InputObject,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$ArchiveRoot = (Join-Path -Path (Get-Location).Path -ChildPath 'MythicArchive')
    )

    process {
        Write-Verbose '🜁 The archive brazier is lit.'
        Write-Verbose '🜂 The object is carried toward the manifest.'
        $sigil = Save-MythicObject -InputObject $InputObject -ArchiveRoot $ArchiveRoot
        Write-Verbose "🜃 The rite is sealed with sigil: $sigil"
        return $sigil
    }
}
