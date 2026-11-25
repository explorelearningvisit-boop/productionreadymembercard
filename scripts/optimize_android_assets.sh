#!/usr/bin/env bash
set -euo pipefail

# Convert only PNG assets declared by Flutter into optimized WebP in the CI
# checkout. Original repository artwork remains untouched.
command -v cwebp >/dev/null 2>&1 || {
  echo "cwebp is required; install the webp package first" >&2
  exit 1
}

mapfile -t assets < <(
  sed -nE 's/^[[:space:]]*-[[:space:]]*(assets\/.*\.png)[[:space:]]*$/\1/p' pubspec.yaml
)

if ((${#assets[@]} == 0)); then
  echo "No declared PNG assets found; nothing to optimize."
  exit 0
fi

for asset in "${assets[@]}"; do
  [[ -f "$asset" ]] || { echo "Missing declared asset: $asset" >&2; exit 1; }
  output="${asset%.png}.webp"
  cwebp -quiet -q 84 -m 6 "$asset" -o "$output"
  test -s "$output"
  sed -i "s|$asset|$output|g" pubspec.yaml
  while IFS= read -r source; do
    sed -i "s|$asset|$output|g" "$source"
  done < <(grep -rl --include='*.dart' --fixed-strings "$asset" lib || true)
  printf 'Optimized %s -> %s (%s bytes -> %s bytes)\n' \
    "$asset" "$output" "$(stat -c %s "$asset")" "$(stat -c %s "$output")"
done

echo "Flutter asset references now use optimized WebP files."
