# Architecture

## Overview
Mythic Archival Engine uses a small, layered design:
- Public commands orchestrate archiving and lineage lookup.
- Private helpers handle hashing, directory creation, and afterword writing.
- The manifest is the authoritative record of every archived object.

## Usage Examples
```powershell
Import-Module ./src/MythicArchivalEngine.psd1
$sigil = Save-MythicObject -InputObject $object
Get-MythicLineage -Sigil $sigil
```

## Parameter Breakdown
- Most commands accept an `ArchiveRoot` or `ManifestPath` so operators can redirect archives to isolated vaults.
- `Save-MythicObject` and `Invoke-MythicRitual` accept pipeline input for ergonomic use.

## Return Values
Public commands return either the sigil or matching lineage entries, depending on the operation.

## Mythic Lore Notes
The architecture mirrors a rite: a sealed object, a written afterword, and a ledger entry. Each layer keeps the archive understandable without sacrificing the mythic tone.
