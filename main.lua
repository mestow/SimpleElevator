--[[
Author
Made by TheMeMuX
Upgraded by mestow
]]




function Initialize(a_Plugin)
	a_Plugin:SetName("SimpleElevator");
	a_Plugin:SetVersion(1);
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_MOVING, JugadorSalta);
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_CROUCHED, JugadorAgacha);


	-- Load the InfoReg shared library:
	dofile(cPluginManager:GetPluginsPath() .. "/InfoReg.lua")

	
	LOG("Initialized " .. a_Plugin:GetName() .. " v" .. a_Plugin:GetVersion())
	return true;
end


function JugadorSalta(Player, OldPosition, NewPosition, PreviousIsOnGround) -- If player jump

		a_Delta = OldPosition - NewPosition;
		if (a_Delta.y < 0) then
		if PreviousIsOnGround == true then
		if Player:GetWorld():GetBlock(Vector3i(OldPosition.x-1, OldPosition.y-1, OldPosition.z)) == E_BLOCK_IRON_BLOCK and Player:GetWorld():GetBlock(Vector3i(OldPosition.x-1, OldPosition.y-2, OldPosition.z)) == E_BLOCK_SEA_LANTERN then			
				for i = OldPosition.y, Player:GetWorld():GetHeight(OldPosition.x-1, OldPosition.z), 1 do			
						if Player:GetWorld():GetBlock(Vector3i(OldPosition.x-1, i, OldPosition.z)) == E_BLOCK_IRON_BLOCK and Player:GetWorld():GetBlock(Vector3i(OldPosition.x-1, OldPosition.y-2, OldPosition.z)) == E_BLOCK_SEA_LANTERN then

							Player:TeleportToCoords(OldPosition.x, i+1, OldPosition.z)
							Player:SendAboveActionBarMessage("§6UP")
							return true
						end
					end
				end
			end
		end
	return false
end

function JugadorAgacha(Player) -- If player shift
OldPosition = Player:GetPosition()
	if Player:GetWorld():GetBlock(Vector3i(OldPosition.x-1, OldPosition.y-1, OldPosition.z)) == E_BLOCK_IRON_BLOCK and Player:GetWorld():GetBlock(Vector3i(OldPosition.x-1, OldPosition.y-2, OldPosition.z)) == E_BLOCK_SEA_LANTERN then
		local i = OldPosition.y-2
		while i >= 3 do
			if Player:GetWorld():GetBlock(Vector3i(OldPosition.x-1, i, OldPosition.z))	== E_BLOCK_IRON_BLOCK and Player:GetWorld():GetBlock(Vector3i(OldPosition.x-1, OldPosition.y-2, OldPosition.z)) == E_BLOCK_SEA_LANTERN then
				Player:TeleportToCoords(OldPosition.x, i+1, OldPosition.z)
				Player:SendAboveActionBarMessage("§cDown")
				Player:SetInvulnerableTicks(14)
				return true
			end
			i = i - 1
		end
	end
end

