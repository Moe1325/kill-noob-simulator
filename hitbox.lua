-- Modded by 0wei
_G.Size = 15
_G.Disabled = true

game:GetService('RunService').RenderStepped:connect(function()
  if _G.Disabled then
    for i,v in next, game:GetService('Players'):GetPlayers() do
      if v.Name ~= game:GetService('Players').LocalPlayer.Name then
        pcall(function()
          v.Character.HumanoidRootPart.Size = Vector3.new(_G.Size,_G.Size,_G.Size)
          v.Character.HumanoidRootPart.Transparency = 0.9
          v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really red")
          v.Character.HumanoidRootPart.Material = "Neon"
          v.Character.HumanoidRootPart.CanCollide = false
        end)
      end
    end
  end
end)
