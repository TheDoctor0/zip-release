#!/bin/sh

# Create zip archive or exit if command fails
set -eu

echo "\n📦 Creating zip archive...\n"

zip -r $1 $2 -x $3 || { echo "\n⛔ Unable to create zip archive.\n"; exit 1;  }

echo "\n✔ Successfuly created archive.\n"
