local cloneref = (cloneref or clonereference or function(i) return i end)
local Players = cloneref(game:GetService("Players"))
local UIS = cloneref(game:GetService("UserInputService"))
local RunService = cloneref(game:GetService("RunService"))
local TweenService = cloneref(game:GetService("TweenService"))
local CoreGui = cloneref(game:GetService("CoreGui"))
local HttpService = game:GetService("HttpService")

local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")
local Mouse = LP:GetMouse()

local protectgui = protectgui or (syn and syn.protect_gui) or function() end
local gethui = gethui or function() return CoreGui end

local CONFIG_ROOT = "YutaHub"
local DEFAULT_MAP = "Default"

if makefolder and not isfolder(CONFIG_ROOT) then pcall(makefolder, CONFIG_ROOT) end

local T = {
    BG = Color3.fromRGB(14, 14, 17),
    Panel = Color3.fromRGB(22, 22, 27),
    Elem = Color3.fromRGB(30, 30, 37),
    Sel = Color3.fromRGB(28, 28, 34),
    Hover = Color3.fromRGB(40, 40, 50),
    Stroke = Color3.fromRGB(45, 45, 55),
    Border = Color3.fromRGB(70, 70, 86),
    Text = Color3.fromRGB(240, 240, 245),
    Dim = Color3.fromRGB(160, 160, 172),
    Off = Color3.fromRGB(52, 52, 60),
    Accent = Color3.fromRGB(140, 100, 255),
    Red = Color3.fromRGB(255, 50, 50),
    Dark = Color3.new(0, 0, 0),
    White = Color3.new(1, 1, 1),
}

local function new(class, props, parent)
    local o = Instance.new(class)
    for k, v in pairs(props or {}) do o[k] = v end
    if parent then o.Parent = parent end
    return o
end
local function corner(o, r) return new("UICorner", {CornerRadius = UDim.new(0, r)}, o) end
local function stroke(o, c, t) return new("UIStroke", {Color = c or T.Stroke, Thickness = t or 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, o) end
local function pad(o, l, t, r, b)
    return new("UIPadding", {PaddingLeft = UDim.new(0, l), PaddingTop = UDim.new(0, t), PaddingRight = UDim.new(0, r), PaddingBottom = UDim.new(0, b)}, o)
end
local SILVER = Color3.fromRGB(205, 208, 216)
local DARK_EDGE = Color3.fromRGB(12, 12, 14)
local function gradientStroke(o, thickness, rotation)
    local st = new("UIStroke", {
        Color = Color3.new(1, 1, 1), Thickness = thickness or 2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    }, o)
    new("UIGradient", {
        Rotation = rotation or 45,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, SILVER),
            ColorSequenceKeypoint.new(0.25, DARK_EDGE),
            ColorSequenceKeypoint.new(0.50, SILVER),
            ColorSequenceKeypoint.new(0.75, DARK_EDGE),
            ColorSequenceKeypoint.new(1.00, SILVER),
        }),
    }, st)
    return st
end
local function asAsset(v)
    if v == nil or v == "" then return nil end
    if type(v) == "number" or tonumber(v) then return "rbxassetid://" .. v end
    return v
