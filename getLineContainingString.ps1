# Script : Get line containing string from big file
# Author : abdallah.benbrahim@gmail.com

# Get file name
[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
$dialog = New-Object System.Windows.Forms.OpenFileDialog
$dialog.DefaultExt = '.txt'
$dialog.Filter = 'All Files | *.*'
$dialog.FilterIndex = 0
$dialog.InitialDirectory = $home
$dialog.Multiselect = $false
$dialog.RestoreDirectory = $true
$dialog.Title = "Select a text file"
$dialog.ValidateNames = $true
$dialog.ShowDialog()
$fileName = $dialog.FileName

# Get word to find
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

$objForm = New-Object System.Windows.Forms.Form 
$objForm.Text = "Recherche"
$objForm.Size = New-Object System.Drawing.Size(300,200) 
$objForm.StartPosition = "CenterScreen"

$objForm.KeyPreview = $True
$objForm.Add_KeyDown({if ($_.KeyCode -eq "Enter") 
    {$wordToFind=$objTextBox.Text;$objForm.Close()}})
$objForm.Add_KeyDown({if ($_.KeyCode -eq "Escape") 
    {$objForm.Close()}})

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Size(75,120)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.Add_Click({$wordToFind=$objTextBox.Text;$objForm.Close()})
$objForm.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Size(150,120)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Cancel"
$CancelButton.Add_Click({$objForm.Close()})
$objForm.Controls.Add($CancelButton)

$objLabel = New-Object System.Windows.Forms.Label
$objLabel.Location = New-Object System.Drawing.Size(10,20) 
$objLabel.Size = New-Object System.Drawing.Size(280,20) 
$objLabel.Text = "Merci de saisir la chaine à rechercher : "
$objForm.Controls.Add($objLabel) 

$objTextBox = New-Object System.Windows.Forms.TextBox 
$objTextBox.Location = New-Object System.Drawing.Size(10,40) 
$objTextBox.Size = New-Object System.Drawing.Size(260,20) 
$objForm.Controls.Add($objTextBox) 

$objForm.Topmost = $True

$objForm.Add_Shown({$objForm.Activate()})
[void] $objForm.ShowDialog()

If (Test-Path "$env:temp\$wordToFind.txt"){
	Clear-Content "$env:temp\$wordToFind.txt"
}

# Start a reseach
gc $fileName | % { if($_ -match $wordToFind) { add-content "$env:temp\$wordToFind.txt" $_}}