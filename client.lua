ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- Vérifications

AddEventHandler("playerSpawned", function()
	local loaded = true
	if IsSpawned then
		while loaded do
			Citizen.Wait(5000)
			if ServerPlayer ~= nil then
					loaded = false
					TriggerServerEvent("pPeds:onSpawn", ServerPlayer)
			IsSpawned = false
			end
	    end
	end
 end)

-- Variables

local ClientPlayer, ServerPlayer, IsSpawned = PlayerId(), GetPlayerServerId(PlayerId()), true

-- TriggerClientEvent

RegisterNetEvent("pPeds:deletePed")
AddEventHandler("pPeds:deletePed", function()
	local hash2 = GetHashKey("mp_m_freemode_01")
	RequestModel(hash2)
	while not HasModelLoaded(hash2)
		do RequestModel(hash2) Citizen.Wait(0) end
		SetPlayerModel(ClientPlayer, hash2)
		ESX.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
		TriggerEvent("skinchanger:loadSkin", skin)
    end)
end)

RegisterNetEvent("pPeds:setPed")
AddEventHandler("pPeds:setPed", function(ped)
	local hash = GetHashKey(ped)

	RequestModel(hash)
	while not HasModelLoaded(hash) do RequestModel(hash) Citizen.Wait(0) end	
	SetPlayerModel(ClientPlayer, hash)
	SetPedDefaultComponentVariation(PlayerPedId())
	ClearAllPedProps(PlayerPedId())
	ClearPedDecorations(PlayerPedId())
	ClearPedFacialDecorations(PlayerPedId())
	SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 0)
	Wait(500)
	SetPedComponentVariation(PlayerPedId(), 0, 0, 1, 0)
	Wait(500)
	SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 0)
	SetModelAsNoLongerNeeded(hash)
end)

-- Commandes (Addons)

TriggerEvent("chat:addSuggestion", "/deleteped", "Supprimer le ped du joueur.", {
    { name = "id", help = "Id du joueur." }
})

TriggerEvent("chat:addSuggestion", "/setped", "Ajouter un ped au joueur.", {
    { name = "id", help = "Id du joueur." },
    { name = "ped", help = "Taper le nom du ped." }
})