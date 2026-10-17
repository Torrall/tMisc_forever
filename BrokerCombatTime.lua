local _, Common = ...

Common.BrokerCombatTime = {}
local bct = Common.BrokerCombatTime

local combatStartTime = 0
local timeInCombat = 0
local inCombat = false

TEXT_FORMATS = { 
    [true] = "|cffffe608%.02d:%.02d|r", --in combat
    [false] = "|cff7d7000%.02d:%.02d|r", --not in combat
}

-- initialize Broker
bct.BrokerObj = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("tCombatTime", {
        type    = "data source",
        label   = "Combat Time",
        text    = "Combat Time",
        icon    = "Interface\\Timer\\Challenges-Logo.blp",
        OnClick    = function(display, button)
            bct.BrokerObj:Update()
        end,
        OnTooltipShow = function(self)
            self:AddLine("Time In Combat")
        end
})


function bct.BrokerObj:Update()
    local minutes = timeInCombat / 60
    local seconds = timeInCombat % 60
    bct.BrokerObj.text = string.format(TEXT_FORMATS[inCombat],minutes,seconds)
end
bct.BrokerObj:Update()

local throttleCounter = 0
local throttleRollover = 20
function bct.ThrottledUpdate()
    if throttleCounter < throttleRollover then
        throttleCounter = throttleCounter +1
        return
    else
        throttleCounter = 0
    end
    timeInCombat = GetTime()-combatStartTime
    bct.BrokerObj:Update()
end

function bct.CombatStatusChanged(arg1,event)
    if event == "PLAYER_REGEN_ENABLED" then
        bct.eventFrame:SetScript("OnUpdate",nil)
        inCombat = false
        timeInCombat = GetTime()-combatStartTime
        bct.BrokerObj:Update()
    elseif event == "PLAYER_REGEN_DISABLED" then
        inCombat = true
        combatStartTime = GetTime()
        bct.eventFrame:SetScript("OnUpdate",bct.ThrottledUpdate)
    end
end

bct.eventFrame = CreateFrame("Frame")
bct.eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
bct.eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
bct.eventFrame:SetScript("OnEvent",bct.CombatStatusChanged)

