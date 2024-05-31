local insertKey = Enum.KeyCode.RightShift

if not game:IsLoaded() then
game.Loaded:Wait()
end


local plrs = game:GetService("Players")
local PlayerGui = plrs.LocalPlayer:FindFirstChildOfClass("PlayerGui")
local EmojiList = Instance.new("ScrollingFrame")
local EmojiButton = Instance.new("TextButton")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() or Players.LocalPlayer


EmojiList.Name = "EmojiList"
EmojiList.Parent = PlayerGui:WaitForChild("Chat").Frame.ChatBarParentFrame.Frame
EmojiList.Active = true
EmojiList.BackgroundColor3 = Color3.new(0, 0, 0)
EmojiList.BackgroundTransparency = 0.6
EmojiList.BorderSizePixel = 0
EmojiList.Position = UDim2.new(0, 0, 0, 42)
EmojiList.Size = UDim2.new(1, 0, 1, 200)
EmojiList.ScrollBarThickness = 4
EmojiList.VerticalScrollBarInset = "Always"
EmojiList.Visible = false
EmojiButton.Name = "EmojiButton"
EmojiButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
EmojiButton.BackgroundTransparency = 1
EmojiButton.BorderSizePixel = 0
EmojiButton.Size = UDim2.new(1, 0, 0, 20)
EmojiButton.Font = Enum.Font.SourceSansBold
EmojiButton.TextSize = 18
EmojiButton.TextColor3 = Color3.new(1, 1, 1)
EmojiButton.TextXAlignment = Enum.TextXAlignment.Left
game.StarterGui:SetCore("ChatMakeSystemMessage", {
Text = "Emoji Chat Loaded";
Color = Color3.new(255,255,255);
Font = Enum.Font.SourceSans;
FontSize = Enum.FontSize.Size24;
})

local chatFrame = player.PlayerGui.Chat.Frame
chatFrame.ChatChannelParentFrame.Visible = true
chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),chatFrame.ChatChannelParentFrame.Size.Y)


local selected = 0
local chatbox
local emojil = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://raw.githubusercontent.com/bobowawahahahbobobwahahawoaowabobwabo/Script-Stuff/main/Emojis", true))
local emotes = {}
local emojis = {}
local unicode = loadstring(game:HttpGet(("https://pastebin.com/raw/CPzEs37V"),true))()


