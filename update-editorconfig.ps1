# Ruta del archivo centralizado
$sharedEditorConfigUrl = "https://raw.githubusercontent.com/ReParade/Git_Prueba/refs/heads/main/.editorconfig"

# Ruta local del archivo
$localEditorConfig = ".editorconfig"

# Función para obtener la versión del archivo .editorconfig (desde un comentario en la primera línea)
function Get-EditorConfigVersion($filePath) {
    $firstLine = Get-Content $filePath | Select-Object -First 1
    if ($firstLine -match "#\s*version=(\S+)") {
        return $matches[1]
    }
    return $null  # Si no se encuentra la versión, retornar null
}

# Obtener la versión del archivo remoto
function Get-RemoteEditorConfigVersion($url) {
    $tempFile = [System.IO.Path]::GetTempFileName()
    Invoke-WebRequest -Uri $url -OutFile $tempFile
    $version = Get-EditorConfigVersion $tempFile
    Remove-Item $tempFile
    return $version
}

# Obtener la versión remota y local
$remoteVersion = Get-RemoteEditorConfigVersion $sharedEditorConfigUrl
$localVersion = if (Test-Path $localEditorConfig) { Get-EditorConfigVersion $localEditorConfig } else { $null }

# Verificar si las versiones son diferentes
if ($remoteVersion -ne $localVersion) {
    Write-Host "El archivo .editorconfig tiene una versión diferente, actualizando..."
    Invoke-WebRequest -Uri $sharedEditorConfigUrl -OutFile $localEditorConfig
    Write-Host "Archivo .editorconfig actualizado."
} else {
    Write-Host "El archivo .editorconfig ya esta actualizado."
}