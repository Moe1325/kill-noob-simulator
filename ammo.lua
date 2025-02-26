local Player = game:GetService("Players").LocalPlayer

local GunNames = {
    "AK", "AUGA1", "ARP", "Beretta", "Bullpup", "CZ75", "Deagle", "DoubleBarrel",
    "Draco", "Famas", "Glock18", "M1Grand", "M4A1", "MAC10", "MAG7", "MP5", "MP7",
    "MP9", "Negev", "Nova", "P220", "PPBizon", "Pistol", "RPG", "Revolver", "SA58",
    "SawnOff", "Shotgun", "Uzi"
}

local AmmoValue = 1999999 -- change the number to the ammo count that you wish ;)

local SetAmmo = function(Gun)
    if not Gun:IsA("Tool") or not table.find(GunNames, Gun.Name) then return end

    local Stats = Gun:FindFirstChild("Stats")
  
    if not Stats then return end    

    local Ammo = Stats.Ammo

    if not Ammo then return end

    Ammo.Value = AmmoValue
end

local OnChildAdded = function(Child)
    SetAmmo(Child)
end

Player.Backpack.ChildAdded:Connect(OnChildAdded)

for _, Object in ipairs(Player.Backpack:GetChildren()) do
    SetAmmo(Object)
end
