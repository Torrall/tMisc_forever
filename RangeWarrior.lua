local _, class = UnitClass("player")
if class ~= "WARRIOR" then
    return
end

local frame = CreateFrame("Frame", "RangeAlertFrame", UIParent)
frame:SetSize(200, 50)
frame:SetPoint("CENTER", UIParent, "CENTER", 0, 100)
frame:SetFrameStrata("HIGH")

local textYPositions = { 0, -235, -305}
local textFontStrings = {}
for k,v in ipairs(textYPositions) do
    textFontStrings[k] = frame:CreateFontString(nil, "OVERLAY")
    textFontStrings[k]:SetPoint("CENTER", frame, "CENTER", 0, v)
    textFontStrings[k]:SetFont("Fonts\\FRIZQT__.TTF", 24, "THICKOUTLINE")
    textFontStrings[k]:SetText("NO RANGE")
    textFontStrings[k]:SetTextColor(1, 0.2, 0.2, 1)

end

frame:Hide()

local ticker = CreateFrame("Frame")
local SPELL_ID = 6547 --Rend
local CHARGE_ID = 100
local UPDATE_INTERVAL = 0.05
local elapsed = 0

ticker:SetScript("OnUpdate", function(self, delta)
    elapsed = elapsed + delta
    if elapsed < UPDATE_INTERVAL then
        return
    end
    elapsed = 0

    if not UnitExists("target") then
        frame:Hide()
        return
    end

    local inRange = C_Spell.IsSpellInRange(SPELL_ID, "target")
    if inRange == false then
        frame:Show()
    else
        frame:Hide()
        return
    end
    local inRangeCharge = C_Spell.IsSpellInRange(CHARGE_ID, "target")
    if inRangeCharge == true then
        for _,v in pairs(textFontStrings) do
            v:SetTextColor(1, 0.5, 0, 1) -- orange
            v:SetTextColor(1, 0.5, 0, 1) -- orange
        end

    else
        for _,v in pairs(textFontStrings) do
            v:SetTextColor(1, 0.2, 0.2, 1) -- red
        end
    end
end)