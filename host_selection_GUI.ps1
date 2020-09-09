###
###  Server variables for 4 separate hosts and their internal IP addresses

$Hostname1 = "server1.domain.com"
$HostIP1 = 	"10.1.1.5"

$Hostname2 = "server2.domain.com"
$HostIP2 = "10.1.1.37"

$Hostname3 = "server3.domain.com"
$HostIP3 = "10.1.1.21"

$Hostname4 = "server4.domain.com"
$HostIP4 = "10.1.1.53"


#############################################################
#############  NO VARIABLES NEED TO BE EDITED BELOW THIS LINE


$escapedHostname1 = [Regex]::Escape($Hostname1)
$escapedHostname2 = [Regex]::Escape($Hostname2)
$escapedHostname3 = [Regex]::Escape($Hostname3)
$escapedHostname4 = [Regex]::Escape($Hostname4)

$hostsFilePath = "$($Env:WinDir)\system32\Drivers\etc\hosts"
$hostsFile = Get-Content $hostsFilePath



### Test if the script was run as an administrator

function Test-Admin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}


### Response if the script was not run as an administrator

function Not_Elevated
	{
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    
    # Set the size of your form
    $Form = New-Object System.Windows.Forms.Form
    $Form.width = 400
    $Form.height = 300
    $Form.Text = "WARNING"
    # Set the font of the text to be used within the form
    $Font = New-Object System.Drawing.Font("Times New Roman",12)
    $Form.Font = $Font
    # Create a group that will contain your radio buttons
    $MyGroupBox = New-Object System.Windows.Forms.GroupBox
    $MyGroupBox.Location = '40,30'
    $MyGroupBox.size = '300,110'
    $MyGroupBox.text = "Can not run without admin rights.  Right click on the file and run as an administrator."
	# Add an OK button
    $OKButton = new-object System.Windows.Forms.Button
    $OKButton.Location = '140,200'
    $OKButton.Size = '100,40'
    $OKButton.Text = 'OK'
    $OKButton.DialogResult=[System.Windows.Forms.DialogResult]::OK
	# Assign the Accept and Cancel options in the form to the corresponding buttons
    
	
	
	
	$form.AcceptButton = $OKButton
    #$form.CancelButton = $CancelButton
	$form.Controls.AddRange(@($MyGroupBox,$OKButton))
    # Activate the form
    $form.Add_Shown({$form.Activate()})    
    
	
    # Get the results from the button click
    $dialogResult = $form.ShowDialog()
    # If the OK button is selected
    if ($dialogResult -eq "OK")
		{
		
        }
	}

