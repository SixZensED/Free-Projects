local data_quest = require(game:GetService("ReplicatedStorage").ModuleScript.Quest_Settings)

local check_level = function()
	local my_level = game:GetService("Players").LocalPlayer.PlayerData.Level
	local data_level = {}
	for index,value in pairs(data_quest) do
		if tonumber(value.LevelNeed) < tonumber(my_level.Value) then
			table.insert(data_level,value.LevelNeed)
		else
			table.insert(data_level,1)
		end
	end
	return math.max(unpack(data_level))
end

local check_instance = function()
	for index,value in pairs(data_quest) do
		if value.LevelNeed == check_level() and not value.Special_Quest  then
			return {mob = value.Target,quest = index}
		end
	end
end
