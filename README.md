# ESX 1.2 VIP citizens // Dutch Players Edit
-Ability to give a VIP status to a player if you want to enable some features to a limited part of your community.

Exemple : Give VIP status to a player that has donated a certain ammount of money to help the community so he can access a new vehicle shop.

# HOW TO INSTALL AND USE
# Simply use the VIP Callback on any part of your code that you want to block for vip users
Admins only: /addvip & /delvip


					ESX.TriggerServerCallback('pxrp_vip:getVIPStatus', function(isVIP)
						if isVIP then
							OpenShopMenu()
						else
							ESX.ShowNotification("Your character doesn't have the VIP access, please check discord for more information.")
						end
					end, GetPlayerServerId(PlayerId()), '1')


Full credits to original creator.


