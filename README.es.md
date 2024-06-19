[![en](https://img.shields.io/badge/lang-en-blue.svg)](./README.md)
[![es](https://img.shields.io/badge/lang-es-green.svg)](./README.es.md)

# Descripción

Esta es una colección de scripts para ayudar con el manejo de archivos de MU Online.

# Scripts

## :scroll: make-update

Este script compara los contenidos de un cliente de prueba que usemos para configurar nuestro servidor contra el cliente que se compartió con los usuarios.

La idea es poder rápidamente detectar qué archivos nuevos o actualizados hay en el cliente de configuración.

Luego, puedes usar el contenido para compartir como un patch o usarlos para actualizar con el launcher.

# Configuración

El archivo `config.yml` se usa para configurar los scripts. Podés crearlo a partir de [config.example.yml](./config.example.yml) para usarlo como referencia.

## Parámetros

Los parámetros son:

- `baseClientPath`: Ruta al Cliente de MU que usemos para configurar.
- `updater.installerClientPath`: Ruta al cliente compartido con los usuarios.
- `updater.updatePath`: Todos los archivos nuevos o modificados van a ser copiados a esta carpeta.
  > :warning: Cuidado: Los contenidos de esta carpeta van a ser eliminados al comienzo de cada ejecución.
- `updater.exclude`: Agregar en una lista (en Yaml, son archivos indentados que comienzan con un guión medio `-`) patrones de los archivos que quieras ignorar.

> [!NOTE]
> Mirá el archivo [config.example.yml](./config.example.yml) y usalo como referencia para adaptarlo a tu gusto.

# Install

Este script usa el módulo [powershell-yaml](https://github.com/cloudbase/powershell-yaml). Podés instalarlo [abriendo una terminal de PowerShell como administrador](https://learn.microsoft.com/es-es/powershell/scripting/windows-powershell/starting-windows-powershell?view=powershell-7.4) y escribiendo:

```pwsh
Install-Module "powershell-yaml"
```

# Notas

Todos los scripts tienen un archivo batch (.bat) asociado para poder ejecutarlo fácilmente mediante el exporador.
