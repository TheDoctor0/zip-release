#! /bin/sh

# Create archive or exit if command fails
set -eu

printf "\n📦 Creating %s archive...\n" "$5"

if [ "$3" != "." ]
then
  cd "$3"
fi

if [ "$5" = "zip" ]
then
  if [ -z "$4" ]
  then
    zip -r "$1" "$2" || { printf "\n⛔ Unable to create %s archive.\n" "$5"; exit 1;  }
  else
    zip -r "$1" "$2" -x "$4" || { printf "\n⛔ Unable to create %s archive.\n" "$5"; exit 1;  }
  fi
elif [ "$5" = "tar" ]
then
  if [ -z "$4" ]
  then
    tar -zcvf "$1" "$2" || { printf "\n⛔ Unable to create %s archive.\n" "$5"; exit 1;  }
  else
    tar -zcvf "$1" "$2" --exclude="$4" || { printf "\n⛔ Unable to create %s archive.\n" "$5"; exit 1;  }
  fi
else
  printf "\n⛔ Invalid archiving tool.\n"; exit 1;
fi

printf "\n✔ Successfully created %s archive.\n" "$5"