# Obtener la ubicación del archivo Directory.Build.targets
$directoryBuildTargetsPath = "C:\SCISA\SCISA_GIT\SCISA_BASE_APP" # Reemplaza con la ruta de tu carpeta

# Validar si la carpeta existe
if (-not (Test-Path $directoryBuildTargetsPath)) {
    Write-Host "Error: No se encontró la carpeta donde está el Directory.Build.targets: $directoryBuildTargetsPath"
    exit 1
}

# Ruta donde se guardará el archivo .editorconfig
$editorConfigPath = Join-Path $directoryBuildTargetsPath ".editorconfig"

# Ruta del archivo centralizado
$sharedEditorConfigUrl = "https://raw.githubusercontent.com/ReParade/Git_Prueba/refs/heads/main/.editorconfig"

# Descargar el archivo .editorconfig
Write-Host "Descargando .editorconfig en: $editorConfigPath..."
Invoke-WebRequest -Uri $editorConfigUrl -OutFile $editorConfigPath -UseBasicParsing

Write-Host "Archivo .editorconfig actualizado correctamente en $editorConfigPath."