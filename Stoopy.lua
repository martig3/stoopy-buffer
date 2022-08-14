print("loading Stoopy Buffer")
local EventFrame = CreateFrame("frame", "EventFrame")
EventFrame:RegisterEvent("UNIT_SPELLCAST_SENT")
local frame = CreateFrame("Frame", nil, UIParent, 'TooltipBackdropTemplate')
frame:SetSize(100, 100)
frame:SetPoint("CENTER", 200, 0)
frame:SetMovable(true)
EventFrame:SetScript("OnEvent", function(self, event, ...)
        if (event == "UNIT_SPELLCAST_SENT") then
                local unit, target, castGUID, spellID = ...
                local name, _, icon = GetSpellInfo(spellID)
                local tex = frame:CreateTexture(nil, "BACKGROUND")
                tex:SetTexture(icon)
                tex:SetAllPoints(frame) --make texture same size as button
        end
end)
