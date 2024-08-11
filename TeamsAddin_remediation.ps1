# Get Version of currently installed new Teams Package
if (-not ($NewTeamsPackageVersion = (Get-AppxPackage -Name MSTeams).Version)) {
    write-output "New Teams Package not found. Please install new Teams from https://aka.ms/GetTeams ."
    exit 1
}
write-output "Found new Teams Version: $NewTeamsPackageVersion"

# Get Teams Meeting Addin Version
$TMAPath = "{0}\WINDOWSAPPS\MSTEAMS_{1}_X64__8WEKYB3D8BBWE\MICROSOFTTEAMSMEETINGADDININSTALLER.MSI" -f $env:programfiles,$NewTeamsPackageVersion
if (-not ($TMAVersion = (Get-AppLockerFileInformation -Path $TMAPath | Select-Object -ExpandProperty Publisher).BinaryVersion))
{
    write-output "Teams Meeting Addin not found in $TMAPath."
    exit 1
}
write-output "Found Teams Meeting Addin Version: $TMAVersion"

# Install parameters
$TargetDir = "{0}\Microsoft\TeamsMeetingAddin\{1}\" -f ${env:ProgramFiles(x86)},$TMAVersion
$params = '/i "{0}" TARGETDIR="{1}" /qn ALLUSERS=1' -f $TMAPath, $TargetDir

# Start the install process
write-host "executing msiexec.exe $params"
Start-Process msiexec.exe -ArgumentList $params
write-host "Please confirm install result in Windows Eventlog"
