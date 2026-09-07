function Add-MythicManifestEntry {
    <#
    .SYNOPSIS
    Adds an entry to the mythic manifest.

    .DESCRIPTION
    Creates manifest.json if it is missing, appends the supplied entry, and writes the updated
    manifest back to disk.

    .PARAMETER ManifestPath
    The path to the manifest.json file.

    .PARAMETER Entry
    The entry to append to the manifest.

    .OUTPUTS
    System.Object

    .EXAMPLE
    PS> Add-MythicManifestEntry -ManifestPath ./MythicArchive/manifest.json -Entry $entry

    Stores a new archive entry in the manifest.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$ManifestPath,

        [Parameter(Mandatory)]
        [ValidateNotNull()]
        [object]$Entry
    )

    process {
        $manifestDirectory = Split-Path -Path $ManifestPath -Parent
        if ($manifestDirectory) {
            Initialize-MythicDirectory -Path $manifestDirectory | Out-Null
        }

        $utf8NoBom = [System.Text.UTF8Encoding]::new($false)

        $fileStream = [System.IO.File]::Open($ManifestPath, [System.IO.FileMode]::OpenOrCreate, [System.IO.FileAccess]::ReadWrite, [System.IO.FileShare]::None)
        try {
            try {
                $reader = [System.IO.StreamReader]::new($fileStream, $utf8NoBom, $true, 1024, $true)
                try {
                    $manifestContent = $reader.ReadToEnd()
                }
                finally {
                    $reader.Dispose()
                }

                if ($manifestContent) {
                    $manifest = $manifestContent | ConvertFrom-Json -AsHashtable -Depth 20
                }
                else {
                    $manifest = [ordered]@{
                        version = '1.0.0'
                        createdAt = (Get-Date).ToUniversalTime().ToString('o')
                        entries = @()
                    }
                }

                $manifestKeys = @($manifest.Keys)
                $existingEntries = @()
                if (($manifestKeys -contains 'entries') -and $null -ne $manifest.entries) {
                    $existingEntries = @($manifest.entries)
                }

                $updatedManifest = [ordered]@{
                    version = if (($manifestKeys -contains 'version') -and $manifest.version) { $manifest.version } else { '1.0.0' }
                    createdAt = if (($manifestKeys -contains 'createdAt') -and $manifest.createdAt) { $manifest.createdAt } else { (Get-Date).ToUniversalTime().ToString('o') }
                    entries = @($existingEntries + $Entry)
                    lastUpdatedAt = (Get-Date).ToUniversalTime().ToString('o')
                }

                $json = $updatedManifest | ConvertTo-Json -Depth 20
                $fileStream.SetLength(0)
                $fileStream.Position = 0
                $writer = [System.IO.StreamWriter]::new($fileStream, $utf8NoBom, 1024, $true)
                try {
                    $writer.Write($json)
                    $writer.Flush()
                }
                finally {
                    $writer.Dispose()
                }
            }
            catch {
                throw "Unable to process mythic manifest '$ManifestPath'. $($_.Exception.Message)"
            }
        }
        finally {
            $fileStream.Dispose()
        }

        return $Entry
    }
}
