# Ruta del archivo centralizado
$sharedEditorConfigUrl = "https://raw.githubusercontent.com/ReParade/Git_Prueba/refs/heads/main/.editorconfig"
# Ruta local del archivo
$editorConfigPath = Join-Path $solutionRoot ".editorconfig"

# Descargar si no existe o actualizar
if (-Not (Test-Path $editorConfigPath) -or (Invoke-WebRequest -Uri $sharedEditorConfigUrl -Method Head).Headers["Last-Modified"] -ne (Get-Item $editorConfigPath).LastWriteTime) {
    Invoke-WebRequest -Uri $sharedEditorConfigUrl -OutFile $editorConfigPath
    Write-Host "Archivo .editorconfig actualizado."
}