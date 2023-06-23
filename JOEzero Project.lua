
local repo = 'https://raw.githubusercontent.com/JOEzeros/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({ Title = 'JoeXPaid | Rewritten | BETA | v2.1', Center = true, AutoShow = true, })


--Tabs
--------------------------------------------------------------------
local Tabs = {
    CombatTab = Window:AddTab('Combat'),
    VisualsTab = Window:AddTab('Visuals'),
    MiscellaneousTab = Window:AddTab('Miscellaneous'),
    SettingsTab = Window:AddTab('Settings'),
    UISettings = Window:AddTab('UI Menu'),
}
--------------------------------------------------------------------


--CombatTab | Groupboxes
local HitboxExpander = Tabs.CombatTab:AddLeftGroupbox("Hitbox")

--VisualsTab | Tabboxes
local CustomHitsoundsTabBox = Tabs.MiscellaneousTab:AddRightTabbox('Hitsounds')

--VisualsTab | Groupboxes
local CrosshairSect = Tabs.MiscellaneousTab:AddLeftGroupbox('Crosshair')
local PlayerEspSect = Tabs.VisualsTab:AddLeftGroupbox('Player Esp')
local BaseEspSect = Tabs.VisualsTab:AddLeftGroupbox('Base Esp')
local LightSect = Tabs.MiscellaneousTab:AddLeftGroupbox('Lighting')
local ArmSect = Tabs.MiscellaneousTab:AddLeftGroupbox('Arms')
local WorldSect = Tabs.VisualsTab:AddLeftGroupbox('World')

--SettingsTab | Groupboxes
local NotificationSect = Tabs.SettingsTab:AddLeftGroupbox('Notifications')
local GuiSect = Tabs.SettingsTab:AddLeftGroupbox('GUIS')
local WatermarkSect = Tabs.SettingsTab:AddLeftGroupbox('Watermarks')

--UISettings | Groupboxes
local MenuGroup = Tabs.UISettings:AddLeftGroupbox('Menu')


--Notification setup
--------------------------------------------------------------------
local Silent = false
local AdminNotification = false
local PlayerJoinedNotification = false
local PlayerLeftNotification = false
local NotificationFillColor = Color3.fromRGB(0, 0, 0)
local NotificationBorderColor = Color3.new(0/255, 97/255, 106/255)
local NotificationTextColor = Color3.new(1, 1, 1)
local NotificationTitleColor = Color3.new(1, 1, 1)
local AdminSoundId = "rbxassetid://3398620867"  -- Replace with the actual asset ID
local AdminSound = Instance.new("Sound")
AdminSound.SoundId = AdminSoundId
AdminSound.Volume = 0.5
AdminSound.Pitch = 1.2
AdminSound.Looped = true
AdminSound.Parent = workspace
local adminNames = {
    ["The2AnOnly"] = true,
    ["Aulut"] = true,
    ["Fredo"] = true,
    ["silversmonpman"] = true,
    ["LordVahoha"] = true,
    ["0EX"] = true,
}

function showNotification(title, text, duration)
    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local notificationGui = Instance.new("ScreenGui")
    local notificationFrame = Instance.new("Frame")
    local notificationTitle = Instance.new("TextLabel")
    local notificationText = Instance.new("TextLabel")

    notificationGui.Name = "NotificationGui"
    notificationGui.ResetOnSpawn = false
    notificationGui.DisplayOrder = 10
    notificationGui.Parent = playerGui

    notificationFrame.Name = "NotificationFrame"
    notificationFrame.AnchorPoint = Vector2.new(0, 1)
    notificationFrame.BackgroundColor3 = NotificationFillColor
    notificationFrame.BorderSizePixel = 2
    notificationFrame.BorderColor3 = NotificationBorderColor
    notificationFrame.Position = UDim2.new(0, 10, 1, -10)
    notificationFrame.Size = UDim2.new(0, 300, 0, 80)
    notificationFrame.Parent = notificationGui

    notificationTitle.Name = "Title"
    notificationTitle.AnchorPoint = Vector2.new(0, 0)
    notificationTitle.BackgroundTransparency = 1
    notificationTitle.Font = Enum.Font.Cartoon
    notificationTitle.Position = UDim2.new(0, 10, 0, 10)
    notificationTitle.Size = UDim2.new(1, -20, 0, 25)
    notificationTitle.Text = title
    notificationTitle.TextColor3 = NotificationTitleColor
    notificationTitle.TextSize = 20
    notificationTitle.Parent = notificationFrame

    notificationText.Name = "Text"
    notificationText.AnchorPoint = Vector2.new(0, 0)
    notificationText.BackgroundTransparency = 1
    notificationText.Font = Enum.Font.Cartoon
    notificationText.Position = UDim2.new(0, 10, 0, 35)
    notificationText.Size = UDim2.new(1, -20, 0, 35)
    notificationText.Text = text
    notificationText.TextColor3 = NotificationTextColor
    notificationText.TextSize = 16
    notificationText.Parent = notificationFrame

    notificationFrame:TweenPosition(
        UDim2.new(0, 10, 1, -(notificationFrame.Size.Y.Offset + 10)),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quint,
        0.5,
        true
    )
    wait(duration)

notificationFrame:TweenPosition(
    UDim2.new(0, 10, 1, 70),
    Enum.EasingDirection.Out,
    Enum.EasingStyle.Quint,
    0.5,
    true,
    function()
        notificationGui:Destroy()
    end
)
end

game.Players.PlayerAdded:Connect(function(player)
    if adminNames[player.DisplayName] then
        if not Silent and AdminNotification then
            showNotification("Notification", player.DisplayName .. " | Admin Joined", 2)
            print("Notification", "" ..player.DisplayName.. "Admin | Joined", 5 )
            AdminSound:Play()
            wait(5)
            AdminSound:Stop()
        end
    else
        if not Silent and PlayerJoinedNotification then
            if player:IsFriendsWith(game.Players.LocalPlayer.UserId) then
                showNotification("Notification", "" ..player.DisplayName.. "Friend | Joined", 2)
            else
                showNotification("Notification", "" ..player.DisplayName.. " | Joined", 2)
            end
        end
    end
end)

