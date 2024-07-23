--[[

                      > boboware by xyzzr © CC0 1.0 Universal (2024) <
    > Licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License. <

]]

local games = {
    kat = 621129760
}

if game.PlaceId == games.kat then
    loadstring(game:HttpGet("https://xyzzr.github.io/roblox/boboware/kat.lua"))()
else -- universal
  loadstring(game:HttpGet("https://xyzzr.github.io/roblox/boboware/universal.lua"))()
end
