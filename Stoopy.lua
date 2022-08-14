print("loading Stoopy Buffer")
local EventFrame = CreateFrame("frame", "EventFrame")
EventFrame:RegisterEvent("UNIT_SPELLCAST_SENT")

local container = CreateFrame("Frame", nil, UIParent, 'TooltipBackDropTemplate')
container:SetSize(300, 100)
container:SetPoint("CENTER", 400, 0)
container:SetMovable(true)
container:EnableMouse(true)
container:RegisterForDrag("LeftButton")
container:SetScript("OnDragStart", function(self)
  self:StartMoving()
end)
container:SetScript("OnDragStop", function(self)
  self:StopMovingOrSizing()
end)

local buffer = {}
for i = 1, 3, 1 do
  local frame = CreateFrame("Frame", nil, container, nil)
  frame:Show()
  frame:SetPoint("CENTER", (85 * i) - 170, 0)
  frame:SetSize(80, 80)
  local bg = frame:CreateTexture('bg', 'ARTWORK', nil, -6)
  bg:SetAllPoints(frame)
  buffer[i] = bg
end

local function pushIcon(icon, i)
  local bg = buffer[i]
  local currentTexture = bg:GetTexture()
  bg:SetTexture(icon)
  if buffer[i + 1] == nil or currentTexture == nil then return end
  pushIcon(currentTexture, i + 1)
end

EventFrame:SetScript("OnEvent", function(self, event, ...)
  if (event == "UNIT_SPELLCAST_SENT") then
    local unit, target, castGUID, spellID = ...
    local name, _, icon = GetSpellInfo(spellID)
    pushIcon(icon, 1)
    print(icon)
  end
end)
