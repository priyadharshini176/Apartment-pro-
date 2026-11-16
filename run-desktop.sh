#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
if ! compgen -G 'lib/mysql-connector-j*.jar' > /dev/null; then
  echo "MySQL Connector/J JAR not found in lib/. See README.md."
  exit 1
fi
mkdir -p build
find src -name '*.java' -print > sources.txt
javac -encoding UTF-8 -cp 'lib/*' -d build @sources.txt
java -cp 'build:lib/*' com.apartment.ui.DesktopApp
