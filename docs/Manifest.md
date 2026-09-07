# Manifest

## Overview
`manifest.json` is the global ledger of archived objects. Each entry records the sigil, hash, object path, afterword path, and archival timestamp.

## Usage Examples
```powershell
Add-MythicManifestEntry -ManifestPath ./MythicArchive/manifest.json -Entry $entry
Get-MythicLineage -Sigil 'JQRL-JGCR-PCG7' -ManifestPath ./MythicArchive/manifest.json
```

## Parameter Breakdown
- `ManifestPath`: The path to `manifest.json`.
- `Entry`: The manifest record being added.
- `Sigil`: The sigil used to search the manifest lineage.

## Return Values
`Add-MythicManifestEntry` returns the inserted entry. `Get-MythicLineage` returns matching manifest records.

## Mythic Lore Notes
The manifest behaves like a temple ledger: each entry is a named offering whose lineage can be traced long after the rite completes.
