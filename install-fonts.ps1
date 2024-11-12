# https://www.jordanmalcolm.com/deploying-windows-10-fonts-at-scale/

[CmdletBinding()]
Param(
	[Parameter(Mandatory = $true, HelpMessage = "Font path.")][string]$FontFolder,
	[Parameter()][ValidateSet('Break', 'Continue', 'Ignore', 'Inquire', 'SilentlyContinue', 'Stop', 'Suspend')]$ErrorActionPreference = "SilentlyContinue",
	[Parameter()][ValidateRange(1,3)][Int]$LogLevel = 2,
	[Parameter()][Switch]$WhatIf
)

$FontItem = Get-Item -Path $FontFolder
$FontList = Get-ChildItem -Path "$FontItem\*" -Include ('*.fon','*.otf','*.ttc','*.ttf')

foreach ($Font in $FontList) {
        Write-Host 'Installing font -' $Font.BaseName
        Copy-Item $Font "C:\Windows\Fonts"
        New-ItemProperty -Name $Font.BaseName -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -PropertyType string -Value $Font.name         
}
