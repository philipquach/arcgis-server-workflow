# Function to check if a software is installed using its product code
function Is-SoftwareInstalled {
    param (
        [string]$productCode
    )
$installedSoftware = Get-WmiObject -Class Win32_Product | Where-Object { $_.IdentifyingNumber -eq $productCode }
    return $installedSoftware -ne $null
}
# Function to check if a directory exists
function Is-DirectoryExists {
    param (
        [string]$directoryPath
    )
return Test-Path $directoryPath
}
# Main script
$productCode = "{BFADF38F-B9D3-40E6-AFD5-7DA1DA5BD349}"  # Product code for the software
$directoriesToCheck = @(
    'D:\ArcGIS\Server',
    'D:\arcgisserver'
)
# Check if the software is installed
if (Is-SoftwareInstalled -productCode $productCode) {
    Write-Host "Software with product code $productCode is installed."
} else {
    Write-Host "Software with product code $productCode is not installed."
}
# Check if the specified directories exist
foreach ($directory in $directoriesToCheck) {
    if (Is-DirectoryExists -directoryPath $directory) {
        Write-Host "Directory exists: $directory"
    } else {
        Write-Host "Directory does not exist: $directory"
    }
}
