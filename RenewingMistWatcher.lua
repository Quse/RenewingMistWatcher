

local RMW_antibug = 0
local RMW_TimeSinceLastUpdate = 0
local RMW_UpdateInterval = 0.1

local font = "Interface\\Addons\\sharedmedia\\fonts\\font.ttf"
local fontsize = 8
local fontflag = "OUTLINEMONOCHROME"

-- local RMW_Backdrop = RMW_Backdrop
-- local RMW_BackdropBorder = RMW_BackdropBorder
-- local RMW_LockState = RMW_LockState
-- local RMW_AutohideState = RMW_AutohideState
-- local RMW_Scale = RMW_Scale
-- local RMW_Position = RMW_Position
-- local RMW_IconsState = RMW_IconsState
-- local RMW_BarShowed = RMW_BarShowed
-- local RMW_BackdropBarBG = RMW_BackdropBarBG
-- local RMW_BackdropBarFG = RMW_BackdropBarFG


if GetLocale() == "koKR" then
	RMW_RMlocale = "Renewing Mist"
elseif GetLocale() == "deDE" then
	RMW_RMlocale = "Renewing Mist"
elseif GetLocale() == "zhCN" then
	RMW_RMlocale = "Renewing Mist"
elseif GetLocale() == "zhTW" then
	RMW_RMlocale = "Renewing Mist"
elseif GetLocale() == "esES" then
	RMW_RMlocale = "Renewing Mist"
elseif GetLocale() == "esMX" then
	RMW_RMlocale = "Renewing Mist"
elseif GetLocale() == "ruRU" then
	RMW_RMlocale = "Renewing Mist"
elseif GetLocale() == "ptBR" then
	RMW_RMlocale = "Renewing Mist"
elseif GetLocale() == "frFR" then
	RMW_RMlocale = "Renewing Mist"
elseif GetLocale() == "" then
	RMW_RMlocale = "Renewing Mist"
else
	RMW_RMlocale = "Renewing Mist"
end

local adtrz_classtable = {
	["HUNTER"] = {.09,1,.54, "8aff18"}, 
	["WARLOCK"] = {1,.14,.45, "7426ff"}, 
	["PRIEST"] = {1.0, 1.0, 1.0, "FFFFFF"}, 
	["PALADIN"] = {.85,0,1, "ff00da"}, 
	["MAGE"] = {1,.81,0, "00d0ff"}, 
	["ROGUE"] = {0,.94,1, "fff100"}, 
	["DRUID"] = {.05,.36,1, "ff5d0f"}, 
	["SHAMAN"] = {1,.41,0, "0069ff"}, 
	["WARRIOR"] = {.32,.60,.85, "da9b54"}, 
	["DEATHKNIGHT"] = {0.30, 0.15, 1, "ff284d"}, 
	["MONK"] = {.58,1,0, "00ff96"}
}

function RMW_SlashTest()
	local name = UnitName("player")
	MyFrameRMW:Show()
	local testtable={random(5, 195), random(0, 3), random(1, 3), random(8, 10)}
	MyFrameRMWMIDDLEText:SetText((testtable[1]/10).."\n|cff008467"..name.."|r")
	
	if RMW_IgnorePets == 1 then
		MyFrameRMWTOPRIGHTText:SetText(testtable[4])
		MyFrameRMWTOPRIGHTText:SetFont(font, fontsize, fontflag)
		MyFrameRMWTOPRIGHTText:SetShadowOffset(0,0)
	else
		MyFrameRMWTOPRIGHTText:SetText(testtable[4].."+"..testtable[3].."p")
		MyFrameRMWTOPRIGHTText:SetFont(font, fontsize, fontflag)
		MyFrameRMWTOPRIGHTText:SetShadowOffset(0,0)
	end
	
	MyFrameRMWTOPLEFTText:SetText(testtable[2])
	RMW_castbar:SetValue(testtable[1]/200)
	print(string.format("|TInterface\\Icons\\ability_monk_renewingmists:15:15|t".."|cff008467 Renewing Mist Watcher : |r|cFFC1EFA8Test.|r"))
	wipe(testtable)
end


function RMW_UpdateState()
	MyFrameRMW:SetBackdropColor(0, 0, 0, 0)	
	MyFrameRMW:SetBackdropBorderColor(0, 0, 0, 0)
	MyFrameRMW:SetScale(RMW_Scale)
	MyFrameRMWChild1:SetBackdropColor(1,1,1,RMW_IconsState)	
	MyFrameRMWChild2:SetBackdropColor(1,1,1,RMW_IconsState)	
	
	if RMW_LockState == 0 then
		MyFrameRMW:SetMovable(true)
		MyFrameRMW:EnableMouse(true)
		MyFrameRMW:RegisterForDrag("LeftButton")
	else
		MyFrameRMW:SetMovable(false)
		MyFrameRMW:EnableMouse(false)
		MyFrameRMW:RegisterForDrag(nil)
	end
	
	if RMW_BarShowed == 0 then
		MyFrameRMW:SetHeight(75) 
		MyFrameRMWChild3:Hide()
	else
		MyFrameRMW:SetHeight(88) 
		MyFrameRMWChild3:Hide()
	end
	
	MyFrameRMWChild3:SetBackdropColor(RMW_BackdropBarBG[1], RMW_BackdropBarBG[2], RMW_BackdropBarBG[3], RMW_BackdropBarBG[4])	
	RMW_castbar:SetBackdropColor(RMW_BackdropBarFG[1], RMW_BackdropBarFG[2], RMW_BackdropBarFG[3], RMW_BackdropBarFG[4])
end

