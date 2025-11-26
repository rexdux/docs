#!/bin/sh

for filepath in "$@"; do
  if [ -e "$filepath" ]; then
    filename=$(basename "$filepath" .md)
    pandoc "$filepath" -o "pages/${filename}.html" --template=layouts/default.html
  fi
done
