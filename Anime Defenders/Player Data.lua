local sharedata = require(game:GetService("ReplicatedStorage").Modules.Bins.SharedData)

local GetPlayerLevelFromXp = function()
	return tonumber(module.sharedata.GetPlayerLevelFromXp(string.match(game:GetService("Players").LocalPlayer.PlayerGui.HUD.Toolbar.XPBar.XPAmount.Text, "%((%d+) / %d+ XP%)")))
end

local GetPlayerXpFromLevel = function()
	return tonumber(module.sharedata.GetPlayerLevelFromXp(game:GetService("Players").LocalPlayer.leaderstats["\240\159\148\165 Level"].Value))
end

local CanTeleportToTradeLobby = function()
	local level_data = game:GetService("Players").LocalPlayer.leaderstats["\240\159\148\165 Level"].Value
	if level_data < sharedata.TRADING_PLACE_LEVEL_REQUIREMENT then
		return false
	end
	return true
end