function RMW_UpdateMenuTexts()
	
	RMW_MenuTexts = {}
	if RMW_LockState == 0 then  -- RMW_MenuTexts[1]
		tinsert(RMW_MenuTexts, "UNLOCKED")
	else
		tinsert(RMW_MenuTexts, "LOCKED")
	end
	if RMW_BackdropBorder[1] == 0 then  -- RMW_MenuTexts[2]
		tinsert(RMW_MenuTexts, "GREEN")
	else
		tinsert(RMW_MenuTexts, "CLASSIC")
	end
	if RMW_AutohideState == 0 then  -- RMW_MenuTexts[3]
		tinsert(RMW_MenuTexts, "DISABLED")
	else
		tinsert(RMW_MenuTexts, "ENABLED")
	end
	if RMW_IconsState == 0 then -- RMW_MenuTexts[4]
		tinsert(RMW_MenuTexts, "HIDED")
	else
		tinsert(RMW_MenuTexts, "SHOWED")
	end
	if RMW_BarShowed == 0 then -- RMW_MenuTexts[5]
		tinsert(RMW_MenuTexts, "HIDED")
	else
		tinsert(RMW_MenuTexts, "SHOWED")
	end
	if RMW_IgnorePets == 0 then -- RMW_MenuTexts[6]
		tinsert(RMW_MenuTexts, "NOT IGNORED")
	else
		tinsert(RMW_MenuTexts, "IGNORED")
	end
	
end




