# Function to uninstall ArcGIS Server
function Uninstall-ArcGIS {
    Write-Host "Uninstalling ArcGIS Server..."
    try {
        # Start the uninstallation process
        $process = Start-Process -FilePath msiexec.exe -ArgumentList "/x {BFADF38F-B9D3-40E6-AFD5-7DA1DA5BD349} /qb" -Wait -PassThru
        
        # Check the exit code of the process
        if ($process.ExitCode -eq 0) {
            Write-Host "ArcGIS Server has been successfully uninstalled."
            
            # Remove the server directory if it exists
            Remove-DirectoryIfExists 'D:\ArcGIS\Server'
            Remove-DirectoryIfExists 'D:\arcgisserver'
        } else {
            Write-Host "Installer exit code: $($process.ExitCode)"
        }
    } catch {
        Write-Host "An error occurred during the uninstallation process: $_"
    }
}
# Function to remove a directory if it exists
function Remove-DirectoryIfExists {
    param (
        [string]$Path
    )
    try {
        if (Test-Path $Path) {
            Write-Host "Removing directory: $Path"
            Remove-Item -Path $Path -Recurse -Force -ErrorAction Stop
        } else {
            Write-Host "Directory does not exist: $Path"
        }
    } catch {
        Write-Host "An error occurred while removing the directory: $_"
    }
}
# Function to get a tree of items in a directory
function Get-Tree {
    param (
        [string]$Path,
        [string]$Include = '*'
    )
    
    return @(Get-Item $Path -Include $Include -Force) + 
           (Get-ChildItem $Path -Recurse -Include $Include -Force) | 
           Sort-Object -Property PSPath -Descending -Unique
}
# Function to remove a tree of items in a directory
function Remove-Tree {
    param (
        [string]$Path,
        [string]$Include = '*'
    )
    
    try {
        Get-Tree -Path $Path -Include $Include | Remove-Item -Force -Recurse -ErrorAction Stop
    } catch {
        Write-Host "An error occurred while removing the tree: $_"
    }
}