game.Players.PlayerRemoving:Connect(function(player)
    if not Silent and PlayerLeftNotification then
	if player:IsFriendsWith(game.Players.LocalPlayer.UserId) then
		showNotification("Notification", "" ..player.DisplayName.. "Friend | Left", 2)
	else
		showNotification("Notification", "" ..player.DisplayName.. " | Left", 2)
	end
end
end)

NotificationSect:AddToggle('SilentToggle', { Text = 'Enable', Default = false, Tooltip = nil, })
Toggles.SilentToggle:OnChanged(function(ST)
    if ST == true then
        Silent = false
    elseif ST == false then
        Silent = true
    end
end)

NotificationSect:AddToggle('PlayerJoinNotification', { Text = 'Player Join Notification', Default = false, Tooltip = nil, })
Toggles.PlayerJoinNotification:OnChanged(function(PJN)
    if PJN == true then
        PlayerJoinedNotification = true
    elseif PJN == false then
        PlayerJoinedNotification = false
    end
end)

NotificationSect:AddToggle('PlayerLeftNotification', { Text = 'Player Leave Notification', Default = false, Tooltip = nil, })
Toggles.PlayerLeftNotification:OnChanged(function(PLN)
    if PLN == true then
        PlayerLeftNotification = true
    elseif PLN == false then
        PlayerLeftNotification = false
    end
end)

NotificationSect:AddToggle('AdminToggle', { Text = 'Admin', Default = false, Tooltip = nil, })
Toggles.PlayerLeftNotification:OnChanged(function(AT)
    if AT == true then
        AdminNotification = true
    elseif AT == false then
        AdminNotification = false
    end
end)

Toggles.SilentToggle:AddColorPicker('NotificationBorder', {
    Default = NotificationBorderColor,
    Title = nil,
    Transparency = 0,
    Callback = function(Value)
        NotificationBorderColor = Value
    end
})

Toggles.SilentToggle:AddColorPicker('NotificationFill', {
    Default = NotificationFillColor,
    Title = nil,
    Transparency = 0,
    Callback = function(Value)
        NotificationFillColor = Value
    end
})

NotificationSect:AddLabel('Title'):AddColorPicker('NotificationTitleColorPicker', {
    Default = NotificationTitleColor,
    Title = nil,
    Transparency = 0,
    Callback = function(Value)
        NotificationTitleColor = Value
    end
})

NotificationSect:AddLabel('Content'):AddColorPicker('NotificationTextColorPicker', {
    Default = NotificationTextColor,
    Title = nil,
    Transparency = 0,
    Callback = function(Value)
        NotificationTextColor = Value
    end
})

local function UnloadNotification()
    showNotification("Notification", "JOEzeros Unloaded!", 3)
end
--------------------------------------------------------------------


--Watermark
--------------------------------------------------------------------
Library:SetWatermarkVisibility(true)
Library:SetWatermark('JoeXPaid | Rewritten | BETA | v2.1')
Library.KeybindFrame.Visible = true;
Library:OnUnload(function()
    print('Unloaded!')
    Library.Unloaded = true
end)

WatermarkSect:AddToggle('WatermarkToggle', { Text = 'Watermark', Default = true, Tooltip = nil, })
Toggles.WatermarkToggle:OnChanged(function(WMT)
    if WMT == true then
        Library:SetWatermarkVisibility(true)
    elseif WMT == false then
        Library:SetWatermarkVisibility(false)
    end
end)
WatermarkSect:AddToggle('KeybindToggle', { Text = 'Keybinds', Default = true, Tooltip = nil, })
Toggles.KeybindToggle:OnChanged(function(WMT)
    if WMT == true then
        Library.KeybindFrame.Visible = WMT
    elseif WMT == false then
        Library.KeybindFrame.Visible = WMT
    end
end)
WatermarkSect:AddToggle('SI', { Text = 'Server Info', Default = true, Tooltip = nil, })
Toggles.SI:OnChanged(function(ServerInfoS)
	game:GetService("Players").LocalPlayer.PlayerGui.GameUI.ServerInfo.Visible = ServerInfoS
end)

WatermarkSect:AddToggle('ST', { Text = 'Server Stats', Default = true, Tooltip = nil, })
Toggles.ST:OnChanged(function(ServerStatuss)
	game:GetService("Players").LocalPlayer.PlayerGui.GameUI.ServerStatus.Visible = ServerStatuss
end)
--------------------------------------------------------------------


--Crosshair
--------------------------------------------------------------------
local CrosshairOpacity = 1
local CrosshairRecenter = true
local CrosshairThickness = 2
local CrosshairLength = 8
local currentColor = Color3.fromRGB(255, 127, 0)
local crosshairEnabled = false
local crosshairDrawing = {}
local function drawCrosshair()
    local cam = workspace.CurrentCamera or workspace:FindFirstChildOfClass("Camera")
    if not cam then
        return
    end

    local settings = {
        color = currentColor,
        thickness = CrosshairThickness,
        length = CrosshairLength,
        opacity = CrosshairOpacity,
        x_offset = 0,
        y_offset = 0,
        recenter = CrosshairRecenter
    }

    local center = Vector2.new(cam.ViewportSize.x / 2, cam.ViewportSize.y / 2)
    local crosshairLines = {
        {From = center - Vector2.new(settings.length, 0) - Vector2.new(settings.x_offset, settings.y_offset), To = center + Vector2.new(settings.length, 0) - Vector2.new(settings.x_offset, settings.y_offset)},
        {From = center - Vector2.new(0, settings.length) - Vector2.new(settings.x_offset, settings.y_offset), To = center + Vector2.new(0, settings.length) - Vector2.new(settings.x_offset, settings.y_offset)}
    }

    for i, line in ipairs(crosshairLines) do
        if not crosshairDrawing[i] then
            crosshairDrawing[i] = Drawing.new("Line")
        end

        crosshairDrawing[i].From = line.From
        crosshairDrawing[i].To = line.To
        crosshairDrawing[i].Thickness = settings.thickness
        crosshairDrawing[i].Color = settings.color
        crosshairDrawing[i].Transparency = settings.opacity
        crosshairDrawing[i].Visible = crosshairEnabled
    end

    if settings.recenter then
        if not crosshairDrawing.connection then
            crosshairDrawing.connection = cam:GetPropertyChangedSignal("ViewportSize"):Connect(function()
                drawCrosshair()
            end)
        end
    else
        if crosshairDrawing.connection then
            crosshairDrawing.connection:Disconnect()
            crosshairDrawing.connection = nil
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    drawCrosshair()
end)

