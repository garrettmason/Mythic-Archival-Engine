# Save-MythicObject

## Overview
`Save-MythicObject` serializes any supplied object into Clixml, derives a deterministic sigil, writes a lore-flavored afterword, and records the archive in `manifest.json`.

## Usage Examples
```powershell
Import-Module ./src/MythicArchivalEngine.psd1
Save-MythicObject -InputObject (Get-Date)
```

```powershell
$artifact = [pscustomobject]@{ Name = 'Aegis'; Rank = 'Prime' }
$sigil = $artifact | Save-MythicObject -ArchiveRoot ./MythicArchive
```

## Parameter Breakdown
- `InputObject`: The object to archive.
- `ArchiveRoot`: The directory that receives `objects/`, `afterwords/`, and `manifest.json`.

## Return Values
Returns the generated sigil as a `System.String`.

## Mythic Lore Notes
The function is written like a rite because the archive is treated as a solemn vault. The sigil is deterministic so repeated offerings preserve the same lineage.
