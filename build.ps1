$outputZip = "Docker-KSU.zip"
$updateJsonPath = "update.json"

if (Test-Path $updateJsonPath)
{
    $updateJson = Get-Content -Path $updateJsonPath -Raw | ConvertFrom-Json
    $version = $updateJson.version
    Write-Host "Version: $version"
}
else
{
    Write-Warning "File $updateJsonPath not found. Using default version."
    $version = "unknown"
}

$excludeList = @(
    ".idea",
    ".git",
    ".github",
    "build.ps1",
    $outputZip
)

if (Test-Path $outputZip)
{
    Remove-Item -Path $outputZip -Force
}

Write-Host "Creating archive $outputZip..."

$filesToZip = Get-ChildItem -Path . -Exclude $excludeList -Recurse

Compress-Archive -Path $filesToZip -DestinationPath $outputZip -Force

Write-Host "Done! Archive created: $outputZip"
