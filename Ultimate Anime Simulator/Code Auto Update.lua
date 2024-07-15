local code_data = game:GetService("ReplicatedStorage").Configuration.CodeData.Value
local get_code = game:GetService("HttpService"):JSONDecode(code_data)

for i,v in pairs(get_code) do
	print(i)
end