local function loadCrosshair()
    crosshairEnabled = true
    for _, drawing in ipairs(crosshairDrawing) do
        drawing.Visible = crosshairEnabled
    end
end

local function unloadCrosshair()
    crosshairEnabled = false
    for _, drawing in ipairs(crosshairDrawing) do
        drawing.Visible = crosshairEnabled
    end
end

local Crosshair = true
local function CrosshairToggle()
    if Crosshair == false then
        Crosshair = true
    elseif Crosshair == true then
        Crosshair = false
    end
    if Crosshair == true then
        loadCrosshair()
    elseif Crosshair == false then
        unloadCrosshair()
    end
end

CrosshairSect:AddToggle('Crosshair', { Text = 'ON | OFF', Default = false, Tooltip = nil, })
Toggles.Crosshair:OnChanged(function()
    CrosshairToggle()
end)

Toggles.Crosshair:AddColorPicker('CrosshairColor', {
    Default = currentColor,
    Title = nil,
    Transparency = 0,

    Callback = function(Value)
        currentColor = Value
    end
})

CrosshairSect:AddSlider('CrosshairThicknessSlider', {Text = 'Thickness', Default = CrosshairThickness, Min = 1, Max = 10, Rounding = 1, Compact = true,}):OnChanged(function(value)
	CrosshairThickness = value
end)

CrosshairSect:AddSlider('CrosshairLengthSlider', {Text = 'Length', Default = CrosshairLength, Min = 1, Max = 20, Rounding = 1, Compact = true,}):OnChanged(function(value)
	CrosshairLength = value
end)

CrosshairSect:AddSlider('CrosshairOpacitySlider', {Text = 'Opacity', Default = CrosshairOpacity, Min = 0, Max = 1, Rounding = 1, Compact = true,}):OnChanged(function(value)
	CrosshairOpacity = value
end)

unloadCrosshair()
--------------------------------------------------------------------


--Save/Theme Manager
--------------------------------------------------------------------
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')
SaveManager:BuildConfigSection(Tabs.UISettings)
ThemeManager:ApplyToTab(Tabs.UISettings)
--------------------------------------------------------------------


--Player Esp
--------------------------------------------------------------------
PlayerEspSect:AddToggle('Chams',{ Text = 'Player Esp', Default = false, Tooltip = nil, })

Toggles.Chams:AddColorPicker('OutlineColorPicker', {
    Default = Color3.fromRGB(172, 12, 12),
    Title = 'ESP Outline Color',
    Transparency = 0,
    Callback = function(Value)
        for _, a in ipairs(workspace:GetChildren()) do
            local b = a:FindFirstChild("Chams")
            if b and b:IsA("Highlight") then
                b.OutlineColor = Value
            end
        end
    end
})

Toggles.Chams:AddColorPicker('FillColorPicker', {
    Default = Color3.fromRGB(219, 128, 128),
    Title = 'ESP Fill Color',
    Transparency = 0,
    Callback = function(Value)
        -- Update
        for _, a in ipairs(workspace:GetChildren()) do
            local b = a:FindFirstChild("Chams")
            if b and b:IsA("Highlight") then
                b.FillColor = Value
            end
        end
    end
})

local function runChams()
    while Toggles.Chams.Value do
        wait(0.01)
        for i, a in ipairs(workspace:GetChildren()) do
            if a:FindFirstChild("HumanoidRootPart") then
                if not a:FindFirstChild("Chams") then
                    if a ~= game:GetService("Workspace").Ignore.FPSArms then
                        local b = Instance.new("Highlight", a)
                        b.Adornee = a
                        b.Name = "Chams"
                        b.FillColor = Options.FillColorPicker.Value
                        b.FillTransparency = 0.6
                        b.OutlineColor = Options.OutlineColorPicker.Value
                    end
                end
            end
        end
    end
    for _, a in ipairs(workspace:GetChildren()) do
        local b = a:FindFirstChild("Chams")
        if b and b:IsA("Highlight") then
            b:Destroy()
        end
    end
end

Toggles.Chams:OnChanged(runChams)
Options.OutlineColorPicker:SetValueRGB(Color3.fromRGB(172, 12, 12))
Options.FillColorPicker:SetValueRGB(Color3.fromRGB(219, 128, 128))
--------------------------------------------------------------------


--Player Backpack ESP
--------------------------------------------------------------------
local BackpackEspEnabled = false
local BackpackEspInstances = {}
local BPs = {}
local BackpackTransparency = 0.3
local BackpackX = 2
local BackpackY = 2
local BackpackZ = 0.5
local BackpackColor = BrickColor.new("Bright green")

