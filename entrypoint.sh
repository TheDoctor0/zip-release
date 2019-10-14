#!/bin/sh

# Create zip archive or exit if command fails
set -eu

echo "\n📦 Creating zip archive...\n"

zip -r ${ARCHIVE_FILENAME} . -x '/*node_modules/*' '/*.git/*' '/*.github/*' '/*laradock/*' '/*deploy/*' '/*.gitmodules' '/*.gitattributes' '/*.gitignore' '/*.editorconfig' '/*.env.ci' '/*.phpstorm.meta.php' '/*.whitesource' '/*_ide_helper.php' '/*Makefile' '/*phpcs.xml' '/*package.json' '/*yarn.lock' '/*psalm.xml' '/*phpstan.neon' '/*webpack.mix.js' '/*actions/*' '/*config/vue-i18n-generator.php' '/*resources/app/*' '/*resources/install/*' '/*resources/lang/generated/*' '/*requests/*' || { echo "\⛔️ Unable to create zip archive.\n"; exit 1;  }

echo "\n✔️ Successfuly created archive.\n"
