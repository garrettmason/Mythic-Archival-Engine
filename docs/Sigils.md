# Sigils

## Overview
Sigils are deterministic ASCII glyphs derived from a SHA-256 seed. They make each archive entry easy to reference while remaining human-readable.

## Usage Examples
```powershell
New-MythicSigil -Seed 'moonlit-archive'
New-MythicSigil -Seed (Get-MythicHash -InputString 'moonlit-archive')
```

## Parameter Breakdown
- `Seed`: The value used to derive the sigil.

## Return Values
Returns a `System.String` containing the sigil.

## Mythic Lore Notes
The glyphs are intentionally ceremonial but remain plain ASCII so they travel cleanly through logs, manifests, and documentation.