local function EnableBackpackEsp()
    if BackpackEspEnabled then
        return
    end

    local parts = workspace:GetDescendants()

    for _, part in ipairs(parts) do
        if part:IsA("UnionOperation") and part.BrickColor == BrickColor.new("Mid gray") and part.Material == Enum.Material.Fabric then
            local BackpackEsp = Instance.new("BoxHandleAdornment")
            BackpackEsp.Adornee = part
            BackpackEsp.AlwaysOnTop = true
            BackpackEsp.ZIndex = 0
            BackpackEsp.Size = Vector3.new(BackpackX, BackpackY, BackpackZ)
            BackpackEsp.Transparency = BackpackTransparency
            BackpackEsp.Color = BackpackColor
            BackpackEsp.Parent = workspace
            table.insert(BPs, BackpackEsp)

            table.insert(BackpackEspInstances, BackpackEsp)
        end
    end

    BackpackEspEnabled = true
end

local function DisableBackpackEsp()
    if not BackpackEspEnabled then
        return
    end

    for _, espInstance in ipairs(BackpackEspInstances) do
        espInstance:Destroy()
    end

    BackpackEspInstances = {}
    BackpackEspEnabled = false
end

local function updateBackpackEspProperties()
    for _, BackpackEsp in ipairs(BPs) do
        BackpackEsp.Size = Vector3.new(BackpackX, BackpackY, BackpackZ)
        BackpackEsp.Transparency = BackpackTransparency
        BackpackEsp.Color = BackpackColor
    end
end

PlayerEspSect:AddToggle('BackpackEspToggle', { Text = 'Backpack', Default = false, Tooltip = nil, })
Toggles.BackpackEspToggle:OnChanged(function(STE)
    if STE == true then
        EnableBackpackEsp()
        while true do
            if Toggles.BackpackEspToggle.Value then
            wait(1)
            DisableBackpackEsp()
            EnableBackpackEsp()
            end
        end
    elseif STE == false then
        DisableBackpackEsp()
    end
end)

local BackpackTransparencySlider = PlayerEspSect:AddSlider('BackpackTransparencySlider', {Text = 'Transparency', Default = BackpackTransparency, Min = 0, Max = 1, Rounding = 1, Compact = true})
BackpackTransparencySlider:OnChanged(function(Value)
    BackpackTransparency = Value
    if Toggles.BackpackEspToggle.Value then
        updateBackpackEspProperties()
    end
end)

local BackpackSizeXSlider = PlayerEspSect:AddSlider('BackpackXSlider', {Text = 'X', Default = BackpackX, Min = 0.5, Max = 10, Rounding = 1, Compact = true})
BackpackSizeXSlider:OnChanged(function(Value)
    BackpackX = Value
    if Toggles.BackpackEspToggle.Value then
        updateBackpackEspProperties()
    end
end)

local BackpackSizeYSlider = PlayerEspSect:AddSlider('BackpackYSlider', {Text = 'Y', Default = BackpackY, Min = 0.5, Max = 10, Rounding = 1, Compact = true})
BackpackSizeYSlider:OnChanged(function(Value)
    BackpackY = Value
    if Toggles.BackpackEspToggle.Value then
        updateBackpackEspProperties()
    end
end)

local BackpackSizeZSlider = PlayerEspSect:AddSlider('BackpackZSlider', {Text = 'Z', Default = BackpackZ, Min = 0.5, Max = 10, Rounding = 1, Compact = true})
BackpackSizeZSlider:OnChanged(function(Value)
    BackpackZ = Value
    if Toggles.BackpackEspToggle.Value then
        updateBackpackEspProperties()
    end
end)

Toggles.BackpackEspToggle:AddColorPicker('BackpackColorPicker', {
    Default = BackpackColor.Color,
    Title = nil,
    Transparency = 0,
    Callback = function(value)
        BackpackColor = BrickColor.new(value)

        for _, BackpackEsp in ipairs(BPs) do
            BackpackEsp.Color = BackpackColor
        end
    end
})
--------------------------------------------------------------------


--------------------------------------------------------------------
local Connections = {}
local Debounce = {}
local Players = {}

for _, Player in workspace:GetChildren() do
	if Player:IsA("Model") and Player:FindFirstChild("HumanoidRootPart") then
		table.insert(Players, Player)
	end
end
Connections["Update Players"] = workspace.DescendantAdded:Connect(function(Player)
	if Player.Name == "HumanoidRootPart" and Player.Parent:IsA("Model") then
		table.insert(Players, Player.Parent); Debounce["Players"] = false
	end
end)
Connections["Remove Players"] =  workspace.ChildRemoved:Connect(function(Player)
	if table.find(Players, Player) then
		table.remove(Players, table.find(Players, Player)); Debounce["Players"] = false
	end
end)
--------------------------------------------------------------------


--Hitbox Expander
--------------------------------------------------------------------
HitboxExpander:AddToggle('HeadExpander', { Text = "Head", Default = false, })
HitboxExpander:AddSlider('HeadSize', { Text = "Size", Default = 1, Min = 1, Max = 3, Rounding = 1, Compact = false, })
HitboxExpander:AddDivider()
HitboxExpander:AddToggle('TorsoExpander', { Text = "Torso", Default = false, })
HitboxExpander:AddSlider('TorsoSize', { Text = "Size", Default = 1, Min = 1, Max = 3, Rounding = 1, Compact = false, })

local Properties = {
	["Size"] = {
		["Head"] = Vector3.new(1.6732481718063354, 0.8366240859031677, 0.8366240859031677),
		["Torso"] = Vector3.new(0.6530659198760986, 2.220424175262451, 1.4367451667785645)
	}
}

Toggles.HeadExpander:OnChanged(function()

	if not Toggles.HeadExpander.Value then
		for _, Player in Players do
			for Property, Value in Properties do
				pcall(function ()
					Player.Head[Property] = Value["Head"]
				end)
			end
		end
		Debounce["Players"] = false; return
	end
	task.spawn(function()
		while Toggles.HeadExpander.Value do
			if not Toggles.HeadExpander.Value then break end
			for _, Player in Players do
				pcall(function()
					Player.Head.Size = Vector3.new(Options.HeadSize.Value, Options.HeadSize.Value, Options.HeadSize.Value)
				end)
			end
			task.wait(0.01)
		end
	end)
	Debounce["Players"] = false
end)

