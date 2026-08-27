-- ====================================================================
-- YUTA HUB UI LIBRARY (YutaPremiumLib)
-- ====================================================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local VIM = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

local Theme = {
    Background = Color3.fromRGB(13, 13, 18),
    Sidebar = Color3.fromRGB(18, 18, 26),
    TopBar = Color3.fromRGB(22, 22, 32),
    Accent = Color3.fromRGB(0, 220, 100),
    AccentGlow = Color3.fromRGB(0, 180, 80),
    ElementBg = Color3.fromRGB(25, 25, 35),
    ElementHover = Color3.fromRGB(32, 32, 46),
    TextMain = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(140, 140, 155),
    Border = Color3.fromRGB(35, 35, 48),
    BorderHover = Color3.fromRGB(55, 55, 75)
}

local AnimInfo = {
    Fast = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Smooth = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Bounce = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
}

local DRAG_THRESHOLD = 15

local function tween(object, info, property)
    local t = TweenService:Create(object, info, property)
    t:Play()
    return t
end

local function applyAdvancedDrag(triggerObject, targetObject)
    local dragging = false
    local dragInput, dragStart, startPos

    triggerObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = targetObject.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)

    triggerObject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            tween(targetObject, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            })
        end
    end)
end

local YutaPremiumLib = {}
YutaPremiumLib.__index = YutaPremiumLib

