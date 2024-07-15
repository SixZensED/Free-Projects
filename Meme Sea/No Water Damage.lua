local old 
old = hookmetamethod(game,"__namecall",function(...)
	local Self = ...
	if tostring(Self) == "WaterDamage" then
		return nil
	end
	return old(...)
end)