SLASH_RenewingMistWatcher_CMD1_1 = "/rmw"
SLASH_RenewingMistWatcher_CMD1_2 = "/renewingmistwatcher"
function SlashCmdList.RenewingMistWatcher_CMD1_(RenewingMistWatcher_msg, editbox)
	local SCMD, SARG1, SARG2, SARG3, SARG4 = RenewingMistWatcher_msg:match("^(%S*)%s*(%S*)%s*(%S*)%s*(%S*)%s*(.-)$")
	
	RMW_UpdateMenuTexts()
	
	------------------------------------------------
	------------		TEST			------------
	------------------------------------------------
	if (SCMD == "test" or SCMD == "TEST") then
		RMW_SlashTest()
	--
	--
	--
	------------------------------------------------
	------------		HIDE			------------
	------------------------------------------------
	elseif (SCMD == "hide" or SCMD == "HIDE") then
		MyFrameRMW:Hide()
		print(string.format("|TInterface\\Icons\\ability_monk_renewingmists:15:15|t".."|cff008467 Renewing Mist Watcher : |r|cFFC1EFA8Hide.|r"))
	--
	--
	--
	------------------------------------------------
	------------		SCALE			------------
	------------------------------------------------
	elseif (SCMD == "scale" or SCMD == "SCALE") then	
		if SARG1 and type(tonumber(SARG1)) == "number" and tonumber(SARG1) >= 0.2 and tonumber(SARG1) <= 2 then
		 	if not MyFrameRMW:IsShown() then RMW_SlashTest() end -- show test if notShown
			RMW_Scale = tonumber(SARG1)
			RMW_UpdateState()
			MyFrameRMW:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
			print(string.format("|TInterface\\Icons\\ability_monk_renewingmists:15:15|t".."|cff008467 Renewing Mist Watcher : |r|cFFC1EFA8Scale.|r|cFFff5050 "..SARG1.."|r"))
		else
			print(string.format("|TInterface\\Icons\\ability_monk_renewingmists:15:15|t".."|cff008467 RMW : |r|cFFC1EFA8Scale.|r|cFFff5050 Incorrect syntax|r"))
			print(string.format("|cFFC1EFA8Proper use: |r|cff008467''/rmw scale X''. With X contained between 0.2 and 2.|r"))
		end	
	--
	--
	--
	------------------------------------------------
	------------		COLOR			------------
	------------------------------------------------
	elseif (SCMD == "color" or SCMD == "COLOR" or 
			SCMD == "green" or SCMD == "Green" or SCMD == "GREEN" or 
			SCMD == "classic" or SCMD == "Classic" or SCMD == "CLASSIC"
			) then
			
		if (SARG1 and 
		   (SARG1 == "green" or SARG1 == "Green" or SARG1 == "GREEN" or 
			SARG1 == "classic" or SARG1 == "Classic" or SARG1 == "CLASSIC")) or
			(SCMD == "green" or SCMD == "Green" or SCMD == "GREEN" or 
			SCMD == "classic" or SCMD == "Classic" or SCMD == "CLASSIC"
			) then
			
		 	if not MyFrameRMW:IsShown() then RMW_SlashTest() end -- show test if notShown
			if SARG1 == "green" or SARG1 == "Green" or SARG1 == "GREEN" or SCMD == "green" or SCMD == "Green" or SCMD == "GREEN" then
				RMW_Backdrop = {0,0, 0, RMW_Backdrop[4]}
				RMW_BackdropBorder = {0, 0, 0, RMW_BackdropBorder[4]}
				RMW_BackdropBarBG = {0, 0, 0, RMW_BackdropBarBG[4]}
				RMW_BackdropBarFG = {0, 0, 0, RMW_BackdropBarFG[4]}
				-- MyFrameRMW:SetBackdropColor(0.00, 0.22, 0.2, 0.35)	
				-- MyFrameRMW:SetBackdropBorderColor(0.00, 0.52, 0.4, 0.7)	
				-- MyFrameRMWChild3:SetBackdropColor(0.00, 0.16, 0.14, 0.7)
				-- RMW_castbar:SetBackdropColor(0.224, 0.812, 0.549, 0.5)
			else
				RMW_Backdrop = {0, 0, 0, RMW_Backdrop[4]}
				RMW_BackdropBorder = {0, 0, 0, RMW_BackdropBorder[4]}
				RMW_BackdropBarBG = {0, 0, 0, RMW_BackdropBarBG[4]}
				RMW_BackdropBarFG = {0, 0, 0, RMW_BackdropBarFG[4]}
				-- MyFrameRMW:SetBackdropColor(0, 0, 0, 0.35)	
				-- MyFrameRMW:SetBackdropBorderColor(1, 1, 1, 0.7)
				-- MyFrameRMWChild3:SetBackdropColor(0, 0, 0, 0.7) 
				-- RMW_castbar:SetBackdropColor(0.5, 0.5, 0.5, 0.5)
			end
			RMW_UpdateState()
			
			RMW_UpdateMenuTexts()
			print(string.format("|TInterface\\Icons\\ability_monk_renewingmists:15:15|t".."|cff008467 Renewing Mist Watcher : |r|cFFC1EFA8Color.|r|cFFff5050 "..RMW_MenuTexts[2].."|r"))
		else
			print(string.format("|TInterface\\Icons\\ability_monk_renewingmists:15:15|t".."|cff008467 RMW : |r|cFFC1EFA8Color.|r|cFFff5050 Incorrect syntax|r"))
			print(string.format("|cFFC1EFA8Proper use: |r|cff008467''/rmw color green'' or ''/rmw color classic'' (only two colors available for now).|r"))
		end	
	--
	--
	--
	------------------------------------------------
	------------		ALPHA			------------
	------------------------------------------------
	elseif (SCMD == "alpha" or SCMD == "ALPHA") then
		if SARG1 and type(tonumber(SARG1)) == "number" and tonumber(SARG1) >= 0 and tonumber(SARG1) <= 1 then
			if not MyFrameRMW:IsShown() then RMW_SlashTest() end -- show test if notShown
			
			RMW_Backdrop = {RMW_Backdrop[1], RMW_Backdrop[2], RMW_Backdrop[3], tonumber(SARG1)/2}
			RMW_BackdropBorder = {RMW_BackdropBorder[1], RMW_BackdropBorder[2], RMW_BackdropBorder[3], tonumber(SARG1)}
			RMW_BackdropBarBG = {RMW_BackdropBarBG[1], RMW_BackdropBarBG[2], RMW_BackdropBarBG[3], 0.5 + tonumber(SARG1)/2}
			RMW_BackdropBarFG = {RMW_BackdropBarFG[1], RMW_BackdropBarFG[2], RMW_BackdropBarFG[3], 0.5 + tonumber(SARG1)/7*5/2}
			
			
			RMW_UpdateState()
			print(string.format("|TInterface\\Icons\\ability_monk_renewingmists:15:15|t".."|cff008467 Renewing Mist Watcher : |r|cFFC1EFA8Alpha.|r|cFFff5050 "..SARG1.."|r"))
		else
			print(string.format("|TInterface\\Icons\\ability_monk_renewingmists:15:15|t".."|cff008467 RMW : |r|cFFC1EFA8Alpha.|r|cFFff5050 Incorrect syntax|r"))
			print(string.format("|cFFC1EFA8Proper use: |r|cff008467''/rmw alpha X''. With X contained between 0 and 1.|r"))
		end		
	--
	--
	--
	------------------------------------------------
	------------	TOGGLE	AUTOHIDE	------------
	------------------------------------------------
	elseif (SCMD == "autohide" or SCMD == "AUTOHIDE") then
		if not MyFrameRMW:IsShown() then RMW_SlashTest() end -- show test if notShown
		RMW_AutohideState = ((RMW_AutohideState - 1) * (RMW_AutohideState - 1)) ^ 0.5
		if RMW_AutohideState == 1 then MyFrameRMW:Hide() end
		RMW_UpdateMenuTexts()
		print(string.format("|TInterface\\Icons\\ability_monk_renewingmists:15:15|t".."|cff008467 Renewing Mist Watcher : |r|cFFC1EFA8Autohide.|r|cFFff5050 "..RMW_MenuTexts[3].."|r"))
	--
	--
	--
	------------------------------------------------
	------------	TOGGLE	LOCK		------------
	------------------------------------------------
	elseif (SCMD == "lock" or SCMD == "LOCK") then
		if not MyFrameRMW:IsShown() then RMW_SlashTest() end -- show test if notShown
		RMW_LockState = ((RMW_LockState - 1) * (RMW_LockState - 1)) ^ 0.5
		RMW_UpdateState()
		RMW_UpdateMenuTexts()
		print(string.format("|TInterface\\Icons\\ability_monk_renewingmists:15:15|t".."|cff008467 Renewing Mist Watcher : |r|cFFC1EFA8Lock.|r|cFFff5050 "..RMW_MenuTexts[1].."|r"))
	--
	--
	--
	------------------------------------------------
	------------	DEFAULT SETTINGS	------------
	------------------------------------------------
	elseif (SCMD == "default" or SCMD == "DEFAULT") then
		if SARG1 == "confirm" then
			RMW_Backdrop = {0, 0.22, 0.2, 0.35}
			RMW_BackdropBorder = {0, 0, 0, 1}
			RMW_BackdropBarBG = {0, 0, 0, .5}
			RMW_BackdropBarFG = {0, 0, 0, .5}
			RMW_LockState = 0
			RMW_AutohideState = 1
			RMW_Scale = 1
			RMW_IconsState = 1
			RMW_BarShowed = 0
			
			RMW_UpdateState()
			MyFrameRMW:SetPoint("CENTER", UIParent, "CENTER", 0, -185) 
			
			print(string.format("|TInterface\\Icons\\ability_monk_renewingmists:15:15|t".."|cff008467 Renewing Mist Watcher : |r|cFFC1EFA8Reset.|r"))
			RMW_SlashTest()
			
		else
			print(string.format("|TInterface\\Icons\\ability_monk_renewingmists:15:15|t".."|cff008467 RMW : |r|cFFC1EFA8Reset.|r|cFFff5050 Type ''/rmw default confirm'' to reset settings.|r"))
		end
	--
	--
	--
	------------------------------------------------
	------------	TOGGLE ICONS	----------------
	------------------------------------------------
	elseif (SCMD == "icons" or SCMD == "ICONS" or SCMD == "icon" or SCMD == "ICON") then
		if not MyFrameRMW:IsShown() then RMW_SlashTest() end -- show test if notShown
		RMW_IconsState = ((RMW_IconsState - 1) * (RMW_IconsState - 1)) ^ 0.5
		RMW_UpdateState()
		
		RMW_UpdateMenuTexts()
		print(string.format("|TInterface\\Icons\\ability_monk_renewingmists:15:15|t".."|cff008467 Renewing Mist Watcher : |r|cFFC1EFA8Icons.|r|cFFff5050 "..RMW_MenuTexts[4].."|r"))
	--
	--
	--
	------------------------------------------------
	-----------------	TOGGLE BAR	----------------
	------------------------------------------------
	elseif (SCMD == "bar" or SCMD == "BAR") then
		if not MyFrameRMW:IsShown() then RMW_SlashTest() end -- show test if notShown
		RMW_BarShowed = ((RMW_BarShowed - 1) * (RMW_BarShowed - 1)) ^ 0.5
		RMW_UpdateState()
	
		RMW_UpdateMenuTexts()
		print(string.format("|TInterface\\Icons\\ability_monk_renewingmists:15:15|t".."|cff008467 Renewing Mist Watcher : |r|cFFC1EFA8Bar.|r|cFFff5050 "..RMW_MenuTexts[5].."|r"))
	--
	--
	--
	------------------------------------------------
	-----------------	IGNORE PETS	----------------
	------------------------------------------------
	elseif (SCMD == "pets" or SCMD == "PETS" or SCMD == "pet" or SCMD == "PET") then
		RMW_IgnorePets = ((RMW_IgnorePets - 1) * (RMW_IgnorePets - 1)) ^ 0.5	
		
		RMW_UpdateMenuTexts()
		print(string.format("|TInterface\\Icons\\ability_monk_renewingmists:15:15|t".."|cff008467 Renewing Mist Watcher : |r|cFFC1EFA8Pets.|r|cFFff5050 "..RMW_MenuTexts[6].."|r"))
	
	
	
	else
		print(string.format("|TInterface\\Icons\\ability_monk_renewingmists:20:20|t".."|cff008467 RenewingMistWatcher v"..GetAddOnMetadata("RenewingMistWatcher", "Version")..": |r|cFFC1EFA8Commands.|r"))
		print(string.format("|cFFC1EFA8/rmw test|r        |cff008467-- Show a test frame.|r"))
		print(string.format("|cFFC1EFA8/rmw hide|r       |cff008467-- Hide the RMW frame.|r"))
		print(string.format("|cFFC1EFA8/rmw pets|r       |cff008467-- Ignore all pets.|r|cFFff5050 "..RMW_MenuTexts[6].."|r"))
		print(string.format("|cFFC1EFA8/rmw lock|r        |cff008467-- Toggle Lock.|r|cFFff5050 "..RMW_MenuTexts[1].."|r"))
		print(string.format("|cFFC1EFA8/rmw color|r       |cff008467-- Select between ''classic'' and ''green''.|r|cFFff5050 "..RMW_MenuTexts[2].."|r"))
		print(string.format("|cFFC1EFA8/rmw alpha|r      |cff008467-- Set (background & border) alpha (0-1).|r|cFFff5050 "..RMW_BackdropBorder[4].."|r"))
		print(string.format("|cFFC1EFA8/rmw scale|r       |cff008467-- Set scale (0.2-2).|r|cFFff5050 "..RMW_Scale.."|r"))
		print(string.format("|cFFC1EFA8/rmw icons|r       |cff008467-- Toggle show/hide on both icons.|r|cFFff5050 "..RMW_MenuTexts[4].."|r"))
		print(string.format("|cFFC1EFA8/rmw bar|r          |cff008467-- Toggle show/hide on the bar.|r|cFFff5050 "..RMW_MenuTexts[5].."|r"))
		print(string.format("|cFFC1EFA8/rmw autohide|r  |cff008467-- When enabled, the frame is automatically hided when no RM is active.|r|cFFff5050 "..RMW_MenuTexts[3].."|r"))
		print(string.format("|cFFC1EFA8/rmw default|r    |cff008467-- Set default options.|r"))
	
	end
	