function YutaPremiumLib:CreateWindow(menuTitle)
    local window = {
        CurrentTab = nil,
        Tabs = {},
        Active = true,
        Minimized = false
    }

    if CoreGui:FindFirstChild("YutaUltraGui Premium") then
        CoreGui["YutaUltraGui Premium"]:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "YutaUltraGui Premium"
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = 99999
    screenGui.Parent = CoreGui
    window.ScreenGui = screenGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 560, 0, 380)
    mainFrame.Position = UDim2.new(0.5, -280, 0.5, -190)
    mainFrame.BackgroundColor3 = Theme.Background
    mainFrame.BackgroundTransparency = 0
    mainFrame.ZIndex = 0
    mainFrame.Active = true
    mainFrame.Parent = screenGui
    window.MainFrame = mainFrame

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 14)
    mainCorner.Parent = mainFrame

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = Theme.Border
    mainStroke.Thickness = 1.2
    mainStroke.Parent = mainFrame

    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Size = UDim2.new(1, 0, 0, 42)
    topBar.BackgroundColor3 = Theme.TopBar
    topBar.BackgroundTransparency = 0.4
    topBar.BorderSizePixel = 0
    topBar.ZIndex = 2
    topBar.Parent = mainFrame

    local topCorner = Instance.new("UICorner")
    topCorner.CornerRadius = UDim.new(0, 14)
    topCorner.Parent = topBar

    applyAdvancedDrag(topBar, mainFrame)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "YutaTitleLabel"
    titleLabel.Size = UDim2.new(1, -120, 1, 0)
    titleLabel.Position = UDim2.new(0, 18, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = string.upper(menuTitle or "YUTA HUB")
    titleLabel.TextColor3 = Theme.TextMain
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 3
    titleLabel.Parent = topBar

    local neonLine = Instance.new("Frame")
    neonLine.Name = "DynamicNeonLine"
    neonLine.Size = UDim2.new(1, 0, 0, 1.5)
    neonLine.Position = UDim2.new(0, 0, 1, 0)
    neonLine.BackgroundColor3 = Theme.Accent
    neonLine.BorderSizePixel = 0
    neonLine.ZIndex = 5
    neonLine.Parent = topBar

    local mobileToggleBtn = Instance.new("TextButton")

    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "YutaCloseBtn"
    closeBtn.Size = UDim2.new(0, 26, 0, 26)
    closeBtn.Position = UDim2.new(1, -36, 0.5, -11)
    closeBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Theme.TextSecondary
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 16
    closeBtn.ZIndex = 3
    closeBtn.AutoButtonColor = false
    closeBtn.Parent = topBar
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

    closeBtn.MouseEnter:Connect(function() tween(closeBtn, AnimInfo.Fast, {BackgroundColor3 = Color3.fromRGB(220, 50, 50), TextColor3 = Color3.fromRGB(255, 255, 255)}) end)
    closeBtn.MouseLeave:Connect(function() tween(closeBtn, AnimInfo.Fast, {BackgroundColor3 = Color3.fromRGB(28, 28, 38), TextColor3 = Theme.TextSecondary}) end)
    closeBtn.MouseButton1Click:Connect(function()
        mobileToggleBtn.Visible = false
        screenGui:Destroy()
        window.Active = false
    end)

    local minBtn = Instance.new("TextButton")
    minBtn.Name = "YutaMinBtn"
    minBtn.Size = UDim2.new(0, 26, 0, 26)
    minBtn.Position = UDim2.new(1, -68, 0.5, -11)
    minBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    minBtn.Text = "-"
    minBtn.TextColor3 = Theme.TextSecondary
    minBtn.Font = Enum.Font.GothamBold
    minBtn.TextSize = 14
    minBtn.ZIndex = 3
    minBtn.AutoButtonColor = false
    minBtn.Parent = topBar
    Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)
    minBtn.MouseEnter:Connect(function() tween(minBtn, AnimInfo.Fast, {BackgroundColor3 = Color3.fromRGB(38, 38, 52), TextColor3 = Theme.TextMain}) end)
    minBtn.MouseLeave:Connect(function() tween(minBtn, AnimInfo.Fast, {BackgroundColor3 = Color3.fromRGB(28, 28, 38), TextColor3 = Theme.TextSecondary}) end)

    mobileToggleBtn.Name = "MobileYutaToggle"
    mobileToggleBtn.Size = UDim2.new(0, 45, 0, 45)
    mobileToggleBtn.Position = UDim2.new(0, 20, 0, 20)
    mobileToggleBtn.BackgroundColor3 = Theme.Sidebar
    mobileToggleBtn.BackgroundTransparency = 0.2
    mobileToggleBtn.Text = "N"
    mobileToggleBtn.TextColor3 = Theme.Accent
    mobileToggleBtn.Font = Enum.Font.GothamBlack
    mobileToggleBtn.TextSize = 20
    mobileToggleBtn.ZIndex = 999
    mobileToggleBtn.Visible = true
    mobileToggleBtn.Parent = screenGui

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 12)
    toggleCorner.Parent = mobileToggleBtn

    local toggleStroke = Instance.new("UIStroke")
    toggleStroke.Color = Theme.Border
    toggleStroke.Thickness = 1.2
    toggleStroke.Parent = mobileToggleBtn

    applyAdvancedDrag(mobileToggleBtn, mobileToggleBtn)

    local sidebar = Instance.new("Frame")
    sidebar.Name = "Sidebar"
    sidebar.Size = UDim2.new(0, 150, 1, -42)
    sidebar.Position = UDim2.new(0, 0, 0, 42)
    sidebar.BackgroundColor3 = Theme.Sidebar
    sidebar.BackgroundTransparency = 0.4
    sidebar.BorderSizePixel = 0
    sidebar.ZIndex = 2
    sidebar.Parent = mainFrame

    local containerFrame = Instance.new("Frame")
    containerFrame.Name = "ContainerFrame"
    containerFrame.Size = UDim2.new(1, -150, 1, -42)
    containerFrame.Position = UDim2.new(0, 150, 0, 42)
    containerFrame.BackgroundTransparency = 1
    containerFrame.ClipsDescendants = true
    containerFrame.ZIndex = 2
    containerFrame.Parent = mainFrame

    window.ContainerFrame = containerFrame
    window.Sidebar = sidebar

    local function toggleMinimizeState()
        window.Minimized = not window.Minimized
        if window.Minimized then
            sidebar.Visible = false
            containerFrame.Visible = false
            titleLabel.Visible = false
            minBtn.Visible = false
            closeBtn.Visible = false
            if neonLine then neonLine.Visible = false end
            mainFrame.Visible = false
            mobileToggleBtn.Visible = true
        else
            mainFrame.Visible = true
            minBtn.Visible = true
            closeBtn.Visible = true
            sidebar.Visible = true
            containerFrame.Visible = true
            titleLabel.Visible = true
            if neonLine then neonLine.Visible = true end
        end
    end

    minBtn.MouseButton1Click:Connect(toggleMinimizeState)

    local waktuMulaiSentuh = 0
    mobileToggleBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            waktuMulaiSentuh = tick()
        end
    end)

    mobileToggleBtn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if tick() - waktuMulaiSentuh < 0.22 then
                toggleMinimizeState()
            end
        end
    end)

    local sidebarLayout = Instance.new("UIListLayout")
    sidebarLayout.Padding = UDim.new(0, 5)
    sidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    sidebarLayout.Parent = sidebar

    local sidebarPadding = Instance.new("UIPadding")
    sidebarPadding.PaddingTop = UDim.new(0, 12)
    sidebarPadding.Parent = sidebar

    return window
