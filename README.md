# PowerShell

I've found over the years that I've created PowerShell scripts to make administration of different tasks easier.  I've pulled bits a pieces from other scripts around the internet and from coworkers and made them my own to complete specific tasks required.  


host_selection_GUI.ps1

This script provides an simple way for a user to toggle between static hosts entries and DNS records.  It was created for development team that needed to make changes to their hosts files regularly and they always managed to have their hosts files set the wrong way.  This Powershell script creates a GUI with options for either static or dynamic hosts and checks that the script was run with adminstrative rights.  Upon completion, the script flushes the DNS records on the client.  To simplify it for the end user, I ran this through PS2EXE to create an executable that the end users could execute by double clicking on it.

