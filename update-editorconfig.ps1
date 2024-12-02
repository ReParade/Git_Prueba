# Ruta del archivo centralizado
$sharedEditorConfigUrl = "https://raw.githubusercontent.com/ReParade/Git_Prueba/refs/heads/main/.editorconfig"

# Ruta local del archivo
$localEditorConfig = ".editorconfig"

# Función para obtener el encabezado Last-Modified del archivo remoto
function Get-LastModifiedHeader($url) {
    $response = Invoke-WebRequest -Uri $url -Method Head
    return $response.Headers["Last-Modified"]
}

# Obtener la fecha de modificación del archivo remoto
$remoteLastModified = Get-LastModifiedHeader $sharedEditorConfigUrl

# Verificar si el archivo local no existe o si está desactualizado
if (-Not (Test-Path $localEditorConfig) -or $remoteLastModified -ne (Get-Item $localEditorConfig).LastWriteTime) {
    Write-Host "El archivo ha cambiado o no existe, actualizando..."
    # Descargar el archivo remoto
    Invoke-WebRequest -Uri $sharedEditorConfigUrl -OutFile $localEditorConfig
    Write-Host "Archivo .editorconfig actualizado."
} else {
    Write-Host "El archivo .editorconfig ya está actualizado."
}