Options.HeadSize:OnChanged(function()
	Debounce["Players"] = false
end)

Toggles.TorsoExpander:OnChanged(function()
	if not Toggles.TorsoExpander.Value then
		for _, Player in Players do
			for Property, Value in Properties do
				pcall(function ()
					Player.Torso[Property] = Value["Torso"]
				end)
			end
		end
		Debounce["Players"] = false; return
	end

	task.spawn(function()
		while Toggles.TorsoExpander.Value do
			if not Toggles.TorsoExpander.Value then break end
			for _, Player in Players do
				pcall(function()
					Player.Torso.Size = Vector3.new(Options.TorsoSize.Value, Options.TorsoSize.Value, Options.TorsoSize.Value)
				end)
			end
			task.wait(0.01)
		end
	end)
	Debounce["Players"] = false
end)

Options.TorsoSize:OnChanged(function()
	Debounce["Players"] = false
end)
--------------------------------------------------------------------


--HitSound
--------------------------------------------------------------------
local SoundService = game:GetService("SoundService")
local CustomHitsoundsTab = CustomHitsoundsTabBox:AddTab('Hitsounds')

SoundService.PlayerHitHeadshot.Volume = 5
SoundService.PlayerHitHeadshot.Pitch = 1
SoundService.PlayerHitHeadshot.EqualizerSoundEffect.HighGain = -2

--HeadHitSound
CustomHitsoundsTab:AddDropdown('HeadshotHit', { Values = { 'Default','Rust', }, Default = 1, Multi = false, Text = 'Head Hitsound', Tooltip = nil, })

Options.HeadshotHit:OnChanged(function()
	if Options.HeadshotHit.Value == "Default" then
		game:GetService("SoundService").PlayerHitHeadshot.SoundId = "rbxassetid://9119561046"
	end

	if Options.HeadshotHit.Value == "Rust" then
		game:GetService("SoundService").PlayerHitHeadshot.SoundId = "rbxassetid://1255040462"
		game:GetService("SoundService").PlayerHitHeadshot.Playing = true
	end
end)

CustomHitsoundsTab:AddSlider('Volume_Slider', {Text = 'Volume', Default = 4, Min = 0, Max = 10, Rounding = 1, Compact = true,}):OnChanged(function(vol)
	SoundService.PlayerHitHeadshot.Volume = vol
end)

CustomHitsoundsTab:AddSlider('Pitch_Slider', {Text = 'Pitch', Default = 1, Min = 0, Max = 2, Rounding = 1, Compact = true,}):OnChanged(function(pich)
	SoundService.PlayerHitHeadshot.Pitch = pich
end)

--BodyHitsound
CustomHitsoundsTab:AddDropdown('Hit', {
	Values = { 'Default', 'Rust', },
	Default = 1,
	Multi = false,
	Text = 'Body Hitsound',
	Tooltip = nil,
})
Options.Hit:OnChanged(function()
	if Options.Hit.Value == "Default" then
		SoundService.PlayerHit2.SoundId = "rbxassetid://9114487369"
        game:GetService("SoundService").PlayerHit2.Playing = true
	end

	if Options.Hit.Value == "Rust" then
		game:GetService("SoundService").PlayerHit2.SoundId = "rbxassetid://1255040462"
		game:GetService("SoundService").PlayerHit2.Playing = true
	end
end)

CustomHitsoundsTab:AddSlider('Volume_Slider', {Text = 'Volume', Default = 5, Min = 0, Max = 10, Rounding = 1, Compact = true,}):OnChanged(function(vole)
	SoundService.PlayerHit2.Volume = vole
end)

CustomHitsoundsTab:AddSlider('Pitch_Slider', {Text = 'Pitch', Default = 1, Min = 0, Max = 2, Rounding = 1, Compact = true,}):OnChanged(function(piche)
	SoundService.PlayerHit2.Pitch = piche
end)
--------------------------------------------------------------------


--SpawnTotem Esp
--------------------------------------------------------------------
local SpawntotemEspEnabled = false
local SpawntotemEspInstances = {}
local STs = {}
local SpawnTotemTransparency = 0.3
local SpawnTotemX = 2
local SpawnTotemY = 0.5
local SpawnTotemZ = 2
local SpawnTotemColor = BrickColor.new("Bright blue") -- Store the color globally

local function EnableSpawntotemEsp()
    if SpawntotemEspEnabled then
        return
    end

    local parts = workspace:GetDescendants()

    for _, part in ipairs(parts) do
        if part:IsA("Part") and part.BrickColor == BrickColor.new("Dark stone grey") and part.Name == "Prim" and part.Material == Enum.Material.Slate then
            local SpawntotemEsp = Instance.new("BoxHandleAdornment")
            SpawntotemEsp.Adornee = part
            SpawntotemEsp.AlwaysOnTop = true
            SpawntotemEsp.ZIndex = 0
            SpawntotemEsp.Size = Vector3.new(SpawnTotemX, SpawnTotemY, SpawnTotemZ)
            SpawntotemEsp.Transparency = SpawnTotemTransparency
            SpawntotemEsp.Color = SpawnTotemColor -- Use the global color variable
            SpawntotemEsp.Parent = workspace
            table.insert(STs, SpawntotemEsp)

            table.insert(SpawntotemEspInstances, SpawntotemEsp)
        end
    end

    SpawntotemEspEnabled = true
end

local function DisableSpawntotemEsp()
    if not SpawntotemEspEnabled then
        return
    end

    for _, espInstance in ipairs(SpawntotemEspInstances) do
        espInstance:Destroy()
    end

    SpawntotemEspInstances = {}
    SpawntotemEspEnabled = false
end