for i,w in next,emojil do
local str = ""
for v in w.unicode_output:gmatch("[%a%d]+") do
str = str..unicode(v)
end
emojis[w.shortname:sub(2,-2)] = {str,w.keywords}
emotes[#emotes + 1] = w.shortname:sub(2,-2)
end

local emotes,names = emojis,emotes
shared.emotes = emotes
shared.names = names

function compare(t,v)
for _,i in next,t do
if i:sub(1,#v):lower() == v:lower() then
return true
      end
   end
end

function insertEmoji(chat,emoji,emojiText)
if chat and emoji and emojiText then
local finalEmojiText = ":"..emojiText..":"
local prefix = string.find(chatbox.Text,":")
local swapChat = string.gsub(chat,chatbox.Text:sub(prefix),finalEmojiText)
local swapEmoji = string.gsub(swapChat,":[%w%p]+:",emoji)
return(swapEmoji)
   end
end

local e = {}
local n = {}
function update(name)
local t = name
e = {}
n = {}
for i,v in next,emotes do
if i:sub(1,#t):lower() == t:lower() or compare(v[2],t) then
n[#n+1] = i
   end
end
table.sort(n,function(a,b)
return a <= b
end)
for i,v in next,n do
e[i] = emotes[v][1]
end
EmojiList:ClearAllChildren()

local namenum = 1
local prefix = string.find(chatbox.Text,":")

if #e ~= 0 then
EmojiList.Visible = true
local YSize = 25
local num = 1
for i,v in next,e do
if i <= 100 then
local Position = ((num * YSize) - YSize)
local b = EmojiButton:Clone()
local emoj = v
local emojName = n[i]

b.Name = tostring(namenum)
b.Parent = EmojiList
b.Text = emoj.." :"..emojName..":"
b.Position = UDim2.new(0,8,0,Position + 5)
EmojiList.CanvasSize = UDim2.new(0,0,0,Position + 30)
if namenum <= 9 then
EmojiList.Size = UDim2.new(1,0,1,EmojiList.CanvasSize.Y.Offset-40)
else
EmojiList.Size = UDim2.new(1,0,1,200)
end
namenum = namenum+1
num = num+1
b.MouseButton1Click:connect(function()
chatbox.Text = insertEmoji(chatbox.Text,emoj,emojName)
chatbox:CaptureFocus()
EmojiList.Visible = false
      end)
   end
end
else
EmojiList.Visible = false
end
selected = 0
end

local chatboxFunc = nil
if pcall(function() chatbox = PlayerGui:WaitForChild("Chat").Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar end) then
local function Index()
chatbox.Text = string.gsub(chatbox.Text, "\t", "")
local prefix = string.find(chatbox.Text,":")
if prefix ~= nil then
local search = chatbox.Text:sub(prefix+1)
if string.find(search," ") then
EmojiList.Visible = false
   return
end
local endsearch = string.find(search,":")
if endsearch ~= nil then
update(search:sub(1,endsearch-1))
EmojiList.Visible = false
chatbox.Text = insertEmoji(chatbox.Text,e[1],n[1])
return
end
update(search)
else
EmojiList.Visible = false
    end
end
chatboxFunc = chatbox:GetPropertyChangedSignal("Text"):Connect(Index)
PlayerGui.Chat.Frame.ChatBarParentFrame.ChildAdded:Connect(function(newbar)
wait()
if newbar:FindFirstChild("BoxFrame") then
chatbox = PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar
if chatboxFunc then chatboxFunc:Disconnect() end
chatboxFunc = chatbox:GetPropertyChangedSignal("Text"):Connect(Index)
    end
end)
else
  print("Custom chat detected.")
end

local function updateView()
   local index = selected-1
   local topPos = math.ceil(EmojiList.CanvasPosition.Y/25)
   local bottomPos = math.floor((EmojiList.CanvasPosition.Y + EmojiList.AbsoluteSize.Y)/25)-1
   local canvasPos
   if index < topPos then
       canvasPos = index*25
   elseif index > bottomPos then
       canvasPos = 25*(index+1)-EmojiList.AbsoluteSize.Y+5
   end
   if canvasPos then
       EmojiList.CanvasPosition = Vector2.new(0,canvasPos)
   end
end

game:GetService("UserInputService").InputBegan:connect(function(input)
if EmojiList.Visible then
if input.KeyCode == Enum.KeyCode.Down then
   local function scrollDown()
    local deselect = EmojiList:FindFirstChild(selected)
    if deselect ~= nil then
    deselect.BackgroundTransparency = 1
    end
    selected = selected+1
    local item = EmojiList:FindFirstChild(selected)
    if item ~= nil then
    item.BackgroundTransparency = 0.6
    else
    selected = selected-1
    local item = EmojiList:FindFirstChild(selected)
    if item ~= nil then
    item.BackgroundTransparency = 0.6
        end
    end
    updateView()
    end
   
    local releaseEvent,stopped
    releaseEvent = game:GetService("UserInputService").InputEnded:Connect(function(input)
       if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Down then
           releaseEvent:Disconnect()
           stopped = true
        end
    end)
    scrollDown()
    wait(0.5)
    while not stopped do
       scrollDown()
       wait()
       end
elseif input.KeyCode == Enum.KeyCode.Up then
   local function scrollUp()
    local deselect = EmojiList:FindFirstChild(selected)
    if deselect ~= nil then
    deselect.BackgroundTransparency = 1
    end
    selected = selected-1
    local item = EmojiList:FindFirstChild(selected)
    if item ~= nil then
    item.BackgroundTransparency = 0.6
    else
    selected = selected+1
    local item = EmojiList:FindFirstChild(selected)
    if item ~= nil then
    item.BackgroundTransparency = 0.6
        end
    end
    updateView()
    end
   
    local releaseEvent,stopped
    releaseEvent = game:GetService("UserInputService").InputEnded:Connect(function(input)
       if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Up then
           releaseEvent:Disconnect()
           stopped = true
       end
    end)
    scrollUp()
    wait(0.5)
    while not stopped do
       scrollUp()
       wait()
       end
elseif input.KeyCode == insertKey then
if selected ~= 0 then
local item = EmojiList:FindFirstChild(selected)
local prefix = string.find(chatbox.Text,":")
if item ~= nil and prefix ~= nil then
chatbox.Text = insertEmoji(chatbox.Text,e[selected],n[selected])
chatbox:CaptureFocus()
EmojiList.Visible = false
             end
          end
      end
   end
end)
game.StarterGui:SetCore("ChatMakeSystemMessage", {
Text = "Emojis Loaded";
Color = Color3.new(255,255,255);
Font = Enum.Font.SourceSans;
FontSize = Enum.FontSize.Size24;
})
