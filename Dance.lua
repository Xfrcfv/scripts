local Dance = {}

Dance.OptionEnabled = Menu.AddOptionBool({ "Utility", "Dance"}, "Enabled", false)
Dance.optionKey = Menu.AddKeyOption({ "Utility", "Dance"},"Dance Key",Enum.ButtonCode.KEY_G)

 
local tick = 0

function Dance.OnGameStart()
  local tick = 0
end

function Dance.OnUpdate()
  if not Menu.IsEnabled(Dance.OptionEnabled) then return end
  local myHero = Heroes.GetLocal()
  if not myHero then return end 
  local degree = 160  -- угол поворота персонажа       можно менять   
  local timign = 0.15 -- повторно задать угол поворота можно менять   
  if Menu.IsKeyDown(Dance.optionKey) then
    if tick <= GameRules.GetGameTime() then
      local angle = Entity.GetRotation(myHero)
      local angleOffset = Angle(0, 45+degree, 0)
      angle:SetYaw(angle:GetYaw() + angleOffset:GetYaw())
      local x,y,z = angle:GetVectors()
      local direction = x + y + z
      direction:SetZ(0)
      direction:Normalize()
      direction:Scale(1)
      local origin = NPC.GetAbsOrigin(myHero)
      tohere = origin + direction
      Dance.NeedMove(myHero , tohere)
      tick = GameRules.GetGameTime() + timign
    end
  end
end

function Dance.NeedMove(npc , vectore)
  Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, npc, vectore, nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY)
end

return Dance
