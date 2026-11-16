#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p build
find src -name '*.java' -print > sources.txt
javac -encoding UTF-8 -cp 'lib/*' -d build @sources.txt
java -cp 'build:lib/*' com.apartment.Main
