local looting = false

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		if IsControlJustPressed(0,1101824977) and not IsPedInAnyVehicle(player, true) and not looting then
			local shape = true
			while shape do
				Wait(0)
				local player = PlayerPedId()
				local coords = GetEntityCoords(player)
				local entityHit = 0
				local shapeTest = StartShapeTestBox(coords.x, coords.y, coords.z, 2.0, 2.0, 2.0, 0.0, 0.0, 0.0, true, 8, player)
				local rtnVal, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(shapeTest)
				local type = GetPedType(entityHit)
				local dead = IsEntityDead(entityHit)
				local PressTime = 0
				if type == 4 and dead then
					local looted = Citizen.InvokeNative(0x8DE41E9902E85756, entityHit)
					if not looted then
						shape = false
						looting = true
						PressTime = GetGameTimer()
						while looting do
							Wait(0)
							if IsControlJustReleased(0,1101824977) then
								KeyHeldTime = GetGameTimer() - PressTime
								PressTime = 0
								if KeyHeldTime > 250 then
									looting = false
									Wait(500)
									local lootedcheck = Citizen.InvokeNative(0x8DE41E9902E85756, entityHit)
									if lootedcheck then
										local loot = math.random(10, 500)
										local lootpay = loot / 100
										local loot_xp = math.random (10,50)
										local loot_xp_pay= loot_xp / 10
										TriggerServerEvent('vorp_loot', lootpay,loot_xp_pay)
										Wait(500)
										TriggerEvent("vorp:TipBottom", 'You ~e~stole~q~ $' .. lootpay .. ' and got ' .. loot_xp_pay .. ' XP', 1500)
									else
										looting = false
									end
								else
									looting = false
								end
							end
						end
					end
				end
			end
		end
    end
end)
