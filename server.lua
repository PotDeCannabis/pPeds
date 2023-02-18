ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

-- Functions

function FindIdentifier(id)
	iden = ESX.GetPlayerFromId(id).identifier
	return iden
end

-- TriggerServerEvent

RegisterServerEvent("pPeds:onSpawn")
AddEventHandler("pPeds:onSpawn", function(id)  
	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @steamid",{
		["@steamid"] = FindIdentifier(id),
		}, function(result)
		if result[1].ped ~= "none" then
			TriggerClientEvent("pPeds:setPed", id, result[1].ped)
		end
	end)
end)

-- Commandes

RegisterCommand("deleteped", function(source, args)
	id = args[1]
	local Player = ESX.GetPlayerFromId(id)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getGroup() == "owner" or xPlayer.getGroup() == "gerantserveur" or xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == "admin" then
		if id ~= nil and Player ~= nil then
			TriggerClientEvent("pPeds:deletePed", id)
			MySQL.Async.execute("UPDATE users SET ped = @ped WHERE identifier = @steamid", {
			["@ped"] = "none",
			["@steamid"] = FindIdentifier(id)
			})
		else
			TriggerClientEvent("pPeds:deletePed", source)
			MySQL.Async.execute("UPDATE users SET ped = @ped WHERE identifier = @steamid", {
			["@ped"] = "none",
			["@steamid"] = FindIdentifier(source)
			})
		end
	end
end)

RegisterCommand("setped", function(source, args)
	id = args[1]
	ped = args[2]
	local Admin = ESX.GetPlayerFromId(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getGroup() == "owner" or xPlayer.getGroup() == "gerantserveur" or xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == "admin" then
		if id ~= nil and Player ~= nil then
			if ped ~= nil then
				TriggerClientEvent("pPeds:setPed", id, ped)
				MySQL.Async.execute("UPDATE users SET ped = @ped WHERE identifier = @steamid", {
	       		["@steamid"] = FindIdentifier(id),
        		["@ped"] = ped,
	    		})
			end
		end
	end
end)