function Save-MythicObject {
    <#
    .SYNOPSIS
    Archives an object into the mythic ledger.

    .DESCRIPTION
    Serializes an input object to Clixml, derives a deterministic sigil from the archived payload,
    writes a companion afterword, and appends a manifest entry describing the archive.

    .PARAMETER InputObject
    The object to archive.

    .PARAMETER ArchiveRoot
    The root directory that will contain the archive, manifest, objects, and afterwords.

    .OUTPUTS
    System.String

    .EXAMPLE
    PS> Save-MythicObject -InputObject (Get-Date)

    Archives the supplied object and returns its sigil.

    .NOTES
    The ritual favors deterministic preservation so the same object yields the same sigil.
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
        $resolvedArchiveRoot = Initialize-MythicDirectory -Path $ArchiveRoot
        $objectDirectory = Initialize-MythicDirectory -Path (Join-Path -Path $resolvedArchiveRoot -ChildPath 'objects')
        Initialize-MythicDirectory -Path (Join-Path -Path $resolvedArchiveRoot -ChildPath 'afterwords') | Out-Null
        $manifestPath = Join-Path -Path $resolvedArchiveRoot -ChildPath 'manifest.json'

        $tempPath = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), [System.IO.Path]::GetRandomFileName() + '.clixml')

        try {
            Export-Clixml -InputObject $InputObject -Path $tempPath -Depth 10 -Force -ErrorAction Stop
            $hash = Get-MythicHash -Path $tempPath
            $sigil = New-MythicSigil -Seed $hash
            $objectPath = Join-Path -Path $objectDirectory -ChildPath "$sigil.clixml"
            Move-Item -Path $tempPath -Destination $objectPath -Force -ErrorAction Stop

            $typeName = $InputObject.GetType().FullName
            $afterwordPath = Write-MythicAfterword -ArchiveRoot $resolvedArchiveRoot -Sigil $sigil -Hash $hash -TypeName $typeName -ObjectPath $objectPath

            $entry = [pscustomobject]@{
                sigil = $sigil
                hash = $hash
                typeName = $typeName
                objectPath = $objectPath
                afterwordPath = $afterwordPath
                archivedAt = (Get-Date).ToUniversalTime().ToString('o')
            }

            Add-MythicManifestEntry -ManifestPath $manifestPath -Entry $entry | Out-Null
            return $sigil
        }
        catch {
            if (Test-Path -Path $tempPath) {
                Remove-Item -Path $tempPath -Force -ErrorAction SilentlyContinue
            }
            if ($objectPath -and (Test-Path -Path $objectPath)) {
                Remove-Item -Path $objectPath -Force -ErrorAction SilentlyContinue
            }
            if ($afterwordPath -and (Test-Path -Path $afterwordPath)) {
                Remove-Item -Path $afterwordPath -Force -ErrorAction SilentlyContinue
            }

            throw
        }
    }
}
