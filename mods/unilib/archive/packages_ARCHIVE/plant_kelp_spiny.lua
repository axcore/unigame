---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("australia:kelp_brown", {
	description = "Ecklonia radiata: Common Kelp",
	drawtype = "plantlike",
	waving = 1,
	tiles = {"aus_kelp_brown.png"},
	inventory_image = "aus_kelp_brown.png",
	wield_image = "aus_kelp_brown.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climable = true,
	drowning = 1,
	is_ground_content = true,
	groups = {snappy=3, seaplants=1, sea=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

minetest.register_abm({
    nodenames = {"australia:stone_kelp_brown"},
    interval = 15,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
        if (minetest.get_node(yp).name == "default:water_source" or
        minetest.get_node(yp).name == "australia:water_source") then
            pos.y = pos.y + 1
            minetest.add_node(pos, {name = "australia:kelp_brown"}) else
            return
        end
    end
})
]]--
