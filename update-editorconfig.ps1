# Buscar la raíz de la solución (.sln más cercano)
function Get-SolutionRoot {
    $currentDir = Get-Location
    Write-Host "Buscando archivo .sln desde: $currentDir"
    while (-not (Get-ChildItem -Path $currentDir -Filter "*.sln" -File -ErrorAction SilentlyContinue)) {
        $parentDir = $currentDir.Parent
        if (-not $parentDir) {
            throw "No se encontró un archivo .sln en la jerarquía de directorios desde $currentDir."
        }
        $currentDir = $parentDir
    }
    return $currentDir
}

# Obtener la ruta de la raíz de la solución
try {
    $solutionRoot = Get-SolutionRoot
    Write-Host "Raíz de la solución encontrada en: $solutionRoot"
} catch {
    Write-Host "Error: $($_.Exception.Message)"
    exit 1
}

# Ruta del archivo centralizado
$sharedEditorConfigUrl = "https://raw.githubusercontent.com/ReParade/Git_Prueba/refs/heads/main/.editorconfig"
# Ruta local del archivo
$editorConfigPath = Join-Path $solutionRoot ".editorconfig"

# Descargar el archivo .editorconfig
Write-Host "Descargando .editorconfig en $editorConfigPath..."
Invoke-WebRequest -Uri $editorConfigUrl -OutFile $editorConfigPath -UseBasicParsing

Write-Host "Archivo .editorconfig actualizado correctamente."