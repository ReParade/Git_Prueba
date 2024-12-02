# Ruta del archivo centralizado
$sharedEditorConfigUrl = "https://raw.githubusercontent.com/ReParade/Git_Prueba/refs/heads/main/.editorconfig"
# Ruta local del archivo
$editorConfigPath = Join-Path $solutionRoot ".editorconfig"

# Descargar si no existe o actualizar
if (-Not (Test-Path $localEditorConfig) -or (Invoke-WebRequest -Uri $sharedEditorConfigUrl -Method Head).Headers["Last-Modified"] -ne (Get-Item $localEditorConfig).LastWriteTime) {
    Invoke-WebRequest -Uri $sharedEditorConfigUrl -OutFile $localEditorConfig
    Write-Host "Archivo .editorconfig actualizado."
}