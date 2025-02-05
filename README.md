# Zip Release [![License](https://img.shields.io/github/license/TheDoctor0/zip-release)](https://github.com/TheDoctor0/zip-release/blob/master/LICENSE)
GitHub action that can be used to create release archive using zip or tar.

It works on all platforms: **Linux**, **MacOS** and **Windows**.

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
      uses: thedoctor0/zip-release@0.7.5
      with:
        type: 'zip'
        filename: 'release.zip'
        exclusions: '*.git* /*node_modules/* .editorconfig'
```

The generated archive will be placed as specified by `directory`, `path` and `filename`.
If you want to attach it to the latest release use another action like [`ncipollo/release-action`](https://github.com/ncipollo/release-action):
```yaml
- name: Upload Release
  uses: ncipollo/release-action@v1.12.0
  with:
    artifacts: "release.zip"
    token: ${{ secrets.GITHUB_TOKEN }}
```

## Arguments

### `filename`
Default: `release.zip`

The filename for the generated archive, relative to `directory`.

If you use `type: tar` it's recommended to set the filename to a `tar.gz` (the tarball is always gzip compressed).

### `directory`
Default: `.`

The working directory where the zip or tar actually runs.

### `path`
Default: `.`

The path to the files or directory that should be archived, relative to `directory`.

Path with whitespace is currently not supported because of the limitation of GitHub actions regarding the parameter formatting (no YAML double quoting).
A solution based on [similar issues](https://github.com/rojopolis/spellcheck-github-actions/commit/0d2f3ab70398848fd52892971396beff29d3fd61) will soon be implemented.

### `type`
Default: `zip`

Either `zip` or `tar` or `7z`.

Defines if either a ZIP-file is created, or a tar archive (the latter gzipped).

On Windows platform 7zip is used to zip files as zip command is unavailable there.

### `exclusions`
Default: none

List of excluded files or directories.

Please note: this handles slightly differently, depending on if you use `type: zip` or `type: tar`.

ZIP requires you to specify wildcards or full filenames.

TAR allows you to specify only the filename, no matter if it's in a subdirectory.

To ignore directories starting with `.` like `.git` add `/` forward slash to specify that it's a folder: `/.git`

### `recursive_exclusions`
Default: none

Alternative to `exclusions` that allows you to specify a list of [recursive wildcards](https://sevenzip.osdn.jp/chm/cmdline/switches/recurse.htm).
Only applies to `type: zip` on Windows where 7zip is used.

For example:

```exclusions: *.txt``` will only exclude files ending with `.txt`

```recursive_exclusions: *.txt``` will exclude files ending with `.txt` in any subdirectory.

### `custom`
Default: none

Provide any custom parameters to the zipping command.

For example:

```custom: --ignore-failed-read``` option used with `tar` command, which allows to ignore and continue on unreadable files.

```custom: -j``` option used with `zip` command, which allows creating zip files [without junk paths](https://stackoverflow.com/questions/9710141/create-zip-file-and-ignore-directory-structure).

### `command`
Default: none

An extra command that will run before zipping.

For example:

```command: "mkdir -p release"``` can be used to create a directory where the archived file can be stored to fix `tar` issue with `file changed as we read it` error