local function updateSpawnTotemEspProperties()
    for _, SpawntotemEsp in ipairs(STs) do
        SpawntotemEsp.Size = Vector3.new(SpawnTotemX, SpawnTotemY, SpawnTotemZ)
        SpawntotemEsp.Transparency = SpawnTotemTransparency
        SpawntotemEsp.Color = SpawnTotemColor -- Use the global color variable
    end
end

local function SpawnTotemUpdate()
    DisableSpawntotemEsp()
    if SpawntotemEspEnabled then
        EnableSpawntotemEsp()
        updateSpawnTotemEspProperties()
    end
end

BaseEspSect:AddToggle('SpawnTotemEspToggle', { Text = 'Spawn Totem', Default = false, Tooltip = nil, })
Toggles.SpawnTotemEspToggle:OnChanged(function(STE)
    if STE == true then
        EnableSpawntotemEsp()
    elseif STE == false then
        DisableSpawntotemEsp()
    end
end)

spawn(function()
    while true do
        wait(5)
        SpawnTotemUpdate()
    end
end)

local SpawnTotemTransparencySlider = BaseEspSect:AddSlider('SpawnTotemTransparencySlider', {Text = 'Transparency', Default = SpawnTotemTransparency, Min = 0, Max = 1, Rounding = 1, Compact = true})
SpawnTotemTransparencySlider:OnChanged(function(Value)
    SpawnTotemTransparency = Value
    if Toggles.SpawnTotemEspToggle.Value then
        updateSpawnTotemEspProperties()
    end
end)

local SpawnTotemSizeXSlider = BaseEspSect:AddSlider('SpawnTotemXSlider', {Text = 'X', Default = SpawnTotemX, Min = 0.5, Max = 10, Rounding = 1, Compact = true})
SpawnTotemSizeXSlider:OnChanged(function(Value)
    SpawnTotemX = Value
    if Toggles.SpawnTotemEspToggle.Value then
        updateSpawnTotemEspProperties()
    end
end)

local SpawnTotemSizeYSlider = BaseEspSect:AddSlider('SpawnTotemYSlider', {Text = 'Y', Default = SpawnTotemY, Min = 0.5, Max = 10, Rounding = 1, Compact = true})
SpawnTotemSizeYSlider:OnChanged(function(Value)
    SpawnTotemY = Value
    if Toggles.SpawnTotemEspToggle.Value then
        updateSpawnTotemEspProperties()
    end
end)

local SpawnTotemSizeZSlider = BaseEspSect:AddSlider('SpawnTotemZSlider', {Text = 'Z', Default = SpawnTotemZ, Min = 0.5, Max = 10, Rounding = 1, Compact = true})
SpawnTotemSizeZSlider:OnChanged(function(Value)
    SpawnTotemZ = Value
    if Toggles.SpawnTotemEspToggle.Value then
        updateSpawnTotemEspProperties()
    end
end)

Toggles.SpawnTotemEspToggle:AddColorPicker('SpawnTotemColorPicker', {
    Default = SpawnTotemColor.Color,
    Title = 'Spawn Totem Color',
    Transparency = 0,
    Callback = function(value)
        SpawnTotemColor = BrickColor.new(value)

        -- Update the color of the spawn totem
        for _, SpawntotemEsp in ipairs(STs) do
            SpawntotemEsp.Color = SpawnTotemColor
        end
    end
})
--------------------------------------------------------------------


--Tc Esp
--------------------------------------------------------------------
local UserInputService = game:GetService("UserInputService")
local TCESPs = {}
local adorned = false
local TcColor = Color3.fromRGB(118, 20, 20)
local TcTransparency = 0.3
local TcX = 2
local TcY = 6
local TcZ = 2
local TcespEnabled = false

local function addTCEsp()
    local parts = workspace:GetDescendants()
    for _, part in ipairs(parts) do
        if part:IsA("UnionOperation") and part.Name == "State" and part.Material == Enum.Material.Neon then
            local TCESP = Instance.new("BoxHandleAdornment")
            TCESP.Adornee = part
            TCESP.AlwaysOnTop = true
            TCESP.ZIndex = 0
            TCESP.Size = Vector3.new(TcX, TcY, TcZ)
            TCESP.Transparency = TcTransparency
            TCESP.Color3 = TcColor
            TCESP.Parent = workspace
            TCESP.CFrame = CFrame.new(0, -2.2, 0)
            table.insert(TCESPs, TCESP)
        end
    end
end

local function removeTCEsp()
    for _, TCESP in ipairs(TCESPs) do
        TCESP:Destroy()
    end
    TCESPs = {}
end

local function updateTCEspProperties()
    for _, TCESP in ipairs(TCESPs) do
        TCESP.Transparency = TcTransparency
        TCESP.Color3 = TcColor
        TCESP.Size = Vector3.new(TcX, TcY, TcZ)
    end
end

local function TcUpdate()
    removeTCEsp()
    if TcespEnabled then
        addTCEsp()
        updateTCEspProperties()
    end
end

local TcEspToggle = BaseEspSect:AddToggle('TCEsp', { Text = "TC Esp", Default = false })
TcEspToggle:OnChanged(function(enabled)
    TcespEnabled = enabled
    if enabled then
        TcUpdate()
    else
        removeTCEsp()
    end
end)

spawn(function()
    while true do
        wait(5)
        TcUpdate()
    end
end)

local TcTransparencySlider = BaseEspSect:AddSlider('TcTransparency', {Text = 'Transparency', Default = TcTransparency, Min = 0, Max = 1, Rounding = 1, Compact = true})
TcTransparencySlider:OnChanged(function(TCT)
    TcTransparency = TCT
    if TcEspToggle.Value then
        updateTCEspProperties()
    end
end)

