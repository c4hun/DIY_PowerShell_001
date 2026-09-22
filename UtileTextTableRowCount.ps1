# Set the reference date (based on the current system date: 2026-09-22)
$Today = Get-Date

# Define the schedule and date ranges for the five major monthly sections
$ScheduleData = @(
    @{ Id = "001"; Title = "W1: STORE SETUP & FLOOR RESET"; Start = [datetime]"2026-09-01"; End = [datetime]"2026-09-07"; Status = "COMPLETED" },
    @{ Id = "002"; Title = "W2: PROMOTIONAL ROLLOUT"; Start = [datetime]"2026-09-08"; End = [datetime]"2026-09-14"; Status = "COMPLETED" },
    @{ Id = "003"; Title = "W3: MID-MONTH RE-ZONING"; Start = [datetime]"2026-09-15"; End = [datetime]"2026-09-21"; Status = "COMPLETED" },
    @{ Id = "004"; Title = "W4: INVENTORY AUDIT & RECOVERY"; Start = [datetime]"2026-09-22"; End = [datetime]"2026-09-28"; Status = "IN PROGRESS" },
    @{ Id = "005"; Title = "W5: MONTH-END CLOSE & TRANSITION"; Start = [datetime]"2026-09-29"; End = [datetime]"2026-09-30"; Status = "PLANNED" }
)

Write-Host "+---------------------------------------------------------------------+"
Write-Host "| [AUTOMATED RETAIL SCHEDULE] Filtered by Today: $($Today.ToString('yyyy-MM-dd')) |"
Write-Host "+---------------------------------------------------------------------+"

# Determine whether each schedule item should be displayed or highlighted
foreach ($item in $ScheduleData) {
    # Logic: If the current week is active, highlight it; otherwise, mark it as archived
    $isCurrentWeek = ($Today -ge $item.Start) -and ($Today -le $item.End)
    
    if ($isCurrentWeek) {
        $marker = "==> [ACTIVE WEEK]"
    } else {
        $marker = "    [ARCHIVED]   "
    }

    # Output the formatted result
    Write-Host "$marker [$($item.Id)] $($item.Title)"
    Write-Host "      Date: $($item.Start.ToString('MM/dd')) - $($item.End.ToString('MM/dd')) | Status: [$($item.Status)]"
}
Write-Host "+---------------------------------------------------------------------+"
