ESX = nil
local PlayerLoaded = false
vip = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

AddEventHandler('esx:onPlayerSpawn', function()
	vip = false
	ESX.TriggerServerCallback('pxrp_vip:getVIPStatus', function(vip)
		if vip then
			while not PlayerLoaded do
				ESX.ShowNotification("Je Nitro status wordt opgehaald...")
				Citizen.Wait(1000)
			end

		ESX.ShowNotification("VIP status: Actief")
		else
		ESX.ShowNotification("Als VIP speler heb je meer mogelijkheden. Bezoek onze Discord server voor meer informatie.")
		end
	end)
end)

function addVIPStatus()
	TriggerServerEvent('pxrp_vip:setVIPStatus', true)
	vip = true
end

function removeVIPStatus()
	TriggerServerEvent('pxrp_vip:setVIPStatus', false)
	vip = false
end

RegisterNetEvent('pxrp_vip:addVIPStatus')
AddEventHandler('pxrp_vip:addVIPStatus', function()
	addVIPStatus()
end)

RegisterNetEvent('pxrp_vip:removeVIPStatus')
AddEventHandler('pxrp_vip:removeVIPStatus', function()
	removeVIPStatus()
end)
