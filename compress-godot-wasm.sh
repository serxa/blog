#!/usr/bin/env bash
set -e
set -x

for f in *.wasm; do
    echo "Compressing $f"
    brotli --best --force --output="$f.br" "$f"
    echo "  New size: $(du -h "$f.br" | cut -f1)"
done

for f in *.html; do
    echo "  Patching $f"
    sed -i '' -e "s/\.wasm\"/\.wasm.br\"/g" "$f"
done

for f in *.js; do
    echo "  Patching $f"
    sed -i '' -e "s/\.wasm\`/\.wasm.br\`/g" "$f"
done