end


function RMW_UpdateCastBar(a, b)
	local c = tonumber(string.format("%.0f", tostring(142*b)))
	RMW_castbar:SetWidth(c)
end


-- OnLoad
function RMW_OnLoad()
  
	-- MyFrameRMW:SetScript("OnUpdate", RenewingMistWatcher_OnUpdate)
	MyFrameRMW:RegisterEvent("UNIT_SPELLCAST_SENT", "player")
	MyFrameRMW:RegisterEvent("PLAYER_ENTERING_WORLD")
	MyFrameRMW:RegisterEvent("PLAYER_LOGOUT")
	MyFrameRMW:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
	
	
	MyFrameRMWMIDDLEText:SetTextColor(1,1,1,1)	
	MyFrameRMWMIDDLEText:SetFont(font, fontsize, fontflag)	
	MyFrameRMWMIDDLEText:SetJustifyH("CENTER")
	MyFrameRMWMIDDLEText:SetJustifyV("MIDDLE")
	MyFrameRMWMIDDLEText:SetText("")
	MyFrameRMWMIDDLEText:SetShadowOffset(0,0)
	
	MyFrameRMWTOPRIGHTText:SetTextColor(1,1,1,1)	
	MyFrameRMWTOPRIGHTText:SetFont(font, fontsize, fontflag)	
	MyFrameRMWTOPRIGHTText:SetJustifyV("TOP")
	MyFrameRMWTOPRIGHTText:SetText("")
	MyFrameRMWTOPRIGHTText:SetShadowOffset(0,0)
	
	MyFrameRMWTOPLEFTText:SetTextColor(1,1,1,1)	
	MyFrameRMWTOPLEFTText:SetFont(font, fontsize, fontflag)
	MyFrameRMWTOPLEFTText:SetJustifyV("TOP")
	MyFrameRMWTOPLEFTText:SetText("")
	MyFrameRMWTOPLEFTText:SetShadowOffset(0,0)
	
	RMW_castbar:SetValue(0.1/20)

