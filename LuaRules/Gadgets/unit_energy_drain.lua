--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:GetInfo()
  return {
    name      = "Energy Drain",
    desc      = "Handles energy drain from radar, cloak etc.. such that they obey priorities.",
    author    = "Google Frog",
    date      = "16 August 2015",
    license   = "GNU GPL, v2 or later",
    layer     = 5,
    enabled   = true  --  loaded by default?
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

if (not gadgetHandler:IsSyncedCode()) then
  return false  --  no unsynced code
end

include("LuaRules/Configs/constants.lua")

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local PERIOD = 10

local INLOS_ACCESS = {inlos = true}

local spGetUnitShieldState  = Spring.GetUnitShieldState
local spSetUnitShieldState  = Spring.SetUnitShieldState

local spGetUnitIsStunned  = Spring.GetUnitIsStunned
local spUseUnitResource   = Spring.UseUnitResource
local spGetUnitRulesParam = Spring.GetUnitRulesParam
local spSetUnitRulesParam = Spring.SetUnitRulesParam

local unitMap = {}
local unitList = {}
local unitCount = 0

local drainUnitDefID = {}

for unitDefID = 1, #UnitDefs do
	local ud = UnitDefs[unitDefID]
	local upkeep = ud.customParams.upkeep_energy
	local cloakerUpkeep = ud.customParams.area_cloak_upkeep
	
	upkeep = upkeep and tonumber(upkeep)
	cloakerUpkeep = cloakerUpkeep and tonumber(cloakerUpkeep)
	if (upkeep and upkeep > 0) or (cloakerUpkeep and cloakerUpkeep > 0) then
		drainUnitDefID[unitDefID] = {
			upkeep = upkeep,
			upkeepPerUpdate = upkeep and upkeep*PERIOD/TEAM_SLOWUPDATE_RATE,
		}
		if cloakerUpkeep then
			-- Upkeep is always paid because cloakers are only active when the unit is active.
			drainUnitDefID[unitDefID].cloakerUpkeep = cloakerUpkeep + (upkeep or 0)
			drainUnitDefID[unitDefID].cloakerUpkeepPerUpdate = (cloakerUpkeep + (upkeep or 0))*PERIOD/TEAM_SLOWUPDATE_RATE
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Unit Updating

local function ScriptUpdate(unitID, env, val)
	if val then
		if env then 
			if env.script.Activate then
				Spring.UnitScript.CallAsUnit(unitID, env.script.Activate)
			end
		else 
			Spring.CallCOBScript(unitID, "Activate", 0)
		end
	else
		if env then 
			if env.script.Deactivate then
				Spring.UnitScript.CallAsUnit(unitID, env.script.Deactivate)
			end
		else 
			Spring.CallCOBScript(unitID, "Deactivate", 0)
		end
	end
end

-- Unit is active as far as this function is concerned.
local function GetUnitUpkeep(unitID, def)
	if def.cloakerUpkeep and ((Spring.GetUnitRulesParam(unitID, "cloak_shield") or 0) > 0) then
		return def.cloakerUpkeep, def.cloakerUpkeepPerUpdate
	elseif def.upkeep then
		return def.upkeep, def.upkeepPerUpdate
	end
end

function gadget:GameFrame(n)
	if n%PERIOD ~= 0 then
		return
	end

	for i = 1, unitCount do
		local data = unitList[i]
		local unitID = data.unitID
		
		local activeState = Spring.GetUnitStates(unitID)
		activeState = activeState and activeState["active"]
		
		local stunned_or_inbuild, stunned, inbuild = spGetUnitIsStunned(unitID) 
		local disarmed = (spGetUnitRulesParam(unitID, "disarmed") == 1)
		local morphing = (spGetUnitRulesParam(unitID, "morphDisable") == 1)
		
		local def = drainUnitDefID[data.unitDefID]
		if activeState and not (stunned_or_inbuild or disarmed or morphing) then
			-- Get upkeep based on run systems
			local newUpkeep, upkeepPerUpdate = GetUnitUpkeep(unitID, def)
			
			if newUpkeep ~= data.oldUpkeep then
				GG.StartMiscPriorityResourcing(unitID, data.teamID, newUpkeep, true, 3)
				
				data.oldUpkeep = newUpkeep
				data.resTable.e = upkeepPerUpdate
			end

			-- Check drain
			local enabled = (GG.CheckMiscPriorityBuildStep(unitID, data.teamID, data.resTable.e, true) and spUseUnitResource(unitID, data.resTable))
			
			if enabled ~= data.oldEnabled then
				spSetUnitRulesParam(unitID, "forcedOff", (enabled and 0) or 1, INLOS_ACCESS)
				GG.UpdateUnitAttributes(unitID)
				data.oldEnabled = enabled
				
				ScriptUpdate(unitID, data.env, enabled)
			end
		else
			if data.oldUpkeep ~= 0 then
				GG.StopMiscPriorityResourcing(unitID, 3)
				data.oldUpkeep = 0
			end
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Unit Tracking

function gadget:UnitCreated(unitID, unitDefID, teamID)
	if drainUnitDefID[unitDefID] and not unitMap[unitID] then
		GG.AddMiscPriorityUnit(unitID, teamID)
	end
end

function gadget:UnitFinished(unitID, unitDefID, teamID)
	if drainUnitDefID[unitDefID] and not unitMap[unitID] then
		local def = drainUnitDefID[unitDefID]
		unitCount = unitCount + 1
		
		local env = Spring.UnitScript.GetScriptEnv(unitID)
		
		local data = {
			unitID = unitID,
			index = unitCount,
			unitDefID = unitDefID, 
			teamID = teamID,
			env = env,
			resTable = {
				m = 0,
				e = def.upkeepPerUpdate
			}
		}
		
		unitList[unitCount] = data
		unitMap[unitID] = data
	end
end

function gadget:UnitDestroyed(unitID, unitDefID, teamID)
	if unitMap[unitID] then
		local index = unitMap[unitID].index
		
		unitList[unitCount].index = index
		unitList[index] = unitList[unitCount]
		
		unitList[unitCount] = nil
		unitMap[unitID] = nil
		unitCount = unitCount - 1
	end
end

function gadget:UnitTaken(unitID, unitDefID, oldTeamID, teamID)
	if unitMap[unitID] then
		unitMap[unitID].teamID = teamID
	end
end

function gadget:Initialize()
	
	for _, unitID in ipairs(Spring.GetAllUnits()) do
		local unitDefID = Spring.GetUnitDefID(unitID)
		local teamID = Spring.GetUnitTeam(unitID)
		gadget:UnitCreated(unitID, unitDefID, teamID)
		gadget:UnitFinished(unitID, unitDefID, teamID)
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------