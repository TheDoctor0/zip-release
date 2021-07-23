#! /bin/bash

# Create archive or exit if command fails
set -eu

printf "\n📦 Creating %s archive...\n" "$INPUT_TYPE"

if [ "$INPUT_DIRECTORY" != "." ] 
then
  cd $INPUT_DIRECTORY
fi

if [ "$INPUT_TYPE" = "zip" ] 
then
  if [ "$RUNNER_OS" = "Windows" ]
  then
    if [ -z "$INPUT_EXCLUSIONS" ] 
    then
      7z a -tzip -r $INPUT_FILENAME $INPUT_PATH || { printf "\n⛔ Unable to create %s archive.\n" "$INPUT_TYPE"; exit 1;  }
    else
      EXCLUSIONS = ''

      for file in $INPUT_EXCLUSIONS
      do
        A += " -x!"
        A += file
      done
      echo $EXCLUSIONS

      7z a -tzip -r $INPUT_FILENAME $INPUT_PATH $EXCLUSIONS || { printf "\n⛔ Unable to create %s archive.\n" "$INPUT_TYPE"; exit 1;  }
    fi
  else
    if [ -z "$INPUT_EXCLUSIONS" ] 
    then
      zip -r $INPUT_FILENAME $INPUT_PATH || { printf "\n⛔ Unable to create %s archive.\n" "$INPUT_TYPE"; exit 1;  }
    else
      zip -r $INPUT_FILENAME $INPUT_PATH -x $INPUT_EXCLUSIONS || { printf "\n⛔ Unable to create %s archive.\n" "$INPUT_TYPE"; exit 1;  }
    fi
  fi
elif [ "$INPUT_TYPE" = "tar" ] 
then
  if [ -z "$INPUT_EXCLUSIONS" ] 
  then
    tar -zcvf $INPUT_FILENAME $INPUT_PATH || { printf "\n⛔ Unable to create %s archive.\n" "$INPUT_TYPE"; exit 1;  }
  else
    tar -zcvf $INPUT_FILENAME --exclude=$INPUT_EXCLUSIONS $INPUT_PATH || { printf "\n⛔ Unable to create %s archive.\n" "$INPUT_TYPE"; exit 1;  }
  fi
else
  printf "\n⛔ Invalid archiving tool.\n"; exit 1;
fi

printf "\n✔ Successfully created %s archive.\n" "$INPUT_TYPE"
