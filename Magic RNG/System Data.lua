local quick_roll = function(args)
	if args then
		game:GetService("Players").LocalPlayer:SetAttribute("FastRoll","K_ON")
	else
		game:GetService("Players").LocalPlayer:SetAttribute("FastRoll","K_FF")
	end
end

local hide_players = function(args)
	game:GetService("ReplicatedStorage").HideAllPlayerFlag.Value = args
end
