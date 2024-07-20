_G.On = true

_G.Settings = {
	["Kill Aura"] = true
}

local RaidArea = workspace.Region:WaitForChild("RaidArea",9e9)

local can_raids = function()
	local Level = game:GetService("Players").LocalPlayer.PlayerData.Level
	return Level.Value >= 1000 and true or false
end

local check_area_raids = function()
	return game:GetService("Players").LocalPlayer:DistanceFromCharacter(RaidArea.Position) < 10 and true or false
end

local check_in_raids = function()
	local RaidFrame = game:GetService("Players").LocalPlayer.PlayerGui.RaidGui.RaidFrame
	return RaidFrame.Visible and true or false
end

local check_start_raids = function()
	local startbutton = game:GetService("Players").LocalPlayer.PlayerGui.RaidGui.RaidFrame.Start_Button
	return startbutton.Visible and true or false
end

local EquipWeapon = (function(...)
	local Get = {...}
	if Get[1] and Get[1] ~= "" then
		if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(Get[1])) then
			local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(Get[1]))
			task.wait()
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
		end
	end
end)

local NoclipNotDup = tostring(math.random(10000000,99999999))
local shp = sethiddenproperty or set_hidden_property or set_hidden_prop or sethiddenprop
spawn(function()
	game:GetService("RunService").Stepped:Connect(function()
		local HumNoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
		local HumNoidRoot = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")

		if not AntiClip and (_G.On) then
			if HumNoid:GetState() == Enum.HumanoidStateType.Seated or HumNoid.Health <= 0 then
				HumNoid.Jump = true
				HumNoid.Sit = false
				if HumNoidRoot:FindFirstChild("NoClip"..NoclipNotDup) then
					HumNoidRoot:FindFirstChild("NoClip"..NoclipNotDup):Destroy()
				end
			end
			if HumNoid.Sit == false and HumNoid.Health > 0 then
				for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
					if v:IsA("BasePart") then
						v.CanCollide = false
					end
				end
			else
				HumNoid.Sit = false
			end
			if not HumNoidRoot:FindFirstChild("NoClip"..NoclipNotDup) and HumNoid.Sit == false then
				local bv = Instance.new("BodyVelocity")
				bv.Parent = HumNoidRoot
				bv.Name = "NoClip"..NoclipNotDup
				bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
				bv.Velocity = Vector3.new(0,0,0)
			end
		else
			if HumNoidRoot:FindFirstChild("NoClip"..NoclipNotDup) then
				HumNoidRoot:FindFirstChild("NoClip"..NoclipNotDup):Destroy()
			end
		end
	end)
end)

local attack = function()
	game:GetService('VirtualUser'):CaptureController()
	game:GetService('VirtualUser'):Button1Down(Vector2.new(1280, 672))
end

local automatic_raids = function()
	if _G.On and can_raids() == true then
		repeat task.wait()
			if not check_area_raids() and not check_in_raids() then
				game:GetService("Players").LocalPlayer.Character:PivotTo(RaidArea.CFrame)
			elseif check_in_raids() then
				if check_start_raids() then
					game:GetService("ReplicatedStorage").OtherEvent.MiscEvents.StartRaid:FireServer("Start")
				else
					for i,v in pairs(workspace.Monster:GetChildren()) do
						if _G.On and v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid").Health > 0 then
							if game:GetService("Players").LocalPlayer:DistanceFromCharacter(v:FindFirstChild("HumanoidRootPart").Position) < 350 then
								repeat task.wait()
									if v:FindFirstChild("Humanoid").Health < v:FindFirstChild("Humanoid").MaxHealth and _G.Settings["Kill Aura"] then
										v:FindFirstChild("Humanoid"):TakeDamage(9e9)
									end
									game:GetService("Players").LocalPlayer.Character:PivotTo(v:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0,7,0) * CFrame.Angles(math.rad(-90),0,0))
									EquipWeapon("Pixel Sword")
									attack()
								until v:FindFirstChild("Humanoid").Health <= 0 or not _G.On
							end
						end
					end
				end
			end
		until not _G.On
	end
end

task.spawn(function()
	while task.wait() do
		xpcall(function()
			automatic_raids()
		end,print)
	end
end)
