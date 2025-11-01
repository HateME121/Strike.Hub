-- gui.lua
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ======= Main ScreenGui =======
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "StrikeGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- ======= Main Frame =======
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 500)
mainFrame.Position = UDim2.new(0, 10, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- ======= UI Gradient =======
local uiGradient = Instance.new("UIGradient")
uiGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 45)), ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 25))})
uiGradient.Parent = mainFrame

-- ======= Title =======
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Strike Hub"
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- ======= Tabs =======
local tabs = {"Current Event", "Optimization", "Auto Farm", "Egg", "Auto Quest", "Mailbox", "Huge Hunter", "Dupe", "Player", "Misc"}
local tabButtons = {}
local tabFrames = {}

local buttonHolder = Instance.new("Frame")
buttonHolder.Size = UDim2.new(1, 0, 0, 40)
buttonHolder.Position = UDim2.new(0, 0, 0, 40)
buttonHolder.BackgroundTransparency = 1
buttonHolder.Parent = mainFrame

local spacing = 400 / #tabs
for i, tabName in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, spacing, 1, 0)
    btn.Position = UDim2.new(0, spacing*(i-1), 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.Text = tabName
    btn.Font = Enum.Font.Gotham
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.TextScaled = true
    btn.Parent = buttonHolder
    tabButtons[tabName] = btn

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 1, -80)
    frame.Position = UDim2.new(0,10,0,80)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.Visible = false
    frame.Parent = mainFrame
    tabFrames[tabName] = frame

    btn.MouseButton1Click:Connect(function()
        for _, f in pairs(tabFrames) do f.Visible = false end
        frame.Visible = true
    end)
end

-- Show first tab by default
tabFrames[tabs[1]].Visible = true

-- ======= Close & Reopen Buttons =======
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextScaled = true
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.BackgroundColor3 = Color3.fromRGB(150,0,0)
closeBtn.Parent = mainFrame

local reopenBtn = Instance.new("TextButton")
reopenBtn.Size = UDim2.new(0, 80, 0, 30)
reopenBtn.Position = UDim2.new(0, 10, 0, 10)
reopenBtn.Text = "Open GUI"
reopenBtn.Font = Enum.Font.GothamBold
reopenBtn.TextScaled = true
reopenBtn.TextColor3 = Color3.fromRGB(255,255,255)
reopenBtn.BackgroundColor3 = Color3.fromRGB(0,150,0)
reopenBtn.Visible = false
reopenBtn.Parent = screenGui

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    reopenBtn.Visible = true
end)

reopenBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    reopenBtn.Visible = false
end)

-- ======= Dragging (after 5 seconds) =======
local dragging = false
local dragInput, mousePos, framePos

wait(5) -- Wait 5 seconds before draggable
mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = mainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - mousePos
        mainFrame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
    end
end)
