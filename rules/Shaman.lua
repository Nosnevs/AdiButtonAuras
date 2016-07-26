--[[
AdiButtonAuras - Display auras on action buttons.
Copyright 2013-2014 Adirelle (adirelle@gmail.com)
All rights reserved.

This file is part of AdiButtonAuras.

AdiButtonAuras is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

AdiButtonAuras is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with AdiButtonAuras.  If not, see <http://www.gnu.org/licenses/>.
--]]

local _, addon = ...

if not addon.isClass("SHAMAN") then return end

AdiButtonAuras:RegisterRules(function()
	Debug('Adding shaman rules')

	local liquidMagmaTotem = GetSpellInfo(192222)

	local function BuildTotemHandler(totemName)
		return function(_, model)
			for slot = 1, 5 do -- max 5 totems at once?
				local found, name, start, duration = GetTotemInfo(slot)
				if found and name == totemName then
					model.expiration = start + duration
					model.highlight = "good"
					break
				end
			end
		end
	end

	return {
		ImportPlayerSpells { "SHAMAN" },
		ShowPower {
			8042, -- Earth Shock
			"MAELSTROM",
		},
		ShowPower {
			{
				188389, -- Flame Shock
				196840, -- Frost Shock
			},
			"MAELSTROM",
			20, -- hint when at 20 or more
		},
		ShowPower {
			187837, -- Lightning Bolt
			"MAELSTROM",
			45,
			nil,
			nil,
			210727, -- Overcharge
		},
		Configure {
			"LiquidMagmaTotemDuration",
			format(L["Show the duration of %s"], liquidMagmaTotem),
			192222, -- Liquid Magma Totem
			"player",
			"PLAYER_TOTEM_UPDATE",
			BuildTotemHandler(liquidMagmaTotem),
		},
	}
end)

-- GLOBALS: AddRuleFor BuffAliases BuildAuraHandler_FirstOf BuildAuraHandler_Longest
-- GLOBALS: BuildAuraHandler_Single BuildDesc BuildKey Configure DebuffAliases Debug
-- GLOBALS: DescribeAllSpells DescribeAllTokens DescribeFilter DescribeHighlight
-- GLOBALS: DescribeLPSSource GetComboPoints GetEclipseDirection GetNumGroupMembers
-- GLOBALS: GetShapeshiftFormID GetSpellBonusHealing GetSpellInfo GetTime
-- GLOBALS: GetTotemInfo HasPetSpells ImportPlayerSpells L LongestDebuffOf
-- GLOBALS: PLAYER_CLASS PassiveModifier PetBuffs SelfBuffAliases SelfBuffs
-- GLOBALS: SharedSimpleBuffs SharedSimpleDebuffs ShowPower SimpleBuffs
-- GLOBALS: SimpleDebuffs UnitCanAttack UnitCastingInfo UnitChannelInfo UnitClass
-- GLOBALS: UnitHealth UnitHealthMax UnitIsDeadOrGhost UnitIsPlayer UnitPower
-- GLOBALS: UnitPowerMax UnitStagger bit ceil floor format ipairs math min pairs
-- GLOBALS: print select string table tinsert GetPlayerBuff ShowStacks