end

function YutaPremiumLib:CreateTab(window, tabName)
    local tab = { Window = window, Name = tabName }
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = tabName .. "TabBtn"
    tabBtn.Size = UDim2.new(1, -20, 0, 34)
    tabBtn.BackgroundColor3 = Theme.ElementBg
    tabBtn.BackgroundTransparency = 1
    tabBtn.Text = "   " .. tabName
    tabBtn.TextColor3 = Theme.TextSecondary
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextSize = 12
    tabBtn.TextXAlignment = Enum.TextXAlignment.Left
    tabBtn.ZIndex = 3
    tabBtn.AutoButtonColor = false
    tabBtn.Parent = window.Sidebar
    tab.TabButton = tabBtn

    Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 8)

    local activeIndicator = Instance.new("Frame")
    activeIndicator.Name = "TabActiveIndicatorFrame"
    activeIndicator.Size = UDim2.new(0, 3, 0.6, 0)
    activeIndicator.Position = UDim2.new(0, 0, 0, 7)
    activeIndicator.BackgroundColor3 = Theme.Accent
    activeIndicator.BorderSizePixel = 0
    activeIndicator.BackgroundTransparency = 1
    activeIndicator.ZIndex = 4
    activeIndicator.Parent = tabBtn

    local pageScroll = Instance.new("ScrollingFrame")
    pageScroll.Name = tabName .. "PageScroll"
    pageScroll.Size = UDim2.new(1, 0, 1, 0)
    pageScroll.BackgroundTransparency = 1
    pageScroll.BorderSizePixel = 0
    pageScroll.ScrollBarThickness = 3
    pageScroll.ScrollBarImageColor3 = Theme.BorderHover
    pageScroll.Visible = false
    pageScroll.ZIndex = 3
    pageScroll.Parent = window.ContainerFrame
    tab.PageScroll = pageScroll

    local pageLayout = Instance.new("UIListLayout")
    pageLayout.Padding = UDim.new(0, 8)
    pageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pageLayout.Parent = pageScroll

    local pagePadding = Instance.new("UIPadding")
    pagePadding.PaddingTop = UDim.new(0, 14)
    pagePadding.PaddingBottom = UDim.new(0, 14)
    pagePadding.Parent = pageScroll

    pageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        pageScroll.CanvasSize = UDim2.new(0, 0, 0, pageLayout.AbsoluteContentSize.Y + 28)
    end)

    local function activateThisTab()
        if window.CurrentTab == tab then return end
        if window.CurrentTab then
            local oldTab = window.CurrentTab
            oldTab.PageScroll.Visible = false
            tween(oldTab.TabButton, AnimInfo.Fast, {BackgroundTransparency = 1, TextColor3 = Theme.TextSecondary})
            local prevIndicator = oldTab.TabButton:FindFirstChild("TabActiveIndicatorFrame")
            if prevIndicator then tween(prevIndicator, AnimInfo.Fast, {BackgroundTransparency = 1}) end
        end
        window.CurrentTab = tab
        pageScroll.Visible = true
        tween(tabBtn, AnimInfo.Fast, {BackgroundTransparency = 0, BackgroundColor3 = Color3.fromRGB(24, 25, 38), TextColor3 = Theme.Accent})
        tween(activeIndicator, AnimInfo.Fast, {BackgroundTransparency = 0})
    end

    tabBtn.MouseButton1Click:Connect(activateThisTab)

    if #window.Tabs == 0 then
        activateThisTab()
    end

    table.insert(window.Tabs, tab)
    return tab
