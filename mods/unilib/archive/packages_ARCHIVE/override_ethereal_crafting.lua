---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if ethereal.xcraft == true then

-- X pattern craft recipes (5x 'a' in X pattern gives 5 of 'b')
local cheat = {
	{"default:cobble", "default:gravel", 5},
	{"default:gravel", "default:dirt", 5},
	{"default:dirt", "default:sand", 5},
	{"default:ice", "default:snow", 20},
	{"ethereal:dry_dirt", "default:desert_sand", 5},
	{"default:stone", "default:silver_sandstone", 5}
}

for n = 1, #cheat do

	minetest.register_craft({
		output = cheat[n][2] .. " " .. cheat[n][3],
		recipe = {
			{cheat[n][1], "", cheat[n][1]},
			{"", cheat[n][1], ""},
			{cheat[n][1], "", cheat[n][1]}
		}
	})
end

end -- END if
]]--
