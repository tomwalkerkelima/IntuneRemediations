Start-Transcript -OutputDirectory c:\temp

# Get Version of currently installed new Teams Package
if (-not ($NewTeamsPackageVersion = (Get-AppxPackage -Name MSTeams -AllUsers).Version)) {
    write-output "New Teams not installed - Remediation not required"
    Stop-Transcript
    exit 0
}
write-output "Found new Teams Version: $NewTeamsPackageVersion"

# Get Teams Meeting Addin Version
$TMAPath = "{0}\WINDOWSAPPS\MSTEAMS_{1}_X64__8WEKYB3D8BBWE\MICROSOFTTEAMSMEETINGADDININSTALLER.MSI" -f $env:programfiles,$NewTeamsPackageVersion
if (-not ($TMAVersion = (Get-AppLockerFileInformation -Path $TMAPath | Select-Object -ExpandProperty Publisher).BinaryVersion))
{
    write-output "Teams Meeting Addin not found in $TMAPath."
    Stop-Transcript
    exit 0
}
write-output "Found Teams Meeting Addin Version: $TMAVersion"

# Install parameters
$TargetDir = "{0}\Microsoft\TeamsMeetingAddin\{1}\" -f ${env:ProgramFiles(x86)},$TMAVersion
$params = '/i "{0}" TARGETDIR="{1}" /qn ALLUSERS=1' -f $TMAPath, $TargetDir

$FileCheck = "{0}AddinInstaller.dll" -f $TargetDir
write-output $FileCheck


if (Test-Path $FileCheck) {
    write-output "Correct Teams AddIn detected, exiting"
    Stop-Transcript
    exit 0
}
else {
    write-output "Correct Teams AddIn does not exist - remediation required"
    Stop-Transcript
    exit 1
}

Stop-Transcript