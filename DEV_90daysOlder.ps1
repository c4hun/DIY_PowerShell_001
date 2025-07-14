# Define the root folder you want to audit
$rootPath = "C:\Users\..."

# Define output CSV path
$outputCsv = "C:\...\AuditReport.csv"

# Recursively get all items and filter by LastWriteTime
Get-ChildItem -Path $rootPath -Recurse | Where-Object {
    $_.LastWriteTime -lt (Get-Date).AddDays(-90)
} | ForEach-Object {
    $file = $_

    [PSCustomObject]@{
        Path      = $file.FullName
        Name      = $file.Name
        Type      = if ($file.PSIsContainer) { "Folder" } else { "File" }
        Size      = if (-not $file.PSIsContainer) { "{0:N0}" -f $file.Length } else { "" }
        Created   = $file.CreationTime
        Modified  = $file.LastWriteTime
        Accessed  = $file.LastAccessTime
    }
} | Export-Csv -Path $outputCsv -NoTypeInformation