end
local function tween(o, props, t)
    TweenService:Create(o, TweenInfo.new(t or 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end
local function SafeCallback(fn, ...)
    if not (fn and typeof(fn) == "function") then return end
    local ok, err = pcall(fn, ...)
    if not ok then warn("[OX] callback error:", err) end
end
local function IsMouseInput(Input, IncludeM2)
    return Input.UserInputType == Enum.UserInputType.MouseButton1
        or (IncludeM2 and Input.UserInputType == Enum.UserInputType.MouseButton2)
        or Input.UserInputType == Enum.UserInputType.Touch
end
local function IsClickInput(Input, IncludeM2)
    return IsMouseInput(Input, IncludeM2) and Input.UserInputState == Enum.UserInputState.Begin
end
local function IsHoverInput(Input)
    return (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch)
        and Input.UserInputState == Enum.UserInputState.Change
end
local function Round(v, r)
    if r <= 0 then return math.floor(v) end
    return tonumber(string.format("%." .. r .. "f", v))
end

local Icons = {
    ["home"] = "rbxassetid://10723407389", ["menu"] = "rbxassetid://10734887784",
    ["layout-dashboard"] = "rbxassetid://10723424646", ["layout-grid"] = "rbxassetid://10723424838",
    ["list"] = "rbxassetid://10723433811", ["settings"] = "rbxassetid://10734950309",
    ["cog"] = "rbxassetid://10709810948", ["sliders"] = "rbxassetid://10734963400",
    ["sliders-horizontal"] = "rbxassetid://10734963191", ["wrench"] = "rbxassetid://10747383470",
    ["toggle-left"] = "rbxassetid://10734984834", ["toggle-right"] = "rbxassetid://10734985040",
    ["user"] = "rbxassetid://10747373176", ["users"] = "rbxassetid://10747373426",
    ["sword"] = "rbxassetid://10734975486", ["swords"] = "rbxassetid://10734975692",
    ["shield"] = "rbxassetid://10734951847", ["crosshair"] = "rbxassetid://10709818534",
    ["target"] = "rbxassetid://10734977012", ["crown"] = "rbxassetid://10709818626",
    ["trophy"] = "rbxassetid://10747363809", ["gamepad-2"] = "rbxassetid://10723395215",
    ["flame"] = "rbxassetid://10723376114", ["heart"] = "rbxassetid://10723406885",
    ["electricity"] = "rbxassetid://10723345749", ["gem"] = "rbxassetid://10723396000",
    ["coins"] = "rbxassetid://10709811110", ["move"] = "rbxassetid://10734900011",
    ["compass"] = "rbxassetid://10709811445", ["map"] = "rbxassetid://10734886202",
    ["map-pin"] = "rbxassetid://10734886004", ["rocket"] = "rbxassetid://10734934585",
    ["timer"] = "rbxassetid://10734984606", ["eye"] = "rbxassetid://10723346959",
    ["eye-off"] = "rbxassetid://10723346871", ["camera"] = "rbxassetid://10709789686",
    ["palette"] = "rbxassetid://10734910430", ["sun"] = "rbxassetid://10734974297",
    ["moon"] = "rbxassetid://10734897102", ["info"] = "rbxassetid://10723415903",
    ["bell"] = "rbxassetid://10709775704", ["search"] = "rbxassetid://10734943674",
    ["filter"] = "rbxassetid://10723375128", ["link"] = "rbxassetid://10723426722",
    ["copy"] = "rbxassetid://10709812159", ["download"] = "rbxassetid://10723344270",
    ["upload"] = "rbxassetid://10747366434", ["save"] = "rbxassetid://10734941499",
    ["trash"] = "rbxassetid://10747362393", ["trash-2"] = "rbxassetid://10747362241",
    ["edit"] = "rbxassetid://10734883598", ["pencil"] = "rbxassetid://10734919691",
    ["check"] = "rbxassetid://10709790644", ["x"] = "rbxassetid://10747384394",
    ["plus"] = "rbxassetid://10734924532", ["minus"] = "rbxassetid://10734896206",
    ["refresh-cw"] = "rbxassetid://10734933222", ["power"] = "rbxassetid://10734930466",
    ["lock"] = "rbxassetid://10723434711", ["unlock"] = "rbxassetid://10747366027",
    ["key"] = "rbxassetid://10723416652", ["mouse-pointer"] = "rbxassetid://10734898476",
    ["hand"] = "rbxassetid://10723405649", ["grab"] = "rbxassetid://10723404472",
    ["terminal"] = "rbxassetid://10734982144", ["code"] = "rbxassetid://10709810463",
    ["bug"] = "rbxassetid://10709782845", ["cpu"] = "rbxassetid://10709813383",
    ["globe"] = "rbxassetid://10723404337", ["cloud"] = "rbxassetid://10709806740",
    ["folder"] = "rbxassetid://10723387563", ["file"] = "rbxassetid://10723374641",
    ["box"] = "rbxassetid://10709782497", ["activity"] = "rbxassetid://10709752035",
    ["star"] = "rbxassetid://10734966248", ["flag"] = "rbxassetid://10723375890",
    ["tag"] = "rbxassetid://10734976528", ["gift"] = "rbxassetid://10723396402",
    ["mail"] = "rbxassetid://10734885430", ["book"] = "rbxassetid://10709781824",
    ["music"] = "rbxassetid://10734905958", ["headphones"] = "rbxassetid://10723406165",
    ["help-circle"] = "rbxassetid://10723406988", ["alert-circle"] = "rbxassetid://10709752996",
    ["alert-triangle"] = "rbxassetid://10709753149", ["check-circle"] = "rbxassetid://10709790387",
    ["x-circle"] = "rbxassetid://10747383819", ["arrow-up"] = "rbxassetid://10709768939",
    ["arrow-down"] = "rbxassetid://10709767827", ["arrow-left"] = "rbxassetid://10709768114",
    ["arrow-right"] = "rbxassetid://10709768347", ["chevron-up"] = "rbxassetid://10709791523",
    ["chevron-down"] = "rbxassetid://10709790948", ["chevron-left"] = "rbxassetid://10709791281",
    ["chevron-right"] = "rbxassetid://10709791437",
}
local IconAlias = {
    ["house"] = "home", ["zap"] = "electricity", ["bolt"] = "electricity",
    ["circle-alert"] = "alert-circle", ["triangle-alert"] = "alert-triangle",
    ["circle-check"] = "check-circle", ["circle-x"] = "x-circle", ["circle-help"] = "help-circle",
    ["user-round"] = "user", ["sliders-vertical"] = "sliders",
}
local function resolveIcon(icon)
    if icon == nil or icon == "" then return nil end
    if type(icon) == "number" then return "rbxassetid://" .. icon end
    if icon:find("rbxassetid://", 1, true) then return icon end
    if tonumber(icon) then return "rbxassetid://" .. icon end
    local n = icon:lower():gsub("^lucide%-", "")
    n = IconAlias[n] or n
    return Icons[n]
end

local ConfigManager = {}
ConfigManager.Registry = {}
ConfigManager.MapName = DEFAULT_MAP
ConfigManager.Configs = {}

function ConfigManager.SetMap(mapName)
    mapName = mapName or DEFAULT_MAP
    mapName = mapName:gsub("[^%w_%-%s]", "")
    if mapName == "" then mapName = DEFAULT_MAP end
    ConfigManager.MapName = mapName
    local path = CONFIG_ROOT .. "/" .. mapName
    if makefolder and not isfolder(path) then pcall(makefolder, path) end
    ConfigManager.RefreshList()
end

function ConfigManager.GetFolder() return CONFIG_ROOT .. "/" .. ConfigManager.MapName end
function ConfigManager.GetPath(configName) return ConfigManager.GetFolder() .. "/" .. configName .. ".json" end

function ConfigManager.Register(flag, entry)
    if not flag or flag == "" then return end
    ConfigManager.Registry[flag] = entry
end

function ConfigManager.Save(configName)
    if not configName or configName == "" then return false, "no name" end
    if not writefile then return false, "no writefile" end
    local folder = ConfigManager.GetFolder()
    if makefolder and not isfolder(folder) then pcall(makefolder, folder) end
    local data = {}
    for flag, entry in pairs(ConfigManager.Registry) do
        local ok, value = pcall(entry.get)
        if ok and value ~= nil then data[flag] = value end
    end
    local ok, err = pcall(function() writefile(ConfigManager.GetPath(configName), HttpService:JSONEncode(data)) end)
    if ok then ConfigManager.RefreshList() end
    return ok, err
end

function ConfigManager.Load(configName)
    if not isfile then return false end
    local path = ConfigManager.GetPath(configName)
    if not isfile(path) then return false end
    local ok, data = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
    if not ok or type(data) ~= "table" then return false end
    for flag, value in pairs(data) do
        local entry = ConfigManager.Registry[flag]
        if entry then pcall(entry.set, value) end
    end
    return true
end

function ConfigManager.Delete(configName)
    if not delfile or not isfile then return false end
    local path = ConfigManager.GetPath(configName)
    if isfile(path) then
        local ok = pcall(delfile, path)
        if ok then ConfigManager.RefreshList() end
        return ok
    end
    return false
end

function ConfigManager.RefreshList()
    ConfigManager.Configs = {}
    if not listfiles or not isfolder then return end
    local folder = ConfigManager.GetFolder()
    if not isfolder(folder) then return end
    local ok, files = pcall(listfiles, folder)
    if not ok or type(files) ~= "table" then return end
    for _, file in ipairs(files) do
        local name = file:match("([^/\\]+)%.json$")
        if name then table.insert(ConfigManager.Configs, name) end
    end
    table.sort(ConfigManager.Configs)
end

pcall(function()
    if makefolder and not isfolder(CONFIG_ROOT .. "/" .. DEFAULT_MAP) then
        makefolder(CONFIG_ROOT .. "/" .. DEFAULT_MAP)
    end
end)

local OX = {Icons = Icons, Config = ConfigManager}

function OX:CreateWindow(cfg)
    cfg = cfg or {}
    local DESIGN_W = cfg.Width or 720
    local DESIGN_H = cfg.Height or 420

    local Window = {
        Tabs = {}, Binds = {}, Signals = {}, Corners = {},
        UserScale = 1, MenuKey = cfg.ToggleKeybind or Enum.KeyCode.RightShift,
        Toggled = false, Unloaded = false, DPIScale = 1,
        DraggableElements = {}, CantDragForced = false,
    }
    local listening = nil

    local function GiveSignal(conn)
        table.insert(Window.Signals, conn)
        return conn
    end

    if PG:FindFirstChild("OXioHub") then PG.OXioHub:Destroy() end
    local gui = new("ScreenGui", {
        Name = "OXioHub", ResetOnSpawn = false, IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 999,
    })
    pcall(protectgui, gui)
    pcall(function() gui.Parent = gethui() end)
    if not gui.Parent then gui.Parent = PG end
    Window.ScreenGui = gui

    local function MouseIsOverFrame(Frame, pos)
        pos = pos or Vector2.new(Mouse.X, Mouse.Y)
        local ap, as_ = Frame.AbsolutePosition, Frame.AbsoluteSize
        return pos.X >= ap.X and pos.X <= ap.X + as_.X and pos.Y >= ap.Y and pos.Y <= ap.Y + as_.Y
    end
    Window.MouseIsOverFrame = MouseIsOverFrame

    local function MakeDraggable(UI, DragFrame, onClick)
        local StartPos, FramePos, Dragging = nil, nil, false
        local Changed, InputBegan, InputChanged

        InputBegan = DragFrame.InputBegan:Connect(function(Input)
            if not IsClickInput(Input) then return end
            if Window.CantDragForced then return end
            StartPos = Input.Position
            FramePos = UI.Position
            Dragging = true

            Changed = Input.Changed:Connect(function()
                if Input.UserInputState ~= Enum.UserInputState.End then return end
                Dragging = false
                if Changed and Changed.Connected then Changed:Disconnect() Changed = nil end
                if onClick then
                    local moved = (Input.Position - StartPos).Magnitude
                    if moved < 6 then onClick() end
                end
            end)
        end)

        InputChanged = UIS.InputChanged:Connect(function(Input)
            if not (gui and gui.Parent) then Dragging = false return end
            if not Dragging or not IsHoverInput(Input) then return end
            local Delta = Input.Position - StartPos
            local NewX = FramePos.X.Offset + Delta.X
            local NewY = FramePos.Y.Offset + Delta.Y
            UI.Position = UDim2.new(FramePos.X.Scale, NewX, FramePos.Y.Scale, NewY)
        end)

        GiveSignal(InputBegan); GiveSignal(InputChanged)
        UI.Destroying:Once(function()
            if InputBegan and InputBegan.Connected then InputBegan:Disconnect() end
            if InputChanged and InputChanged.Connected then InputChanged:Disconnect() end
            if Changed and Changed.Connected then Changed:Disconnect() end
        end)
    end

    local main = new("Frame", {
        Name = "Main", AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(DESIGN_W, DESIGN_H),
        BackgroundColor3 = T.BG, BorderSizePixel = 0,
        ClipsDescendants = true, Visible = false, Parent = gui,
    })
    corner(main, 10); gradientStroke(main, cfg.BorderThickness or 2, cfg.BorderRotation or 45)
    local scale = new("UIScale", {}, main)

    local function fit()
        local vp = gui.AbsoluteSize
        local s = math.min(1, (vp.X * 0.94) / DESIGN_W, (vp.Y * 0.90) / DESIGN_H)
        scale.Scale = math.max(s, 0.4) * Window.UserScale
    end
    fit()
    Window.Refit = fit
    GiveSignal(gui:GetPropertyChangedSignal("AbsoluteSize"):Connect(fit))

    local header = new("Frame", {Size = UDim2.new(1, 0, 0, 60), BackgroundTransparency = 1}, main)
    local logoImage = asAsset(cfg.LogoImage)
    if logoImage then
        new("ImageLabel", {
            Name = "Logo", Position = UDim2.fromOffset(14, 12), Size = UDim2.fromOffset(42, 42),
            BackgroundTransparency = 1, Image = logoImage, ScaleType = Enum.ScaleType.Fit,
        }, header)
    else
        new("TextLabel", {
            Position = UDim2.fromOffset(16, 13), Size = UDim2.fromOffset(44, 40), BackgroundTransparency = 1,
            Text = cfg.LogoText or "OX", Font = Enum.Font.GothamBlack, TextSize = 26, TextColor3 = T.Text,
        }, header)
    end

    local crownSize = cfg.CrownSize or 26
    local crown = new("ImageLabel", {
        Name = "Crown", AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromOffset(cfg.CrownX or 26, cfg.CrownY or 13),
        Size = UDim2.fromOffset(crownSize, crownSize), BackgroundTransparency = 1,
        Image = resolveIcon(cfg.CrownIcon or "crown") or "", ImageColor3 = cfg.CrownColor or Color3.new(1, 1, 1),
        Rotation = cfg.CrownRotation or -20, Visible = cfg.Crown == true, ZIndex = 5,
    }, header)
    function Window:SetCrown(visible) crown.Visible = visible end
    new("TextLabel", {
        Position = UDim2.fromOffset(68, 10), Size = UDim2.fromOffset(150, 22), BackgroundTransparency = 1,
        Text = cfg.Title or "OXio Hub", Font = Enum.Font.GothamBold, TextSize = 17,
        TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = T.Text,
    }, header)
    new("TextLabel", {
        Position = UDim2.fromOffset(68, 32), Size = UDim2.fromOffset(150, 16), BackgroundTransparency = 1,
        Text = cfg.Subtitle or "Game", Font = Enum.Font.Gotham, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = T.Accent,
    }, header)

    local searchBox = new("TextBox", {
        Position = UDim2.new(0, 230, 0, 14), Size = UDim2.new(1, -310, 0, 32),
        BackgroundColor3 = T.Panel, PlaceholderText = "Search..",
        PlaceholderColor3 = T.Dim, Text = "", ClearTextOnFocus = false,
        Font = Enum.Font.Gotham, TextSize = 14, TextColor3 = T.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, header)
    corner(searchBox, 8); pad(searchBox, 14, 0, 10, 0)

    local dragIcon = new("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0, 30),
        Size = UDim2.fromOffset(32, 32), BackgroundTransparency = 1,
        Text = "✥", Font = Enum.Font.GothamBold, TextSize = 22, TextColor3 = T.Text,
        AutoButtonColor = false,
    }, header)
    MakeDraggable(main, dragIcon)
    MakeDraggable(main, header)

    local sidebar = new("Frame", {Position = UDim2.fromOffset(0, 60), Size = UDim2.new(0, 200, 1, -60), BackgroundTransparency = 1}, main)
    new("Frame", {
        AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0),
        Size = UDim2.new(0, 1, 1, 0), BackgroundColor3 = T.Stroke, BorderSizePixel = 0,
    }, sidebar)

    local tabSearch = new("TextBox", {
        Position = UDim2.fromOffset(12, 6), Size = UDim2.new(1, -25, 0, 32),
        BackgroundColor3 = T.Panel, PlaceholderText = "Search tabs...",
        PlaceholderColor3 = T.Dim, Text = "", ClearTextOnFocus = false,
        Font = Enum.Font.Gotham, TextSize = 13, TextColor3 = T.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, sidebar)
    corner(tabSearch, 6); pad(tabSearch, 10, 0, 6, 0)

    local tabList = new("ScrollingFrame", {
        Position = UDim2.fromOffset(8, 46), Size = UDim2.new(1, -17, 1, -46 - 68),
        BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 0,
        CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
    }, sidebar)
    new("UIListLayout", {Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder}, tabList)

    local card = new("Frame", {
        AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 8, 1, -6),
        Size = UDim2.new(1, -17, 0, 56), BackgroundColor3 = T.Panel,
    }, sidebar)
    corner(card, 8)
    local avatar = new("ImageLabel", {
        Position = UDim2.fromOffset(8, 8), Size = UDim2.fromOffset(40, 40),
        BackgroundColor3 = T.Elem, Image = "",
    }, card)
    corner(avatar, 20)
    task.spawn(function()
        local ok, img = pcall(Players.GetUserThumbnailAsync, Players, LP.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
        if ok then avatar.Image = img end
    end)
    local function censor(s) return s:sub(1, 3) .. "***" end
    new("TextLabel", {
        Position = UDim2.fromOffset(56, 9), Size = UDim2.new(1, -60, 0, 18),
        BackgroundTransparency = 1, Text = censor(LP.DisplayName),
        Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = T.Text,
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
    }, card)
    new("TextLabel", {
        Position = UDim2.fromOffset(56, 28), Size = UDim2.new(1, -60, 0, 16),
        BackgroundTransparency = 1, Text = "@" .. censor(LP.Name),
        Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = T.Dim,
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
    }, card)

    local content = new("Frame", {
        Position = UDim2.fromOffset(200, 60),
        Size = UDim2.new(1, -200, 1, -60), BackgroundTransparency = 1,
    }, main)

    local bg = new("ImageLabel", {
        Name = "Background", Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = T.BG, BorderSizePixel = 0,
        Image = "", ImageTransparency = 0.6,
        ScaleType = Enum.ScaleType.Crop, ZIndex = 0, Parent = content,
    })
    corner(bg, 10)

    Window.SectionFrames = {}
    Window.SectionTransparency = cfg.SectionTransparency or 0.35
    Window.HasBg = false

    function Window:SetBackground(image, imageTransparency)
        local has = image ~= nil and image ~= ""
        if has and tonumber(image) then image = "rbxassetid://" .. image end
        bg.Image = has and image or ""
        if has then bg.BackgroundTransparency = 0 end
        if imageTransparency then bg.ImageTransparency = imageTransparency end
        Window.HasBg = has
        for _, f in ipairs(Window.SectionFrames) do
            f.BackgroundTransparency = has and Window.SectionTransparency or 0
        end
    end

    local pageTitle = new("TextLabel", {
        Position = UDim2.fromOffset(16, 6), Size = UDim2.fromOffset(200, 26),
        BackgroundTransparency = 1, Text = "",
        Font = Enum.Font.GothamBold, TextSize = 15, TextColor3 = T.Text,
        TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2,
    }, content)
    local titleLine = new("Frame", {
        Position = UDim2.fromOffset(16, 34), Size = UDim2.fromOffset(40, 2),
        BackgroundColor3 = T.Text, BorderSizePixel = 0, ZIndex = 2,
    }, content)
    local pages = new("Frame", {
        Position = UDim2.fromOffset(0, 44), Size = UDim2.new(1, 0, 1, -54),
        BackgroundTransparency = 1, ClipsDescendants = true, ZIndex = 2,
    }, content)

    local currentTab
    local function selectTab(tab)
        currentTab = tab
        for _, t in ipairs(Window.Tabs) do
            local on = (t == tab)
            t.Page.Visible = on
            t.Indicator.Visible = on
            tween(t.Button, {BackgroundTransparency = on and 0 or 1})
            tween(t.Label, {TextColor3 = on and T.Text or T.Dim})
            if t.Icon then tween(t.Icon, {ImageColor3 = on and T.Text or T.Dim}) end
        end
        pageTitle.Text = tab.Name
        titleLine.Size = UDim2.fromOffset(pageTitle.TextBounds.X, 2)
    end

    local function applySearch()
        local q = searchBox.Text:lower()
        for _, tab in ipairs(Window.Tabs) do
            for _, sec in ipairs(tab.Sections) do
                local any = false
                for _, e in ipairs(sec.Elements) do
                    local vis = q == "" or e.Name:lower():find(q, 1, true) ~= nil
                    e.Frame.Visible = vis
                    if vis then any = true end
                end
                sec.Frame.Visible = (q == "") or any
            end
        end
    end
    GiveSignal(searchBox:GetPropertyChangedSignal("Text"):Connect(applySearch))
    GiveSignal(tabSearch:GetPropertyChangedSignal("Text"):Connect(function()
        local q = tabSearch.Text:lower()
        for _, t in ipairs(Window.Tabs) do
            t.Button.Visible = q == "" or t.Name:lower():find(q, 1, true) ~= nil
        end
    end))

    function Window:SetVisible(v)
        main.Visible = v
        Window.Toggled = v
    end

    function Window:Toggle()
        Window.Toggled = not Window.Toggled
        main.Visible = Window.Toggled
    end

    local openBtn = new("TextButton", {
        Name = "OpenButton", AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0, 42, 0.32, 0),
        Size = UDim2.fromOffset(52, 52),
        BackgroundColor3 = T.BG, Text = "",
        AutoButtonColor = false, Parent = gui,
    })
    corner(openBtn, 10); gradientStroke(openBtn, 2, 45)

    local openBtnText = new("TextLabel", {
        Name = "Label", Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1, Text = cfg.ToggleText or "OX",
        Font = Enum.Font.GothamBlack, TextSize = 24, TextColor3 = T.Text,
        ZIndex = 2, Parent = openBtn,
    })

    local openBtnImageWrap = new("Frame", {
        Name = "ImageWrap", Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1, Visible = false, Parent = openBtn,
    })
    pad(openBtnImageWrap, 4, 4, 4, 4)
    local openBtnImage = new("ImageLabel", {
        Name = "Image", Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1, Image = "",
        ScaleType = Enum.ScaleType.Fit, ImageColor3 = T.White,
        Visible = false, ZIndex = 2, Parent = openBtnImageWrap,
    })
    corner(openBtnImage, 8)

    if cfg.ToggleImage and cfg.ToggleImage ~= "" then
        local img = cfg.ToggleImage
        if tonumber(img) then img = "rbxassetid://" .. img end
        openBtnText.Visible = false
        openBtnImageWrap.Visible = true
        openBtnImage.Image = img
        openBtnImage.Visible = true
    end

    MakeDraggable(openBtn, openBtn, function() Window:Toggle() end)
    table.insert(Window.DraggableElements, openBtn)
    Window.OpenButton = openBtn

    function Window:SetToggleText(text)
        openBtnText.Text = text
        openBtnText.Visible = true
        openBtnImageWrap.Visible = false
        openBtnImage.Visible = false
    end

    function Window:SetToggleImage(imageId)
        if not imageId or imageId == "" then
            Window:SetToggleText(cfg.ToggleText or "OX")
            return
        end
        if tonumber(imageId) then imageId = "rbxassetid://" .. imageId end
        openBtnText.Visible = false
        openBtnImageWrap.Visible = true
        openBtnImage.Image = imageId
        openBtnImage.Visible = true
    end

    local toast
    function Window:Notify(arg1, arg2, arg3)
        local title, desc, dur
        if type(arg1) == "table" then
            title = arg1.Title; desc = arg1.Description; dur = arg1.Time or 3
        else
            title = arg1; dur = arg2 or 2
        end

        if toast and toast.Parent then toast:Destroy() end
        local t = new("Frame", {
            AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -24),
            Size = UDim2.fromOffset(0, 0), AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundColor3 = T.Panel, ZIndex = 9999, Parent = gui,
        })
        corner(t, 8); stroke(t); pad(t, 12, 8, 12, 8)
        new("UIListLayout", {Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder}, t)

        if title and title ~= "" then
            new("TextLabel", {
                Size = UDim2.fromOffset(0, 18), AutomaticSize = Enum.AutomaticSize.X,
                BackgroundTransparency = 1, Text = title,
                Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = T.Text,
                TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = 1,
            }, t)
        end
        if desc and desc ~= "" then
            new("TextLabel", {
                Size = UDim2.fromOffset(0, 16), AutomaticSize = Enum.AutomaticSize.X,
                BackgroundTransparency = 1, Text = desc,
                Font = Enum.Font.Gotham, TextSize = 13, TextColor3 = T.Dim,
                TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = 2,
            }, t)
        end

        toast = t
        task.delay(dur, function()
            if t and t.Parent then
                tween(t, {BackgroundTransparency = 1}, 0.3)
                for _, c in ipairs(t:GetDescendants()) do
                    if c:IsA("TextLabel") then tween(c, {TextTransparency = 1}, 0.3) end
                end
                task.wait(0.3)
                t:Destroy()
            end
        end)
    end

    function Window:Destroy()
        Window.Unloaded = true
        for _, c in ipairs(Window.Signals) do
            if c and c.Connected then c:Disconnect() end
        end
        gui:Destroy()
    end

    local function keyName(k)
        if not k then return "None" end
        if typeof(k) == "EnumItem" then return k.Name end
        return tostring(k)
    end

    local function parseKey(str)
        if not str or str == "" or str == "None" then return nil end
        local ok, kc = pcall(function() return Enum.KeyCode[str] end)
        if ok and kc then return kc end
        return nil
    end

    function Window:SetMenuKey(key) Window.MenuKey = key end

    GiveSignal(UIS.InputBegan:Connect(function(input, gp)
        if listening then
            if input.UserInputType == Enum.UserInputType.Keyboard then
                local b = listening.bind
                if input.KeyCode == Enum.KeyCode.Backspace or input.KeyCode == Enum.KeyCode.Escape then
                    b.Key = nil
                else
                    b.Key = input.KeyCode
                end
                listening.chip.Text = keyName(b.Key)
                listening = nil
            elseif input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.MouseButton2
                or input.UserInputType == Enum.UserInputType.MouseButton3 then
                local b = listening.bind
                local map = {
                    [Enum.UserInputType.MouseButton1] = "MouseButton1",
                    [Enum.UserInputType.MouseButton2] = "MouseButton2",
                    [Enum.UserInputType.MouseButton3] = "MouseButton3",
                }
                b.Key = map[input.UserInputType]
                listening.chip.Text = b.Key
                listening = nil
            end
            return
        end

        if input.UserInputType == Enum.UserInputType.Keyboard
            and Window.MenuKey
            and input.KeyCode == Window.MenuKey
            and not UIS:GetFocusedTextBox() then
            Window:Toggle()
            return
        end

        if gp then return end
        if UIS:GetFocusedTextBox() then return end

        if input.UserInputType == Enum.UserInputType.Keyboard then
            for _, b in ipairs(Window.Binds) do
                if b.Key and typeof(b.Key) == "EnumItem" and b.Key == input.KeyCode then b.Fire() end
            end
        elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
            for _, b in ipairs(Window.Binds) do
                if b.Key == "MouseButton1" then b.Fire() end
            end
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            for _, b in ipairs(Window.Binds) do
                if b.Key == "MouseButton2" then b.Fire() end
            end
        end
    end))

    local ActiveDropdown = nil
    GiveSignal(UIS.InputBegan:Connect(function(Input)
        if ActiveDropdown and IsClickInput(Input, true) then
            local pos = Input.Position
            if not (MouseIsOverFrame(ActiveDropdown.Menu, pos)
                or MouseIsOverFrame(ActiveDropdown.Display, pos)) then
                ActiveDropdown:Close()
            end
        end
    end))

    Window.ActivePopup = nil

    function Window:ShowDropdownPopup(dd)
        if not dd then return end
        if Window.ActivePopup then
            pcall(function() Window.ActivePopup:Destroy() end)
            Window.ActivePopup = nil
        end

        local Overlay = new("TextButton", {
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = T.Dark,
            BackgroundTransparency = 0.5,
            Text = "",
            AutoButtonColor = false,
            BorderSizePixel = 0,
            ZIndex = 9000,
            Parent = gui,
        })

        local Panel = new("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(400, 380),
            BackgroundColor3 = T.BG,
            BorderSizePixel = 0,
            ZIndex = 9001,
            Parent = Overlay,
        })
        corner(Panel, 10); stroke(Panel)

        new("TextLabel", {
            Position = UDim2.fromOffset(16, 12),
            Size = UDim2.new(1, -60, 0, 26),
            BackgroundTransparency = 1,
            Text = (dd.Text or dd.Name or "Select"),
            Font = Enum.Font.GothamBold,
            TextSize = 15,
            TextColor3 = T.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 9002,
        }, Panel)

        local Close = new("TextButton", {
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, -12, 0, 12),
            Size = UDim2.fromOffset(26, 26),
            BackgroundColor3 = T.Red,
            Text = "X",
            Font = Enum.Font.GothamBold,
            TextSize = 13,
            TextColor3 = T.White,
            AutoButtonColor = false,
            ZIndex = 9002,
            Parent = Panel,
        })
        corner(Close, 6)

        local Scroll = new("ScrollingFrame", {
            Position = UDim2.fromOffset(12, 46),
            Size = UDim2.new(1, -24, 1, -58),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = T.Stroke,
            CanvasSize = UDim2.new(),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ZIndex = 9002,
            Parent = Panel,
        })
        new("UIListLayout", {Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder}, Scroll)

        local function closePopup()
            if Window.ActivePopup == Overlay then Window.ActivePopup = nil end
            pcall(function() Overlay:Destroy() end)
        end

        Close.MouseButton1Click:Connect(closePopup)
        Overlay.MouseButton1Click:Connect(closePopup)

        local isMulti = dd.Multi
        local itemButtons = {}

        local function updateVisual()
            local value = dd:Get()
            for name, btn in pairs(itemButtons) do
                local isSelected
                if isMulti then
                    isSelected = type(value) == "table" and value[name] == true
                else
                    isSelected = value == name
                end
                btn.BackgroundTransparency = isSelected and 0 or 1
                btn.TextTransparency = isSelected and 0 or 0.45
            end
        end

        local rawValues = dd.RawValues or dd.Values or {}
        for i, name in ipairs(rawValues) do
            local btn = new("TextButton", {
                Size = UDim2.new(1, -6, 0, 30),
                BackgroundColor3 = T.Hover,
                BackgroundTransparency = 1,
                Text = tostring(name),
                Font = Enum.Font.Gotham,
                TextSize = 13,
                TextColor3 = T.Text,
                TextTransparency = 0.45,
                TextXAlignment = Enum.TextXAlignment.Left,
                AutoButtonColor = false,
                LayoutOrder = i,
                ZIndex = 9003,
                Parent = Scroll,
            })
            pad(btn, 12, 0, 12, 0)
            corner(btn, 5)

            btn.MouseEnter:Connect(function()
                if btn.BackgroundTransparency == 0 then return end
                btn.BackgroundTransparency = 0.7
            end)
            btn.MouseLeave:Connect(function() updateVisual() end)

            btn.MouseButton1Click:Connect(function()
                if isMulti then
                    local cur = dd:Get()
                    local newValue = {}
                    for k, v in pairs(cur or {}) do newValue[k] = v end
                    if newValue[name] then newValue[name] = nil else newValue[name] = true end
                    dd:Set(newValue)
                else
                    dd:Set(name)
                end
                updateVisual()
            end)

            itemButtons[name] = btn
        end

        updateVisual()
        Window.ActivePopup = Overlay
    end

    function Window:AddPopupButton(dd)
        if not dd or not dd.Display then return end
        local display = dd.Display
        local top = display.Parent
        if not top then return end

        display.Position = UDim2.new(1, -68, 0.5, 0)
        display.Size = UDim2.fromOffset(110, 21)

        new("TextLabel", {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -42, 0.5, 0),
            Size = UDim2.fromOffset(14, 14),
            BackgroundTransparency = 1,
            Text = "v",
            Font = Enum.Font.GothamBold,
            TextSize = 12,
            TextColor3 = T.Dim,
            ZIndex = 4,
            Parent = top,
        })

        local popupBtn = new("TextButton", {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -20, 0.5, 0),
            Size = UDim2.fromOffset(18, 18),
            BackgroundColor3 = T.Elem,
            Text = "+",
            Font = Enum.Font.GothamBold,
            TextSize = 13,
            TextColor3 = T.Text,
            AutoButtonColor = false,
            ZIndex = 4,
            Parent = top,
        })
        corner(popupBtn, 4); stroke(popupBtn, T.Stroke, 1)

        popupBtn.MouseEnter:Connect(function() tween(popupBtn, {BackgroundColor3 = T.Hover}, 0.1) end)
        popupBtn.MouseLeave:Connect(function() tween(popupBtn, {BackgroundColor3 = T.Elem}, 0.1) end)
        popupBtn.MouseButton1Click:Connect(function() Window:ShowDropdownPopup(dd) end)
    end

    function Window:AddTab(name, icon)
        local Tab = {Name = name, Sections = {}, ColCount = {0, 0}}

        Tab.Button = new("TextButton", {
            Size = UDim2.new(1, 0, 0, 40), BackgroundColor3 = T.Sel,
            BackgroundTransparency = 1, Text = "", AutoButtonColor = false,
            LayoutOrder = #Window.Tabs,
        }, tabList)
        corner(Tab.Button, 8)
        local iconId = resolveIcon(icon)
        if iconId then
            Tab.Icon = new("ImageLabel", {
                Position = UDim2.fromOffset(16, 10), Size = UDim2.fromOffset(20, 20),
                BackgroundTransparency = 1, Image = iconId, ImageColor3 = T.Dim,
            }, Tab.Button)
        end
        local labelX = iconId and 46 or 22
        Tab.Label = new("TextLabel", {
            Position = UDim2.fromOffset(labelX, 0), Size = UDim2.new(1, -labelX, 1, 0),
            BackgroundTransparency = 1, Text = name, Font = Enum.Font.GothamMedium,
            TextSize = 15, TextColor3 = T.Dim, TextXAlignment = Enum.TextXAlignment.Left,
        }, Tab.Button)
        Tab.Indicator = new("Frame", {
            AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 4, 0.5, 0),
            Size = UDim2.fromOffset(3, 22), BackgroundColor3 = T.Text,
            BorderSizePixel = 0, Visible = false,
        }, Tab.Button)
        corner(Tab.Indicator, 2)

        Tab.Page = new("ScrollingFrame", {
            Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
            BorderSizePixel = 0, Visible = false, ScrollBarThickness = 3,
            ScrollBarImageColor3 = T.Stroke, CanvasSize = UDim2.new(),
            AutomaticCanvasSize = Enum.AutomaticSize.Y, ZIndex = 2,
        }, pages)
        pad(Tab.Page, 12, 4, 12, 0)
        new("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder}, Tab.Page)
        local holder = new("Frame", {
            Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1, LayoutOrder = 0, ZIndex = 2,
        }, Tab.Page)
        new("Frame", {Size = UDim2.new(1, 0, 0, 18), BackgroundTransparency = 1, LayoutOrder = 1}, Tab.Page)
        Tab.Cols = {}
        for i = 1, 2 do
            local col = new("Frame", {
                Position = i == 1 and UDim2.new() or UDim2.new(0.5, 6, 0, 0),
                Size = UDim2.new(0.5, -6, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, ZIndex = 2,
            }, holder)
            new("UIListLayout", {Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder}, col)
            Tab.Cols[i] = col
        end

        Tab.Button.MouseButton1Click:Connect(function() selectTab(Tab) end)
        table.insert(Window.Tabs, Tab)
        if #Window.Tabs == 1 then selectTab(Tab) end

        function Tab:AddSection(title, column, icon)
            column = column or ((Tab.ColCount[1] <= Tab.ColCount[2]) and 1 or 2)
            Tab.ColCount[column] += 1
            local Section = {Elements = {}}

            Section.Frame = new("Frame", {
                Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = T.Panel,
                BackgroundTransparency = Window.HasBg and Window.SectionTransparency or 0,
                LayoutOrder = Tab.ColCount[column], ZIndex = 2,
            }, Tab.Cols[column])
            corner(Section.Frame, 8); stroke(Section.Frame, T.Border, 1)
            table.insert(Window.SectionFrames, Section.Frame)
            new("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder}, Section.Frame)

            local head = new("TextButton", {
                Size = UDim2.new(1, 0, 0, 38), BackgroundTransparency = 1,
                Text = "", AutoButtonColor = false, LayoutOrder = 0, ZIndex = 3,
            }, Section.Frame)
            pad(head, 14, 0, 14, 0)
            local secIcon = resolveIcon(icon)
            if secIcon then
                new("ImageLabel", {
                    Position = UDim2.fromOffset(0, 9), Size = UDim2.fromOffset(20, 20),
                    BackgroundTransparency = 1, Image = secIcon, ImageColor3 = T.Text, ZIndex = 3,
                }, head)
            end
            new("TextLabel", {
                Position = UDim2.fromOffset(secIcon and 28 or 0, 0),
                Size = UDim2.new(1, secIcon and -48 or -20, 1, 0),
                BackgroundTransparency = 1, Text = title, Font = Enum.Font.GothamBold,
                TextSize = 15, TextColor3 = T.Text, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3,
            }, head)
            local arrow = new("TextLabel", {
                AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0),
                Size = UDim2.fromOffset(20, 38), BackgroundTransparency = 1,
                Text = "v", Font = Enum.Font.GothamMedium, TextSize = 13, TextColor3 = T.Dim, ZIndex = 3,
            }, head)
            local lineWrap = new("Frame", {Size = UDim2.new(1, 0, 0, 1), BackgroundTransparency = 1, LayoutOrder = 1, ZIndex = 3}, Section.Frame)
            new("Frame", {Size = UDim2.new(1, -28, 0, 1), BackgroundColor3 = T.Text, BorderSizePixel = 0, Position = UDim2.fromOffset(14, 0), ZIndex = 3}, lineWrap)

            Section.Content = new("Frame", {
                Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1, LayoutOrder = 2, ZIndex = 3,
            }, Section.Frame)
            pad(Section.Content, 14, 6, 14, 10)
            new("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, Section.Content)

            local open = true
            head.MouseButton1Click:Connect(function()
                open = not open
                Section.Content.Visible = open
                arrow.Text = open and "v" or ">"
            end)

            local function register(name, frame)
                table.insert(Section.Elements, {Name = name, Frame = frame})
            end

            function Section:AddToggle(o)
                local state = o.Default == true
                local flag = o.Flag or o.Text or o.Name or ("Toggle_" .. tostring(#Section.Elements))

                local row = new("Frame", {Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, ZIndex = 3}, Section.Content)
                new("TextLabel", {
                    Size = UDim2.new(1, -118, 1, 0), BackgroundTransparency = 1,
                    Text = o.Text or o.Name or "Toggle", Font = Enum.Font.Gotham,
                    TextSize = 14, TextColor3 = T.Dim, TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 3,
                }, row)

                local sw = new("TextButton", {
                    AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
                    Size = UDim2.fromOffset(44, 22), BackgroundColor3 = T.Off,
                    Text = "", AutoButtonColor = false, ZIndex = 3,
                }, row)
                corner(sw, 11)
                local knob = new("Frame", {
                    AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 2, 0.5, 0),
                    Size = UDim2.fromOffset(18, 18), BackgroundColor3 = T.White, ZIndex = 3,
                }, sw)
                corner(knob, 9)

                local obj = {}
                local function set(v, silent)
                    state = v and true or false
                    tween(sw, {BackgroundColor3 = state and T.Accent or T.Off})
                    tween(knob, {Position = state and UDim2.new(1, -20, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)})
                    if not silent then SafeCallback(o.Callback, state) end
                end
                sw.MouseButton1Click:Connect(function() set(not state) end)

                if o.Keybind ~= false then
                    local bind = {Key = o.DefaultKey, Fire = function() set(not state) end}
                    table.insert(Window.Binds, bind)
                    local chip = new("TextButton", {
                        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -52, 0.5, 0),
                        Size = UDim2.fromOffset(50, 20), BackgroundColor3 = T.Elem,
                        Text = keyName(bind.Key), Font = Enum.Font.GothamBold, TextSize = 10,
                        TextColor3 = T.Text, AutoButtonColor = false, ZIndex = 3,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                    }, row)
                    corner(chip, 5)
                    chip.MouseButton1Click:Connect(function()
                        if listening and listening.chip == chip then
                            listening = nil
                            chip.Text = keyName(bind.Key)
                            return
                        end
                        listening = {bind = bind, chip = chip}
                        chip.Text = "..."
                    end)
                end

                function obj:Set(v, silent) set(v, silent) end
                function obj:Get() return state end
                if state then set(true, true) end
                register(o.Text or o.Name or "Toggle", row)

                ConfigManager.Register(flag, {
                    get = function() return state end,
                    set = function(v) set(v, true); SafeCallback(o.Callback, state) end,
                })

                return obj
            end

            function Section:AddSlider(o)
                local min, max, inc = o.Min or 0, o.Max or 100, o.Increment or 1
                local value = math.clamp(o.Default or min, min, max)
                local flag = o.Flag or o.Text or o.Name or ("Slider_" .. tostring(#Section.Elements))
                local rounding = o.Rounding or (inc < 1 and 2 or 0)
                local suffix = o.Suffix or ""

                local row = new("Frame", {Size = UDim2.new(1, 0, 0, 46), BackgroundTransparency = 1, ZIndex = 3}, Section.Content)
                new("TextLabel", {
                    Size = UDim2.new(1, -60, 0, 24), BackgroundTransparency = 1,
                    Text = o.Text or o.Name or "Slider", Font = Enum.Font.Gotham,
                    TextSize = 14, TextColor3 = T.Dim, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3,
                }, row)
                local valLbl = new("TextLabel", {
                    AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0),
                    Size = UDim2.fromOffset(80, 24), BackgroundTransparency = 1, Text = "",
                    Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = T.Text,
                    TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 3,
                }, row)
                local track = new("Frame", {
                    Position = UDim2.new(0, 0, 0, 33), Size = UDim2.new(1, 0, 0, 4),
                    BackgroundColor3 = T.Elem, BorderSizePixel = 0, ZIndex = 3,
                }, row)
                corner(track, 2)
                local fill = new("Frame", {Size = UDim2.new(0, 0, 1, 0), BackgroundColor3 = T.Text, BorderSizePixel = 0, ZIndex = 3}, track)
                corner(fill, 2)
                local knob = new("Frame", {
                    AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
                    Size = UDim2.fromOffset(12, 12), BackgroundColor3 = T.White, ZIndex = 3,
                }, fill)
                corner(knob, 6)
                local hit = new("TextButton", {
                    Position = UDim2.new(0, -6, 0, 24), Size = UDim2.new(1, 12, 0, 22),
                    BackgroundTransparency = 1, Text = "", ZIndex = 3,
                }, row)

                local function render()
                    local a = (value - min) / (max - min)
                    fill.Size = UDim2.new(a, 0, 1, 0)
                    valLbl.Text = tostring(Round(value, rounding)) .. suffix
                end
                local function set(v, silent)
                    v = math.clamp(math.floor(v / inc + 0.5) * inc, min, max)
                    if v == value and not silent then return end
                    value = v
                    render()
                    if not silent then SafeCallback(o.Callback, value) end
                end
                local function fromInput(x)
                    local a = math.clamp((x - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
                    set(min + (max - min) * a)
                end

                local dragging = false
                hit.InputBegan:Connect(function(input)
                    if IsClickInput(input) then
                        dragging = true
                        Tab.Page.ScrollingEnabled = false
                        fromInput(input.Position.X)
                    end
                end)
                GiveSignal(UIS.InputChanged:Connect(function(input)
                    if dragging and IsHoverInput(input) then fromInput(input.Position.X) end
                end))
                GiveSignal(UIS.InputEnded:Connect(function(input)
                    if dragging and IsMouseInput(input) then
                        dragging = false
                        Tab.Page.ScrollingEnabled = true
                    end
                end))

                render()
                register(o.Text or o.Name or "Slider", row)
                local obj = {}
                function obj:Set(v, silent) set(v, silent) end
                function obj:Get() return value end

                ConfigManager.Register(flag, {
                    get = function() return value end,
                    set = function(v) set(v, true); SafeCallback(o.Callback, value) end,
                })

                return obj
            end

            function Section:AddButton(o)
                local btn = new("TextButton", {
                    Size = UDim2.new(1, 0, 0, 32), BackgroundColor3 = T.Elem,
                    Text = o.Text or o.Name or "Button", Font = Enum.Font.GothamMedium,
                    TextSize = 14, TextColor3 = T.Text, AutoButtonColor = true, ZIndex = 3,
                }, Section.Content)
                corner(btn, 6)
                if o.Risky then btn.TextColor3 = T.Red end
                btn.MouseButton1Click:Connect(function() SafeCallback(o.Callback or o.Func) end)
                register(o.Text or o.Name or "Button", btn)
            end

            function Section:AddLabel(text)
                local l = new("TextLabel", {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    Text = text, Font = Enum.Font.Gotham, TextSize = 13,
                    TextColor3 = T.Dim, TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true, ZIndex = 3,
                }, Section.Content)
                pad(l, 0, 2, 0, 2)
                register(text, l)
                return {
                    SetText = function(self, t) l.Text = t end,
                    Holder = l,
                }
            end

            function Section:AddDivider()
                local wrap = new("Frame", {Size = UDim2.new(1, 0, 0, 10), BackgroundTransparency = 1, ZIndex = 3}, Section.Content)
                new("Frame", {
                    AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromScale(0, 0.5),
                    Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = T.Stroke,
                    BorderSizePixel = 0, ZIndex = 3,
                }, wrap)
                return wrap
            end

            function Section:AddDropdown(o)
                local multi = o.Multi == true
                local options = o.Options or o.Values or {}
                local maxVisible = o.MaxVisibleItems or 8
                local ITEM_HEIGHT = 21
                local flag = o.Flag or o.Text or o.Name or ("Dropdown_" .. tostring(#Section.Elements))

                local value
                if multi then
                    value = {}
                    if type(o.Default) == "table" then
                        for _, v in ipairs(o.Default) do value[v] = true end
                    end
                else
                    value = o.Default
                end

                local root = new("Frame", {
                    Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1, ZIndex = 3,
                }, Section.Content)
                new("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, root)

                local top = new("Frame", {Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, LayoutOrder = 0, ZIndex = 3}, root)
                new("TextLabel", {
                    Size = UDim2.new(1, -180, 1, 0), BackgroundTransparency = 1,
                    Text = o.Text or o.Name or "Dropdown", Font = Enum.Font.Gotham,
                    TextSize = 14, TextColor3 = T.Dim,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 3,
                }, top)

                local display = new("TextButton", {
                    AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
                    Size = UDim2.fromOffset(132, 21), BackgroundColor3 = T.Elem,
                    Text = "", AutoButtonColor = false, ZIndex = 3,
                }, top)
                corner(display, 6); stroke(display, T.Stroke, 1)
                pad(display, 8, 0, 22, 0)

                local valueLbl = new("TextLabel", {
                    Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
                    Text = "---", Font = Enum.Font.Gotham, TextSize = 12,
                    TextColor3 = T.Text, TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 3,
                }, display)

                local arrow = new("TextLabel", {
                    AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -4, 0.5, 0),
                    Size = UDim2.fromOffset(14, 14), BackgroundTransparency = 1,
                    Text = "v", Font = Enum.Font.GothamBold, TextSize = 12,
                    TextColor3 = T.Dim, ZIndex = 3,
                }, display)

                local Menu = new("Frame", {
                    BackgroundColor3 = T.Elem, Visible = false,
                    Size = UDim2.fromOffset(132, 0),
                    BorderSizePixel = 0, ZIndex = 8000, Parent = gui,
                })
                corner(Menu, 6); stroke(Menu, T.Stroke, 1)

                local Scroll = new("ScrollingFrame", {
                    BackgroundTransparency = 1, BorderSizePixel = 0,
                    Size = UDim2.fromScale(1, 1),
                    CanvasSize = UDim2.new(),
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 3, ScrollBarImageColor3 = T.Stroke,
                    ScrollingDirection = Enum.ScrollingDirection.Y,
                    ZIndex = 8001, Parent = Menu,
                })
                pad(Scroll, 4, 4, 4, 4)
                new("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder}, Scroll)

                local itemButtons = {}
                local function getValue()
                    if not multi then return value end
                    local out = {}
                    for _, n in ipairs(options) do if value[n] then table.insert(out, n) end end
                    return out
                end

                local function refreshDisplay()
                    local text
                    if multi then
                        local v = getValue()
                        text = #v > 0 and table.concat(v, ", ") or "---"
                    else
                        text = value or "---"
                    end
                    if #text > 25 then text = text:sub(1, 22) .. "..." end
                    valueLbl.Text = text
                end

                local function refreshItems()
                    for name, btn in pairs(itemButtons) do
                        local isSelected = multi and value[name] == true or (not multi and value == name)
                        btn.TextTransparency = isSelected and 0 or 0.5
                        btn.BackgroundTransparency = isSelected and 0 or 1
                    end
                end

                local function recalcSize()
                    local count = #options
                    local visibleCount = math.min(count, maxVisible)
                    local height = visibleCount * ITEM_HEIGHT + 8
                    Menu.Size = UDim2.fromOffset(display.AbsoluteSize.X, height)
                end

                local function positionMenu()
                    local pos = display.AbsolutePosition
                    local size = display.AbsoluteSize
                    Menu.Position = UDim2.fromOffset(math.floor(pos.X), math.floor(pos.Y + size.Y + 2))
                end

                local function build()
                    for _, b in pairs(itemButtons) do b:Destroy() end
                    itemButtons = {}
                    Scroll.CanvasPosition = Vector2.new(0, 0)

                    for i, name in ipairs(options) do
                        local item = new("TextButton", {
                            Size = UDim2.new(1, 0, 0, ITEM_HEIGHT),
                            BackgroundColor3 = T.Hover, BackgroundTransparency = 1,
                            Text = name, Font = Enum.Font.Gotham, TextSize = 13,
                            TextColor3 = T.Text, TextTransparency = 0.5,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            AutoButtonColor = false, LayoutOrder = i, ZIndex = 8002,
                        }, Scroll)
                        pad(item, 8, 0, 8, 0)

                        item.MouseEnter:Connect(function()
                            if (multi and value[name]) or (not multi and value == name) then return end
                            tween(item, {TextTransparency = 0.25}, 0.1)
                            tween(item, {BackgroundTransparency = 0.85}, 0.1)
                        end)
                        item.MouseLeave:Connect(function()
                            if (multi and value[name]) or (not multi and value == name) then return end
                            tween(item, {TextTransparency = 0.5}, 0.1)
                            tween(item, {BackgroundTransparency = 1}, 0.1)
                        end)

                        item.MouseButton1Click:Connect(function()
                            if multi then
                                value[name] = (not value[name]) or nil
                                refreshItems()
                                refreshDisplay()
                                SafeCallback(o.Callback, getValue())
                            else
                                value = name
                                refreshItems()
                                refreshDisplay()
                                SafeCallback(o.Callback, getValue())
                                Dropdown:Close()
                            end
                        end)

                        itemButtons[name] = item
                    end
                    refreshItems()
                    recalcSize()
                end

                local Dropdown = {}
                Dropdown.Display = display
                Dropdown.Menu = Menu
                Dropdown.Active = false

                function Dropdown:Open()
                    if ActiveDropdown and ActiveDropdown ~= Dropdown then ActiveDropdown:Close() end
                    ActiveDropdown = Dropdown
                    Dropdown.Active = true
                    positionMenu()
                    recalcSize()
                    Menu.Visible = true
                    tween(arrow, {Rotation = 180}, 0.15)
                end

                function Dropdown:Close()
                    if ActiveDropdown == Dropdown then ActiveDropdown = nil end
                    Dropdown.Active = false
                    Menu.Visible = false
                    tween(arrow, {Rotation = 0}, 0.15)
                end

                function Dropdown:Toggle()
                    if Dropdown.Active then Dropdown:Close() else Dropdown:Open() end
                end

                display.MouseButton1Click:Connect(function() Dropdown:Toggle() end)

                GiveSignal(display:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
                    if Dropdown.Active then positionMenu() end
                end))

                refreshDisplay()
                build()

                register(o.Text or o.Name or "Dropdown", root)

                local obj = {}
                obj.Display = display
                obj.Menu = Menu
                obj.Multi = multi
                obj.Values = options
                obj.RawValues = options
                obj.Text = o.Text or o.Name or "Dropdown"
                obj.Name = o.Text or o.Name or "Dropdown"

                function obj:Get() return getValue() end
                function obj:Set(v, silent)
                    if multi then
                        value = {}
                        for _, n in ipairs(v or {}) do value[n] = true end
                    else
                        value = v
                    end
                    refreshDisplay()
                    refreshItems()
                    if not silent then SafeCallback(o.Callback, getValue()) end
                end
                function obj:SetValue(v) obj:Set(v) end
                function obj:Refresh(newOptions)
                    options = newOptions or {}
                    obj.Values = options
                    obj.RawValues = options
                    value = multi and {} or nil
                    build()
                    refreshDisplay()
                end
                function obj:SetValues(v) obj:Refresh(v) end

                ConfigManager.Register(flag, {
                    get = function() return getValue() end,
                    set = function(v) obj:Set(v, true); SafeCallback(o.Callback, getValue()) end,
                })

                return obj
            end

            function Section:AddInput(o)
                local flag = o.Flag or o.Text or o.Name or ("Input_" .. tostring(#Section.Elements))

                local row = new("Frame", {Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, ZIndex = 3}, Section.Content)
                new("TextLabel", {
                    Size = UDim2.new(1, -140, 1, 0), BackgroundTransparency = 1,
                    Text = o.Text or o.Name or "Input", Font = Enum.Font.Gotham,
                    TextSize = 14, TextColor3 = T.Dim,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 3,
                }, row)
                local box = new("TextBox", {
                    AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
                    Size = UDim2.fromOffset(132, 26), BackgroundColor3 = T.Elem,
                    Text = o.Default ~= nil and tostring(o.Default) or "",
                    PlaceholderText = o.Placeholder or "", PlaceholderColor3 = T.Dim,
                    ClearTextOnFocus = false, Font = Enum.Font.GothamMedium,
                    TextSize = 12, TextColor3 = T.Text,
                    TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3,
                }, row)
                corner(box, 6); pad(box, 8, 0, 8, 0)

                local function commit()
                    if o.Numeric then
                        local n = tonumber(box.Text)
                        if not n then box.Text = o.Default ~= nil and tostring(o.Default) or "" return end
                        if o.Min then n = math.max(n, o.Min) end
                        if o.Max then n = math.min(n, o.Max) end
                        box.Text = tostring(n)
                        SafeCallback(o.Callback, n)
                    else
                        SafeCallback(o.Callback, box.Text)
                    end
                end

                box.FocusLost:Connect(commit)
                register(o.Text or o.Name or "Input", row)

                local obj = {}
                function obj:Get() return o.Numeric and tonumber(box.Text) or box.Text end
                function obj:Set(v, silent)
                    box.Text = tostring(v)
                    if not silent then commit() end
                end

                ConfigManager.Register(flag, {
                    get = function() return obj:Get() end,
                    set = function(v) box.Text = tostring(v); SafeCallback(o.Callback, obj:Get()) end,
                })

                return obj
            end

            function Section:AddKeybind(o)
                local flag = o.Flag or o.Text or o.Name or ("Keybind_" .. tostring(#Section.Elements))

                local row = new("Frame", {Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, ZIndex = 3}, Section.Content)
                new("TextLabel", {
                    Size = UDim2.new(1, -100, 1, 0), BackgroundTransparency = 1,
                    Text = o.Text or o.Name or "Keybind", Font = Enum.Font.Gotham,
                    TextSize = 14, TextColor3 = T.Dim,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 3,
                }, row)
                local bind = {Key = o.Default}
                bind.Fire = function() SafeCallback(o.Callback, bind.Key) end
                table.insert(Window.Binds, bind)

                local chip = new("TextButton", {
                    AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
                    Size = UDim2.fromOffset(90, 24), BackgroundColor3 = T.Elem,
                    Text = keyName(bind.Key), Font = Enum.Font.GothamBold,
                    TextSize = 11, TextColor3 = T.Text, AutoButtonColor = false,
                    TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 3,
                }, row)
                corner(chip, 6)

                chip.MouseButton1Click:Connect(function()
                    if listening and listening.chip == chip then
                        listening = nil
                        chip.Text = keyName(bind.Key)
                        return
                    end
                    listening = {bind = bind, chip = chip}
                    chip.Text = "..."
                end)

                register(o.Text or o.Name or "Keybind", row)
                local obj = {}
                function obj:Get() return bind.Key end
                function obj:Set(v)
                    bind.Key = v
                    chip.Text = keyName(bind.Key)
                end

                ConfigManager.Register(flag, {
                    get = function()
                        if typeof(bind.Key) == "EnumItem" then return bind.Key.Name end
                        return bind.Key
                    end,
                    set = function(v)
                        if type(v) == "string" then
                            local kc = parseKey(v)
                            bind.Key = kc or v
                        else
                            bind.Key = v
                        end
                        chip.Text = keyName(bind.Key)
                    end,
                })

                return obj
            end

            function Section:AddCopyButton(o)
                local root = new("Frame", {
                    Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1, ZIndex = 3,
                }, Section.Content)
                new("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, root)
                local btn = new("TextButton", {
                    Size = UDim2.new(1, 0, 0, 32), BackgroundColor3 = T.Elem,
                    Text = o.Name or "Copy", Font = Enum.Font.GothamMedium,
                    TextSize = 14, TextColor3 = T.Text, AutoButtonColor = true,
                    LayoutOrder = 0, ZIndex = 3,
                }, root)
                corner(btn, 6)
                local linkBox = new("TextBox", {
                    Size = UDim2.new(1, 0, 0, 28), BackgroundColor3 = T.Elem,
                    Text = o.Link or "", TextEditable = false,
                    ClearTextOnFocus = false, Font = Enum.Font.Gotham,
                    TextSize = 12, TextColor3 = T.Dim,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Visible = false, LayoutOrder = 1, ZIndex = 3,
                }, root)
                corner(linkBox, 6); pad(linkBox, 8, 0, 8, 0)

                btn.MouseButton1Click:Connect(function()
                    local fn = setclipboard or toclipboard
                    if fn and pcall(fn, o.Link) then
                        Window:Notify({Title = "Copied", Description = "Link disalin!", Time = 2})
                    else
                        linkBox.Visible = true
                        Window:Notify({Title = "Manual", Description = "Salin dari kotak", Time = 3})
                    end
                end)
                register(o.Name or "Copy", root)
                return btn
            end

            table.insert(Tab.Sections, Section)
            return Section
        end

        return Tab
    end

    task.defer(function()
        Window:SetBackground(cfg.Background, cfg.BackgroundTransparency)
    end)

    Window:Toggle()
    return Window
end

return OX
