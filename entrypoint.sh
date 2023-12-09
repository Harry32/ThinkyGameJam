#!/usr/bin/env bash

set -e

/usr/local/bin/godot --headless --export-$1 "Web" ../build/index.html
cd ../build
zip -r build.zip .
/opt/butler/bin/butler push build.zip harry32/tgjgravgame:html5