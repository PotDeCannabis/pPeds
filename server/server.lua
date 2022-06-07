--- pPeds | Par YelSDev | Pots#0106 ---
--- https://discord.gg/YzrwD9qNsS ---

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function FindIdentifier(id)
	iden = ESX.GetPlayerFromId(id).identifier
	return iden
end

RegisterCommand(Settings.DeletePed.command, function(source, args)
	id = args[1]
	deleteFromDatabase = args[2]
	local Player = ESX.GetPlayerFromId(id)
	local Admin = ESX.GetPlayerFromId(source)
	if Admin.getGroup() == Settings.RequiredGroup['group1'] or Admin.getGroup() == Settings.RequiredGroup['group2'] or Admin.getGroup() == Settings.RequiredGroup['group3'] or Admin.getGroup() == Settings.RequiredGroup['group4'] or Admin.getGroup() == Settings.RequiredGroup['group5'] or Admin.getGroup() == Settings.RequiredGroup['group6'] then
		if id ~= nil and Player ~= nil then
			if deleteFromDatabase == 'true' then
				TriggerClientEvent('delete:ped', id)
				MySQL.Async.execute('UPDATE users SET ped = @ped WHERE identifier = @steamid', {
				['@ped'] = Settings.DefaultPedDB,
				['@steamid'] = FindIdentifier(id)
				})
			end
		end
	end
end)

RegisterCommand(Settings.command, function(source, args)
	id = args[1]
	ped = args[2]
	local Admin = ESX.GetPlayerFromId(source)
	local Player = ESX.GetPlayerFromId(id)

    if Admin.getGroup() == Settings.RequiredGroup['group1'] or Admin.getGroup() == Settings.RequiredGroup['group2'] or Admin.getGroup() == Settings.RequiredGroup['group3'] or Admin.getGroup() == Settings.RequiredGroup['group4'] or Admin.getGroup() == Settings.RequiredGroup['group5'] or Admin.getGroup() == Settings.RequiredGroup['group6'] then
    	if id ~= nil and Player ~= nil then
			if ped ~= nil then
				TriggerClientEvent('setped', id, ped)
				MySQL.Async.execute('UPDATE users SET ped = @ped WHERE identifier = @steamid', {
	       		['@steamid'] = FindIdentifier(id),
        		['@ped'] = ped,
	    		})
			end
		end
	end
end)

RegisterServerEvent('setPed:onSpawn')
AddEventHandler('setPed:onSpawn', function(id)  
	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @steamid',{
	['@steamid'] = FindIdentifier(id),
	}, function(result)
	if result[1].ped ~= Settings.DefaultPedDB then
		TriggerClientEvent('setped', id, result[1].ped)
    end
  end)
end)