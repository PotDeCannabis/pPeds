--- pPeds | Par YelSDev | Pots#0106 ---
--- https://discord.gg/YzrwD9qNsS ---

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local ClientPlayer, ServerPlayer, IsSpawned = PlayerId(), GetPlayerServerId(PlayerId()), true

RegisterNetEvent('setped')
AddEventHandler('setped', function(ped)
local hash = GetHashKey(ped)
	RequestModel(hash)
	while not HasModelLoaded(hash)
			do RequestModel(hash)
				Citizen.Wait(0)
			end	
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

TriggerEvent('chat:addSuggestion', Settings.DeletePed.command2, Settings.DeletePed.description, {
    { name="id", help=Settings.DeletePed['id'] },
    { name="supprimer", help=Settings.DeletePed['deleteFromDatabase'] }
})

TriggerEvent('chat:addSuggestion', Settings.chatSuggestion.command, Settings.chatSuggestion.description, {
    { name="id", help=Settings.chatSuggestion['id'] },
    { name="ped", help=Settings.chatSuggestion['ped'] }
})

RegisterNetEvent('delete:ped')
AddEventHandler('delete:ped', function()
	local hash2 = GetHashKey('mp_m_freemode_01')
	RequestModel(hash2)
	while not HasModelLoaded(hash2)
			do RequestModel(hash2)
				Citizen.Wait(0)
			end
	SetPlayerModel(ClientPlayer, hash2)
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
    TriggerEvent('skinchanger:loadSkin', skin)
    end)
end)

AddEventHandler('playerSpawned', function()
   local loaded = true
   if IsSpawned then
   	   while loaded do
   	   	   Citizen.Wait(5000)
   	   	   if ServerPlayer ~= nil then
   	   	   	   loaded = false
   	   	   	   TriggerServerEvent('setPed:onSpawn', ServerPlayer)
       		   IsSpawned = false
   	   	   end
      end
   end
end)
