-- // Menunggu game ter-load sepenuhnya
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- // Cleanup UI lama agar tidak menumpuk saat di-execute ulang
local oldGui = game:GetService("CoreGui"):FindFirstChild("NajzGamingHubGui") or game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("NajzGamingHubGui")
if oldGui then oldGui:Destroy() end

-- // Services & Variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- // State / Flags untuk Fitur
local Flags = {
    AutoBrainrot = false,
    AutoCollectCash = false,
    Auto2xTrain = false
}

-- ==========================================
-- // LOGIKA FITUR (LOGIC THREADS)
-- ==========================================

-- 1. Auto Brainrot + Mutasi + Traits
task.spawn(function()
    local TypedRemote = ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("TypedRemote")
    while true do
        if Flags.AutoBrainrot then
            pcall(function()
                TypedRemote.WebSwingRoll:InvokeServer(99999999999999999999999999)
                TypedRemote.RequestMutationOrbPlan:InvokeServer()
                TypedRemote.RequestEventOrbPlan:InvokeServer()
                for i = 1, 10 do
                    TypedRemote.MutationOrbGrabbed:FireServer(i, 1)
                end
                for i = 1, 10 do
                    TypedRemote.EventOrbGrabbed:FireServer(i, 1)
                end
                task.wait(2)
                TypedRemote.WebSwingRollFinish:FireServer()
            end)
        end
        task.wait(3)
    end
end)

-- 2. Auto Collect Cash
local function getPlotTemplate(base)
    local plotsFolder = workspace:FindFirstChild("Plots")
    if not plotsFolder then return nil end

    if base == 1 then
        return plotsFolder:FindFirstChild("PlotTemplate")
    else
        local children = plotsFolder:GetChildren()
        return children[base] 
    end
end

task.spawn(function()
    while true do
        if Flags.AutoCollectCash then
            pcall(function()
                local char = LocalPlayer.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        for base = 1, 5 do
                            local plot = getPlotTemplate(base)
                            if not plot then continue end

                            local floors = plot:FindFirstChild("Floors")
                            if not floors then continue end

                            for floorNum = 0, 2 do
                                local floorObj = floors:FindFirstChild("Floor" .. floorNum)
                                if not floorObj then continue end

                                local stands = floorObj:FindFirstChild("Stands")
                                if not stands then continue end

                                for standNum = 1, 10 do
                                    local stand = stands:FindFirstChild(tostring(standNum))
                                    if not stand then continue end

                                    local cashModel = stand:FindFirstChild("CashModel")
                                    if not cashModel then continue end

                                    local touchPart = cashModel:FindFirstChild("TouchPart")
                                    if touchPart and touchPart:IsA("BasePart") then
                                        firetouchinterest(hrp, touchPart, 0) 
                                        task.wait(0.01)
                                        firetouchinterest(hrp, touchPart, 1)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
        task.wait(1)
    end
end)

-- 3. Auto x2 Train
task.spawn(function()
    while true do
        if Flags.Auto2xTrain then
            pcall(function()
                local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
                if playerGui then
                    local mainGui = playerGui:FindFirstChild("MainGui")
                    if mainGui then
                        local button = mainGui:FindFirstChild("2xButton")
                        if button and button:IsA("ImageButton") and button.Visible then
                            local success = pcall(function()
                                firesignal(button.MouseButton1Click)
                                firesignal(button.Activated)
                            end)
                            if not success then
                                pcall(function()
                                    for _, conn in pairs(getconnections(button.MouseButton1Click)) do
                                        conn:Fire()
                                    end
                                    for _, conn in pairs(getconnections(button.Activated)) do
                                        conn:Fire()
                                    end
                                end)
                            end
                        end
                    end
                end
            end)
        end
        task.wait(0.5)
    end
end)

-- ==========================================
-- // PEMBUATAN GUI
-- ==========================================

local ParentContainer = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NajzGamingHubGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = ParentContainer

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 240, 0, 180)
MainFrame.Position = UDim2.new(0.5, -120, 0.4, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

-- Draggable UI Function
local function MakeDraggable(gui)
    local dragging, dragInput, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = gui.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
MakeDraggable(MainFrame)

-- Title Bar
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 180, 0, 35)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Web Swing For Lucky Block"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

-- Hide / Show Button
local HideBtn = Instance.new("TextButton")
HideBtn.Size = UDim2.new(0, 30, 0, 35)
HideBtn.Position = UDim2.new(1, -35, 0, 0)
HideBtn.BackgroundTransparency = 1
HideBtn.Text = "▼"
HideBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
HideBtn.TextSize = 12
HideBtn.Font = Enum.Font.SourceSansBold
HideBtn.Parent = MainFrame

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -35)
ContentFrame.Position = UDim2.new(0, 0, 0, 35)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local minimized = false
HideBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        ContentFrame.Visible = false
        MainFrame.Size = UDim2.new(0, 240, 0, 35)
        HideBtn.Text = "▲"
    else
        MainFrame.Size = UDim2.new(0, 240, 0, 180)
        ContentFrame.Visible = true
        HideBtn.Text = "▼"
    end
end)

-- Helper Helper Pembuat Toggle Row
local function createToggleRow(text, yPos, flagKey)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(0, 210, 0, 30)
    Row.Position = UDim2.new(0.5, -105, 0, yPos)
    Row.BackgroundTransparency = 1
    Row.Parent = ContentFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0, 160, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 13
    Label.Font = Enum.Font.SourceSansBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Row
    
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0, 20, 0, 20)
    Toggle.Position = UDim2.new(1, -20, 0.5, -10)
    Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Toggle.BorderSizePixel = 0
    Toggle.Text = ""
    Toggle.Parent = Row

    Toggle.MouseButton1Click:Connect(function()
        Flags[flagKey] = not Flags[flagKey]
        if Flags[flagKey] then
            Toggle.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        else
            Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        end
    end)
end

-- // Menambahkan 3 Fitur ke UI
createToggleRow("Auto Roll + Mutasi", 5, "AutoBrainrot")
createToggleRow("Auto Collect Cash", 40, "AutoCollectCash")
createToggleRow("Auto 2x Train", 75, "Auto2xTrain")

-- Watermark
local Watermark = Instance.new("TextLabel")
Watermark.Size = UDim2.new(1, 0, 0, 20)
Watermark.Position = UDim2.new(0, 0, 1, -25)
Watermark.BackgroundTransparency = 1
Watermark.Text = "YouTube: Najz Hub V2"
Watermark.TextColor3 = Color3.fromRGB(200, 200, 200)
Watermark.TextSize = 12
Watermark.Font = Enum.Font.SourceSansBold
Watermark.Parent = ContentFrame