local Players = game:GetService("Players")
local player = Players.LocalPlayer
local getmsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
local instance = (_G.chatSpyInstance or 0) + 1
_G.chatSpyInstance = instance

local Rayfield = loadstring(game:HttpGet('https://xyzzr.github.io/roblox/ML/library.lua'))()
local Window = Rayfield:CreateWindow({
    Name = "Message Logger | V1.2",
    LoadingTitle = "Message Logger",
    LoadingSubtitle = "by @.bitdancer",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "ML",
        FileName = "data"
    },
    KeySystem = false,
    KeySettings = {
        Title = "Message Logger",
        Subtitle = "Key System",
        Note = "bleeeeeeh",
        SaveKey = true,
        Key = "ABCDEF"
    }
})



-- Tabs
local Tab = Window:CreateTab("Main", 4483362458)
local Tab2 = Window:CreateTab("Logs", 4483362458)

-- raw settings
local loggerenabled = false -- master toggle
local loggedmsgs = [[
-- ML - Date of download: ]] .. os.date("%B %d, %Y - %H:%M:%S") .. [[


pal didint log anything and still downloaded 💀
]]

-- [[ Chat logger logic ]] --

local function onChatted(p, msg)
    if _G.chatSpyInstance == instance and loggerenabled then
        msg = msg:gsub("[\n\r]", ''):gsub("\t", ' '):gsub("[ ]+", ' ')
        local hidden = true
        local conn = getmsg.OnClientEvent:Connect(function(packet, channel)
            if packet.SpeakerUserId == p.UserId and packet.Message == msg:sub(#msg - #packet.Message + 1) then
                hidden = false
            end
        end)
        wait(1)
        conn:Disconnect()
        if hidden then
            local Label = Tab2:CreateLabel("[" .. p.Name .. "]: " .. msg)
            if loggedmsgs:find("pal didint log anything and still downloaded 💀") then
                loggedmsgs = loggedmsgs:gsub("pal didint log anything and still downloaded 💀", "")
            end
            local timestamp = os.date("%H:%M:%S")
            loggedmsgs = loggedmsgs .. "\n[" .. timestamp .. "_" .. p.Name .. "/" .. p.UserId .. "]: " .. msg
        end
    end
end

for _, p in ipairs(Players:GetPlayers()) do
    p.Chatted:Connect(function(msg)
        onChatted(p, msg)
    end)
end

Players.PlayerAdded:Connect(function(p)
    p.Chatted:Connect(function(msg)
        onChatted(p, msg)
    end)
end)

-- [[ End of chat logger logic ]] --


local Section = Tab:CreateSection("Logger settings")

local Toggle = Tab:CreateToggle({
    Name = "Log messages",
    CurrentValue = false,
    Flag = "mastertoggle",
    Callback = function(Value)
        loggerenabled = Value
        if loggerenabled then
            Rayfield:Notify({
                Title = "ML - Status",
                Content = "Logger turned on!",
                Duration = 6.5,
                Image = 4483362458,
                Actions = {},
            })
        else
            Rayfield:Notify({
                Title = "ML - Status",
                Content = "Logger turned off!",
                Duration = 6.5,
                Image = 4483362458,
                Actions = {},
            })
        end
    end,
})

-- Misc section
local Section = Tab:CreateSection("Misc")

local Button = Tab:CreateButton({
   Name = "Destroy UI & Logger",
   Callback = function()
        loggerenabled = false
            task.wait(0.1)
        Rayfield:Destroy()
   end,
})
local Label = Tab:CreateLabel("Credits: @.bitdancer - Main scripter")

-- Download logs button
local Section = Tab2:CreateSection("Downloading")
local Button = Tab2:CreateButton({
    Name = "Download logs",
    Callback = function()
        Rayfield:Notify({
            Title = "ML - Logs downloader",
            Content = "Downloaded logs to executor workspace.",
            Duration = 6.5,
            Image = 4483362458,
            Actions = {},
        })
        local thefilename = "ML - " .. os.date("%B %d, %Y - %H.%M.%S")
        writefile(thefilename .. ".txt", loggedmsgs)
    end,
})

-- Logs section
local Section = Tab2:CreateSection("Logs")
