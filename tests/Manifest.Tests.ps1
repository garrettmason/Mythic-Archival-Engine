BeforeAll {
    Import-Module (Join-Path (Join-Path $PSScriptRoot '..') 'src/MythicArchivalEngine.psd1') -Force
}

Describe 'Mythic manifest' {
    BeforeEach {
        $script:ArchiveRoot = Join-Path ([System.IO.Path]::GetTempPath()) ([System.IO.Path]::GetRandomFileName())
        New-Item -ItemType Directory -Path $script:ArchiveRoot | Out-Null
        $script:ManifestPath = Join-Path $script:ArchiveRoot 'manifest.json'
    }

    AfterEach {
        if (Test-Path $script:ArchiveRoot) {
            Remove-Item -Path $script:ArchiveRoot -Recurse -Force
        }
    }

    It 'creates a manifest when it is missing' {
        $entry = [pscustomobject]@{
            sigil = 'alpha-beta-gamma'
            hash = '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef'
            typeName = 'System.String'
            objectPath = (Join-Path $script:ArchiveRoot 'objects/alpha.clixml')
            afterwordPath = (Join-Path $script:ArchiveRoot 'afterwords/alpha.txt')
            archivedAt = '2026-09-07T00:00:00.0000000Z'
        }

        Add-MythicManifestEntry -ManifestPath $script:ManifestPath -Entry $entry | Out-Null

        Test-Path $script:ManifestPath | Should -BeTrue
        $manifest = Get-Content -Path $script:ManifestPath -Raw | ConvertFrom-Json
        $manifest.entries.Count | Should -Be 1
        $manifest.entries[0].sigil | Should -Be 'alpha-beta-gamma'
    }

    It 'returns all matching lineage entries' {
        $entryOne = [pscustomobject]@{ sigil = 'lineage-sigil'; hash = 'a'; typeName = 'one'; objectPath = 'o1'; afterwordPath = 'a1'; archivedAt = 't1' }
        $entryTwo = [pscustomobject]@{ sigil = 'lineage-sigil'; hash = 'b'; typeName = 'two'; objectPath = 'o2'; afterwordPath = 'a2'; archivedAt = 't2' }
        $entryThree = [pscustomobject]@{ sigil = 'other-sigil'; hash = 'c'; typeName = 'three'; objectPath = 'o3'; afterwordPath = 'a3'; archivedAt = 't3' }

        Add-MythicManifestEntry -ManifestPath $script:ManifestPath -Entry $entryOne | Out-Null
        Add-MythicManifestEntry -ManifestPath $script:ManifestPath -Entry $entryTwo | Out-Null
        Add-MythicManifestEntry -ManifestPath $script:ManifestPath -Entry $entryThree | Out-Null

        $lineage = Get-MythicLineage -Sigil 'lineage-sigil' -ManifestPath $script:ManifestPath
        $lineage.Count | Should -Be 2
        @($lineage | Select-Object -ExpandProperty sigil) | Should -Be @('lineage-sigil', 'lineage-sigil')
    }
}
