super sigma loader:
```lua
local function ls(url, onError)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if not success then
        if oer then
            oer(result)
        else
            warn("failed to load script from " .. url .. ": " .. tostring(result))
        end
    end
    return result
end

local su = "https://xyzzr.github.io/roblox/ML/main.lua"

ls(su, function(err)
    print("An error occurred: " .. tostring(err))
end)
```
