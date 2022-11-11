local RunService = game:GetService("RunService")
local RP = game:GetService("ReplicatedStorage")

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/ThroySunsetX/SunsetX/main/README.md'))()

local Window = Rayfield:CreateWindow({
	Name = "SunsetX Free | Anime Evolution",
	LoadingTitle = "SunsetX",
	LoadingSubtitle = "by Throy and Wertyzz",
	ConfigurationSaving = {
		Enabled = false,
		FolderName = "SunsetX",
		FileName = "SunsetX Hub"
	},
        Discord = {
        	Enabled = true,
        	Invite = "4neBEbaDEm",
        	RememberJoins = false
        },
    KeySystem = true,
	KeySettings = {
		Title = "SunsetX Hub",
		Subtitle = "Key System",
		Note = "Join the discord (discord.gg/4neBEbaDEm)",
		FileName = "SunsetX Key",
		SaveKey = false,
		GrabKeyFromSite = false,
		Key = "WillSmiff"
	}
})

Rayfield:Notify({
    Title = "SunsetX Loaded!",
    Content = "Successfully loaded SunsetX, enjoy the script!",
    Duration = 6,
    Image = 4483362458,
    Actions = {
        Ignore = {
            Name = "Thank you!",
		},
	},
})



for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
    v:Disable()
end

local LocalPlayer = game.Players.LocalPlayer 
local Char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait() 
local Humrp = Char:WaitForChild('HumanoidRootPart')

-- //Modules
local AEServices = require(LocalPlayer.PlayerGui.UI.Client.Services)

local function GetCoins()
    for _,Drops in pairs(workspace.__DROPS:GetChildren()) do 
			Drops.CanCollide = false
			Drops.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
			task.wait(0.05)
    end
end

local function AutoClick()
    game:GetService("ReplicatedStorage").Remotes.Client:FireServer({"PowerTrain", AEServices.CurrentAreaBuy})
end

local function AutoClaimGifts()
	task.wait(1)
	for _,v in pairs(game.Players.LocalPlayer.PlayerGui.UI.CenterFrame.Gifts.Frame:GetChildren()) do
		if v.ClassName == "ImageLabel" then
			if v:FindFirstChild("Frame") then
				if v.Frame.TextLabel.Text == "Claim" then
					RP.Remotes.Client:FireServer({"Gift", v.Name})
				end
			end
		end
	end
end

local function AutoKillNearFunc(Area)
	if workspace.__WORKSPACE.Mobs:FindFirstChild(Area) then
		for _,Mobs in pairs(workspace.__WORKSPACE.Mobs:FindFirstChild(Area):GetChildren()) do 
			local mag = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Mobs.HumanoidRootPart.Position).magnitude 
            
            if mag < 10 then 
                local args = {
					[1] = {
						[1] = "AttackMob",
						[2] = Mobs,
						[3] = "Left Arm"
					}
				}
				
				task.wait(0.1)
				game:GetService("ReplicatedStorage").Remotes.Client:FireServer(unpack(args))
            end
		end
	end
end

local function AutoKillMobFunc(Area, Mob)
	if workspace.__WORKSPACE.Mobs:FindFirstChild(Area) then
		for _,Mobs in pairs(workspace.__WORKSPACE.Mobs:FindFirstChild(Area):GetChildren()) do 
			if Mobs.Name == Mob then
				local args = {
					[1] = {
						[1] = "AttackMob",
						[2] = Mobs,
						[3] = "Left Arm"
					}
				}
				
				task.wait(0.1)
				game:GetService("ReplicatedStorage").Remotes.Client:FireServer(unpack(args))
			end
		end
	end
end


local all_areas = {}
local all_eggareas = {}
local all_eggmobs = {}
local mobTable = {}
local all_guis = {}
local all_guis2 = {}

for i,v in pairs(workspace.__CURRENTAREA:GetChildren()) do 
    table.insert(all_areas, v.Name)
end

for _,v in pairs(workspace.__WORKSPACE.FightersPoint:GetChildren()) do
	table.insert(all_eggareas, v.name)
end

for _,v in pairs(LocalPlayer.PlayerGui.UI.CenterFrame:GetChildren()) do
	if v:IsA("ImageLabel") then	
		table.insert(all_guis, v.Name)
	end