end

function YutaPremiumLib:CreateButton(tab, buttonText, callback)
    local btnFrame = Instance.new("TextButton")
    btnFrame.Size = UDim2.new(1, -28, 0, 38)
    btnFrame.BackgroundColor3 = Theme.ElementBg
    btnFrame.BackgroundTransparency = 0.2
    btnFrame.Text = "  " .. buttonText
    btnFrame.TextColor3 = Theme.TextMain
    btnFrame.Font = Enum.Font.GothamBold
    btnFrame.TextSize = 12
    btnFrame.TextXAlignment = Enum.TextXAlignment.Left
    btnFrame.ZIndex = 4
    btnFrame.AutoButtonColor = false
    btnFrame.Parent = tab.PageScroll

    Instance.new("UICorner", btnFrame).CornerRadius = UDim.new(0, 8)
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Theme.Border
    btnStroke.Thickness = 1
    btnStroke.Parent = btnFrame

    btnFrame.MouseButton1Click:Connect(function()
        task.spawn(callback or function() end)
    end)
end

function YutaPremiumLib:CreateToggle(tab, toggleText, defaultState, callback)
    local toggled = defaultState or false
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -28, 0, 42)
    toggleFrame.BackgroundColor3 = Theme.ElementBg
    toggleFrame.BackgroundTransparency = 0.2
    toggleFrame.ZIndex = 4
    toggleFrame.Parent = tab.PageScroll

    Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(0, 8)
    local frameStroke = Instance.new("UIStroke")
    frameStroke.Color = Theme.Border
    frameStroke.Thickness = 1
    frameStroke.Parent = toggleFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -75, 1, 0)
    label.Position = UDim2.new(0, 14, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = toggleText
    label.TextColor3 = toggled and Theme.TextMain or Theme.TextSecondary
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 5
    label.Parent = toggleFrame

    local switchContainer = Instance.new("TextButton")
    switchContainer.Size = UDim2.new(0, 38, 0, 22)
    switchContainer.Position = UDim2.new(1, -52, 0.5, -11)
    switchContainer.BackgroundColor3 = toggled and Theme.Accent or Color3.fromRGB(38, 38, 50)
    switchContainer.Text = ""
    switchContainer.ZIndex = 5
    switchContainer.AutoButtonColor = false
    switchContainer.Parent = toggleFrame
    Instance.new("UICorner", switchContainer).CornerRadius = UDim.new(1, 0)

    local switchBall = Instance.new("Frame")
    switchBall.Size = UDim2.new(0, 16, 0, 16)
    switchBall.Position = toggled and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
    switchBall.BackgroundColor3 = toggled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 185)
    switchBall.BorderSizePixel = 0
    switchBall.ZIndex = 6
    switchBall.Parent = switchContainer
    Instance.new("UICorner", switchBall).CornerRadius = UDim.new(1, 0)

    local function triggerToggle()
        toggled = not toggled
        if toggled then
            tween(switchContainer, AnimInfo.Fast, {BackgroundColor3 = Theme.Accent})
            tween(switchBall, AnimInfo.Fast, {Position = UDim2.new(1, -19, 0.5, -8), BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
            tween(label, AnimInfo.Fast, {TextColor3 = Theme.TextMain})
        else
            tween(switchContainer, AnimInfo.Fast, {BackgroundColor3 = Color3.fromRGB(38, 38, 50)})
            tween(switchBall, AnimInfo.Fast, {Position = UDim2.new(0, 3, 0.5, -8), BackgroundColor3 = Color3.fromRGB(180, 180, 185)})
            tween(label, AnimInfo.Fast, {TextColor3 = Theme.TextSecondary})
        end
        task.spawn(function() (callback or function() end)(toggled) end)
    end

    switchContainer.MouseButton1Click:Connect(triggerToggle)
    label.Active = true
    label.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            triggerToggle()
        end
    end)
end

function YutaPremiumLib:CreateDropdown(tab, dropdownText, optionsTable, callback)
    local callbackFunc = callback or function() end
    local dropdown = { Opened = false, Buttons = {}, Options = optionsTable }

    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Size = UDim2.new(1, -28, 0, 42)
    dropdownFrame.BackgroundColor3 = Theme.ElementBg
    dropdownFrame.BackgroundTransparency = 0.2
    dropdownFrame.ClipsDescendants = true
    dropdownFrame.ZIndex = 4
    dropdownFrame.Parent = tab.PageScroll

    Instance.new("UICorner", dropdownFrame).CornerRadius = UDim.new(0, 8)
    local frameStroke = Instance.new("UIStroke")
    frameStroke.Color = Theme.Border
    frameStroke.Thickness = 1
    frameStroke.Parent = dropdownFrame

    local triggerBtn = Instance.new("TextButton")
    triggerBtn.Size = UDim2.new(1, 0, 0, 42)
    triggerBtn.BackgroundTransparency = 1
    triggerBtn.Text = "  " .. dropdownText .. " : SELECT OPTION ▼"
    triggerBtn.TextColor3 = Theme.TextSecondary
    triggerBtn.Font = Enum.Font.GothamBold
    triggerBtn.TextSize = 12
    triggerBtn.TextXAlignment = Enum.TextXAlignment.Left
    triggerBtn.ZIndex = 5
    triggerBtn.AutoButtonColor = false
    triggerBtn.Parent = dropdownFrame

    local listScroll = Instance.new("ScrollingFrame")
    listScroll.Size = UDim2.new(1, -16, 0, 105)
    listScroll.Position = UDim2.new(0, 8, 0, 46)
    listScroll.BackgroundTransparency = 1
    listScroll.BorderSizePixel = 0
    listScroll.ScrollBarThickness = 2
    listScroll.ZIndex = 6
    listScroll.Parent = dropdownFrame

    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 4)
    listLayout.Parent = listScroll

    for _, optionName in ipairs(optionsTable) do
        local optBtn = Instance.new("TextButton")
        optBtn.Size = UDim2.new(1, 0, 0, 28)
        optBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
        optBtn.Text = "  " .. tostring(optionName)
        optBtn.TextColor3 = Theme.TextSecondary
        optBtn.Font = Enum.Font.Gotham
        optBtn.TextSize = 11
        optBtn.TextXAlignment = Enum.TextXAlignment.Left
        optBtn.ZIndex = 7
        optBtn.AutoButtonColor = false
        optBtn.Parent = listScroll

        Instance.new("UICorner", optBtn).CornerRadius = UDim.new(0, 5)

        optBtn.MouseButton1Click:Connect(function()
            triggerBtn.Text = "  " .. dropdownText .. " : " .. tostring(optionName) .. " ▲"
            dropdown.Opened = false
            tween(dropdownFrame, AnimInfo.Smooth, {Size = UDim2.new(1, -28, 0, 42)})
            task.spawn(function() callbackFunc(optionName) end)
        end)
    end

    listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        listScroll.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
    end)

    triggerBtn.MouseButton1Click:Connect(function()
        dropdown.Opened = not dropdown.Opened
        if dropdown.Opened then
            triggerBtn.Text = "  " .. dropdownText .. " : SELECT OPTION ▲"
            tween(dropdownFrame, AnimInfo.Smooth, {Size = UDim2.new(1, -28, 0, 160)})
        else
            triggerBtn.Text = "  " .. dropdownText .. " : SELECT OPTION ▼"
            tween(dropdownFrame, AnimInfo.Smooth, {Size = UDim2.new(1, -28, 0, 42)})
        end
    end)
