Import-Module (Join-Path (Join-Path $PSScriptRoot '..') 'src/MythicArchivalEngine.psd1') -Force

$sigil = Invoke-MythicRitual -InputObject ([pscustomobject]@{
    Name = 'Oracle Stone'
    Tier = 'Relic'
})

$sigil
