function Get-MythicHash {
    <#
    .SYNOPSIS
    Produces a SHA-256 hash for text or a file.

    .DESCRIPTION
    Hashes either a supplied string or the bytes of a file path and returns the lowercase hexadecimal
    digest.

    .PARAMETER InputString
    The text to hash.

    .PARAMETER Path
    The path to the file whose contents should be hashed.

    .OUTPUTS
    System.String
    #>
    [CmdletBinding(DefaultParameterSetName = 'String')]
    param(
        [Parameter(Mandatory, ParameterSetName = 'String', ValueFromPipeline)]
        [AllowNull()]
        [string]$InputString,

        [Parameter(Mandatory, ParameterSetName = 'Path')]
        [ValidateNotNullOrEmpty()]
        [string]$Path
    )

    process {
        switch ($PSCmdlet.ParameterSetName) {
            'Path' {
                if (-not (Test-Path -Path $Path)) {
                    throw "Cannot hash missing path '$Path'."
                }

                $resolvedPath = (Resolve-Path -Path $Path).Path
                $bytes = [System.IO.File]::ReadAllBytes($resolvedPath)
            }
            default {
                $bytes = [System.Text.Encoding]::UTF8.GetBytes(($InputString ?? ''))
            }
        }

        $sha256 = [System.Security.Cryptography.SHA256]::Create()
        try {
            return ([System.BitConverter]::ToString($sha256.ComputeHash($bytes))).Replace('-', '').ToLowerInvariant()
        }
        finally {
            $sha256.Dispose()
        }
    }
}
