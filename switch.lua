local Player = game:GetService("Players").LocalPlayer

local GunNames = {
    "AK", "AUGA1", "ARP", "Beretta", "Bullpup", "CZ75", "Deagle", "DoubleBarrel",
    "Draco", "Famas", "Glock18", "M1Grand", "M4A1", "MAC10", "MAG7", "MP5", "MP7",
    "MP9", "Negev", "Nova", "P220", "PPBizon", "Pistol", "RPG", "Revolver", "SA58",
    "SawnOff", "Shotgun", "Uzi"
}

local SwitchValue = true

local function SetSwitch(Gun)
    if not Gun:IsA("Tool") then 
        print("Not a tool:", Gun.Name)
        return
    end

    if not table.find(GunNames, Gun.Name) then
        print("Gun not in list:", Gun.Name)
        return
    end

    local Switch = Gun:FindFirstChild("Switch")
    if Switch then
        Switch.Value = SwitchValue
        print("Switch set to", SwitchValue, "for", Gun.Name)
    else
        print("No Switch found in", Gun.Name)
    end
end

local function OnChildAdded(Child)
    SetSwitch(Child)
end

Player.Backpack.ChildAdded:Connect(OnChildAdded)

for _, Object in ipairs(Player.Backpack:GetChildren()) do
    SetSwitch(Object)
end
