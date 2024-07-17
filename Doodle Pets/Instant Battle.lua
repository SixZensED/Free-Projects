local state = game:GetService("ReplicatedStorage"):FindFirstChild("State")
local fastForward = state and state:FindFirstChild("FastForward")

if fastForward then
    fastForward.Value = 0
    local metaTable = {
        __newindex = function(_, key, value)
            if key == "Value" then
                fastForward.Changed:Wait()
                fastForward.Value = 0
            else
                rawset(fastForward, key, value)
            end
        end
      }
    setmetatable(fastForward, metaTable)
end
