#!/bin/sh

for filepath in "$@"; do
  if [ -e "$filepath" ]; then
    filename=$(basename "$filepath" .md)
    echo "Generating pages/${filename}.html"
    pandoc "$filepath" -o "pages/${filename}.html" --template=layouts/default.html
  fi
done
