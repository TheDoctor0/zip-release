# Zip Release [![License](https://img.shields.io/github/license/TheDoctor0/zip-release)](https://github.com/TheDoctor0/zip-release/blob/master/LICENSE)
GitHub action that can be used to create release archive using zip or tar.

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
      uses: thedoctor0/zip-release@master
      with:
        filename: 'release.zip'
        exclusions: '*.git* /*node_modules/* .editorconfig'
```
You can add this job to release the zipped file to GitHub(change the artifact file to the release filename):
```
- name: Upload Release
    uses: ncipollo/release-action@v1
    with:
        artifacts: "release.zip"
        token: ${{ secrets.GITHUB_TOKEN }}
```

## Arguments
| Argument | Description | Default |
|---|---|---|
| filename | Filename for archive | release.zip |
| path | Base path for archive files | . |
| directory | Working directory before zipping | . |
| exclusions | List of excluded files / directories | |
| type | Tool to use for archiving (zip / tar) | zip |