end


function GetDate()
	local date = {}
	local months = {
		{"January", 31};
		{"February", 28};
		{"March", 31};
		{"April", 30};
		{"May", 31};
		{"June", 30};
		{"July", 31};
		{"August", 31};
		{"September", 30};
		{"October", 31};
		{"November", 30};
		{"December", 31};
	}
	local t = tick()
	date.total = t
	date.seconds = math.floor(t % 60)
	date.minutes = math.floor((t / 60) % 60)
	date.hours = math.floor((t / 60 / 60) % 24)
	date.year = (1970 + math.floor(t / 60 / 60 / 24 / 365.25))
	date.yearShort = tostring(date.year):sub(-2)
	date.isLeapYear = ((date.year % 4) == 0)
	date.isAm = (date.hours < 12)
	date.hoursPm = (date.isAm and date.hours or (date.hours == 12 and 12 or (date.hours - 12)))
	if (date.hoursPm == 0) then date.hoursPm = 12 end
	if (date.isLeapYear) then
		months[2][2] = 29
	end
	do
		date.dayOfYear = math.floor((t / 60 / 60 / 24) % 365.25)
		local dayCount = 0
		for i,month in pairs(months) do
			dayCount = (dayCount + month[2])
			if (dayCount > date.dayOfYear) then
				date.monthWord = month[1]
				date.month = i
				date.day = (date.dayOfYear - (dayCount - month[2]) + 1)
				break
			end
		end
	end
	function date:format(str)
		str = str
		:gsub("#s", ("%.2i"):format(self.seconds))
		:gsub("#m", ("%.2i"):format(self.minutes))
		:gsub("#h", tostring(self.hours))
		:gsub("#H", tostring(self.hoursPm))
		:gsub("#Y", tostring(self.year))
		:gsub("#y", tostring(self.yearShort))
		:gsub("#a", (self.isAm and "AM" or "PM"))
		return str
	end
	return date
end

local Client
if not identifyexecutor then
	Client = "Universal"
else
	Client = identifyexecutor()
end

local Version = "Alpha"

local MainTab = Window:CreateTab("Main")
local BossTab = Window:CreateTab("Boss")
local EggTab = Window:CreateTab("Egg")
local MiscTab = Window:CreateTab("Misc")
local InfoTab = Window:CreateTab("Info")

local MagnetConnection
local AutoClickConnection
local AutoClaimConnection
local AutoEggConnection 
local AutoKillNearConnection 
local AutoKillMobConnection 
local AutoKillAreaConnection 

--InfoTabPart

local DataSection = InfoTab:CreateSection("Data")

local TimeLabel = InfoTab:CreateLabel("Date: "..tostring(GetDate():format("#h:#m")))
spawn(function()
    while true do
        wait(0.2)
        TimeLabel:Set(tostring(GetDate():format("#h:#m")))
    end
end)

local ExecutorLabel = InfoTab:CreateLabel("Executor: "..Client)
local VersionLabel = InfoTab:CreateLabel("Version: "..Version)

local timesince = 0
local TimeLabel2 = InfoTab:CreateLabel("Time since boot: "..timesince.."s")
spawn(function()
    while true do
        TimeLabel2:Set("Time since boot: "..timesince.."s")
        wait(1)
        timesince += 1
    end
end)

local DiscordInvite = InfoTab:CreateButton({
	Name = "Copy Discord Invite",
	Callback = function()
		if setclipboard then
            setclipboard("https://discord.gg/4neBEbaDEm")
        end
	end,
})

--MainTabPart

local FarmSection = MainTab:CreateSection("Farm")

local AutoclickToggle = MainTab:CreateToggle({
	Name = "Autoclick",
	CurrentValue = false,
	Callback = function(Value)
		if Value then
            AutoClickConnection = RunService.RenderStepped:Connect(function()                
                AutoClick()
            end)
        else
            AutoClickConnection:Disconnect()
        end
	end,
})

local Magnet = MainTab:CreateToggle({
	Name = "Magnet",
	CurrentValue = false,
	Callback = function(Value)
        if Value then
            MagnetConnection = RunService.RenderStepped:Connect(function()
                GetCoins()
            end)
        else
            MagnetConnection:Disconnect()
        end
	end,
})

