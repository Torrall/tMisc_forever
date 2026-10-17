local LDB = LibStub and LibStub("LibDataBroker-1.1", true)
if not LDB then return end

LDB:NewDataObject("CDM Launcher", {
    type  = "launcher",
    label = "Cooldown Manager",
    icon  = "Interface\\Icons\\Spell_nature_timestop",

    OnClick = function(_, button)
        -- Left-click: open CDM settings
        if button == "LeftButton" then
            local frame = _G["CooldownViewerSettings"]
            if frame:IsShown() then
                frame:Hide()
            else
                frame:Show()
                frame:Raise()
            end
        end
    end,

    OnTooltipShow = function(tt)
        tt:AddLine("Cooldown Manager", 1, 1, 1)
        tt:AddLine("|cffaaaaaaleft-click|r to open settings")
    end,
})