BeforeAll {
    Import-Module (Join-Path (Join-Path $PSScriptRoot '..') 'src/MythicArchivalEngine.psd1') -Force
}

Describe 'New-MythicSigil' {
    It 'is deterministic for the same seed' {
        $first = New-MythicSigil -Seed 'moonlit-archive'
        $second = New-MythicSigil -Seed 'moonlit-archive'

        $first | Should -Be $second
    }

    It 'produces printable ASCII only' {
        $sigil = New-MythicSigil -Seed 'astral-seed'

        $sigil | Should -Match '^[ -~]+$'
    }
}
