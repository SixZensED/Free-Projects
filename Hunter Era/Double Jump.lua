local state = game:GetService("Players").LocalPlayer:FindFirstChild("Skills")
local doublejump = state and state:GetAttribute("DoubleJump") == false

if doublejump then
	state:SetAttribute("DoubleJump", true)
end
