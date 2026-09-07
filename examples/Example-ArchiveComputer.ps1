Import-Module (Join-Path (Join-Path $PSScriptRoot '..') 'src/MythicArchivalEngine.psd1') -Force

$computerArchive = [pscustomobject]@{
    Name = 'ARC-01'
    OS = 'Windows 11'
    Role = 'Keeper'
}

Save-MythicObject -InputObject $computerArchive -ArchiveRoot (Join-Path $PSScriptRoot '..' 'MythicArchive')