end

-- ====================================================================
-- SISTEM UTAMA (CASES FOR BRAINROT)
-- ====================================================================
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local RequestKick = Remotes:WaitForChild("RequestKick")
local RequestSetKick = Remotes:WaitForChild("RequestSetKick")
local RequestRebirth = Remotes:WaitForChild("RequestRebirth")
local SellShopRequest = Remotes:WaitForChild("SellShopRequest")
local RequestCollect = Remotes:WaitForChild("RequestCollect")
local RequestBuyWeight = Remotes:WaitForChild("RequestBuyWeight")
local RequestSpeedUpgrade = Remotes:WaitForChild("RequestSpeedUpgrade")
local WeightShopStateSync = Remotes:WaitForChild("WeightShopStateSync")
local WeightsConfig = require(ReplicatedStorage:WaitForChild("WeightsConfig"))
local PopupGate = require(ReplicatedStorage:WaitForChild("PopupGate"))

local START_POS = Vector3.new(205.44, 23.68, 111.74)

local farmActive = false
local rebirthActive = false
local autoTrainActive = false
local autoSellActive = false
local autoCollectActive = false
local autoPlaytimeActive = false
local autoIndexActive = false
local autoSeasonFreeActive = false
local autoBuyWeightActive = false
local autoBuySpeedactive = false

