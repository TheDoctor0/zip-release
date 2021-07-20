# Zip Release [![License](https://img.shields.io/github/license/TheDoctor0/zip-release)](https://github.com/TheDoctor0/zip-release/blob/master/LICENSE)
GitHub action that can be used to create release archive using zip or tar.

**NOTE:** Because this action is written in bash it will only work on **Linux** and **MacOS**.

## Usage
An example workflow config:
```yaml
name: Create Archive
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Archive Release
      uses: thedoctor0/zip-release@master
      with:
        filename: 'release.zip'
        exclusions: '*.git* /*node_modules/* .editorconfig'
```

The generated archive will be placed as specified by `directory` and `filename`.
If you want to attach it to the latest release use another action like [`ncipollo/release-action`](https://github.com/ncipollo/release-action):
```yaml
- name: Upload Release
  uses: ncipollo/release-action@v1
  with:
    artifacts: "release.zip"
    token: ${{ secrets.GITHUB_TOKEN }}
```

## Arguments

### `filename`
Default: `release.zip`

The filename for the generated archive, relative to `directory`.

If you use `type: tar` it's recommended to set the filename to a `tar.gz` (the tarball is always gzip compressed).

### `path`
Default: `.`

The path to the files or directory that should be archived, relative to `directory`

### `directory`
Default: `.`

The working directory where the zip or tar actually runs.

### `exclusions`
Default: none

List of excluded files or directories.

Please note: this handles slightly differently, depending on if you use `type: zip` or `type: tar`.

ZIP requires you to specify wildcards or full filenames.

TAR allows you to specify only the filename, no matter if it's in a subdirectory.

### `type`
Default: `zip`

Either `zip` or `tar`.

Defines if either a ZIP-file is created, or a tar archive (the latter gzipped).

