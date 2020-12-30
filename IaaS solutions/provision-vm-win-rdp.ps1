# login to azure account
Connect-AzAccount -SubscriptionName 'demo-sub'

# set subsciption
Set-AzContext -SubscriptionName 'demo-sub'

# create resouce group
New-AzResourceGroup -Name "demo-win-rg" -Location "centralindia"

#create credentials for vm
$username = 'demoadmin'
$password = ConvertTo-SecureString 'password1234%^&*' -AsPlainText -Force
$WindowsCred = New-Object System.Management.Automantion.PSCredential ($username, $password)

# create a virtual machine & open ssh port 3389
New-AzVM `
    -ResourceGroupName 'demo-win-rg' `
    -Name 'demo-win-vm' `
    -Size 'Standard_B1ls' `
    -Image 'Win2019Datacenter'
    -Credentials $WindowsCred
    -OpenPorts 3389

# get public ip of vm
Get-AzPublicIpAddress `
    -ResourceGroupName 'demo-win-rg' `
    -Name 'demo-win-vm' | Select-Object Get-AzPublicIpAddress

# clean up deployment
Remove-AzResourceGroup -Name 'demo-win-rg'