local MobDrop = MainTab:CreateDropdown({
	Name = "Select Mobs";
	Options = {};
	CurrentOption = "None";

	Callback = function(Option)
        
    end
})

local AreaDrop = MainTab:CreateDropdown({
	Name = "Select Area";
	Options = all_areas;
	CurrentOption = "None";

	Callback = function(Selected)

		for _,v in pairs(mobTable) do table.remove(mobTable,_) end
		for _,v in pairs(mobTable) do table.remove(mobTable,_) end
		for _,v in pairs(mobTable) do table.remove(mobTable,_) end
		for _,v in pairs(mobTable) do table.remove(mobTable,_) end
		for _,v in pairs(mobTable) do table.remove(mobTable,_) end
		for _,v in pairs(mobTable) do table.remove(mobTable,_) end
		task.wait()
        if workspace["__WORKSPACE"].Areas[Selected]:FindFirstChild("Door") then
            Rayfield:Notify({
				Title = "Farm Error",
				Content = "Unlock the "..Selected.." Area to Farm!",
				Duration = 2,
				Image = 4483362458,
			})
        else
            if workspace["__WORKSPACE"].Mobs:FindFirstChild(Selected) then
                for i,v in pairs(workspace["__WORKSPACE"].Mobs[Selected]:GetChildren()) do
					if not table.find(mobTable,v.Name) then
                        table.insert(mobTable,v.Name)
					end
					print(#workspace["__WORKSPACE"].Mobs[Selected]:GetChildren())
					if i == #workspace["__WORKSPACE"].Mobs[Selected]:GetChildren() then
						MobDrop.Options = mobTable
						MobDrop:Refresh(mobTable)
						MobDrop:Set("None")
					end
                end
           	else
            	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["__WORKSPACE"].Areas[Selected].Point.CFrame
                wait(0.2)
                for i,v in pairs(workspace["__WORKSPACE"].Mobs[Selected]:GetChildren()) do
					if not table.find(mobTable,v.Name) then
                        table.insert(mobTable,v.Name)
					end
					if i == #workspace["__WORKSPACE"].Mobs[Selected]:GetChildren() then
						MobDrop.Options = mobTable
						MobDrop:Refresh(mobTable)
						MobDrop:Set("None")
					end
                end
            end
        end
    end
})

local AutoKillNear = MainTab:CreateToggle({
	Name = "Auto Kill Near",
	CurrentValue = false,
	Callback = function(Value)
        if Value then
            AutoKillNearConnection = RunService.RenderStepped:Connect(function()
                AutoKillNearFunc(AreaDrop.CurrentOption)
            end)
        else
            AutoKillNearConnection:Disconnect()
        end
	end,
})

local AutoKillMob = MainTab:CreateToggle({
	Name = "Auto Kill Mob",
	CurrentValue = false,
	Callback = function(Value)
        if Value then
            AutoKillMobConnection = RunService.RenderStepped:Connect(function()
                AutoKillMobFunc(AreaDrop.CurrentOption, MobDrop.CurrentOption)
            end)
        else
            AutoKillMobConnection:Disconnect()
        end
	end,
})

--BossTabPart
local BossSection = BossTab:CreateSection("BossFarm")

local bosdb = false
local LastCf = LocalPlayer.Character.HumanoidRootPart.CFrame

local BossFarmConnection 
local AutoKillBoss
local AreaFarm
local Hud 
AutoKillBoss = BossTab:CreateToggle({
	Name = "Auto Kill Boss",
	CurrentValue = false,
	Callback = function(Value)
		bosdb = Value
		for _,v in pairs(game:GetService("Workspace")["__BOSSES"]:GetChildren()) do
			if v:FindFirstChild("TIMERHUD") and bosdb == true then
				LastCf = LocalPlayer.Character.HumanoidRootPart.CFrame
				LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame * CFrame.new(-2,4,-2)
				while true do
					wait()
					if v:FindFirstChild("TIMERHUD") then
						AutoKillNearFunc(v.Name)
					else
						task.wait(0.15)
						LocalPlayer.Character.HumanoidRootPart.CFrame = LastCf
						break
					end
				end
			end
		end
	end,
})

for _,v in pairs(game:GetService("Workspace")["__BOSSES"]:GetChildren()) do
	v.ChildAdded:Connect(function(child)
		if bosdb == true then
			if child.Name == "TIMERHUD" then
				LastCf = LocalPlayer.Character.HumanoidRootPart.CFrame
				LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame * CFrame.new(-2,4,-2)
				while true do
					wait()
					if v:FindFirstChild("TIMERHUD") then
						AutoKillNearFunc(v.Name)
					else
						task.wait(0.15)
						LocalPlayer.Character.HumanoidRootPart.CFrame = LastCf
						break
					end
				end
			end
		end
	end)
end


--EggTabPart
local AutoOpenEggSection = EggTab:CreateSection("AutoEgg")

local AutoEggDropdown
local SelectPetDropdown1
local SelectPetDropdown2
local SelectPetDropdown3
local SelectPetDropdown4
local SelectPetDropdown5
local SelectPetDropdown6
local Parametros = {}

local AutoEgg = EggTab:CreateToggle({
	Name = "AutoEgg",
	CurrentValue = false,
	Callback = function(Value)
		if Value then
			AutoEggConnection = RunService.RenderStepped:Connect(function()
				task.wait(1)
				game:GetService("ReplicatedStorage").Remotes.Client:FireServer({"BuyTier", workspace.__WORKSPACE.FightersPoint[AutoEggDropdown.CurrentOption], "E", Parametros})	
			end)	
		else	
			AutoEggConnection:Disconnect()
		end
	end,
})

AutoEggDropdown = EggTab:CreateDropdown({
	Name = "Select Egg",
	Options = all_eggareas,
	CurrentOption = "None",
	Callback = function(Option)

		for _,v in pairs(all_eggmobs) do table.remove(all_eggmobs,_) end
		for _,v in pairs(all_eggmobs) do table.remove(all_eggmobs,_) end
		for _,v in pairs(all_eggmobs) do table.remove(all_eggmobs,_) end
		for _,v in pairs(all_eggmobs) do table.remove(all_eggmobs,_) end
		for _,v in pairs(all_eggmobs) do table.remove(all_eggmobs,_) end
		for _,v in pairs(all_eggmobs) do table.remove(all_eggmobs,_) end
		task.wait()

		for i,v in pairs(workspace["__WORKSPACE"].FightersPoint[Option].Fighters:GetChildren()) do
			if not table.find(all_eggmobs,v.Name) then
				table.insert(all_eggmobs,v.Name)
			end
			if i == #workspace["__WORKSPACE"].FightersPoint[Option].Fighters:GetChildren() then
				SelectPetDropdown1:Refresh(all_eggmobs)
				SelectPetDropdown2:Refresh(all_eggmobs)
				SelectPetDropdown3:Refresh(all_eggmobs)
				SelectPetDropdown4:Refresh(all_eggmobs)
				SelectPetDropdown5:Refresh(all_eggmobs)
				SelectPetDropdown6:Refresh(all_eggmobs)
			end
		end
	end,
})

local AutoDeleteEggSection = EggTab:CreateSection("Auto Delete")

local ResetAutoDelete = EggTab:CreateButton({
	Name = "Reset Auto Delete",
	Callback = function()
		Parametros = {}
		SelectPetDropdown1:Set("NoPet")
		SelectPetDropdown2:Set("NoPet")
		SelectPetDropdown3:Set("NoPet")
		SelectPetDropdown4:Set("NoPet")
		SelectPetDropdown5:Set("NoPet")
		SelectPetDropdown6:Set("NoPet")
	end,
})

SelectPetDropdown1 = EggTab:CreateDropdown({
	Name = "Select Pet 1",
	Options = {},
	CurrentOption = "NoPet",
	Callback = function(Option)
		 Parametros[Option] = true
	end,
})

SelectPetDropdown2 = EggTab:CreateDropdown({
	Name = "Select Pet 2",
	Options = {},
	CurrentOption = "NoPet",
	Callback = function(Option)
		 Parametros[Option] = true
	end,
})

SelectPetDropdown3 = EggTab:CreateDropdown({
	Name = "Select Pet 3",
	Options = {},
	CurrentOption = "NoPet",
	Callback = function(Option)
		 Parametros[Option] = true
	end,
})

SelectPetDropdown4 = EggTab:CreateDropdown({
	Name = "Select Pet 4",
	Options = {},
	CurrentOption = "NoPet",
	Callback = function(Option)
		 Parametros[Option] = true
	end,
})

SelectPetDropdown5 = EggTab:CreateDropdown({
	Name = "Select Pet 5",
	Options = {},
	CurrentOption = "NoPet",
	Callback = function(Option)
		 Parametros[Option] = true
	end,
})

SelectPetDropdown6 = EggTab:CreateDropdown({
	Name = "Select Pet 6",
	Options = {},
	CurrentOption = "NoPet",
	Callback = function(Option)
		 Parametros[Option] = true
	end,
})

--MiscTabPart

local MiscSection = MiscTab:CreateSection("Misc")

local OpenedGUI = "None"
local BlackList = {"Fusee", "Rebirth", "Stats", "Artifacts","CMDS", "DungeonRoom", "DefenseInfo4", "BackDefense4", "Defense4", "DefenseInfo2", "BackDefense2", "Defense3", "Limit Break", "VipServer", "Gang", "Defense", "BackDefense3", "Defense2", "Backpack", "BackDefense", "DefenseInfo", "DefenseInfo3", "Skills", "System", "Achievements", "FightersBuy", "Shop", "Gifts", "Settings", "Codes", "ArtifactsOLD"}
--for _,black in pairs(BlackList) do table.remove(all_guis, "CMDS") end
for i,Uis in ipairs(all_guis) do
	if not table.find(BlackList, Uis) then
		table.insert(all_guis2, Uis)
	end
end
task.wait()
--UITabPart
UIDrop = MiscTab:CreateDropdown({
	Name = "Open UI",
	Options = all_guis2,
	CurrentOption = "None",
	Callback = function(Option)
		 for _,v in pairs(LocalPlayer.PlayerGui.UI.CenterFrame:GetChildren()) do
			if v.Name == Option and Option ~= OpenedGUI then
				if OpenedGUI ~= "None" then
					LocalPlayer.PlayerGui.UI.CenterFrame[OpenedGUI].Visible = false
				end
				OpenedGUI = Option
				v.Visible = true
				v.Position = UDim2.new(-4,0 ,-2 , 0)
			end
		 end
	end,
})


local AutoClaimToggle = MiscTab:CreateToggle({
	Name = "AutoClaim Gifts",
	CurrentValue = false,
	Callback = function(Value)
		if Value then
            AutoClaimConnection = RunService.RenderStepped:Connect(function()                
                AutoClaimGifts()
            end)
        else
            AutoClaimConnection:Disconnect()
        end
	end,
})


local WalkSpeedChange = 16
local WalkActive = false
local JumpPowerChange = 50
local JumpActive = false

local PlayerSection = MiscTab:CreateSection("Player")

local WalkSpeedToggle = MiscTab:CreateToggle({
	Name = "WalkSpeed Changer",
	CurrentValue = false,
	Callback = function(Value)
		WalkActive = Value
	end,
})

local WalkspeedSlider = MiscTab:CreateSlider({
	Name = "Walkspeed",
	Range = {16, 150},
	Increment = 2,
	Suffix = "Speed",
	CurrentValue = 16,
	Callback = function(Value)
        WalkSpeedChange = Value
	end,
})

local JumpPowerToggle = MiscTab:CreateToggle({
	Name = "JumpPower Changer",
	CurrentValue = false,
	Callback = function(Value)
		JumpActive = Value
	end,
})

local JumpPowerSlider = MiscTab:CreateSlider({
	Name = "JumpPower",
	Range = {50, 150},
	Increment = 2,
	Suffix = "Power",
	CurrentValue = 50,
	Callback = function(Value)
        JumpPowerChange = Value
	end,
})

RunService.RenderStepped:Connect(function()
    if WalkActive then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeedChange
    end
	if JumpActive then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = JumpPowerChange
    end
end)