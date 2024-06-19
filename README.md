[![en](https://img.shields.io/badge/lang-en-green.svg)](./README.md)
[![es](https://img.shields.io/badge/lang-es-blue.svg)](./README.es.md)

# Description

This is a collection of scripts to help with MU Online file handling.

# Scripts

## :scroll: make-update

This script compares the content on a test client we use to try things and the installer that was shared to the users.

The idea is to be able to quickly tell which files were added or updated in the test client.

Then you can share these files as a patch or use them with an update launcher.

# Config

The `config.yml` file is used to configure the settings on the scripts. You can use [config.example.yml](./config.example.yml) as a reference.

## Parameters

The parameters are:

- `baseClientPath`: Path to the MU Client we use for testing.
- `updater.installerClientPath`: Path to the MU Client installer shared to the users.
- `updater.updatePath`: All new or updated files will be copied in this folder.
  > :warning: Caution: The contents on this file will be deleted at the start of each execution.
- `updater.exclude`: Aadd as a list (in Yaml, indented values starting with hyphen `-`) patterns of files yow want to exclude.

> [!NOTE]
> Check [config.example.yml](./config.example.yml) file as an example and update to your liking.

# Install

This script uses the [powershell-yaml](https://github.com/cloudbase/powershell-yaml) PowerShell module. You need to install it by [opening a PowerShell terminal as an admin](https://learn.microsoft.com/en-us/powershell/scripting/windows-powershell/starting-windows-powershell?view=powershell-7.4#with-administrative-privileges-run-as-administrator) and typing:

```pwsh
Install-Module "powershell-yaml"
```

# Notes

All scripts has their associated batch file (.bat) to make it easier to run from the file explorer.