local selectedWeightKey = nil
local selectedSpeedIndex = nil
local ownedWeights = {}

local speedOptions = {
    { Label = "1 Speed", Index = 1 },
    { Label = "5 Speed", Index = 2 },
    { Label = "12 Speed", Index = 3 },
    { Label = "21 Speed", Index = 4 },
    { Label = "50 Speed", Index = 5 },
}

local function getRootPart()
    local char = localPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function getHumanoid()
    local char = localPlayer.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function findOwnedPlot()
    local Plots = workspace:FindFirstChild("Plots")
    if not Plots then return nil end
    for i = 1, 6 do
        local plot = Plots:FindFirstChild("Plot" .. i)
        if plot and plot:GetAttribute("OwnerUserId") == localPlayer.UserId then
            return i
        end
    end
    return nil
end

local function teleportSpam(targetPos, duration)
    local root = getRootPart()
    if not root then return end
    local start = os.clock()
    while os.clock() - start < (duration or 0.5) do
        root.CFrame = CFrame.new(targetPos)
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        task.wait(0.05)
    end
end

local function dynamicTweenToTarget(targetPos)
    local root = getRootPart()
    local humanoid = getHumanoid()
    if not root or not humanoid then return end

    local arrived = false
    while farmActive and root and humanoid and root.Parent and not arrived do
        local dt = RunService.Heartbeat:Wait()
        local dist = (targetPos - root.Position).Magnitude
        if dist <= 2 then arrived = true break end
        local speed = math.max(humanoid.WalkSpeed + 50, 50)
        local step = math.min(speed * dt, dist)
        root.CFrame = root.CFrame + (targetPos - root.Position).Unit * step
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
    end
    if root and root.Parent then
        root.CFrame = CFrame.new(targetPos)
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
    end
end

local function fireKickButton()
    local kickButton = playerGui:FindFirstChild("Game") and playerGui.Game:FindFirstChild("HUD") and playerGui.Game.HUD:FindFirstChild("HUDFrame") and playerGui.Game.HUD.HUDFrame:FindFirstChild("KickButton")
    while not kickButton and farmActive do
        task.wait(0.1)
        kickButton = playerGui.Game.HUD.HUDFrame:FindFirstChild("KickButton")
    end
    if not kickButton or not farmActive then return end

    if type(firesignal) == "function" then
        pcall(function() firesignal(kickButton.Activated) firesignal(kickButton.MouseButton1Click) end)
    else
        local x, y = kickButton.AbsolutePosition.X + kickButton.AbsoluteSize.X / 2, kickButton.AbsolutePosition.Y + kickButton.AbsoluteSize.Y / 2
        VIM:SendMouseButtonEvent(x, y, 0, true, game, 1)
        task.wait(0.1)
        VIM:SendMouseButtonEvent(x, y, 0, false, game, 1)
    end
end

local function sendKickRequests()
    if RequestKick then RequestKick:FireServer({ tier = "Perfect" }) end
    task.wait(0.1)
    if RequestSetKick then RequestSetKick:FireServer({ action = "launch" }) end
end

local function hasModelInCharacter()
    local char = localPlayer.Character
    if not char then return false end
    for _, child in ipairs(char:GetChildren()) do
        if child:IsA("Model") and child.Name ~= "HumanoidRootPart" then return true end
    end
    return false
