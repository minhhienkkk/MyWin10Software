@echo off
setlocal enabledelayedexpansion

REM List all available drives
echo Available drives:
for %%D in (A: B: D: E: F: G: H: I: J: K: L: M: N: O: P: Q: R: S: T: U: V: W: X: Y: Z:) do (
    if exist "%%D" (
        echo %%D
    )
)

REM Prompt the user to choose a drive
set /p "drive=Enter the drive letter to copy ZaloPC and delete it (e.g., C): "
set "source_folder=%LOCALAPPDATA%\ZaloPC"
set "target_folder=!drive!:\ZaloPC"

REM Check if the ZaloPC folder exists on the target drive and delete it
if exist "!target_folder!" (
    echo Deleting ZaloPC folder from %drive%...
    rd /s /q "!target_folder!"
    echo ZaloPC folder has been deleted.
) else (
    echo The ZaloPC folder does not exist on %drive%.
)

REM Check if the source folder exists
if exist "!source_folder!" (
    REM Copy the ZaloPC folder to the chosen drive
    echo Copying ZaloPC folder from %source_folder% to %target_folder%...
    robocopy "!source_folder!" "!target_folder!" /mir /w:0 /r:0

    REM Delete the source folder after copy
    echo Deleting the source folder %source_folder%...
    rd /s /q "!source_folder!"

    REM Create a symbolic link (junction) from source_folder to target_folder
    echo Creating symbolic link from %source_folder% to %target_folder%...
    mklink /j "!source_folder!" "!target_folder!"
) else (
    echo The ZaloPC folder does not exist at the source location %source_folder%.
)

pause
