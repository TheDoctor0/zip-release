#! /bin/sh

# Create archive or exit if command fails
set -eu

echo "\n📦 Creating $5 archive...\n"

if [ "$3" != "." ]
then
  cd $3
fi

# Tool: zip
if [ "$5" == "zip" ]
then
  if [ -z "$4" ]
  then
    zip -r $1 $2 || { echo "\n⛔ Unable to create $5 archive.\n"; exit 1;  }
  else
    zip -r $1 $2 -x $4 || { echo "\n⛔ Unable to create $5 archive.\n"; exit 1;  }
  fi
fi

# Tool: tar
if [ "$5" == "tar" ]
then
  if [ -z "4" ]
  then
    tar -zcvf $1 $2 || { echo "\n⛔ Unable to create $5 archive.\n"; exit 1;  }
  else
    tar -zcvf $1 $2 --exclude=$4 || { echo "\n⛔ Unable to create $5 archive.\n"; exit 1;  }
  fi
fi

echo "\n✔ Successfully created $5 archive.\n"