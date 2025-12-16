#!/bin/sh

# Generate index

src="./src"
out="$src/index.md"

echo "Generating index.html"
{
  echo "---"
  echo "title: My Documents"
  echo "subtitle: A collection of various personal documents."
  echo "---"
  echo
} > "$out"

for f in "$src"/*.md; do
  [ "$f" = "$out" ] && continue
  filename=$(basename "$f" .md)
  filetitle=$(grep '^title:' "$f" | sed 's/.*"[ ]*\(.*\)[ ]*".*/\1/')
  [ -z "$filetitle" ] && filetitle="$filename"
  lang=$(grep '^lang:' "$f" | sed 's/^lang:[[:space:]]*//')
  if [ -n "$lang" ] && [ "$lang" != "en-US" ]; then
    printf -- "- [%s](./pages/%s.html){lang=%s}\n" "$filetitle" "$filename" "$lang" >> "$out"
  else
    printf -- "- [%s](./pages/%s.html)\n" "$filetitle" "$filename" >> "$out"
  fi
done

{
  sed -n '1,5p' "$out"
  sed -n '6,$p' "$out" | sort -f
} > "$out.tmp"

mv "$out.tmp" "$out"
pandoc "$out" -o "index.html" --template=layouts/index.html

# Generate pages

for filepath in "$@"; do
  if [ -e "$filepath" ]; then
    filename=$(basename "$filepath" .md)
    if [ "$filename" != "index" ]; then
      # Generate the HTML in pages directory
      echo "Generating pages/${filename}.html"
      pandoc "$filepath" -o "pages/${filename}.html" -V permalink="${filename}" --template=layouts/default.html
    fi
  fi
done
