function New-MythicSigil {
    <#
    .SYNOPSIS
    Creates a deterministic ASCII sigil.

    .DESCRIPTION
    Uses a SHA-256 seed to select ceremonial ASCII glyphs in a repeatable pattern. The same seed
    always yields the same sigil.

    .PARAMETER Seed
    The seed value used to derive the sigil.

    .OUTPUTS
    System.String

    .EXAMPLE
    PS> New-MythicSigil -Seed 'moonlit-archive'

    Produces a stable sigil for the supplied seed.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]$Seed
    )

    process {
        $sourceHash = if ($Seed -match '^[0-9a-fA-F]{64}$') {
            $Seed.ToLowerInvariant()
        }
        else {
            Get-MythicHash -InputString $Seed
        }

        # The glyph set omits visually ambiguous characters (I, O, S, 0, 1) to keep sigils readable in logs and docs.
        $glyphs = @('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', '2', '3', '4', '5', '6', '7', '8', '9')
        $pairs = for ($index = 0; $index -lt 12; $index++) {
            $pair = $sourceHash.Substring($index * 2, 2)
            $glyphs[[Convert]::ToInt32($pair, 16) % $glyphs.Count]
        }

        return @(
            ($pairs[0..3] -join ''),
            ($pairs[4..7] -join ''),
            ($pairs[8..11] -join '')
        ) -join '-'
    }
}
