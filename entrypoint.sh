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
      7z a -tzip $INPUT_FILENAME $INPUT_PATH $INPUT_CUSTOM || { printf "\n⛔ Unable to create %s archive.\n" "$INPUT_TYPE"; exit 1;  }
    else
      EXCLUSIONS=''

      EXCLUSIONS=(${INPUT_EXCLUSIONS// / })
      for EXCLUSION in EXCLUSIONS;
      do
        EXCLUSIONS+=" -x!"
        EXCLUSIONS+=$EXCLUSION
      done

      for EXCLUSION in $INPUT_RECURSIVE_EXCLUSIONS
      do
        EXCLUSIONS+=" -xr!"
        EXCLUSIONS+=$EXCLUSION
      done

      7z a -tzip $INPUT_FILENAME $INPUT_PATH $EXCLUSIONS $INPUT_CUSTOM || { printf "\n⛔ Unable to create %s archive.\n" "$INPUT_TYPE"; exit 1;  }
    fi
  else
    if [ -z "$INPUT_EXCLUSIONS" ] 
    then
      zip -r $INPUT_FILENAME $INPUT_PATH $INPUT_CUSTOM || { printf "\n⛔ Unable to create %s archive.\n" "$INPUT_TYPE"; exit 1;  }
    else
      zip -r $INPUT_FILENAME $INPUT_PATH -x $INPUT_EXCLUSIONS $INPUT_CUSTOM || { printf "\n⛔ Unable to create %s archive.\n" "$INPUT_TYPE"; exit 1;  }
    fi
  fi
elif [ "$INPUT_TYPE" = "7z" ] || [ "$INPUT_TYPE" = "7zip" ] 
then
  if [ -z "$INPUT_EXCLUSIONS" ] 
  then
    7z a -tzip $INPUT_FILENAME $INPUT_PATH $INPUT_CUSTOM || { printf "\n⛔ Unable to create %s archive.\n" "$INPUT_TYPE"; exit 1;  }
  else
    EXCLUSIONS=''

    EXCLUSIONS=(${INPUT_EXCLUSIONS// / })
    for EXCLUSION in EXCLUSIONS;
    do
      EXCLUSIONS+=" -x!"
      EXCLUSIONS+=$EXCLUSION
    done

    for EXCLUSION in $INPUT_RECURSIVE_EXCLUSIONS
    do
      EXCLUSIONS+=" -xr!"
      EXCLUSIONS+=$EXCLUSION
    done

    7z a -tzip $INPUT_FILENAME $INPUT_PATH $EXCLUSIONS $INPUT_CUSTOM || { printf "\n⛔ Unable to create %s archive.\n" "$INPUT_TYPE"; exit 1;  }
  fi
elif [ "$INPUT_TYPE" = "tar" ] || [ "$INPUT_TYPE" = "tar.gz" ] 
then
  if [ -z "$INPUT_EXCLUSIONS" ] 
  then
    tar -zcvf $INPUT_FILENAME $INPUT_PATH $INPUT_CUSTOM || { printf "\n⛔ Unable to create %s archive.\n" "$INPUT_TYPE"; exit 1;  }
  else
    EXCLUSIONS=''

    for EXCLUSION in $INPUT_EXCLUSIONS
    do
      EXCLUSIONS+=" --exclude="
      EXCLUSIONS+=$EXCLUSION
    done

    tar $EXCLUSIONS -zcvf $INPUT_FILENAME $INPUT_PATH $INPUT_CUSTOM || { printf "\n⛔ Unable to create %s archive.\n" "$INPUT_TYPE"; exit 1;  }
  fi
else
  printf "\n⛔ Invalid archiving tool.\n"; exit 1;
fi

printf "\n✔ Successfully created %s archive.\n" "$INPUT_TYPE"
