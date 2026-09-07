Set-StrictMode -Version Latest

$privatePath = Join-Path -Path $PSScriptRoot -ChildPath 'Private'
$publicPath = Join-Path -Path $PSScriptRoot -ChildPath 'Public'

. (Join-Path -Path $privatePath -ChildPath 'Initialize-MythicDirectory.ps1')

Get-ChildItem -Path $privatePath -Filter '*.ps1' -File | Sort-Object Name | Where-Object {
    $_.BaseName -notin @('Initialize-MythicDirectory', 'Ensure-MythicDirectory')
} | ForEach-Object {
    . $_.FullName
}

Get-ChildItem -Path $publicPath -Filter '*.ps1' -File | Sort-Object Name | ForEach-Object {
    . $_.FullName
}

Export-ModuleMember -Function @(
    'Save-MythicObject',
    'Invoke-MythicRitual',
    'New-MythicSigil',
    'Add-MythicManifestEntry',
    'Get-MythicLineage'
)
