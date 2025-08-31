$peerConfig1 = @{
    Name = "vnet-1-to-vnet-2"
    VirtualNetwork = Get-AzVirtualNetwork -Name "cloudmentor-vnet-1"
    RemoteVirtualNetworkId = (Get-AzVirtualNetwork -Name "cloudmentor-vnet-2").Id
}
Add-AzVirtualNetworkPeering @peerConfig1

$peerConfig2 = @{
    Name = "vnet-2-to-vnet-1"
    VirtualNetwork = Get-AzVirtualNetwork -Name "cloudmentor-vnet-2"
    RemoteVirtualNetworkId = (Get-AzVirtualNetwork -Name "cloudmentor-vnet-1").Id
}
Add-AzVirtualNetworkPeering @peerConfig2