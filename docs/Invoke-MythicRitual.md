# Invoke-MythicRitual

## Overview
`Invoke-MythicRitual` is a ceremonial wrapper around `Save-MythicObject`. It adds progress narration while preserving the same archival outcome.

## Usage Examples
```powershell
Import-Module ./src/MythicArchivalEngine.psd1
Invoke-MythicRitual -InputObject @{ Name = 'Oracle Stone' }
```

## Parameter Breakdown
- `InputObject`: The object to archive during the rite.
- `ArchiveRoot`: The archive directory used by the ritual.

## Return Values
Returns the sigil created by the underlying archive operation.

## Mythic Lore Notes
This command is the public invocation of the same preservation logic, but it speaks with a ritual voice so operators know the archive is being sealed intentionally.