end

local function farmLoop()
    while farmActive do
        teleportSpam(START_POS, 0.5)
        fireKickButton()
        task.wait(0.3)
        sendKickRequests()

        local gotModel = false
        while farmActive do
            if hasModelInCharacter() then gotModel = true break end
            task.wait(0.1)
        end
        if not gotModel or not farmActive then task.wait(1) continue end

        dynamicTweenToTarget(START_POS)
        task.wait(0.5)
    end
end

local function getRebirthRequirement(rebirths)
    if rebirths <= 6 then return 10^rebirths * 1000
    elseif rebirths <= 8 then return 5^(rebirths-6) * 1000000000
    else return 2^(rebirths-8) * 25000000000 end
end

local function rebirthLoop()
    while rebirthActive do
        local kickPower = localPlayer:GetAttribute("KickPower") or 0
        local rebirths = localPlayer:GetAttribute("Rebirths") or 0
        if kickPower >= getRebirthRequirement(rebirths) then
            PopupGate.Run(function() RequestRebirth:FireServer({ mode = "rebirth" }) end, 5)
        end
        task.wait(1)
    end
end

local function autoTrainLoop()
    while autoTrainActive do
        local comboGui = playerGui:FindFirstChild("ComboRushGui")
        if comboGui then
            for _, child in ipairs(comboGui:GetChildren()) do
                if child.Name ~= "ComboPill" and child:IsA("GuiObject") then
                    for _, btn in ipairs(child:GetDescendants()) do
                        if btn:IsA("GuiButton") and btn.Visible and btn.Active then
                            pcall(function() firesignal(btn.Activated) firesignal(btn.MouseButton1Click) end)
                            task.wait(0.3)
                        end
                    end
                end
            end
        end
        task.wait(0.1)
    end
end

-- ====================================================================
-- LOOP FITUR AUTO SELL (DIUBAH SESUAI REQUEST)
-- ====================================================================
local function autoSellLoop()
    local Event = game:GetService("ReplicatedStorage").Remotes.SellShopRequest
    while autoSellActive do
        PopupGate.Run(function()
            Event:InvokeServer(
                {
                    kind = "brainrotAll"
                }
            )
        end, 5)
        task.wait(1)
    end
end

local function autoCollectLoop()
    while autoCollectActive do
        local plotNumber = findOwnedPlot()
        if plotNumber then
            for slot = 1, 30 do
                if not autoCollectActive then break end
                PopupGate.Run(function() RequestCollect:FireServer(plotNumber, slot) end, 5)
                task.wait(0.1)
            end
        end
        task.wait(0)
    end
end

local function autoPlaytimeLoop()
    while autoPlaytimeActive do
        for i = 1, 12 do
            if not autoPlaytimeActive then break end
            pcall(function()
                local args = { i }
                ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("RequestOpenGift"):FireServer(unpack(args))
            end)
        end
        task.wait(1)
    end
end

local function autoIndexLoop()
    while autoIndexActive do
        pcall(function()
            ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("RequestClaimAllIndexGems"):FireServer()
        end)
        task.wait(1)
    end
end

local function autoSeasonFreeLoop()
    while autoSeasonFreeActive do
        for i = 1, 20 do
            if not autoSeasonFreeActive then break end
            pcall(function()
                local args = { "Free", i }
                ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("RequestEventPassClaim"):FireServer(unpack(args))
            end)
        end
        task.wait(1)
    end
end

local function autoBuyWeightLoop()
    while autoBuyWeightActive do
        if selectedWeightKey then
            PopupGate.Run(function() RequestBuyWeight:FireServer({ key = selectedWeightKey }) end, 5)
        end
        task.wait(0.5)
    end
end

local function autoBuySpeedLoop()
    while autoBuySpeedactive do
        if selectedSpeedIndex then
            PopupGate.Run(function() RequestSpeedUpgrade:FireServer({ index = selectedSpeedIndex }) end, 5)
        end
        task.wait(0.5)
    end
end

WeightShopStateSync.OnClientEvent:Connect(function(data)
    if type(data) == "table" and data.owned then ownedWeights = data.owned end
end)