end

	------------------------------------------------
	----------------	OnEvent		----------------
	------------------------------------------------
function RMW_OnEvent(self, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, ...)
	-- print(event, arg1, arg2, arg3)
	if event == "UNIT_SPELLCAST_SENT" and arg2 == RMW_RMlocale then
		RMW_UnpauseAddon()
	
	elseif event == "PLAYER_ENTERING_WORLD" then
		local checkClass = select(2, UnitClass("player"))
		MyFrameRMW:UnregisterEvent("PLAYER_ENTERING_WORLD")
		if checkClass == "MONK" then 
		
			local loginText = {}
			if not RMW_Backdrop then tinsert(loginText, "Backdrop") RMW_Backdrop = {0, 0.22, 0.2, 0.35} end
			if not RMW_BackdropBorder then tinsert(loginText, "BackdropBorder") RMW_BackdropBorder = {0.00, 0.52, 0.4, 0.70} end
			if not RMW_LockState then tinsert(loginText, "LockState") RMW_LockState = 0 end
			if not RMW_AutohideState then tinsert(loginText, "AutohideState") RMW_AutohideState = 1 end
			if not RMW_Scale then tinsert(loginText, "Scale") RMW_Scale = 1 end 
			if not RMW_Position then tinsert(loginText, "Position") RMW_Position = {"CENTER", "CENTER", 0, 0} end
			if not RMW_IconsState then tinsert(loginText, "IconsState") RMW_IconsState = 1 end
			if not RMW_BarShowed then tinsert(loginText, "BarState") RMW_BarShowed = 1 end
			if not RMW_BackdropBarBG then tinsert(loginText, "BackdropBarBG") RMW_BackdropBarBG = {0.00, 0.16, 0.14, 0.7} end
			if not RMW_BackdropBarFG then tinsert(loginText, "BackdropBarFG") RMW_BackdropBarFG = {0.224, 0.812, 0.549, 0.5} end
			if not RMW_IgnorePets then tinsert(loginText, "IgnorePets") RMW_IgnorePets = 0 end 
			
			
			if loginText[1] then
				print("|TInterface\\Icons\\ability_monk_renewingmists:15:15|tcreate variables:", loginText[1], loginText[2], loginText[3], loginText[4], loginText[5], loginText[6], loginText[7], loginText[8], loginText[9], loginText[10], loginText[11])
				wipe(loginText)
			end
			
			MyFrameRMW:SetPoint(RMW_Position[1], nil, RMW_Position[2], RMW_Position[3], RMW_Position[4])
			RMW_UpdateState()
			

			RMW_TimeSinceLastUpdate = 0
			if GetSpecialization() == 2 then
				RMW_UnpauseAddon()
				--print(string.format("|TInterface\\Icons\\ability_monk_renewingmists:15:15|t".."|cff008467 Renewing Mist Watcher : |r|cFFC1EFA8Loaded.|r"))
			else
				RMW_DisableBecauseOfWrongSpec()
			end
			
		else
			MyFrameRMW:SetScript("OnUpdate", nil)
			MyFrameRMW:UnregisterEvent("UNIT_SPELLCAST_SENT")
			MyFrameRMW:UnregisterEvent("PLAYER_LOGOUT")
			MyFrameRMW:UnregisterEvent("PLAYER_SPECIALIZATION_CHANGED")
			MyFrameRMW:Hide()
			SLASH_RenewingMistWatcher_CMD1_1 = nil
			SLASH_RenewingMistWatcher_CMD1_2 = nil
			--print(string.format("|TInterface\\Icons\\ability_monk_renewingmists:15:15|t".."|cff008467 Renewing Mist Watcher : |r|cFFC1EFA8Disabled. (play a monk dude!)|r"))
		end
		
	elseif event == "PLAYER_LOGOUT" then
	
		local point, _, relativeTo, xOfs, yOfs = MyFrameRMW:GetPoint()
		RMW_Position = {point, relativeTo, xOfs, yOfs}
		
		
		
	elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
		if GetSpecialization() == 2 then
			RMW_EnableBecauseBackOnRightSpec()
		else
			RMW_DisableBecauseOfWrongSpec()
		end
	end
	
	
end

	------------------------------------------------
	----------------	OnUpdate		------------
	------------------------------------------------
function RenewingMistWatcher_OnUpdate(_, RMW_elapsed)
	RMW_TimeSinceLastUpdate = RMW_TimeSinceLastUpdate + RMW_elapsed
		if (RMW_TimeSinceLastUpdate > RMW_UpdateInterval) then
			RMW_UpdateText()
			RMW_TimeSinceLastUpdate = 0
		end
end

	------------------------------------------------
	----------------	Update Text		------------
	------------------------------------------------
function RMW_UpdateText()
	local middletext, toprighttext, toplefttext = RMW_FormatText()
	MyFrameRMWMIDDLEText:SetText(middletext)
	MyFrameRMWTOPRIGHTText:SetText(toprighttext)
	MyFrameRMWTOPLEFTText:SetText(toplefttext)
end

	------------------------------------------------
	----------------	Format Text		------------
	------------------------------------------------
function RMW_FormatText()
	local timeleft, name, class, hotcountplayers, hotcountpets = RMW_ScanRaidFor611()
	local stacks = RMW_ScanRaidFor607()
	local tablecolor = adtrz_classtable[class]
	local hdcolor = tablecolor[4]
	local middletext, toprighttext, toplefttext
	
	
-- pause de l'addon --
	if timeleft == 25 then 
		RMW_antibug = RMW_antibug + 1-- anti bug
		if RMW_antibug >= 10 then -- anti bug
			RMW_PauseAddon()
		end-- anti bug
		return _, _, _
	end
	RMW_antibug = 0 -- reset de l'anti-bug
	
-- format MIDDLE --
	middletext = "|cff"..hdcolor..name.."|r".." - "..string.format("%.1f", timeleft)

