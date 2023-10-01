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
-- an even simpler from of bed - usually for animals 
-- it is a nodebox and not wallmounted because that makes it easier to replace beds with straw mats
minetest.register_node("cottages:straw_mat", {
        description = S("layer of straw"),
        drawtype = 'nodebox',
        tiles = { cottages.straw_texture }, -- done by VanessaE
        wield_image = cottages.straw_texture,
        inventory_image = cottages.straw_texture,
        sunlight_propagates = true,
        paramtype = 'light',
        paramtype2 = "facedir",
        walkable = false,
	groups = { hay = 3, snappy = 2, oddly_breakable_by_hand = 2, flammable=3 },
	sounds = cottages.sounds.leaves,
	node_box = {
		type = "fixed",
		fixed = {
					{-0.48, -0.5,-0.48,  0.48, -0.45, 0.48},
			}
	},
	selection_box = {
		type = "fixed",
		fixed = {
					{-0.48, -0.5,-0.48,  0.48, -0.25, 0.48},
			}
	},
	is_ground_content = false,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		return cottages.sleep_in_bed( pos, node, clicker, itemstack, pointed_thing );
	end
})
minetest.register_craft({
	output = "cottages:straw_mat 6",
	recipe = {
                {cottages.craftitem_stone,'',''},
		{"farming:wheat", "farming:wheat", "farming:wheat", },
	},
        replacements = {{ cottages.craftitem_stone, cottages.craftitem_seed_wheat.." 3" }},  
})
minetest.register_craft({
	output = "cottages:straw_bale",
	recipe = {
		{"cottages:straw_mat"},
		{"cottages:straw_mat"},
		{"cottages:straw_mat"},
	},
})
minetest.register_craft({
	output = "cottages:straw_mat 3",
	recipe = {
		{"cottages:straw_bale"},
	},
})
]]--
