---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- the basic version of a bed - a sleeping mat
-- to facilitate upgrade path straw mat -> sleeping mat -> bed, this uses a nodebox
minetest.register_node("cottages:sleeping_mat", {
        description = S("sleeping mat"),
        drawtype = 'nodebox',
        tiles = { 'cottages_sleepingmat.png' }, -- done by VanessaE
        wield_image = 'cottages_sleepingmat.png',
        inventory_image = 'cottages_sleepingmat.png',
        sunlight_propagates = true,
        paramtype = 'light',
        paramtype2 = "facedir",
        walkable = false,
        groups = { snappy = 3 },
	sounds = cottages.sounds.leaves,
        selection_box = {
                        type = "wallmounted",
                        },
        node_box = {
                type = "fixed",
                fixed = {
                                        {-0.48, -0.5,-0.48,  0.48, -0.5+1/16, 0.48},
                        }
        },
        selection_box = {
                type = "fixed",
                fixed = {
                                        {-0.48, -0.5,-0.48,  0.48, -0.5+2/16, 0.48},
                        }
        },
	is_ground_content = false,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
				return cottages.sleep_in_bed( pos, node, clicker, itemstack, pointed_thing );
			end
})
minetest.register_craft({
	output = "cottages:sleeping_mat 3",
	recipe = {
		{"cottages:wool_tent", "cottages:straw_mat","cottages:straw_mat" }
	}
})

-- this one has a pillow for the head; thus, param2 becomes visible to the builder, and mobs may use it as a bed
minetest.register_node("cottages:sleeping_mat_head", {
        description = S("sleeping mat with pillow"),
        drawtype = 'nodebox',
        tiles = { 'cottages_sleepingmat.png' }, -- done by VanessaE
        wield_image = 'cottages_sleepingmat.png',
        inventory_image = 'cottages_sleepingmat.png',
        sunlight_propagates = true,
        paramtype = 'light',
        paramtype2 = "facedir",
        groups = { snappy = 3 },
	sounds = cottages.sounds.leaves,
        node_box = {
                type = "fixed",
                fixed = {
                                        {-0.48, -0.5,-0.48,  0.48, -0.5+1/16, 0.48},
                                        {-0.34, -0.5+1/16,-0.12,  0.34, -0.5+2/16, 0.34},
                        }
        },
        selection_box = {
                type = "fixed",
                fixed = {
                                        {-0.48, -0.5,-0.48,  0.48, -0.5+2/16, 0.48},
                        }
        },
	is_ground_content = false,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
				return cottages.sleep_in_bed( pos, node, clicker, itemstack, pointed_thing );
			end
})
minetest.register_craft({
	output = "cottages:sleeping_mat_head",
	recipe = {
		{"cottages:sleeping_mat","cottages:straw_mat" }
	}
})
]]--
