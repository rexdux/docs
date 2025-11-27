#!/bin/sh

src="./src"
out="$src/index.md"

{
  echo '---'
  echo 'title: "My Documents"'
  echo 'subtitle: "A collection of various personal documents."'
  echo '---'
  echo
} > "$out"

for f in "$src"/*.md; do
  # Skip the generated index.md
  [ "$f" = "$out" ] && continue
  filename=$(basename "$f" .md)
  filetitle=$(grep '^title:' "$f" | sed 's/.*"[ ]*\(.*\)[ ]*".*/\1/')
  [ -z "$filetitle" ] && filetitle="$filename"
  # Append entry to index.md
  printf -- "- [%s](./pages/%s.html)\n" "$filetitle" "$filename" >> "$out"
done

# Sort alphabetically
{
  sed -n '1,5p' "$out"        # keep header untouched
  sed -n '6,$p' "$out" | sort -f
} > "$out.tmp"

mv "$out.tmp" "$out"
