BeforeAll {
    Import-Module (Join-Path (Join-Path $PSScriptRoot '..') 'src/MythicArchivalEngine.psd1') -Force
}

Describe 'Invoke-MythicRitual' {
    BeforeEach {
        $script:ArchiveRoot = Join-Path ([System.IO.Path]::GetTempPath()) ([System.IO.Path]::GetRandomFileName())
        New-Item -ItemType Directory -Path $script:ArchiveRoot | Out-Null
    }

    AfterEach {
        if (Test-Path $script:ArchiveRoot) {
            Remove-Item -Path $script:ArchiveRoot -Recurse -Force
        }
    }

    It 'wraps Save-MythicObject and returns the sigil' {
        Mock -ModuleName MythicArchivalEngine Save-MythicObject { 'mocked-sigil' }

        $result = Invoke-MythicRitual -InputObject 'ritual-object' -ArchiveRoot $script:ArchiveRoot -Verbose 4>&1

        @($result | Where-Object { $_ -is [string] }) | Should -Be @('mocked-sigil')
        Should -Invoke -ModuleName MythicArchivalEngine Save-MythicObject -Times 1 -ParameterFilter { $ArchiveRoot -eq $script:ArchiveRoot }
    }
}