local TcSizeXSlider = BaseEspSect:AddSlider('TcSizeX', {Text = 'X', Default = TcX, Min = 1, Max = 10, Rounding = 1, Compact = true})
TcSizeXSlider:OnChanged(function(TCX)
    TcX = TCX
    if TcEspToggle.Value then
        updateTCEspProperties()
    end
end)

local TcSizeYSlider = BaseEspSect:AddSlider('TcSizeY', {Text = 'Y', Default = TcY, Min = 1, Max = 10, Rounding = 1, Compact = true})
TcSizeYSlider:OnChanged(function(TCY)
    TcY = TCY
    if TcEspToggle.Value then
        updateTCEspProperties()
    end
end)

local TcSizeZSlider = BaseEspSect:AddSlider('TcSizeZ', {Text = 'Z', Default = TcZ, Min = 1, Max = 10, Rounding = 1, Compact = true})
TcSizeZSlider:OnChanged(function(TCZ)
    TcZ = TCZ
    if TcEspToggle.Value then
        updateTCEspProperties()
    end
end)

TcEspToggle:AddColorPicker('TcColor', {
    Default = TcColor,
    Title = nil,
    Transparency = 0,
    Callback = function(Value)
        TcColor = Value
        if TcEspToggle.Value then
            updateTCEspProperties()
        end
    end
})
--------------------------------------------------------------------


--UI Settings
--------------------------------------------------------------------
local function afterUnload()
    unloadCrosshair()
    UnloadNotification()
    Toggles.TorsoExpander.Value = false
    Toggles.HeadExpander.Value = false
    Toggles.Chams.Value = false
    Silent = true
end

MenuGroup:AddButton('Unload', function() Library:Unload()  afterUnload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'LeftControl', NoUI = true, Text = 'Menu keybind' })
Library.ToggleKeybind = Options.MenuKeybind
--------------------------------------------------------------------


--Lighting
--------------------------------------------------------------------
local defaultColor = game:GetService("ReplicatedStorage").Arrow.Trail.Color.Keypoints[1].Value
local ArrowDect = game:GetService("ReplicatedStorage").Arrow
local ArrowBrighness = game:GetService("ReplicatedStorage").Arrow.Trail.Brightness

local ArrowLifetimeSlider = LightSect:AddSlider('ArrowLifetimeSlider', {Text = 'Arrow Trial Lifetime', Default = 2, Min = 2, Max = 20, Rounding = 1, Compact = true})
ArrowLifetimeSlider:OnChanged(function(Value)
    ArrowDect.Trail.Lifetime = Value
end)

local ArrowBrightnessSlider = LightSect:AddSlider('ArrowTrialBrightness', {Text = 'Arrow Trial Brightness', Default = ArrowBrighness, Min = 1, Max = 100, Rounding = 1, Compact = true})
ArrowBrightnessSlider:OnChanged(function(Value)
    ArrowBrighness = Value
end)

local GlowstickRangeSlider = LightSect:AddSlider('GlowstickRange', {Text = 'Glowstick Range', Default = game:GetService("ReplicatedStorage").HandModels.Glowstick.GlowPart.PointLight.Range, Min = 1, Max = 60, Rounding = 1, Compact = true})
GlowstickRangeSlider:OnChanged(function(Value)
    game:GetService("ReplicatedStorage").HandModels.Glowstick.GlowPart.PointLight.Range = Value
end)

LightSect:AddLabel('Arrow Trial Color'):AddColorPicker('ArrowTrialColorPicker', {
    Default = Color3.fromRGB(defaultColor.R * 255, defaultColor.G * 255, defaultColor.B * 255),
    Title = nil,
    Transparency = 0,
    Callback = function(value)
        game:GetService("ReplicatedStorage").Arrow.Trail.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(value.R * 255, value.G * 255, value.B * 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(value.R * 255, value.G * 255, value.B * 255))
        })
    end
})

LightSect:AddLabel('Bullet Color'):AddColorPicker('BulletColorPicker', { Default = game:GetService("ReplicatedStorage").Bullet.Color, Title = nil, Transparency = 0, Callback = function(Value)
    game:GetService("ReplicatedStorage").Bullet.Color = Color3.new(Value.R, Value.G, Value.B)
    game:GetService("ReplicatedStorage").Bullet.PointLight.Color = Color3.new(Value.R, Value.G, Value.B)
end
})

LightSect:AddLabel('Glowstick Color'):AddColorPicker('GlowstickColorPicker', { Default = game:GetService("ReplicatedStorage").HandModels.Glowstick.GlowPart.Color, Title = nil, Transparency = 0, Callback = function(Value)
    game:GetService("ReplicatedStorage").HandModels.Glowstick.GlowPart.Color = Color3.new(Value.R, Value.G, Value.B)
    game:GetService("ReplicatedStorage").HandModels.Glowstick.GlowPart.PointLight.Color = Color3.new(Value.R, Value.G, Value.B)
end
})

LightSect:AddLabel('Cloud Color'):AddColorPicker('CloudsColorPicker', {
    Default = Color3.fromRGB(172, 12, 12),
    Title = nil,
    Transparency = 0,
    Callback = function(Value)
        workspace.Terrain.Clouds.Color = Value
    end
})
--------------------------------------------------------------------


--Blood Splatter
--------------------------------------------------------------------
local BloodSplatter = game:GetService("Players").LocalPlayer.PlayerGui.GameUI.BloodSplatter

GuiSect:AddToggle('BloodSplatter',{ Text = 'Blood Splatter', Default = true, Tooltip = nil, })
Toggles.BloodSplatter:OnChanged(function(BS)
    if BS == true then
        BloodSplatter.Visible = true
    elseif BS == false then
        BloodSplatter.Visible = false
    end
end)
--------------------------------------------------------------------


--Chat
--------------------------------------------------------------------
Chat = game:GetService("Players").LocalPlayer.PlayerGui.GameUI.Chat