-- format LEFT --
	if stacks then
		if stacks == 0 or stacks == 1 then
			toplefttext = 1
		else
			toplefttext = stacks
		end
	else
		toplefttext = 0
	end
	
-- format RIGHT --	
	if hotcountpets == 0 then
		toprighttext = hotcountplayers
		MyFrameRMWTOPRIGHTText:SetFont(font, fontsize, fontflag)
		MyFrameRMWTOPRIGHTText:SetShadowOffset(0,0)
		--MyFrameRMWTOPRIGHTText:SetPoint("TOPRIGHT", MyFrameRMW, "TOPRIGHT", -24, -16)
	elseif hotcountpets > 0 then
		toprighttext = hotcountplayers.."+"..hotcountpets.."p"
		MyFrameRMWTOPRIGHTText:SetFont(font, fontsize, fontflag)
		MyFrameRMWTOPRIGHTText:SetShadowOffset(0,0)
		--MyFrameRMWTOPRIGHTText:SetPoint("TOPRIGHT", MyFrameRMW, "TOPRIGHT", -16, -16)
	end
	
-- send --
	return middletext, toprighttext, toplefttext
end






	-- ------------------------------------------------
	-- -----------	Create Text	about 611	------------
	-- ------------------------------------------------
-- function RMW_ScanRaidFor611()

	-- local mintime = 25
	-- local minname = "none"
	-- local minclass = "PRIEST"
	-- local curtime = GetTime()
	-- local hotcountplayers = 0
	-- local hotcountpets = 0

	-- if UnitInRaid("player") then
	-- ----   RAID   ----
	-- ---- JOUEURS  ----
		-- for i = 1, GetNumGroupMembers() do
			-- for j = 1, 40 do
				-- if UnitBuff("raid"..i, j) and RMW_CheckFor611("raid"..i, j) then
					-- local hottime = select(7, UnitBuff("raid"..i, j)) - curtime
					-- if hottime < mintime then
						-- mintime = hottime
						-- minname = UnitName("raid"..i)
						-- minclass = select(2, UnitClass("raid"..i))
					-- end
					-- hotcountplayers = hotcountplayers + 1
				-- end
			-- end
		-- end
	-- ----   PETS  ----
		-- for i = 1, GetNumGroupMembers() do
			-- if UnitExists("raidpet"..i) then 
				-- for j = 1, 40 do
					-- if UnitBuff("raidpet"..i, j) and RMW_CheckFor611("raidpet"..i, j) then
						-- local hottime = select(7, UnitBuff("raidpet"..i, j)) - curtime
						-- if hottime < mintime then
							-- mintime = hottime
							-- minname = UnitName("raid"..i).."'s pet"
							-- minclass = select(2, UnitClass("raid"..i))
						-- end
						-- hotcountpets = hotcountpets + 1
					-- end
				-- end
			-- end
		-- end
	-- ---- FIN RAID ----
	-- elseif UnitInParty("player") then
	-- ----   PARTY  ----
	-- ---- JOUEURS  ----
		-- for i = 1, GetNumSubgroupMembers() do
			-- for j = 1, 40 do
				-- if UnitBuff("party"..i, j) and RMW_CheckFor611("party"..i, j) then
					-- local hottime = select(7, UnitBuff("party"..i, j)) - curtime
					-- if hottime < mintime then
						-- mintime = hottime
						-- minname = UnitName("party"..i)
						-- minclass = select(2, UnitClass("party"..i))
					-- end
					-- hotcountplayers = hotcountplayers + 1
				-- end
			-- end
		-- end
	-- ----   PETS  ----
		-- for i = 1, GetNumSubgroupMembers() do
			-- if UnitExists("partypet"..i) then 
				-- for j = 1, 40 do
					-- if UnitBuff("partypet"..i, j) and RMW_CheckFor611("partypet"..i, j) then
						-- local hottime = select(7, UnitBuff("partypet"..i, j)) - curtime
						-- if hottime < mintime then
							-- mintime = hottime
							-- minname = UnitName("party"..i).."'s pet"
							-- minclass = select(2, UnitClass("party"..i))
						-- end
						-- hotcountpets = hotcountpets + 1
					-- end
				-- end
			-- end
		-- end
	-- ----FIN PARTY ----
	-- end
	-- ----   SOLO   ----
	-- ---- JOUEURS  ----
	-- if not UnitInRaid("player") then
		-- for j = 1, 40 do
			-- if UnitBuff("player", j) and RMW_CheckFor611("player", j) then
				-- local hottime = select(7, UnitBuff("player", j)) - curtime
				-- if hottime < mintime then
					-- mintime = hottime
					-- minname = UnitName("player")
					-- minclass = "MONK"
				-- end
				-- hotcountplayers = hotcountplayers + 1
			-- end
		-- end
	-- ----   PETS  ----
		-- if UnitExists("playerpet") then 
			-- for j = 1, 40 do
				-- if UnitBuff("playerpet", j) and RMW_CheckFor611("playerpet", j) then
					-- local hottime = select(7, UnitBuff("playerpet", j)) - curtime
					-- if hottime < mintime then
						-- mintime = hottime
						-- minname = UnitName("player").."'s pet"
						-- minclass = "MONK"
					-- end
					-- hotcountpets = hotcountpets + 1
				-- end
			-- end
		-- end
	-- end
	-- ---- FIN SOLO ----	
	
	-- if mintime < 24 then RMW_castbar:SetValue(mintime / 20) else RMW_castbar:SetValue(0.1/20)  end
	
	-- return mintime, minname, minclass, hotcountplayers, hotcountpets
	
-- end


	------------------------------------------------
	-----------	Create Text	about 611	------------
	------------------------------------------------
