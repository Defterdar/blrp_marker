-- https://runtime.fivem.net/doc/natives/?_0x28477EC23D892089
-- locations set in config.lua

local QBCore = exports['qb-core']:GetCoreObject()

local function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
	DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
	ClearDrawOrigin()
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for i = 1, #config, 1 do
			loc = locations[i]
                
			local playerCoord = GetEntityCoords(PlayerPedId(), false)
			local locVector = vector3(loc.pos.x, loc.pos.y, loc.pos.z)

			if loc.job == QBCore.Functions.GetPlayerData().job.name or loc.job == "" then
				if Vdist2(playerCoord, locVector) < 150 then
					DrawMarker(loc.marker,loc.pos.x,loc.pos.y,loc.pos.z-0.75,0.0,0.0,0.0,0.0,0.0,0.0,loc.scale,loc.scale,loc.scale,loc.rgba[1],loc.rgba[2],loc.rgba[3],loc.rgba[4],false,true,2,nil,nil,false)
				end
                    
				if Vdist2(playerCoord, locVector) < loc.dist then
					DrawText3D(loc.pos.x,loc.pos.y,loc.pos.z,loc.text)
				end
			end
		end
	end
end)