task.spawn(function()
    for _ = 1, 3 do
        pcall(function() WeightShopStateSync:FireServer() end)
        task.wait(0.5)
    end
end)

-- ====================================================================
-- INISIALISASI UI YUTA
-- ====================================================================
local UiWindow = YutaPremiumLib:CreateWindow("Najz Hub - Roll Cases For Brainrot")
local TabMain = YutaPremiumLib:CreateTab(UiWindow, "Main")
local TabShop = YutaPremiumLib:CreateTab(UiWindow, "Shop")
local TabMisc = YutaPremiumLib:CreateTab(UiWindow, "Misc")

-- Tab Main Features
YutaPremiumLib:CreateToggle(TabMain, "Start Auto Farm", false, function(state)
    farmActive = state
    if farmActive then task.spawn(farmLoop) end
end)

YutaPremiumLib:CreateToggle(TabMain, "Auto Rebirth", false, function(state)
    rebirthActive = state
    if rebirthActive then task.spawn(rebirthLoop) end
end)

YutaPremiumLib:CreateToggle(TabMain, "Auto Train Perfect", false, function(state)
    autoTrainActive = state
    if autoTrainActive then task.spawn(autoTrainLoop) end
end)

YutaPremiumLib:CreateToggle(TabMain, "Auto Collect Cash", false, function(state)
    autoCollectActive = state
    if autoCollectActive then task.spawn(autoCollectLoop) end
end)

YutaPremiumLib:CreateToggle(TabMain, "Auto Claim Playtime", false, function(state)
    autoPlaytimeActive = state
    if autoPlaytimeActive then task.spawn(autoPlaytimeLoop) end
end)

YutaPremiumLib:CreateToggle(TabMain, "Auto Claim All Index", false, function(state)
    autoIndexActive = state
    if autoIndexActive then task.spawn(autoIndexLoop) end
end)

YutaPremiumLib:CreateToggle(TabMain, "Auto Claim Season Free", false, function(state)
    autoSeasonFreeActive = state
    if autoSeasonFreeActive then task.spawn(autoSeasonFreeLoop) end
end)

-- Tab Shop Features (Title Diubah Menjadi Auto Sell All Brainrot)
YutaPremiumLib:CreateToggle(TabShop, "Auto Sell All Brainrot", false, function(state)
    autoSellActive = state
    if autoSellActive then task.spawn(autoSellLoop) end
end)

local weightKeys = {}
for key, _ in pairs(WeightsConfig.Weights) do table.insert(weightKeys, key) end
table.sort(weightKeys)

YutaPremiumLib:CreateDropdown(TabShop, "Weight", weightKeys, function(selected)
    selectedWeightKey = selected
end)

YutaPremiumLib:CreateToggle(TabShop, "Auto Buy Selected Weight", false, function(state)
    autoBuyWeightActive = state
    if autoBuyWeightActive then task.spawn(autoBuyWeightLoop) end
end)

local speedLabels = {}
for _, opt in ipairs(speedOptions) do table.insert(speedLabels, opt.Label) end

YutaPremiumLib:CreateDropdown(TabShop, "Speed", speedLabels, function(selected)
    for _, opt in ipairs(speedOptions) do
        if opt.Label == selected then selectedSpeedIndex = opt.Index break end
    end
end)

YutaPremiumLib:CreateToggle(TabShop, "Auto Buy Selected Speed", false, function(state)
    autoBuySpeedactive = state
    if autoBuySpeedactive then task.spawn(autoBuySpeedLoop) end
end)

-- Tab Misc Features
YutaPremiumLib:CreateButton(TabMisc, "Destroy UI", function()
    farmActive = false
    rebirthActive = false
    autoTrainActive = false
    autoSellActive = false
    autoCollectActive = false
    autoPlaytimeActive = false
    autoIndexActive = false
    autoSeasonFreeActive = false
    autoBuyWeightActive = false
    autoBuySpeedactive = false
    task.wait(0.5)
    if UiWindow.ScreenGui then UiWindow.ScreenGui:Destroy() end
end)

print("Najz Hub UI loaded successfully for Cases for brainrot!")
