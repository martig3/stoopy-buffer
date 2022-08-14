local EventFrame = CreateFrame("frame", "EventFrame")
EventFrame:RegisterEvent("UNIT_SPELLCAST_SENT")
EventFrame:RegisterEvent("UNIT_SPELLCAST_FAILED")

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

local bgs = {}
local icons = {}
local frames = {}
local timings = {}
local spamCount = 0
for i = 1, 3, 1 do
  local frame = CreateFrame("Frame", nil, container, nil)
  frame:Show()
  frame:SetPoint("CENTER", (85 * i) - 170, 0)
  frame:SetSize(80, 80)
  local bg = frame:CreateTexture('bg', 'ARTWORK', nil, -6)
  bg:SetAllPoints(frame)
  bgs[i] = bg
  frames[i] = frame
end

local function pushIcon(icon, i)
  local bg = bgs[i]
  if bg == nil then return end
  local currentTexture = bg:GetTexture()
  bg:SetTexture(icon)
  if currentTexture == nil then return end
  pushIcon(currentTexture, i + 1)
end

local function handleSpamming()
  spamCount = spamCount + 1
 -- TODO: add logic to incidicate visually that the spell is being spammed
end

EventFrame:SetScript("OnEvent", function(self, event, ...)
  if event == "UNIT_SPELLCAST_SENT" then
    local unit, target, castGUID, spellID = ...
    local name, _, icon = GetSpellInfo(spellID)
    if icons[1] == icon then handleSpamming() return end
    icons[1] = icon
    pushIcon(icon, 1)
    spamCount = 0
    print(icon)
  end
  if event == "UNIT_SPELLCAST_FAILED" then
    local _, _, spellID = ...
    local name, _, icon = GetSpellInfo(spellID)
    if icons[1] == icon then handleSpamming() return end
  end
end)

print("Loaded Stoopy Buffer")