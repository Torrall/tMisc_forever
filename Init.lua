local _, Common = ...
Common.Init = {}

local Init = Common.Init

Init.FunctionToExecute = {}
Init.EventFrame = CreateFrame("Frame")
Init.EventFrame:SetScript("OnEvent",function(handovertable, event,...)
    local arg3 = select(1,...)
	if event == "ADDON_LOADED" and not(arg3 == "tMisc") then
        --do nothing
	else
		for k,v in ipairs(Init.FunctionToExecute[event]) do
			v(...)
		end
	end
end)

function Common:RegisterFunctionForEvent(event,funcHandle)
	if not(Init.FunctionToExecute[event]) then
		Init.FunctionToExecute[event] = {}
		Init.EventFrame:RegisterEvent(event)
	end
	table.insert(Init.FunctionToExecute[event],funcHandle)
end

function Common.Init.InitializeDB()
    print("tMisc.Init InitializeDB")
    if tMiscDB == nil then
        tMiscDB = {}
    end
    Common.db = tMiscDB
end
Common:RegisterFunctionForEvent("ADDON_LOADED",Common.Init.InitializeDB)