function RMW_ScanRaidFor611()

	local mintime = 25
	local minname = "none"
	local minclass = "PRIEST"
	local curtime = GetTime()
	local hotcountplayers = 0
	local hotcountpets = 0
	
	
	if UnitInRaid("player") then
	----   RAID   ----
	---- JOUEURS  ----
		for i = 1, GetNumGroupMembers() do
			local j=1
			while true do
				-- check si plus de buff
				if not UnitBuff("raid"..i, j) then 
					break
				-- cherche le buff sur les j consécutifs
				elseif RMW_CheckFor611("raid"..i, j) then
					local hottime = select(7, UnitBuff("raid"..i, j)) - curtime
					if hottime < mintime then
						mintime = hottime
						minname = select(1, (UnitName("raid"..i)))
						minclass = select(2, UnitClass("raid"..i))
					end
					hotcountplayers = hotcountplayers + 1
					end
				j=j+1
			end 
		end
	----   PETS  ----
		if RMW_IgnorePets == 0 then
			for i = 1, GetNumGroupMembers() do
				local j=1
				while true do
					-- check si plus de buff
					if not UnitBuff("raidpet"..i, j) then 
						break
					-- cherche le buff sur les j consécutifs
					elseif RMW_CheckFor611("raidpet"..i, j) then
						local hottime = select(7, UnitBuff("raidpet"..i, j)) - curtime
						if hottime < mintime then
							mintime = hottime
							minname = select(1, (UnitName("raid"..i))).."'s pet"
							minclass = select(2, UnitClass("raid"..i))
						end
						hotcountpets = hotcountpets + 1
						end
					j=j+1
				end 
			end
		end
	---- FIN RAID ----
	elseif UnitInParty("player") then
	----   PARTY  ----
	---- JOUEURS  ----
		for i = 1, GetNumSubgroupMembers() do
			local j=1
			while true do
				-- check si plus de buff
				if not UnitBuff("party"..i, j) then 
					break
				-- cherche le buff sur les j consécutifs
				elseif RMW_CheckFor611("party"..i, j) then
					local hottime = select(7, UnitBuff("party"..i, j)) - curtime
					if hottime < mintime then
						mintime = hottime
						minname = select(1, (UnitName("party"..i)))
						minclass = select(2, UnitClass("party"..i))
					end
					hotcountplayers = hotcountplayers + 1
					end
				j=j+1
			end 
		end
	----   PETS  ----
		if RMW_IgnorePets == 0 then
			for i = 1, GetNumSubgroupMembers() do
				local j=1
				while true do
					-- check si plus de buff
					if not UnitBuff("partypet"..i, j) then 
						break
					-- cherche le buff sur les j consécutifs
					elseif RMW_CheckFor611("partypet"..i, j) then
						local hottime = select(7, UnitBuff("partypet"..i, j)) - curtime
						if hottime < mintime then
							mintime = hottime
							minname = select(1, (UnitName("party"..i))).."'s pet"
							minclass = select(2, UnitClass("party"..i))
						end
						hotcountpets = hotcountpets + 1
						end
					j=j+1
				end 
			end
		end
	----FIN PARTY ----
	end
	----   SOLO   ----
	---- JOUEURS  ----
	if not UnitInRaid("player") then
		do
			local j=1
			while true do
				-- check si buff
				if not UnitBuff("player", j) then 
					break
				end
				-- cherche le buff
				if RMW_CheckFor611("player", j) then
					local hottime = select(7, UnitBuff("player", j)) - curtime
					if hottime < mintime then
						mintime = hottime
						minname = UnitName("player")
						minclass = "MONK"
					end
					hotcountplayers = hotcountplayers + 1
				end
				j=j+1
			end 
		end
	----   PETS  ----
		if UnitExists("playerpet") and RMW_IgnorePets == 0 then 
			local j=1
			while true do
				-- check si buff
				if not UnitBuff("playerpet", j) then 
					break
				end
				-- cherche le buff
				if RMW_CheckFor611("playerpet", j) then
					local hottime = select(7, UnitBuff("playerpet", j)) - curtime
					if hottime < mintime then
						mintime = hottime
						minname = "Your Pet"
						minclass = "MONK"
					end
					hotcountpets = hotcountpets + 1
				end
				j=j+1
			end 
		end
	end
	---- FIN SOLO ----	
	
	if mintime < 24 then RMW_castbar:SetValue(mintime / 20) else RMW_castbar:SetValue(0.1/20) end
	
	return mintime, minname, minclass, hotcountplayers, hotcountpets
	
end
	------------------------------------------------
	-----------	Check a buff for 611	------------
	------------------------------------------------
function RMW_CheckFor611(gid, bid)

	local id = select(11, UnitBuff(gid, bid))
	if id == 119611 then
		local caster = select(8, UnitBuff(gid, bid))
		if caster and UnitIsUnit(caster, "player") then
			return true
		end
	end
	
	return false
end









	-- ------------------------------------------------
	-- -----------	Create Text	about 607	------------
	-- ------------------------------------------------
