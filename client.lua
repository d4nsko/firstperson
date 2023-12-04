-- Credits JiminyKroket

Citizen.CreateThread(function()
  local unarmedHash = `WEAPON_UNARMED`;
  while true do
    local sleep = 500
    local wep = GetSelectedPedWeapon(PlayerPedId());
    if (wep~=unarmedHash) then
      sleep = 100
      local camMode = (GetVehiclePedIsUsing(PlayerPedId(), true) ~= 0 and GetFollowVehicleCamViewMode()) or GetFollowPedCamViewMode()
      if camMode ~= 4 then
        sleep = 0
        DisableControlAction(0, 24, true)
        DisableControlAction(0, 69, true)
        DisableControlAction(0, 70, true)
        DisableControlAction(0, 92, true)
        DisableControlAction(0, 257, true)
        DisableControlAction(0, 331, true)
      end
    end
    Wait(sleep)
  end
end)

local shot = false
local check = false
local check2 = false
local count = 0

--aiming
Citizen.CreateThread(function()
	while true do
		SetBlackout(false)
		Citizen.Wait( 1 )
		if IsPlayerFreeAiming(PlayerId()) then
		    if GetFollowPedCamViewMode() == 4 and check == false then
			    check = false
			else
			    SetFollowPedCamViewMode(4)
			    check = true
			end
		else
		    if check == true then
		        SetFollowPedCamViewMode(1)
				check = false
			end
		end
	end
end )


--shooting
Citizen.CreateThread(function()
	while true do
		SetBlackout(false)
		Citizen.Wait( 1 )
		
		if IsPedShooting(GetPlayerPed(-1)) and shot == false and GetFollowPedCamViewMode() ~= 4 then
			check2 = true
			shot = true
			SetFollowPedCamViewMode(4)
		end
		
		if IsPedShooting(GetPlayerPed(-1)) and shot == true and GetFollowPedCamViewMode() == 4 then
			count = 0
		end
		
		if not IsPedShooting(GetPlayerPed(-1)) and shot == true then
		    count = count + 1
		end

        if not IsPedShooting(GetPlayerPed(-1)) and shot == true then
			if not IsPedShooting(GetPlayerPed(-1)) and shot == true and count > 20 then
		        if check2 == true then
				    check2 = false
					shot = false
					SetFollowPedCamViewMode(1)
				end
			end
		end	    
	end
end )
