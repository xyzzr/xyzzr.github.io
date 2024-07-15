--[[

OMG NO RATS!?
NO LOGGERS!?
WHATTTT THIS IS UNHEARD OF!

Supported games reminder 
https://www.roblox.com/games/9043532917/Ramp-Jumping-On-sports-cars
https://www.roblox.com/games/6816975827/Car-Suspension-Test
https://www.roblox.com/games/4456880028/Ro-Crash
https://www.roblox.com/games/5752297721/Z-Bus
https://www.roblox.com/games/7764872557/UPDATE-Realistic-Car-Crash-Simulator
https://www.roblox.com/games/3239849876/TRAFFIC-Road-of-Car-Crash
https://www.roblox.com/games/7720943627/Car-Crash-Test
https://www.roblox.com/games/10592754185/BT-Drive-BETA
https://www.roblox.com/games/4643061038/Car-Crash-Test


known bugs
more than 1 execution: fly bugs out
fix: rejoin & execute only once


CHANGELOG

6/26/2024: 8:18PM
Added remove limbs command
Added nude command (wow)

6/25/2024: 5:32PM
Fixed bald command
Fixed fly

7/15/2024 5:27PM
Fixed bald command again 😥
]]

loadstring(game:HttpGet("https://pastebin.com/raw/2GHL79gP"))() -- spys gonna get this!
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xyzzr/libarys/main/xsyhfs.lua"))()
local version = "1.5"
local Wm = library:Watermark("Rice admin | v" .. version)
local Notif = library:InitNotifications()

library.title = "Rice admin"
library:Introduction()
wait(1)
local Init = library:Init()
local Tab1 = Init:NewTab("Main")
local Tab2 = Init:NewTab("Misc")
--[[ FUNCTIONS ]]--

local Players = game:GetService("Players")
function splitString(str,delim)
    local broken = {}
    if delim == nil then delim = "," end
    for w in string.gmatch(str,"[^"..delim.."]+") do
        table.insert(broken,w)
    end
    return broken
end
function toTokens(str)
    local tokens = {}
    for op,name in string.gmatch(str,"([+-])([^+-]+)") do
        table.insert(tokens,{Operator = op,Name = name})
    end
    return tokens
end
function getRoot(char)
    local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
    return rootPart
end
local WTS = function(Object)
    local ObjectVector = workspace.CurrentCamera:WorldToScreenPoint(Object.Position)
    return Vector2.new(ObjectVector.X, ObjectVector.Y)
end
local mouse = Players.LocalPlayer:GetMouse()
local MousePositionToVector2 = function()
    return Vector2.new(mouse.X, mouse.Y)
end
local GetClosestPlayerFromCursor = function()
    local found = nil
    local ClosestDistance = math.huge
    for i, v in pairs(Players:GetPlayers()) do
        if v ~= Players.LocalPlayer and v.Character and v.Character:FindFirstChildOfClass("Humanoid") then
            for k, x in pairs(v.Character:GetChildren()) do
                if string.find(x.Name, "Torso") then
                    local Distance = (WTS(x) - MousePositionToVector2()).Magnitude
                    if Distance < ClosestDistance then
                        ClosestDistance = Distance
                        found = v
                    end
                end
            end
        end
    end
    return found
end

