# Action ZIP
GitHub action that can be used to create release zip archive for Laravel based projects.
Some custom exclusions are added, so feel free to fork this repository to change them.

## Usage

An example action config:

```
- name: Archive Release
  uses: thedoctor0/action-laravel-zip@v0.1.0
    env:
      ARCHIVE_FILENAME: release.zip
```