-- function RMW_ScanRaidFor607()

	-- if UnitInRaid("player") then
	-- ----   RAID   ----
	-- ---- JOUEURS  ----
		-- for i = 1, GetNumGroupMembers() do
			-- for j = 1, 40 do
				-- if UnitBuff("raid"..i, j) and RMW_CheckFor607("raid"..i, j) then
					-- local stacks = select(4, UnitBuff("raid"..i, j))
					-- return stacks
				-- end
			-- end
		-- end
	-- ----   PETS  ----
		-- for i = 1, GetNumGroupMembers() do
			-- if UnitExists("raidpet"..i) then 
				-- for j = 1, 40 do
					-- if UnitBuff("raidpet"..i, j) and RMW_CheckFor607("raidpet"..i, j) then
						-- local stacks = select(4, UnitBuff("raidpet"..i, j))
						-- return stacks
					-- end
				-- end
			-- end
		-- end
	-- ---- FIN RAID ----
	-- elseif UnitInParty("player") then
	-- ----   PARTY  ----
	-- ---- JOUEURS  ----
		-- for i = 1, GetNumSubgroupMembers() do
			-- for j = 1, 40 do
				-- if UnitBuff("party"..i, j) and RMW_CheckFor607("party"..i, j) then
					-- local stacks = select(4, UnitBuff("party"..i, j))
					-- return stacks
				-- end
			-- end
		-- end
	-- ----   PETS  ----
		-- for i = 1, GetNumSubgroupMembers() do
			-- if UnitExists("partypet"..i) then 
				-- for j = 1, 40 do
					-- if UnitBuff("partypet"..i, j) and RMW_CheckFor607("partypet"..i, j) then
						-- local stacks = select(4, UnitBuff("partypet"..i, j))
						-- return stacks
					-- end
				-- end
			-- end
		-- end
	-- ----FIN PARTY ----
	-- end
	-- ----   SOLO   ----
	-- ---- JOUEURS  ----
	-- if not UnitInRaid("player") then
		-- for j = 1, 40 do
			-- if UnitBuff("player", j) and RMW_CheckFor607("player", j) then
				-- local stacks = select(4, UnitBuff("player", j))
				-- return stacks
			-- end
		-- end
	-- ----   PETS  ----
		-- if UnitExists("playerpet") then 
			-- for j = 1, 40 do
				-- if UnitBuff("playerpet", j) and RMW_CheckFor607("playerpet", j) then
					-- local stacks = select(4, UnitBuff("playerpet", j))
					-- return stacks
				-- end
			-- end
		-- end
	-- end
	-- ---- FIN SOLO ----	
	
	-- return nil
-- end





	------------------------------------------------
	-----------	Create Text	about 607	------------
	------------------------------------------------
function RMW_ScanRaidFor607()
	local result


	if UnitInRaid("player") then
	----   RAID   ----
	---- JOUEURS  ----
		do
			local result = RMW_scanPartyOrRaidOrPetsFor607("raid", GetNumGroupMembers())
			if result then
				return result
			end
		end
	--   PETS  ----
		do
			local result = RMW_scanPartyOrRaidOrPetsFor607("raidpet", GetNumGroupMembers())
			if result then
				return result
			end
		end
	-- FIN RAID ----
	elseif UnitInParty("player") then
	--   PARTY  ----
	-- JOUEURS  ----
		do
			local result = RMW_scanPartyOrRaidOrPetsFor607("party", GetNumSubgroupMembers())
			if result then
				return result
			end
		end
	--   PETS  ----
		do
			local result = RMW_scanPartyOrRaidOrPetsFor607("partypet", GetNumSubgroupMembers())
			if result then
				return result
			end
		end
	----FIN PARTY ----
	end
	----   SOLO   ----
	---- JOUEURS  ----
	if not UnitInRaid("player") then
		do
			local result = RMW_scanPlayerOrPlayerPetFor607("player")
			if result then
				return result
			end
		end
	----   PETS  ----
		if UnitExists("playerpet") then 
			local result = RMW_scanPlayerOrPlayerPetFor607("playerpet")
			if result then
				return result
			end
		end	
	end
	---- FIN SOLO ----	
	return nil
end
	------------------------------------------------
	-----------	Check Player for 607	------------
	------------------------------------------------
function RMW_scanPlayerOrPlayerPetFor607(unitid)
	local j=1
	while true do
		-- check si buff
		if not UnitBuff(unitid, j) then 
			return nil
		end
		-- cherche le buff
		if RMW_CheckFor607(unitid, j) then
			local stacks = select(4, UnitBuff(unitid, j))
			return stacks
		end
		j=j+1
	end 
end
	------------------------------------------------
	-----------		Check Raid for 607	------------
	------------------------------------------------
function RMW_scanPartyOrRaidOrPetsFor607(unitid, number)
	for i = 1, number do
		local j=1
		while true do
			-- check si fin de fonction ou de i 
			if not UnitBuff(unitid..i, j) then 
				-- check si fin de fonction
				if i == number then
					return nil
				-- check si fin de i 
				else
					break
				end
			-- cherche le buff sur les j consécutifs
			elseif RMW_CheckFor607(unitid..i, j) then
				local stacks = select(4, UnitBuff(unitid..i, j))
				return stacks
			end
			j=j+1
		end 
	end
	
end
	------------------------------------------------
	-----------	Check a buff for 607	------------
	------------------------------------------------
function RMW_CheckFor607(gid, bid)

	local id = select(11, UnitBuff(gid, bid))
	if id == 119607 then
		local caster = select(8, UnitBuff(gid, bid))
		if caster and UnitIsUnit(caster, "player") then
			return true
		end
	end
	
	return false
end





	------------------------------------------------
	-------	ENABLE/DISABLE 		FUNCTIONS	--------
	------------------------------------------------
function RMW_PauseAddon()
	MyFrameRMW:SetScript("OnUpdate", nil)
	MyFrameRMW:RegisterEvent("UNIT_SPELLCAST_SENT")
	if RMW_AutohideState == 1 then MyFrameRMW:Hide() end
end
function RMW_UnpauseAddon()
	MyFrameRMW:UnregisterEvent("UNIT_SPELLCAST_SENT")
	RMW_antibug = 0 -- reset de l'anti-bug
	MyFrameRMW:SetScript("OnUpdate", RenewingMistWatcher_OnUpdate)
	MyFrameRMW:Show()
end
function RMW_DisableBecauseOfWrongSpec()
	MyFrameRMW:SetScript("OnUpdate", nil)
	MyFrameRMW:UnregisterEvent("UNIT_SPELLCAST_SENT")
	MyFrameRMW:Hide()
	-- print(string.format("|TInterface\\Icons\\ability_monk_renewingmists:15:15|t".."|cff008467 Renewing Mist Watcher : |r|cFFC1EFA8Disabled|r"))
end
function RMW_EnableBecauseBackOnRightSpec()
	MyFrameRMW:RegisterEvent("UNIT_SPELLCAST_SENT")
	-- print(string.format("|TInterface\\Icons\\ability_monk_renewingmists:15:15|t".."|cff008467 Renewing Mist Watcher : |r|cFFC1EFA8Enabled|r"))
end




