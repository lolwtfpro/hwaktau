task.wait(10)

game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Server"):WaitForChild("Data"):WaitForChild("EquipItem"):InvokeServer("Luck Vial")
local s, e = pcall(function()
    queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/lolwtfpro/hwaktau/refs/heads/main/usepot.lua"))()')()
end)
