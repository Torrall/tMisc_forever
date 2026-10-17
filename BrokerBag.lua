local _, Common = ...

Common.BrokerBag = {}
local bb = Common.BrokerBag

-- initialize Broker
bb.BrokerObj = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("tBagOpener", {
        type    = "data source",
        label   = "Bag Opener",
        text    = "Bag Opener",
        icon    = "Interface\\ICONS\\INV_Misc_Bag_08",
        OnClick    = function(display, button)
            if IsShiftKeyDown() then
                BaudBagToggleBank()
            elseif (button == "LeftButton") then
                ToggleBag(0)
                bb.BrokerObj.Update()
            end
        end,
        OnTooltipShow = function(self)
            self:AddLine("Bags")
            self:AddLine("Left-Click: Toggle Bags")
            self:AddLine("Shift-Click: Toggle Bank")
        end
})

function bb.BrokerObj.Update()
    local allSlots = 0
    local emptyslots = 0
    for i= 0,NUM_BAG_SLOTS do
        emptyslots = emptyslots +  C_Container.GetContainerNumFreeSlots(i)
        allSlots = allSlots + C_Container.GetContainerNumSlots(i)
    end
    bb.BrokerObj.text = emptyslots.."/"..allSlots
end

bb.BrokerObj.Update()

--local updateFrame = CreateFrame("Frame")
--updateFrame:RegisterEvent("BAG_UPDATE")
--updateFrame:SetScript("OnEvent",bbb.BrokerObj.Update)

Common:RegisterFunctionForEvent("BAG_UPDATE", bb.BrokerObj.Update)