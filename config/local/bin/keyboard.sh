#!/bin/bash

layouts=$(jq -r '.layouts | map(.code) | join(",")' layouts.json)

echo $layouts
