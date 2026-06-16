@echo off
setlocal

set "ROOT_DIR=%~dp0.."
set "SRC_DIR=%ROOT_DIR%\src"
set "RESULTS_DIR=%ROOT_DIR%\results"

if not exist "%RESULTS_DIR%" mkdir "%RESULTS_DIR%"

gcc -O0 "%SRC_DIR%\benchmark_ram.c" -o "%ROOT_DIR%\benchmark_ram.exe"
if errorlevel 1 exit /b 1

gcc -O0 "%SRC_DIR%\benchmark_register.c" -o "%ROOT_DIR%\benchmark_register.exe"
if errorlevel 1 exit /b 1

set "RAM_RESULTS=%RESULTS_DIR%\windows_benchmark_ram.txt"
set "REGISTER_RESULTS=%RESULTS_DIR%\windows_benchmark_register.txt"

type nul > "%RAM_RESULTS%"
type nul > "%REGISTER_RESULTS%"

echo Executando benchmark_ram 10 vezes...
for /L %%i in (1,1,10) do (
    echo Execucao %%i>> "%RAM_RESULTS%"
    "%ROOT_DIR%\benchmark_ram.exe" >> "%RAM_RESULTS%"
    echo.>> "%RAM_RESULTS%"
)

echo Executando benchmark_register 10 vezes...
for /L %%i in (1,1,10) do (
    echo Execucao %%i>> "%REGISTER_RESULTS%"
    "%ROOT_DIR%\benchmark_register.exe" >> "%REGISTER_RESULTS%"
    echo.>> "%REGISTER_RESULTS%"
)

echo Resultados salvos em %RESULTS_DIR%
endlocal
