local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()

local win = lib:Window("PREVIEW",Color3.fromRGB(44, 120, 224), Enum.KeyCode.RightControl)

local tab = win:Tab("Main")

tab:Button("Infinite Ammo", function()
loadstring(game:HttpGet"https://raw.githubusercontent.com/Moe1325/kill-noob-simulator/refs/heads/main/ammo.lua")()
end)

tab:Button("Glock Switch", function()
loadstring(game:HttpGet"https://raw.githubusercontent.com/Moe1325/kill-noob-simulator/refs/heads/main/switch.lua")()
end)

tab:Button("Hitbox Expander", function()
loadstring(game:HttpGet"https://raw.githubusercontent.com/Moe1325/kill-noob-simulator/refs/heads/main/hitbox.lua")()
end)

tab:Button("Azure Modded", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Actyrn/Scripts/main/AzureModded"))()
end)

tab:Button("Infinite Yield", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/edgeiy/infiniteyield/master/source"))()
end)

local changeclr = win:Tab("Change UI Color")

changeclr:Colorpicker("Change UI Color",Color3.fromRGB(44, 120, 224), function(t)
lib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
end)
