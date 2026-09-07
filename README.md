# Mythic Archival Engine

![CI](https://github.com/garrettmason/Mythic-Archival-Engine/actions/workflows/ci.yml/badge.svg)
![Version](https://img.shields.io/badge/version-1.0.0-indigo)

The archive does not merely store objects; it consecrates them.
Mythic Archival Engine is a PowerShell module for preserving objects with deterministic sigils, manifest lineage, and lore-rich afterwords.

## Features
- Deterministic SHA-256 based sigils
- Clixml object archival
- Manifest creation and lineage lookup
- Ceremonial wrapper command for ritualized output
- Pester test coverage and CI validation

## Installation
```powershell
Import-Module ./src/MythicArchivalEngine.psd1
```

## Quick Start
```powershell
$artifact = [pscustomobject]@{
    Name = 'Aegis'
    Rank = 'Prime'
}

$sigil = Save-MythicObject -InputObject $artifact
$sigil
```

## Examples
```powershell
Invoke-MythicRitual -InputObject @{ Name = 'Oracle Stone' }
Get-MythicLineage -Sigil 'demo-sigil' -ManifestPath ./MythicArchive/manifest.json
New-MythicSigil -Seed 'moonlit-archive'
```

## Sigil Gallery
```text
JQRL-JGCR-PCG7
MJGM-3RN3-9B5E
```

## Project Structure
- `src/` contains the module and manifest.
- `tests/` contains Pester coverage.
- `examples/` demonstrates the public commands.
- `docs/` documents the ritual and its records.

## Lore
In the old vaults, every object was named twice: once for the living, and once for the ledger.
Mythic Archival Engine keeps that tradition alive by turning each archive into a readable myth.
