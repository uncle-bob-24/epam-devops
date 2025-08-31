Connect-AzAccount

#VNet1 Variables 
$RG1 = "cmaz-65725fc3-mod2-rg-01"
$Location1 = "East US"
$VNetName1 = "cmaz-65725fc3-mod2-vnet-01"
$FESubName1 = "frontend-01"
$VNetPrefix1 = "10.2.0.0/16"
$FESubPrefix1 = "10.2.0.0/24"
$GWSubPrefix1 = "10.2.255.0/27"
$GWName1 = "cmaz-65725fc3-mod2-vpng-01"
$GWIPName1 = "cmaz-65725fc3-mod2-pip-01"
$GWIPconfName1 = "gwipconf1"
$Connection12 = "cmaz-65725fc3-mod2-vcn-01"

#VNet2 Variables
$RG2 = "cmaz-65725fc3-mod2-rg-02"
$Location2 = "West US"
$VnetName2 = "cmaz-65725fc3-mod2-vnet-02"
$FESubName2 = "frontend-02"
$VnetPrefix2 = "10.24.0.0/16"
$FESubPrefix2 = "10.24.0.0/24"
$GWSubPrefix2 = "10.24.255.0/27"
$GWName2 = "cmaz-65725fc3-mod2-vpng-02"
$GWIPName2 = "cmaz-65725fc3-mod2-pip-02"
$GWIPconfName2 = "gwipconf2"
$Connection21 = "cmaz-65725fc3-mod2-vcn-02"
$TagName = "Creator"
$TagValue = "azamat_kireyev@epam.com"

#Create the resource group
New-AzResourceGroup -Name $RG1 -Location $Location1

#Create subnet config
$fesub1 = New-AzVirtualNetworkSubnetConfig -Name $FESubName1 -AddressPrefix $FESubPrefix1
$gwsub1 = New-AzVirtualNetworkSubnetConfig -Name "GatewaySubnet" -AddressPrefix $GWSubPrefix1

#Create TestVNet1.
New-AzVirtualNetwork -Name $VNetName1 -ResourceGroupName $RG1 -Location $Location1 -AddressPrefix $VNetPrefix1 -Subnet $fesub1,$gwsub1

#Request a public IP address
$gwpip1 = New-AzPublicIpAddress -Name $GWIPName1 -ResourceGroupName $RG1 -Location $Location1 -AllocationMethod Static -Sku Standard

#Create the gateway configuration
$vnet1 = Get-AzVirtualNetwork -Name $VNetName1 -ResourceGroupName $RG1
$subnet1 = Get-AzVirtualNetworkSubnetConfig -Name "GatewaySubnet" -VirtualNetwork $vnet1
$gwipconf1 = New-AzVirtualNetworkGatewayIpConfig -Name $GWIPconfName1 -Subnet $subnet1 -PublicIpAddress $gwpip1

#Create the gateway for TestVNet1
New-AzVirtualNetworkGateway -Name $GWName1 -ResourceGroupName $RG1 -Location $Location1 -IpConfigurations $gwipconf1 -GatewayType Vpn -VpnType RouteBased -GatewaySku VpnGw2AZ -VpnGatewayGeneration "Generation2"

#VNet2
#Create a resource group
New-AzResourceGroup -Name $RG2 -Location $Location2

#Create the subnet configurations
$fesub2 = New-AzVirtualNetworkSubnetConfig -Name $FESubName2 -AddressPrefix $FESubPrefix2
$gwsub2 = New-AzVirtualNetworkSubnetConfig -Name "GatewaySubnet" -AddressPrefix $GWSubPrefix2

#Create TestVNet2
New-AzVirtualNetwork -Name $VnetName2 -ResourceGroupName $RG2 -Location $Location2 -AddressPrefix $VnetPrefix2 -Subnet $fesub2,$gwsub2

#Request a public IP address
$gwpip2 = New-AzPublicIpAddress -Name $GWIPName2 -ResourceGroupName $RG2 -Location $Location2 -AllocationMethod Static -Sku Standard

#Create the gateway configuration
$vnet2 = Get-AzVirtualNetwork -Name $VnetName2 -ResourceGroupName $RG2
$subnet2 = Get-AzVirtualNetworkSubnetConfig -Name "GatewaySubnet" -VirtualNetwork $vnet2
$gwipconf2 = New-AzVirtualNetworkGatewayIpConfig -Name $GWIPconfName2 -Subnet $subnet2 -PublicIpAddress $gwpip2

#Create the TestVNet2 gateway
New-AzVirtualNetworkGateway -Name $GWName2 -ResourceGroupName $RG2 -Location $Location2 -IpConfigurations $gwipconf2 -GatewayType Vpn -VpnType RouteBased -GatewaySku VpnGw2AZ -VpnGatewayGeneration "Generation2"

#Get both virtual network gateways
$vnet1gw = Get-AzVirtualNetworkGateway -Name $GWName1 -ResourceGroupName $RG1
$vnet2gw = Get-AzVirtualNetworkGateway -Name $GWName2 -ResourceGroupName $RG2

New-AzVirtualNetworkGatewayConnection -Name $Connection12 -ResourceGroupName $RG1 -VirtualNetworkGateway1 $vnet1gw -VirtualNetworkGateway2 $vnet2gw -Location $Location1 -ConnectionType Vnet2Vnet -SharedKey 'AzureA1b2C3'

New-AzVirtualNetworkGatewayConnection -Name $Connection21 -ResourceGroupName $RG2 -VirtualNetworkGateway1 $vnet2gw -VirtualNetworkGateway2 $vnet1gw -Location $Location2 -ConnectionType Vnet2Vnet -SharedKey 'AzureA1b2C3'

#checking the connection
Get-AzVirtualNetworkGatewayConnection -Name $Connection12 -ResourceGroupName $RG1
Get-AzVirtualNetworkGatewayConnection -Name $Connection21 -ResourceGroupName $RG2