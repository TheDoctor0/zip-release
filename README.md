# Action Zip [![License](https://img.shields.io/github/license/TheDoctor0/action-zip)](https://github.com/TheDoctor0/action-zip/blob/master/LICENSE)
GitHub action that can be used to create release zip archive.

## Usage
An example workflow config:
```
name: Create Archive
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Archive Release
      uses: thedoctor0/action-zip@master
      with:
        filename: 'release.zip'
        exclusions: '*.git* /*node_modules/* .editorconfig'
```

## Arguments
| Argument | Description | Default |
|---|---|---|
| filename | Filename for archive | release.zip |
| path | Base path for archive files | . |
| exclusions | List of excluded files/directories | |