# Buscar el archivo Directory.Build.targets en el directorio actual o en sus subdirectorios
function Find-DirectoryBuildTargets {
    $currentDir = Get-Location
    Write-Host "Buscando Directory.Build.targets desde: $currentDir"
    while (-not (Get-ChildItem -Path $currentDir -Filter "Directory.Build.targets" -File -ErrorAction SilentlyContinue)) {
        $parentDir = $currentDir.Parent
        if (-not $parentDir) {
            throw "No se encontró el archivo Directory.Build.targets en la jerarquía de directorios desde $currentDir."
        }
        $currentDir = $parentDir
    }
    return $currentDir
}

# Obtener la ruta donde se encuentra Directory.Build.targets
try {
    $solutionRoot = Find-DirectoryBuildTargets
    Write-Host "Directory.Build.targets encontrado en: $solutionRoot"
} catch {
    Write-Host "Error: $($_.Exception.Message)"
    exit 1
}

# Ruta donde se guardará el archivo .editorconfig
$editorConfigPath = Join-Path $solutionRoot ".editorconfig"

# Ruta del archivo centralizado
$sharedEditorConfigUrl = "https://raw.githubusercontent.com/ReParade/Git_Prueba/refs/heads/main/.editorconfig"

# Descargar el archivo .editorconfig
Write-Host "Descargando .editorconfig en: $editorConfigPath..."
Invoke-WebRequest -Uri $editorConfigUrl -OutFile $editorConfigPath -UseBasicParsing

Write-Host "Archivo .editorconfig actualizado correctamente."