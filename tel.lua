local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()
local win = lib:Window("Moe Hub", Color3.fromRGB(44, 120, 224), Enum.KeyCode.RightControl)
local mainTab = win:Tab("Main")
local teleportTab = win:Tab("Teleport")

local ws = game:GetService("Workspace")
local plr = game:GetService("Players").LocalPlayer
local cam = game:GetService("Workspace").CurrentCamera
local rs = game:GetService("RunService")
local sg = game:GetService("StarterGui")

local crates, upgrades, safeboxes, cars = {}, {}, {}, {}
local espCratesEnabled, espUpgradesEnabled, espSafeBoxesEnabled, espCarsEnabled = false, false, false, false

local function notify(txt)
    sg:SetCore("SendNotification", {
        Title = "Moe Hub",
        Text = txt,
        Button1 = "OK",
        Duration = 5
    })
end

-- 🚀 **Instant Teleport Function**
local function tp(targetPos, offsetY)
    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        plr.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, offsetY, 0))
    end
end

local function findValidPart(model)
    return model and (model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")) or nil
end

local function toggleESP(tbl, state, parentPath, objName, label, color)
    for _, data in pairs(tbl) do
        if data.h then data.h:Destroy() end
        if data.d then data.d:Remove() end
        if data.t then data.t:Remove() end
    end
    table.clear(tbl)

    if not state then return end

    local parent = type(parentPath) == "string" and ws:FindFirstChild(parentPath) or parentPath
    if not parent then
        notify(label .. " Not Found")
        return
    end

    local found = false
    for _, v in ipairs(parent:GetChildren()) do
        if v:IsA("Model") and (objName == nil or v.Name == objName) then
            local part = findValidPart(v)
            if part then
                found = true

                local h = Instance.new("Highlight", part)
                h.FillColor = color
                h.OutlineColor = Color3.fromRGB(255, 255, 255)
                h.FillTransparency = 0.5
                h.OutlineTransparency = 0

                local d = Drawing.new("Line")
                d.Thickness = 2
                d.Color = color

                local t = Drawing.new("Text")
                t.Text = label
                t.Size = 18
                t.Color = color
                t.Center = true
                t.Outline = true

                tbl[part] = {part = part, h = h, d = d, t = t}
            end
        end
    end

    if not found then
        notify(label .. " Not Found")
    end
end

rs.RenderStepped:Connect(function()
    for tbl, enabled in pairs({
        [crates] = espCratesEnabled,
        [upgrades] = espUpgradesEnabled,
        [safeboxes] = espSafeBoxesEnabled,
        [cars] = espCarsEnabled
    }) do
        if enabled then
            for p, data in pairs(tbl) do
                if p and p:IsDescendantOf(ws) then
                    local v, o = cam:WorldToViewportPoint(p.Position)
                    data.d.Visible = o
                    data.t.Visible = o
                    if o then
                        data.d.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
                        data.d.To = Vector2.new(v.X, v.Y)
                        data.t.Position = Vector2.new(v.X, v.Y - 20)
                    end
                else
                    data.d.Visible = false
                    data.t.Visible = false
                end
            end
        end
    end
end)

mainTab:Toggle("Crate ESP", false, function(v)
    espCratesEnabled = v
    toggleESP(crates, v, ws, "Crate", "Crate", Color3.fromRGB(255, 0, 0))
end)

mainTab:Toggle("Upgrades ESP", false, function(v)
    espUpgradesEnabled = v
    toggleESP(upgrades, v, "Upgrades", nil, "Upgrade", Color3.fromRGB(0, 255, 0))
end)

mainTab:Toggle("Safe Box ESP", false, function(v)
    local ectModels = ws:FindFirstChild("Map") and ws.Map:FindFirstChild("EctModels")
    if not ectModels then
        notify("Safe Box Folder Not Found")
        return
    end
    espSafeBoxesEnabled = v
    toggleESP(safeboxes, v, ectModels, "DepositBox", "Safe Box", Color3.fromRGB(255, 255, 0))
end)

mainTab:Toggle("Car ESP", false, function(v)
    espCarsEnabled = v
    toggleESP(cars, v, "Cars", "Car", "Car", Color3.fromRGB(0, 0, 255))
end)

mainTab:Button("Infinite Ammo", function()
loadstring(game:HttpGet"https://raw.githubusercontent.com/Moe1325/kill-noob-simulator/refs/heads/main/ammo.lua")()
end)

mainTab:Button("Glock Switch", function()
loadstring(game:HttpGet"https://raw.githubusercontent.com/Moe1325/kill-noob-simulator/refs/heads/main/switch.lua")()
end)

mainTab:Button("Hitbox Expander", function()
loadstring(game:HttpGet"https://raw.githubusercontent.com/Moe1325/kill-noob-simulator/refs/heads/main/hitbox.lua")()
end)

mainTab:Button("Azure Modded", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Actyrn/Scripts/main/AzureModded"))()
end)

mainTab:Button("Infinite Yield", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/edgeiy/infiniteyield/master/source"))()
end)

teleportTab:Button("Teleport to Nearest Crate", function()
    local target = findValidPart(ws:FindFirstChild("Crate"))
    if target then
        tp(target.Position, 5)
    else
        notify("Crate Not Found")
    end
end)

teleportTab:Button("Teleport to Nearest Upgrade", function()
    local target = findValidPart(ws:FindFirstChild("Upgrades"))
    if target then
        tp(target.Position, 0)
    else
        notify("Upgrade Not Found")
    end
end)

teleportTab:Button("Teleport to Nearest Safe Box", function()
    local ectModels = ws:FindFirstChild("Map") and ws.Map:FindFirstChild("EctModels")
    if not ectModels then
        notify("Safe Box Folder Not Found")
        return
    end
    local target = findValidPart(ectModels:FindFirstChild("DepositBox"))
    if target then
        tp(target.Position, 5)
    else
        notify("Safe Box Not Found")
    end
end)

teleportTab:Button("Teleport to Nearest Car", function()
    local carsFolder = ws:FindFirstChild("Cars")
    if not carsFolder then
        notify("Cars Folder Not Found")
        return
    end

    local closest, minDist, closestCar = nil, math.huge, nil
    for _, v in ipairs(carsFolder:GetChildren()) do
        if v:IsA("Model") and v.Name == "Car" then
            local part = findValidPart(v)
            if part then
                local dist = (part.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                if dist < minDist then
                    closest, minDist, closestCar = part, dist, v
                end
            end
        end
    end

    if closest then
        tp(closest.Position, 0)
    else
        notify("Car Not Found")
    end
end)

teleportTab:Button("Teleport to Safe Zone", function()
    tp(Vector3.new(-166, 8, -432), 0)
end)
