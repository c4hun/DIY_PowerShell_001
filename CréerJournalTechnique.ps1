$Date = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
$FilenameDate = Get-Date -Format 'yyyyMMdd_HHmmss'

$Log = @"
=== JOURNAL TECHNIQUE ===
Date    : $Date
Action  : Suppression des fichiers .tmp
Result  : OK
"@

$LogPath = "C:\...\JournalTech_$FilenameDate.txt"
$Log | Out-File -FilePath $LogPath -Encoding UTF8