GuiSect:AddToggle('ChatGui',{ Text = 'Chat', Default = true, Tooltip = nil, })
Toggles.ChatGui:OnChanged(function(C)
    if C == true then
        Chat.Visible = true
    elseif C == false then
        Chat.Visible = false
    end
end)
--------------------------------------------------------------------


--Arms
--------------------------------------------------------------------
local ArmDect = workspace.Ignore:WaitForChild("FPSArms")

ArmSect:AddDropdown('ArmMaterial', {
    Values = { 'ForceField', 'SmoothPlastic', 'Neon' },
    Default = 2,
    Multi = false,
    Text = 'Material',
    Tooltip = nil,
})

Options.ArmMaterial:OnChanged(function()
    if Options.ArmMaterial.Value == "ForceField" then 
        ArmDect.LeftHand.Material = Enum.Material.ForceField
        ArmDect.LeftLowerArm.Material = Enum.Material.ForceField
        ArmDect.LeftUpperArm.Material = Enum.Material.ForceField
        ArmDect.RightHand.Material = Enum.Material.ForceField
        ArmDect.RightLowerArm.Material = Enum.Material.ForceField
        ArmDect.RightUpperArm.Material = Enum.Material.ForceField
    end
    if Options.ArmMaterial.Value == "SmoothPlastic" then
        ArmDect.LeftHand.Material = Enum.Material.SmoothPlastic
        ArmDect.LeftLowerArm.Material = Enum.Material.SmoothPlastic
        ArmDect.LeftUpperArm.Material = Enum.Material.SmoothPlastic
        ArmDect.RightHand.Material = Enum.Material.SmoothPlastic
        ArmDect.RightLowerArm.Material = Enum.Material.SmoothPlastic
        ArmDect.RightUpperArm.Material = Enum.Material.SmoothPlastic
    end
    if Options.ArmMaterial.Value == "Neon" then
        ArmDect.LeftHand.Material = Enum.Material.Neon
        ArmDect.LeftLowerArm.Material = Enum.Material.Neon
        ArmDect.LeftUpperArm.Material = Enum.Material.Neon
        ArmDect.RightHand.Material = Enum.Material.Neon
        ArmDect.RightLowerArm.Material = Enum.Material.Neon
        ArmDect.RightUpperArm.Material = Enum.Material.Neon
    end
end)

ArmSect:AddLabel('Arm Color'):AddColorPicker('ArmColorPicker', {
    Default = Color3.new(0, 0, 0),
    Title = nil,
    Transparency = 0,
    Callback = function(value)
        local ArmnewColor = BrickColor.new(Color3.new(value.R, value.G, value.B))

        ArmDect.LeftHand.BrickColor = ArmnewColor
        ArmDect.LeftLowerArm.BrickColor = ArmnewColor
        ArmDect.LeftUpperArm.BrickColor = ArmnewColor
        ArmDect.RightHand.BrickColor = ArmnewColor
        ArmDect.RightLowerArm.BrickColor = ArmnewColor
        ArmDect.RightUpperArm.BrickColor = ArmnewColor
    end
})
--------------------------------------------------------------------


--Grass
--------------------------------------------------------------------
WorldSect:AddToggle('Grass', { Text = 'Grass', Default = true, Tooltip = nil, })
Toggles.Grass:OnChanged(function(Value)
    sethiddenproperty(game.Workspace.Terrain, "Decoration", Value)
end)
--------------------------------------------------------------------


--FreeCam
--------------------------------------------------------------------
loadstring(game:HttpGet("https://pastebin.com/raw/5PmGhXKz"))()

WorldSect:AddLabel('Free Cam'):AddKeyPicker('FreeCam', { Default = 'F1', Text = 'FreeCam Beta', Tooltip = nil, NoUI = false, })
Options.FreeCam:OnClick(function()
    ToggleFreecam();
end)
--------------------------------------------------------------------


--Particles
--------------------------------------------------------------------
GuiSect:AddToggle('Particles',{ Text = 'Particles', Default = true, Tooltip = nil, })
Toggles.Particles:OnChanged(function(Value)
    if Value == true then
        game:GetService("ReplicatedStorage").Particles.Blood.Enabled = true
        game:GetService("ReplicatedStorage").Particles.Grass.Enabled = true
        game:GetService("ReplicatedStorage").Particles.MuzzleFlash.Enabled = true
        game:GetService("ReplicatedStorage").Particles.Sand.Enabled = true
        game:GetService("ReplicatedStorage").Particles.Sparks.Enabled = true
        game:GetService("ReplicatedStorage").Particles.Stone.Enabled = true
        game:GetService("ReplicatedStorage").Particles.Water.Enabled = true
        game:GetService("ReplicatedStorage").Particles.Wood.Enabled = true
    elseif Value == false then
        game:GetService("ReplicatedStorage").Particles.Blood.Enabled = false
        game:GetService("ReplicatedStorage").Particles.Grass.Enabled = false
        game:GetService("ReplicatedStorage").Particles.MuzzleFlash.Enabled = false
        game:GetService("ReplicatedStorage").Particles.Sand.Enabled = false
        game:GetService("ReplicatedStorage").Particles.Sparks.Enabled = false
        game:GetService("ReplicatedStorage").Particles.Stone.Enabled = false
        game:GetService("ReplicatedStorage").Particles.Water.Enabled = false
        game:GetService("ReplicatedStorage").Particles.Wood.Enabled = false
    end
end)
--------------------------------------------------------------------


--FpsCheck Button
--------------------------------------------------------------------
local function checkFps()
    local fps = 1 / game:GetService("RunService").RenderStepped:Wait()
    print("FPS: " .. math.floor(fps))
    showNotification("Notification", math.floor(fps) .. " FPS", 1)
end
local function toggleFps()
    checkFps()
end

GuiSect:AddButton('Check FPS', function()
    toggleFps()
end)
--------------------------------------------------------------------+

game:GetService("SoundService").Grass.SoundId = "rbxassetid://9120063866"
