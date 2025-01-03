local LocalPlayer = game:GetService("Players").LocalPlayer
repeat
    task.wait()
until LocalPlayer.Character

-- Uh, ignore this spaghetti way of determining screen center
local MouseTarget = Instance.new("Frame", LocalPlayer.PlayerGui:FindFirstChildWhichIsA("ScreenGui"))
MouseTarget.Size = UDim2.new(0, 0, 0, 0)
MouseTarget.Position = UDim2.new(0.5, 0, 0.5, 0)
MouseTarget.AnchorPoint = Vector2.new(0.5, 0.5)
local X, Y = MouseTarget.AbsolutePosition.X, MouseTarget.AbsolutePosition.Y

getgenv().LuckBoosts = {"Luck Vial","Wooden Beckoning Cat"}
local Cats = {"Withered Beckoning Cat", "Wooden Beckoning Cat", "Polished Beckoning Cat"}
local Objects = workspace:WaitForChild("Objects")
local Mobs = Objects:WaitForChild("Mobs")
local Drops = Objects:WaitForChild("Drops")
local LootUI = LocalPlayer.PlayerGui:WaitForChild("Loot")
local Flip = LootUI:WaitForChild("Frame"):WaitForChild("Flip")
local Replay = LocalPlayer.PlayerGui:WaitForChild("ReadyScreen"):WaitForChild("Frame"):WaitForChild("Replay")
local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
local MissionItems = Objects:WaitForChild("MissionItems")

local function Click(Button)
    Button.AnchorPoint = Vector2.new(0.5, 0.5)
    Button.Size = UDim2.new(50, 0, 50, 0)
    Button.Position = UDim2.new(0.5, 0, 0.5, 0)
    Button.ZIndex = 20
    Button.ImageTransparency = 1
    for i, v in ipairs(Button:GetChildren()) do
        if v:IsA("TextLabel") then
            v:Destroy()
        end
    end
    local VIM = game:GetService("VirtualInputManager")
    VIM:SendMouseButtonEvent(X, Y, 0, true, game, 0)
    task.wait()
    VIM:SendMouseButtonEvent(X, Y, 0, false, game, 0)
    task.wait()
end
task.spawn(function()
    while true do
        --for _, Item in pairs(getgenv().LuckBoosts) do
        --    task.wait()
        --    if LocalPlayer.ReplicatedData.luckBoost.duration.Value == 0 then
        --        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Server"):WaitForChild("Data")
        --            :WaitForChild("EquipItem"):InvokeServer(Item)
        --        print(Item .. " used")
        --    end
        --end
        if not LootUI.Enabled then
            if Drops:FindFirstChild("Chest") and Drops:FindFirstChild("Chest"):FindFirstChild("Collect") then
                fireproximityprompt(Drops:FindFirstChild("Chest"):FindFirstChild("Collect"))
            end
        else
            repeat
                Click(Flip)
            until not LootUI.Enabled
        end
        task.wait(0.2)
    end
end)

task.spawn(function()
    while true do
        local VIM = game:GetService("VirtualInputManager")
        VIM:SendKeyEvent(true, 104, false, game)
        task.wait()
        VIM:SendKeyEvent(false, 104, false, game)
        task.wait()
    end
end)

local function InitTP()
    --Root.CFrame = Spawns.BossSpawn.CFrame + Vector3.new(0, 10, 0)
    local InitialTween = game:GetService("TweenService"):Create(Root,TweenInfo.new(1),{CFrame = Spawns.BossSpawn.CFrame + Vector3.new(0, 10, 0)})
    InitialTween:Play()
    InitialTween.Completed:Wait()
    task.wait()
end

local function tween(pos)
    local Tween = game:GetService("TweenService"):Create(Root,TweenInfo.new(1),{CFrame = pos})
    Tween:Play()
    Tween.Completed:Wait()
    task.wait()
end
while(not LocalPlayer.PlayerGui:WaitForChild("Results").Enabled) do
    for i, v in pairs(game:GetService("Workspace"):FindFirstChild("Objects"):FindFirstChild("Mobs"):GetChildren()) do
        if v:FindFirstChild("Humanoid") then
            v:FindFirstChild("Humanoid").Health = 0
            --tween(v:FindFirstChild("HumanoidRootPart").CFrame)
            LocalPlayer.Character.HumanoidRootPart.CFrame = v:FindFirstChild("HumanoidRootPart").CFrame
            task.wait(0.2)
            for i = 0, 10, 1 do
                game:GetService("ReplicatedStorage").Remotes.Server.Combat.M1:FireServer(1, {v:FindFirstChild("Humanoid")})
                if v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid"):FindFirstChild("Health") then
                    v:FindFirstChild("Humanoid").Health = 0
                end
                task.wait()
            end
        end
    end

if MissionItems:FindFirstChild("CursedObject") then
    for i, v in pairs(MissionItems:GetChildren()) do
        if v.Name == "CursedObject" then
            LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            task.wait(1)
            fireproximityprompt(v:FindFirstChild("Collect"))
        end
    end
end

if MissionItems:FindFirstChild("Civilian") then
    for i, v in pairs(MissionItems:GetChildren()) do
        if v.Name == "Civilian" and v:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = v:FindFirstChild("HumanoidRootPart").CFrame
            task.wait(1)
            if v:FindFirstChild("PickUp") then
                fireproximityprompt(v:FindFirstChild("PickUp"))
                task.wait(1)
            end
            
             
            LocalPlayer.Character.HumanoidRootPart.CFrame = workspace:FindFirstChild("Map"):FindFirstChild("Parts"):FindFirstChild("SpawnLocation").CFrame
            task.wait(1)
        end
    end
end
task.wait(1)
end
local s, e = pcall(function()
    queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/lolwtfpro/hwaktau/refs/heads/main/tatatazzza.lua"))()')()
end)

task.wait(20)
for i = 1, 10, 1 do
Replay = LocalPlayer.PlayerGui:WaitForChild("ReadyScreen"):WaitForChild("Frame"):WaitForChild("Replay")
Click(Replay)
task.wait(1)
end


--for i, v in pairs(game:GetService("Workspace"):FindFirstChild("Objects"):FindFirstChild("Drops"):GetChildren()) do
--    if v.Name == "Chest" then
--        fireproximityprompt(v:FindFirstChild("Collect"))
--    end
--end
