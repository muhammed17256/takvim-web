# Kullanim (PowerShell): .\scripts\release.ps1 -User muhammed17256 -Version v1.0
param(
  [Parameter(Mandatory=$true)][string]$User,
  [Parameter(Mandatory=$true)][string]$Version
)
$image = "$User/takvim-web"
$date = Get-Date -Format "yyyy-MM-dd HH:mm"

docker build -t "${image}:$Version" -t "${image}:latest" `
  --build-arg APP_VERSION=$Version --build-arg BUILD_DATE="$date" .
if ($LASTEXITCODE -ne 0) { exit 1 }

docker push "${image}:$Version"
docker push "${image}:latest"
Write-Host "Tamam: https://hub.docker.com/r/$image/tags"
