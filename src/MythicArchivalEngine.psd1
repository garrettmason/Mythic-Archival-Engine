@{
    RootModule        = 'MythicArchivalEngine.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = '5d9f0d7b-8e4f-4e1d-8b67-5d0c1f3a6d10'
    Author            = 'garrettmason'
    CompanyName       = 'Unknown'
    Copyright         = '(c) 2026 garrettmason. All rights reserved.'
    Description       = 'Mythic Archival Engine archives PowerShell objects into a deterministic ritual ledger.'
    PowerShellVersion = '7.0'
    CompatiblePSEditions = @('Core')
    FunctionsToExport = @(
        'Save-MythicObject',
        'Invoke-MythicRitual',
        'New-MythicSigil',
        'Add-MythicManifestEntry',
        'Get-MythicLineage'
    )
    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()
    PrivateData       = @{
        PSData = @{
            Tags = @('PowerShell', 'Archive', 'Mythic', 'Clixml')
            ProjectUri = 'https://github.com/garrettmason/Mythic-Archival-Engine'
            LicenseUri = 'https://opensource.org/licenses/MIT'
            ReleaseNotes = 'Initial release of the Mythic Archival Engine.'
        }
    }
}