### 
function Host_Selection
	{
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    
    # Set the size of your form
    $Form = New-Object System.Windows.Forms.Form
    $Form.width = 500
    $Form.height = 300
    $Form.Text = "Modify Hosts File"
    # Set the font of the text to be used within the form
    $Font = New-Object System.Drawing.Font("Times New Roman",12)
    $Form.Font = $Font
    # Create a group that will contain your radio buttons
    $MyGroupBox = New-Object System.Windows.Forms.GroupBox
    $MyGroupBox.Location = '40,30'
    $MyGroupBox.size = '400,110'
    $MyGroupBox.text = "Do you want to set the IP of the servers to Internal or Public?"
    
    # Create the collection of radio buttons
    $RadioButton1 = New-Object System.Windows.Forms.RadioButton
    $RadioButton1.Location = '20,40'
    $RadioButton1.size = '350,20'
    $RadioButton1.Checked = $true
    $RadioButton1.Text = "Internal - VPN or on the company network"
    $RadioButton2 = New-Object System.Windows.Forms.RadioButton
    $RadioButton2.Location = '20,70'
    $RadioButton2.size = '350,20'
    $RadioButton2.Checked = $false
    $RadioButton2.Text = "Public - no VPN required"

    # Add an OK button

    $OKButton = new-object System.Windows.Forms.Button
    $OKButton.Location = '130,200'
    $OKButton.Size = '100,40'
    $OKButton.Text = 'OK'
    $OKButton.DialogResult=[System.Windows.Forms.DialogResult]::OK
    #Add a cancel button
    $CancelButton = new-object System.Windows.Forms.Button
    $CancelButton.Location = '255,200'
    $CancelButton.Size = '100,40'
    $CancelButton.Text = "Cancel"
    $CancelButton.DialogResult=[System.Windows.Forms.DialogResult]::Cancel
 
    # Add all the GroupBox controls on one line
    $MyGroupBox.Controls.AddRange(@($Radiobutton1,$RadioButton2))
    # Add all the Form controls on one line
    $form.Controls.AddRange(@($MyGroupBox,$OKButton,$CancelButton))
 
    
    # Assign the Accept and Cancel options in the form to the corresponding buttons
    $form.AcceptButton = $OKButton
    $form.CancelButton = $CancelButton
    # Activate the form
    $form.Add_Shown({$form.Activate()})    
    
    # Get the results from the button click
    $dialogResult = $form.ShowDialog()
    # If the OK button is selected
    if ($dialogResult -eq "OK"){
        
        # Check the current state of each radio button and respond accordingly
        if ($RadioButton1.Checked){
				If (($hostsFile) -notmatch ".*\s+$escapedHostname1.*")  {
					Add-HostEntry $Hostname1 $HostIP1
					start-sleep -seconds 1
				} 
				Else {}
				If (($hostsFile) -notmatch ".*\s+$escapedHostname2.*")  {
					Add-HostEntry $Hostname2 $HostIP2
					start-sleep -seconds 1
				}	 
				Else {}
				If (($hostsFile) -notmatch ".*\s+$escapedHostname3.*")  {
					Add-HostEntry $Hostname3 $HostIP3
					start-sleep -seconds 1
				} 
				Else {}
				If (($hostsFile) -notmatch ".*\s+$escapedHostname4.*")  {
					Add-HostEntry $Hostname4 $HostIP4
					start-sleep -seconds 1
				} 
				Else {}
				
           [System.Windows.Forms.MessageBox]::Show("Hosts set for Internal. You may need to close your browser and reopen it for your applications to recognize the new internal IP address." )}
        elseif ($RadioButton2.Checked){
				If (($hostsFile) -match ".*\s+$escapedHostname1.*")  {
					Remove-HostEntry $Hostname1 -ErrorAction SilentlyContinue
					start-sleep -seconds 1
				} 
				Else {}
				If (($hostsFile) -match ".*\s+$escapedHostname2.*")  {
					Remove-HostEntry $Hostname2 -ErrorAction SilentlyContinue
					start-sleep -seconds 1
				}	 
				Else {}
				If (($hostsFile) -match ".*\s+$escapedHostname3.*")  {
					Remove-HostEntry $Hostname3 -ErrorAction SilentlyContinue
					start-sleep -seconds 1
				} 
				Else {}
				If (($hostsFile) -match ".*\s+$escapedHostname4.*")  {
					Remove-HostEntry $Hostname4 -ErrorAction SilentlyContinue
					start-sleep -seconds 1
				} 
				Else {}
				

              [System.Windows.Forms.MessageBox]::Show("Hosts set for Public.  You may need to close your browser and reopen it for your applications to recognize the new public IP address." )}
        }
    }

### Load necessary PowerShell modules for the script to run
function Load-Module ($m) {

    # If module is imported say that and do nothing
    if (Get-Module | Where-Object {$_.Name -eq $m}) {
        write-host "Module $m is already imported."
    }
    else {

        # If module is not imported, but available on disk then import
        if (Get-Module -ListAvailable | Where-Object {$_.Name -eq $m}) {
            Import-Module $m -Verbose
        }
        else {

            # If module is not imported, not available on disk, but is in online gallery then install and import
            if (Find-Module -Name $m | Where-Object {$_.Name -eq $m}) {
                Install-Module -Name $m -Force -Verbose -Scope CurrentUser
                Import-Module $m -Verbose
            }
            else {

                # If module is not imported, not available and not in online gallery then abort
                write-host "Module $m not imported, not available and not in online gallery, exiting."
                EXIT 1
            }
        }
    }
}



# Call the functions

if ((Test-Admin) -eq $false)  
    {
        Not_Elevated
		write-host tried to elevate, did not work, aborting
    } 
else 
	{
		[System.Windows.Forms.MessageBox]::Show("This may take a minute to load the necessary tools.  Click OK." )
		Load-Module PSHosts
		If (($hostsFile) -match ".*\s+$escapedHostname1.*")  {
					Remove-HostEntry $Hostname1 -ErrorAction SilentlyContinue
				} 
				Else {}
				If (($hostsFile) -match ".*\s+$escapedHostname2.*")  {
					Remove-HostEntry $Hostname2 -ErrorAction SilentlyContinue
				}	 
				Else {}
				If (($hostsFile) -match ".*\s+$escapedHostname3.*")  {
					Remove-HostEntry $Hostname3 -ErrorAction SilentlyContinue
				} 
				Else {}
				If (($hostsFile) -match ".*\s+$escapedHostname4.*")  {
					Remove-HostEntry $Hostname4 -ErrorAction SilentlyContinue
				} 
				Else {}
		Host_Selection
		Clear-DnsClientCache
	}
	
exit




