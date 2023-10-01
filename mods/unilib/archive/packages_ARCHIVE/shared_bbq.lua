---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local cold_grills = {
	"bbq:kettle_grill",
	"bbq:propane_grill",
	"bbq:propane_grill_pro",
	"bbq:smoker",
}

local hot_grills = {
	"bbq:kettle_grill_active",
	"bbq:propane_grill_active",
	"bbq:propane_grill_pro_active",
	"bbq:smoker_active",
}

local function on_use_play_sound(sound, use_on_cold)
	return function(itemstack, placer, pointed_thing)
		if not pointed_thing or pointed_thing.type ~= "node" then return end
		local under_pos       = pointed_thing.under
		local under_node_name = minetest.get_node(under_pos).name
		for _, grill_name in ipairs(hot_grills) do
			if under_node_name == grill_name then
				minetest.sound_play(sound, { pos = under_pos, max_hear_distance = 10 })
				return
			end
		end
		if use_on_cold then
			for _, grill_name in ipairs(cold_grills) do
				if under_node_name == grill_name then
					minetest.sound_play(sound, { pos = under_pos, max_hear_distance = 10 })
					return
				end
			end
		end
	end
end
]]--