local SpecialPlayerCases = {
    ["all"] = function(speaker) return Players:GetPlayers() end,
    ["others"] = function(speaker)
        local plrs = {}
        for i,v in pairs(Players:GetPlayers()) do
            if v ~= speaker then
                table.insert(plrs,v)
            end
        end
        return plrs
    end,
    ["me"] = function(speaker)return {speaker} end,
    ["#(%d+)"] = function(speaker,args,currentList)
        local returns = {}
        local randAmount = tonumber(args[1])
        local players = {unpack(currentList)}
        for i = 1,randAmount do
            if #players == 0 then break end
            local randIndex = math.random(1,#players)
            table.insert(returns,players[randIndex])
            table.remove(players,randIndex)
        end
        return returns
    end,
    ["random"] = function(speaker,args,currentList)
        local players = Players:GetPlayers()
        local localplayer = Players.LocalPlayer
        table.remove(players, table.find(players, localplayer))
        return {players[math.random(1,#players)]}
    end,
    ["%%(.+)"] = function(speaker,args)
        local returns = {}
        local team = args[1]
        for _,plr in pairs(Players:GetPlayers()) do
            if plr.Team and string.sub(string.lower(plr.Team.Name),1,#team) == string.lower(team) then
                table.insert(returns,plr)
            end
        end
        return returns
    end,
    ["allies"] = function(speaker)
        local returns = {}
        local team = speaker.Team
        for _,plr in pairs(Players:GetPlayers()) do
            if plr.Team == team then
                table.insert(returns,plr)
            end
        end
        return returns
    end,
    ["enemies"] = function(speaker)
        local returns = {}
        local team = speaker.Team
        for _,plr in pairs(Players:GetPlayers()) do
            if plr.Team ~= team then
                table.insert(returns,plr)
            end
        end
        return returns
    end,
    ["team"] = function(speaker)
        local returns = {}
        local team = speaker.Team
        for _,plr in pairs(Players:GetPlayers()) do
            if plr.Team == team then
                table.insert(returns,plr)
            end
        end
        return returns
    end,
    ["nonteam"] = function(speaker)
        local returns = {}
        local team = speaker.Team
        for _,plr in pairs(Players:GetPlayers()) do
            if plr.Team ~= team then
                table.insert(returns,plr)
            end
        end
        return returns
    end,
    ["friends"] = function(speaker,args)
        local returns = {}
        for _,plr in pairs(Players:GetPlayers()) do
            if plr:IsFriendsWith(speaker.UserId) and plr ~= speaker then
                table.insert(returns,plr)
            end
        end
        return returns
    end,
    ["nonfriends"] = function(speaker,args)
        local returns = {}
        for _,plr in pairs(Players:GetPlayers()) do
            if not plr:IsFriendsWith(speaker.UserId) and plr ~= speaker then
                table.insert(returns,plr)
            end
        end
        return returns
    end,
    ["guests"] = function(speaker,args)
        local returns = {}
        for _,plr in pairs(Players:GetPlayers()) do
            if plr.Guest then
                table.insert(returns,plr)
            end
        end
        return returns
    end,
    ["bacons"] = function(speaker,args)
        local returns = {}
        for _,plr in pairs(Players:GetPlayers()) do
            if plr.Character:FindFirstChild('Pal Hair') or plr.Character:FindFirstChild('Kate Hair') then
                table.insert(returns,plr)
            end
        end
        return returns
    end,
    ["age(%d+)"] = function(speaker,args)
        local returns = {}
        local age = tonumber(args[1])
        if not age == nil then return end
        for _,plr in pairs(Players:GetPlayers()) do
            if plr.AccountAge <= age then
                table.insert(returns,plr)
            end
        end
        return returns
    end,
    ["nearest"] = function(speaker,args,currentList)
        local speakerChar = speaker.Character
        if not speakerChar or not getRoot(speakerChar) then return end
        local lowest = math.huge
        local NearestPlayer = nil
        for _,plr in pairs(currentList) do
            if plr ~= speaker and plr.Character then
                local distance = plr:DistanceFromCharacter(getRoot(speakerChar).Position)
                if distance < lowest then
                    lowest = distance
                    NearestPlayer = {plr}
                end
            end
        end
        return NearestPlayer
    end,
    ["farthest"] = function(speaker,args,currentList)
        local speakerChar = speaker.Character
        if not speakerChar or not getRoot(speakerChar) then return end
        local highest = 0
        local Farthest = nil
        for _,plr in pairs(currentList) do
            if plr ~= speaker and plr.Character then
                local distance = plr:DistanceFromCharacter(getRoot(speakerChar).Position)
                if distance > highest then
                    highest = distance
                    Farthest = {plr}
                end
            end
        end
        return Farthest
    end,
    ["group(%d+)"] = function(speaker,args)
        local returns = {}
        local groupID = tonumber(args[1])
        for _,plr in pairs(Players:GetPlayers()) do
            if plr:IsInGroup(groupID) then  
                table.insert(returns,plr)
            end
        end
        return returns
    end,
    ["alive"] = function(speaker,args)
        local returns = {}
        for _,plr in pairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") and plr.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                table.insert(returns,plr)
            end
        end
        return returns
    end,
    ["dead"] = function(speaker,args)
        local returns = {}
        for _,plr in pairs(Players:GetPlayers()) do
            if (not plr.Character or not plr.Character:FindFirstChildOfClass("Humanoid")) or plr.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then
                table.insert(returns,plr)
            end
        end
        return returns
    end,
    ["rad(%d+)"] = function(speaker,args)
        local returns = {}
        local radius = tonumber(args[1])
        local speakerChar = speaker.Character
        if not speakerChar or not getRoot(speakerChar) then return end
        for _,plr in pairs(Players:GetPlayers()) do
            if plr.Character and getRoot(plr.Character) then
                local magnitude = (getRoot(plr.Character).Position-getRoot(speakerChar).Position).magnitude
                if magnitude <= radius then table.insert(returns,plr) end
            end
        end
        return returns
    end,
    ["cursor"] = function(speaker)
        local plrs = {}
        local v = GetClosestPlayerFromCursor()
        if v ~= nil then table.insert(plrs, v) end
        return plrs
    end,
}

function onlyIncludeInTable(tab,matches)
    local matchTable = {}
    local resultTable = {}
    for i,v in pairs(matches) do matchTable[v.Name] = true end
    for i,v in pairs(tab) do if matchTable[v.Name] then table.insert(resultTable,v) end end
    return resultTable
end

function removeTableMatches(tab,matches)
    local matchTable = {}
    local resultTable = {}
    for i,v in pairs(matches) do matchTable[v.Name] = true end
    for i,v in pairs(tab) do if not matchTable[v.Name] then table.insert(resultTable,v) end end
    return resultTable
end

function getPlayersByName(Name)
    local Name,Len,Found = string.lower(Name),#Name,{}
    for _,v in pairs(Players:GetPlayers()) do
        if Name:sub(0,1) == '@' then
            if string.sub(string.lower(v.Name),1,Len-1) == Name:sub(2) then
                table.insert(Found,v)
            end
        else
            if string.sub(string.lower(v.Name),1,Len) == Name or string.sub(string.lower(v.DisplayName),1,Len) == Name then
                table.insert(Found,v)
            end
        end
    end
    return Found
end
function getPlayer(list,speaker)
    if list == nil then return {speaker.Name} end
    local nameList = splitString(list,",")
    local foundList = {}
    for _,name in pairs(nameList) do
        if string.sub(name,1,1) ~= "+" and string.sub(name,1,1) ~= "-" then name = "+"..name end
        local tokens = toTokens(name)
        local initialPlayers = Players:GetPlayers()
        for i,v in pairs(tokens) do
            if v.Operator == "+" then
                local tokenContent = v.Name
                local foundCase = false
                for regex,case in pairs(SpecialPlayerCases) do
                    local matches = {string.match(tokenContent,"^"..regex.."$")}
                    if #matches > 0 then
                        foundCase = true
                        initialPlayers = onlyIncludeInTable(initialPlayers,case(speaker,matches,initialPlayers))
                    end
                end
                if not foundCase then
                    initialPlayers = onlyIncludeInTable(initialPlayers,getPlayersByName(tokenContent))
                end
            else
                local tokenContent = v.Name
                local foundCase = false
                for regex,case in pairs(SpecialPlayerCases) do
                    local matches = {string.match(tokenContent,"^"..regex.."$")}
                    if #matches > 0 then
                        foundCase = true
                        initialPlayers = removeTableMatches(initialPlayers,case(speaker,matches,initialPlayers))
                    end
                end
                if not foundCase then
                    initialPlayers = removeTableMatches(initialPlayers,getPlayersByName(tokenContent))
                end
            end
        end
        for i,v in pairs(initialPlayers) do table.insert(foundList,v) end
    end
    local foundNames = {}
    for i,v in pairs(foundList) do table.insert(foundNames,v.Name) end
    return foundNames
end

local supported = {
    [6816975827] = true,
    [4456880028] = true,
    [5752297721] = true,
    [7764872557] = true,
    [3239849876] = true,
    [7720943627] = true,
    [10592754185] = true,
    [4643061038] = true,
    [9043532917] = true
}

if supported[game.PlaceId] then
function Destroy(instance)
    spawn(function()
        game:GetService("ReplicatedStorage").DeleteCar:FireServer(instance)
    end)
end
else
print("Invalid gameID! this script might not work.")
end



-- ban
function FindInTable(tbl,val)
    if tbl == nil then return false end
    for _,v in pairs(tbl) do
        if v == val then return true end
    end 
    return false
end
local slockk = false
local banned = {}
Players.PlayerAdded:connect(function(plr)
    if slockk then
        Destroy(plr)
    end
    if FindInTable(banned, plr.UserId) then
        Destroy(plr)
    end
end)





function givehammer()
local selectionbox = Instance.new("SelectionBox", workspace)
local equipped = false
local oldmouse = mouse.Icon
local destroytool = Instance.new("Tool", Players.LocalPlayer:FindFirstChildOfClass("Backpack"))
destroytool.RequiresHandle = false
destroytool.Name = "Destruction Hammer"
destroytool.ToolTip = "xyzzr was here!"
destroytool.TextureId = "http://www.roblox.com/asset/?id=12223874"
destroytool.CanBeDropped = false
destroytool.Equipped:connect(function()
    equipped = true
    mouse.Icon = "rbxasset://textures\\HammerCursor.png"
    while equipped do
        selectionbox.Adornee = mouse.Target
        wait()
    end
end)
destroytool.Unequipped:connect(function()
    equipped = false
    selectionbox.Adornee = nil
    mouse.Icon = oldmouse
    print(oldmouse)
end)
destroytool.Activated:connect(function()
    local explosion = Instance.new("Explosion", workspace)
    explosion.BlastPressure = 0
    explosion.BlastRadius = 0
    explosion.DestroyJointRadiusPercent = 0
    explosion.ExplosionType = Enum.ExplosionType.NoCraters
    explosion.Position = mouse.Target.Position
    Destroy(mouse.Target)
end)
game:GetService("StarterGui"):SetCoreGuiEnabled('Backpack', true)
Players.LocalPlayer.CharacterAdded:connect(function()
    local destroytool = Instance.new("Tool", Players.LocalPlayer:FindFirstChildOfClass("Backpack"))
    destroytool.RequiresHandle = false
    destroytool.Name = "Destruction Hammer"
    destroytool.ToolTip = "xyzzr was here!"
    destroytool.TextureId = "http://www.roblox.com/asset/?id=12223874"
    destroytool.CanBeDropped = false
    destroytool.Equipped:connect(function()
        equipped = true
        mouse.Icon = "rbxasset://textures\\HammerCursor.png"
        while equipped do
            selectionbox.Adornee = mouse.Target
            wait()
        end
    end)
    destroytool.Unequipped:connect(function()
        equipped = false
        selectionbox.Adornee = nil
        mouse.Icon = oldmouse
        print(oldmouse)
    end)
    destroytool.Activated:connect(function()
        local explosion = Instance.new("Explosion", workspace)
        explosion.BlastPressure = 0
        explosion.BlastRadius = 0
        explosion.DestroyJointRadiusPercent = 0
        explosion.ExplosionType = Enum.ExplosionType.NoCraters
        explosion.Position = mouse.Target.Position
        Destroy(mouse.Target)
    end)
    game:GetService("StarterGui"):SetCoreGuiEnabled('Backpack', true)
end)
end

-- [[ END OF FUNCTIONS ]] --

_G.target = "others"

local Selector1 = Tab1:NewSelector("Select Command", "[]", {"bald", "kick", "kill", "server ban", "goto", "server lock", "punish", "nude", "remove limbs"}, function(d)
    -- print(d) -- debug thingie
Notif:Notify("Ran command!", 4, "success")
if d == "bald" then -- bald cmd
    local players = getPlayer(_G.target, Players.LocalPlayer)
    for i, v in pairs(players) do
        for i, v in pairs(Players[v].Character:GetChildren()) do
            if v:IsA("Accessory") then
                Destroy(v)
            end
        end
    end
elseif d == "kick" then
local players = getPlayer(_G.target, Players.LocalPlayer)
    for i, v in pairs(players) do
        Destroy(Players[v])
    end
elseif d == "kill" then
    print("ran")
    local players = getPlayer(_G.target, Players.LocalPlayer)
    for i, v in pairs(players) do
        if Players[v].Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            Destroy(Players[v].Character.Torso.Neck)
        else
            Destroy(Players[v].Character.Head.Neck)
        end
    end
elseif d == "server ban" then
    local players = getPlayer(_G.target, Players.LocalPlayer)
    for i, v in pairs(players) do
        table.insert(banned, Players[v].UserId)
        Destroy(Players[v])
    end
elseif d == "goto" then -- goto
local players = getPlayer(_G.target, Players.LocalPlayer)
    for i, v in pairs(players) do
        if Players[v].Character ~= nil then
            if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') and Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').SeatPart then
                Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').Sit = false
                wait(.1)
            end
            getRoot(Players.LocalPlayer.Character).CFrame = getRoot(Players[v].Character).CFrame + Vector3.new(3,1,0)
        end
    end
elseif d == "server lock" then -- serverlock
        if slockk then 
        slockk = false
    else
        slockk = true
    end

elseif d == "punish" then -- punish
    local players = getPlayer(_G.target, Players.LocalPlayer)
    for i, v in pairs(players) do
        Destroy(Players[v].Character)
    end 

elseif d == "nude" then -- nude
    local players = getPlayer(_G.target, Players.LocalPlayer)
    for i, v in pairs(players) do
        Destroy(Players[v].Character:FindFirstChildOfClass("Pants"))
        Destroy(Players[v].Character:FindFirstChildOfClass("Shirt"))
        Destroy(Players[v].Character:FindFirstChildOfClass("ShirtGraphic"))
    end

elseif d == "remove limbs" then -- remove limbs (sigma)
    local players = getPlayer(_G.target, Players.LocalPlayer)
    for i, v in pairs(players) do
        if Players[v].Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            Destroy(Players[v].Character["Left Arm"])
            Destroy(Players[v].Character["Left Leg"])
            Destroy(Players[v].Character["Right Arm"])
            Destroy(Players[v].Character["Right Leg"])
        else
            Destroy(Players[v].Character["LeftUpperArm"])
            Destroy(Players[v].Character["LeftUpperLeg"])
            Destroy(Players[v].Character["RightUpperArm"])
            Destroy(Players[v].Character["RightUpperLeg"])
        end
    end
end


end)




local Textbox2 = Tab1:NewTextbox("Select target", "", "displayname/username", "all", "medium", true, false, function(val)
    _G.target = val
Notif:Notify("Target set to: " ..val, 4, "success")
end)

local Label1 = Tab1:NewLabel("Localplayer", "left")

local Button1 = Tab1:NewButton("Give Destruction Hammer", function()
    givehammer()
    Notif:Notify("Check ur inventory/backpack", 4, "success")
end)

-- [[ flight ]] -- i did NOT make this flight script!!!!! dk the guy who did

local mt = getrawmetatable(game)
local LocalPlayer = game.Players.LocalPlayer
local Character = game.Players.LocalPlayer.Character
local Workspace = game:GetService("Workspace")
local hum = game.Players.LocalPlayer.Character
local p = game:GetService("Players").LocalPlayer
local speed = 50

local c
local h
local bv
local bav
local cam
local flying
local p = game.Players.LocalPlayer
local buttons = {
        W = false,
        S = false,
        A = false,
        D = false,
        Moving = false
}
local yesfly = function ()
        if not p.Character or not p.Character.Head or flying then
                return
        end
        c = p.Character
        h = c.Humanoid
        h.PlatformStand = true
        cam = workspace:WaitForChild('Camera')
        bv = Instance.new("BodyVelocity")
        bav = Instance.new("BodyAngularVelocity")
        bv.Velocity, bv.MaxForce, bv.P = Vector3.new(0, 0, 0), Vector3.new(10000, 10000, 10000), 1000
        bav.AngularVelocity, bav.MaxTorque, bav.P = Vector3.new(0, 0, 0), Vector3.new(10000, 10000, 10000), 1000
        bv.Parent = c.Head
        bav.Parent = c.Head
        flying = true
        h.Died:connect(function()
                flying = false
        end)
end

local nofly = function ()
        if not p.Character or not flying then
                return
        end
        h.PlatformStand = false
        bv:Destroy()
        bav:Destroy()
        flying = false
end

game:GetService("UserInputService").InputBegan:connect(function (input, GPE)
        if GPE then
                return
        end
        for i, e in pairs(buttons) do
                if i ~= "Moving" and input.KeyCode == Enum.KeyCode[i] then
                        buttons[i] = true
                        buttons.Moving = true
                end
        end
end)



game:GetService("UserInputService").InputEnded:connect(function (input, GPE)
        if GPE then
                return
        end
        local a = false
        for i, e in pairs(buttons) do
                if i ~= "Moving" then
                        if input.KeyCode == Enum.KeyCode[i] then
                                buttons[i] = false
                        end
                        if buttons[i] then
                                a = true
                        end
                end
        end
        buttons.Moving = a
end)

local setVec = function (vec)
        return vec * (speed / vec.Magnitude)
end

game:GetService("RunService").Heartbeat:connect(function (step)
        if flying and c and c.PrimaryPart then
                local p = c.PrimaryPart.Position
                local cf = cam.CFrame
                local ax, ay, az = cf:toEulerAnglesXYZ()
                c:SetPrimaryPartCFrame(CFrame.new(p.x, p.y, p.z) * CFrame.Angles(ax, ay, az))
                if buttons.Moving then
                        local t = Vector3.new()
                        if buttons.W then
                                t = t + (setVec(cf.lookVector))
                        end
                        if buttons.S then
                                t = t - (setVec(cf.lookVector))
                        end
                        if buttons.A then
                                t = t - (setVec(cf.rightVector))
                        end
                        if buttons.D then
                                t = t + (setVec(cf.rightVector))
                        end
                        c:TranslateBy(t * step)
                end
        end
end)

local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
local Toggled = value

if Toggled then
    Toggled = false
    nofly()
else
    Toggled = true
    yesfly()
end

Toggled = false
nofly()

-- [[ flight ]] --




local Slider1 = Tab1:NewSlider("Fly speed", "", true, "/", {min = 1, max = 500, default = 50}, function(value)
    speed = value
end)

local Toggle1 = Tab1:NewToggle("Toggle fly", false, function(value)
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
local Toggled = value

if Toggled then
Notif:Notify("Toggled flight", 4, "success")
    Toggled = true
    yesfly()
else
Notif:Notify("Untoggled flight", 4, "success")
    Toggled = false
    nofly()
end

end):AddKeybind(Enum.KeyCode.F)

-- [[ MISC ]] --


local Label4 = Tab2:NewLabel("Made by xyzzr!", "left")

-- [[ END ]] --
local FinishedLoading = Notif:Notify("Loaded rice admin!", 4, "success")
