#!/bin/sh

# Create zip archive or exit if command fails
set -eu

echo "\n📦 Creating zip archive...\n"

if [ "$3" != "." ]
then
  cd $3
fi

if [ -z "$4" ]
then
  zip -r $1 $2 || { echo "\n⛔ Unable to create zip archive.\n"; exit 1;  }
else
  zip -r $1 $2 -x $4 || { echo "\n⛔ Unable to create zip archive.\n"; exit 1;  }
fi

echo "\n✔ Successfully created archive.\n"
