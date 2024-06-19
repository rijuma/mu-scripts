# Made with Love by Marcos https://github.com/rijuma
# Repo: https://github.com/rijuma/mu-scripts

$yamlModule = "powershell-yaml"
try {
  Import-Module $yamlModule -ErrorAction Stop
} catch {
  "  ERROR: $yamlModule module not found."
  ""
  "  This script depends on it to work properly."
  "  Plese run open a PowerShell terminal as an admin and install the module with:"
  ""
  "  Install-Module ""$yamlModule"""
  ""
  exit
}

$configFile = 'config.yml'

try {
  $config = Get-Content $configFile -ErrorAction Stop | ConvertFrom-Yaml
} catch {
  ""
  "  Error parsing '$configFile'. Please check the config file exists or copy the example one."
  ""
  exit 1
}

$baseClientPath = $config.baseClientPath
$installerClientPath = $config.updater.installerClientPath
$updatePath = $config.updater.updatePath

# Ensure Reference Client path exists
if (!(Test-Path -Path "$baseClientPath")) {
  "Base Client path is wrong: '$baseClientPath' in '$configFile'."
  exit
}

# Ensure Installer path exists
if (!(Test-Path -Path "$installerClientPath")) {
  "Installer path is wrong: '$installerClientPath' in '$configFile'."
  exit
}

# Ensure Update Path is set
if (!$updatePath) {
  "Missing updated.updatePath in '$configFile'."
  exit
}

# Create Update dir if not exists
New-Item -ItemType Directory -Force -Path $updatePath | out-null
# Delete all files and folders inside Update Path
Remove-Item "$updatePath\*" -Recurse -Force

# Exclude accesory files, sound and music (saved in a different folder in the installer).
$exclude = $config.updater.exclude

# Get all files from Test Client
Push-Location -Path $baseClientPath
$files = Get-ChildItem "." -File -Exclude $exclude -Recurse | Resolve-Path -Relative
Pop-Location

$files

$added = 0
$updated = 0
$warn = 0

foreach ($file in $files) {
  $basePath = "$baseClientPath\$file"
  $baseFile = Get-Item $basePath

  $installerPath = "$installerClientPath\$file"
  if (Test-Path -Path $installerPath) {
    $refFile = Get-Item $installerPath
  }

  $destFile = "$updatePath\$file"


  # If the file does not exists in the installer, or has a different size, or has a different modification time, then we add it to the update.
  if (!$refFile -or ($baseFile.Length -ne $refFile.Length) -or ($baseFile.LastWriteTime -ne $refFile.LastWriteTime)) {
    if (!$refFile) {
      "[new] $file."
      $added++
    } else {
      "[edit] $file."
      $updated++
    }

    if ($refFile -and ($baseFile.LastWriteTime -lt $refFile.LastWriteTime)) {
      "[Warning] '$file' is newer in the installer client."
      $warn++
    }

    $dir = Split-Path -Parent $destFile
    New-Item -ItemType Directory -Force -Path $dir | out-null
    Copy-Item $baseFile $destFile
  }
}

""
if (($added + $updated) -gt 0) {
  "Update created."

  if ($added) {
    if ($added -eq 1) {
      "- $added new file."
    } else {
      "- $added new files."
    }
  }

  if ($updated) {
    if ($updated -eq 1) {
      "- $updated updated file."
    } else {
      "- $updated updated files."
    }
  }

  if ($warn) {
    if ($warn -eq 1) {
      "- Make sure to check the warning above."
    } else {
      "- Make sure to check the $warn warnings above."
    }
  }
} else {
  "Base client is up to date."
}
""

[Console]::ResetColor()
