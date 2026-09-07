Import-Module (Join-Path (Join-Path $PSScriptRoot '..') 'src/MythicArchivalEngine.psd1') -Force

$userArchive = [pscustomobject]@{
    SamAccountName = 'jsmith'
    DisplayName = 'J. Smith'
    Department = 'Archive Wardens'
}

Save-MythicObject -InputObject $userArchive -ArchiveRoot (Join-Path $PSScriptRoot '..' 'MythicArchive')
