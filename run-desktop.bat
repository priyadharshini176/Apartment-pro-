@echo off
setlocal
cd /d "%~dp0"
if not exist "lib\mysql-connector-j*.jar" (
  echo MySQL Connector/J was not found in lib\.
  echo Download the Connector/J JAR and place the downloaded JAR in lib\.
  echo See README.md for instructions.
  pause
  exit /b 1
)
if not exist build mkdir build
 dir /s /b src\*.java > sources.txt
javac -encoding UTF-8 -cp "lib\*" -d build @sources.txt
if errorlevel 1 (
  echo Compilation failed. Check the errors above.
  pause
  exit /b 1
)
java -cp "build;lib\*" com.apartment.ui.DesktopApp
endlocal
