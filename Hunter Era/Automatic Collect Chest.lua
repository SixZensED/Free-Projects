local interact = function()
	game:service('VirtualInputManager'):SendKeyEvent(true, "E", false, game)
	task.wait(0.05)
	game:service('VirtualInputManager'):SendKeyEvent(false, "E", false, game)
end

for i,v in pairs(Workspace:GetDescendants()) do
	if v.Name == "chest" and v:IsA("Model") then
		if v:FindFirstChild("chest").Transparency == 0 then
			repeat task.wait()
				game:GetService("Players").LocalPlayer.Character:PivotTo(v:FindFirstChild("chest").CFrame)
				interact()
				task.wait(0.15)
			until v:FindFirstChild("chest").Transparency > 0 
		end
	end
end
