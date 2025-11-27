#!/bin/sh

for filepath in "$@"; do
  if [ -e "$filepath" ]; then
    filename=$(basename "$filepath" .md)
    if [ "$filename" != "index" ]; then
      # Generate the HTML in pages directory
      echo "Generating pages/${filename}.html"
      pandoc "$filepath" -o "pages/${filename}.html" --template=layouts/default.html
    else
      # Generate index.html in root directory
      echo "Generating ${filename}.html"
      pandoc "$filepath" -o "${filename}.html" --template=layouts/index.html
    fi
  fi
done
