# LOAD RESOURCES
Add-Type -AssemblyName System.Windows.Forms

# RUNNING LOGIC
$SendAction = {
    param($inputField)
    $text = $inputField.Text.Trim()
    
    if ([string]::IsNullOrWhiteSpace($text)) {
        [System.Windows.Forms.MessageBox]::Show("CONTENT CANNOT BE EMPTY")
        return
    }
	
	# Logging Records
	$logPath = Join-Path $PSScriptRoot "SendAction.tmp"
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
	
    [System.Windows.Forms.MessageBox]::Show("SEND WILL START IN 3 SECONDS. PLEASE SWITCH TO THE TARGET WINDOW.")
    Start-Sleep -Seconds 3
    
    try {
        [System.Windows.Forms.SendKeys]::SendWait($text)
		
		# Logging 
		"$timestamp | SENT: $text" | Out-File -FilePath $logPath -Append -Encoding UTF8
		[System.Windows.Forms.Clipboard]::Clear()
		[System.Windows.Forms.Clipboard]::SetText($text)
		
		# Delay
		[System.Windows.Forms.SendKeys]::SendWait("^f")
		Start-Sleep -Milliseconds 500
		[System.Windows.Forms.SendKeys]::SendWait("^v{ENTER}")
		Start-Sleep -Milliseconds 300
		[System.Windows.Forms.SendKeys]::SendWait("{ESC}")
		
    } catch {
        [System.Windows.Forms.MessageBox]::Show("ERROR SENDING KEYS: " + $_.Exception.Message)
    }
}

# UI CONFIGURATION
function Show-KeySenderUI {
    $form = New-Object System.Windows.Forms.Form -Property @{
        Text = "SENDKEYS TOOL V2.0"
        Size = "300,180"
        StartPosition = "CenterScreen"
        TopMost = $true  # OPTIONAL: KEEPS TOOL ON TOP FOR EASIER SWITCHING
    }

    $label = New-Object System.Windows.Forms.Label -Property @{
        Text = "ENTER KEYS TO SEND:"
        Location = "10,20"
        AutoSize = $true
    }

    $txtInput = New-Object System.Windows.Forms.TextBox -Property @{
        Location = "10,45"
        Size = "260,20"
    }

    $btnSend = New-Object System.Windows.Forms.Button -Property @{
        Text = "SEND"
        Location = "10,80"
    }

    # BIND EVENT: CALL LOGIC LAYER
    $btnSend.Add_Click({ &$SendAction -inputField $txtInput })

    # ADD CONTROLS
    $form.Controls.AddRange(@($label, $txtInput, $btnSend))
    
    # EXECUTE
    $form.ShowDialog()
}

# RUN APPLICATION
Show-KeySenderUI