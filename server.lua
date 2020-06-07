ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetIdentifierWithoutLicense(Identifier)
    return string.gsub(Identifier, "license:", "")
end


ESX.RegisterServerCallback('pxrp_vip:getVIPStatus', function(source, cb)
	local license = GetPlayerIdentifiers(source)[2]
	local identifier = string.gsub(license, "license:", "")

	MySQL.Async.fetchScalar('SELECT vip FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(vip)
		if vip then
			print(('pxrp_vip: %s VIP status has been reset for the player!'):format(identifier))
		end

		cb(vip)
	end)
end)

RegisterServerEvent('pxrp_vip:setVIPStatus')
AddEventHandler('pxrp_vip:setVIPStatus', function(vip)
	local license = GetPlayerIdentifiers(source)[2]
	local identifier = string.gsub(license, "license:", "")

	if type(vip) ~= 'boolean' then
		print(('pxrp_vip: %s attempted to parse something else than a boolean to setVIPStatus!'):format(identifier))
		return
	end

	MySQL.Sync.execute('UPDATE users SET vip = @vip WHERE identifier = @identifier', {
		['@identifier'] = identifier,
		['@vip'] = vip
	})
end)


ESX.RegisterCommand('addvip', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('pxrp_vip:addVIPStatus')
	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(158, 35, 35, 0.4); border-radius: 3px;"><i class="fas fa-globe"></i> <b>[BEWONER TOEGEVOEGD ALS VIP]</b></i></div>'
		})	
end, true, {help = 'Voeg een VIP bewoner toe', validate = true, arguments = {
	{name = 'playerId', help = 'The player id', type = 'player'}
}})

ESX.RegisterCommand('delvip', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('pxrp_vip:removeVIPStatus')
	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(158, 35, 35, 0.4); border-radius: 3px;"><i class="fas fa-globe"></i> <b>[BEWONER VERWIJDERD ALS VIP]</b></i></div>'
		})	
end, true, {help = 'Verwijder een VIP bewoner', validate = true, arguments = {
	{name = 'playerId', help = 'The player id', type = 'player'}
}})