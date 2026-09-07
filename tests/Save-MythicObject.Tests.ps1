BeforeAll {
    Import-Module (Join-Path (Join-Path $PSScriptRoot '..') 'src/MythicArchivalEngine.psd1') -Force
}

Describe 'Save-MythicObject' {
    BeforeEach {
        $script:ArchiveRoot = Join-Path ([System.IO.Path]::GetTempPath()) ([System.IO.Path]::GetRandomFileName())
        New-Item -ItemType Directory -Path $script:ArchiveRoot | Out-Null
    }

    AfterEach {
        if (Test-Path $script:ArchiveRoot) {
            Remove-Item -Path $script:ArchiveRoot -Recurse -Force
        }
    }

    It 'archives an object and records it in the manifest' {
        $object = [pscustomobject]@{
            Name = 'Aegis'
            Value = 42
            Nested = [pscustomobject]@{ Rank = 'Prime'; Active = $true }
        }

        $sigil = Save-MythicObject -InputObject $object -ArchiveRoot $script:ArchiveRoot
        $objectPath = Join-Path $script:ArchiveRoot "objects/$sigil.clixml"
        $afterwordPath = Join-Path $script:ArchiveRoot "afterwords/$sigil.txt"
        $manifestPath = Join-Path $script:ArchiveRoot 'manifest.json'

        Test-Path $objectPath | Should -BeTrue
        Test-Path $afterwordPath | Should -BeTrue
        Test-Path $manifestPath | Should -BeTrue

        $restored = Import-Clixml -Path $objectPath
        $restored.Name | Should -Be 'Aegis'
        $restored.Value | Should -Be 42
        $restored.Nested.Rank | Should -Be 'Prime'
        $restored.Nested.Active | Should -BeTrue

        $manifest = Get-Content -Path $manifestPath -Raw | ConvertFrom-Json
        $manifest.entries.Count | Should -Be 1
        $manifest.entries[0].sigil | Should -Be $sigil
    }
}
