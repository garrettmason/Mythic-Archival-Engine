function Get-MythicLineage {
    <#
    .SYNOPSIS
    Retrieves manifest entries for a sigil.

    .DESCRIPTION
    Reads manifest.json and returns all entries whose sigil matches the supplied value.

    .PARAMETER Sigil
    The sigil to search for.

    .PARAMETER ManifestPath
    The path to the manifest.json file.

    .OUTPUTS
    System.Object[]

    .EXAMPLE
    PS> Get-MythicLineage -Sigil 'JQRL-JGCR-PCG7'

    Returns matching manifest entries.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Sigil,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$ManifestPath = (Join-Path -Path (Get-Location).Path -ChildPath 'MythicArchive/manifest.json')
    )

    process {
        if (-not (Test-Path -Path $ManifestPath)) {
            return @()
        }

        try {
            $manifest = Get-Content -Path $ManifestPath -Raw -ErrorAction Stop | ConvertFrom-Json -Depth 20
        }
        catch {
            throw "Unable to read mythic manifest '$ManifestPath'. $($_.Exception.Message)"
        }

        @($manifest.entries) | Where-Object {
            $_.sigil -eq $Sigil
        }
    }
}
