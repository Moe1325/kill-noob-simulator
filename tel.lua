local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()
local win = lib:Window("PREVIEW", Color3.fromRGB(44, 120, 224), Enum.KeyCode.RightControl)
local tab = win:Tab("Main")

local ws = game:GetService("Workspace")
local plr = game:GetService("Players").LocalPlayer
local cam = game:GetService("Workspace").CurrentCamera
local rs = game:GetService("RunService")

local crates, upgrades, safeboxes, cars = {}, {}, {}, {}
local espCratesEnabled, espUpgradesEnabled, espSafeboxesEnabled, espCarsEnabled = false, false, false, false

local function tp(cords)
    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        plr.Character.HumanoidRootPart.CFrame = CFrame.new(cords)
    end
end

local function findValidPart(model)
    return model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")
end

local function toggleESP(tbl, state, parentPath, objectName, label, color)
    if state then
        local parent = ws:FindFirstChild(parentPath) and ws[parentPath]:FindFirstChild("EctModels")
        if parent then
            for _, v in ipairs(parent:GetChildren()) do
                if v:IsA("Model") and v.Name == objectName then
                    local part = findValidPart(v)
                    if part then
                        local h = Instance.new("Highlight", part)
                        h.FillColor = color
                        h.OutlineColor = Color3.fromRGB(255, 255, 255)
                        h.FillTransparency = 0.5
                        h.OutlineTransparency = 0

                        local d = Drawing.new("Line")
                        d.Thickness = 1
                        d.Color = color

                        local t = Drawing.new("Text")
                        t.Text = label
                        t.Size = 18
                        t.Color = color
                        t.Center = true
                        t.Outline = true

                        tbl[v] = {part = part, h = h, d = d, t = t}
                    end
                end
            end
        end
    else
        for _, data in pairs(tbl) do
            if data.h then data.h:Destroy() end
            if data.d then data.d:Remove() end
            if data.t then data.t:Remove() end
        end
        table.clear(tbl)
    end
end

rs.RenderStepped:Connect(function()
    for tbl, enabled in pairs({
        [crates] = espCratesEnabled,
        [upgrades] = espUpgradesEnabled,
        [safeboxes] = espSafeboxesEnabled,
        [cars] = espCarsEnabled
    }) do
        if enabled then
            for _, data in pairs(tbl) do
                if data.part and data.part:IsDescendantOf(ws) then
                    local v, o = cam:WorldToViewportPoint(data.part.Position)
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

tab:Toggle("Crate ESP", false, function(v)
    espCratesEnabled = v
    toggleESP(crates, v, "Map", "Crate", "Crate", Color3.fromRGB(255, 0, 0))
end)

tab:Toggle("Upgrades ESP", false, function(v)
    espUpgradesEnabled = v
    toggleESP(upgrades, v, "Upgrades", "Upgrades", "Upgrade", Color3.fromRGB(0, 255, 0))
end)

tab:Toggle("Safe Box ESP", false, function(v)
    espSafeboxesEnabled = v
    toggleESP(safeboxes, v, "Map", "DepositBox", "Safe Box", Color3.fromRGB(255, 255, 0))
end)

tab:Toggle("Car ESP", false, function(v)
    espCarsEnabled = v
    toggleESP(cars, v, "Cars", "Car", "Car", Color3.fromRGB(0, 0, 255))
end)

tab:Button("Teleport to Nearest Crate", function()
    if ws:FindFirstChild("Map") and ws.Map:FindFirstChild("EctModels") then
        local closest, minDist = nil, math.huge
        for _, v in ipairs(ws.Map.EctModels:GetChildren()) do
            if v:IsA("Model") and v.Name == "Crate" then
                local part = findValidPart(v)
                if part then
                    local dist = (part.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                    if dist < minDist then
                        closest, minDist = part, dist
                    end
                end
            end
        end
        if closest then tp(closest.Position) end
    end
end)

tab:Button("Teleport to Nearest Upgrade", function()
    if ws:FindFirstChild("Upgrades") then
        local closest, minDist = nil, math.huge
        for _, v in ipairs(ws.Upgrades:GetChildren()) do
            if v:IsA("Model") then
                local part = findValidPart(v)
                if part then
                    local dist = (part.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                    if dist < minDist then
                        closest, minDist = part, dist
                    end
                end
            end
        end
        if closest then tp(closest.Position) end
    end
end)

tab:Button("Teleport to Nearest Safe Box", function()
    if ws:FindFirstChild("Map") and ws.Map:FindFirstChild("EctModels") then
        local closest, minDist = nil, math.huge
        for _, v in ipairs(ws.Map.EctModels:GetChildren()) do
            if v:IsA("Model") and v.Name == "DepositBox" then
                local part = findValidPart(v)
                if part then
                    local dist = (part.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                    if dist < minDist then
                        closest, minDist = part, dist
                    end
                end
            end
        end
        if closest then tp(closest.Position) end
    end
end)

tab:Button("Teleport to Nearest Car", function()
    if ws:FindFirstChild("Cars") then
        local closest, minDist = nil, math.huge
        for _, v in ipairs(ws.Cars:GetChildren()) do
            if v:IsA("Model") then
                local part = findValidPart(v)
                if part then
                    local dist = (part.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                    if dist < minDist then
                        closest, minDist = part, dist
                    end
                end
            end
        end
        if closest then tp(closest.Position) end
    end
end)
