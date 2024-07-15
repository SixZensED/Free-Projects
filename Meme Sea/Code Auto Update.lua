local data_code = require(game:GetService("ReplicatedStorage").ModuleScript.CodeList)
local get_code = {}
table.foreach(data_code,function(index,value)
	if value.Status == true and type(value.Status) == "boolean" and not get_code[index] then
		table.insert(get_code,index)
	end
end)

table.foreach(get_code,print)
