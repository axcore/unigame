---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node('aotearoa:ponga_fence', {
	description = 'Ponga Fence',
	drawtype = "nodebox",
	node_box = {
		type = "connected",
		fixed = {{-1/4, -1/2, -1/4, 1/4, 1/2, 1/4}},
		-- connect_bottom =
		connect_front = {{-1/4, -1/2, -1/2,  1/4, 1/2, -1/4}},
		connect_left = {{-1/2, -1/2, -1/4, -1/4, 1/2,  1/4}},
		connect_back = {{-1/4, -1/2,  1/4,  1/4, 1/2,  1/2}},
		connect_right = {{ 1/4, -1/2, -1/4,  1/2, 1/2,  1/4}},
	},
	connects_to = { "group:crumbly", "group:wood", "group:tree", "group:stone",'aotearoa:ponga_fence',},
	paramtype = "light",
  tiles = {
    "aotearoa_ponga_fence_top.png",
    "aotearoa_ponga_fence_top.png",
    "aotearoa_ponga_fence.png"
  },
	inventory_image = "aotearoa_ponga_fence.png",
	wield_image = "aotearoa_ponga_fence.png",
	groups = {choppy = 3, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = 'aotearoa:ponga_fence',
	recipe = {
		{'', '', ''},
		{'', '', ''},
		{'aotearoa:wheki_tree', 'aotearoa:wheki_tree', 'aotearoa:wheki_tree'},
	}
})
minetest.register_craft({
	output = 'aotearoa:ponga_fence',
	recipe = {
		{'', '', ''},
		{'', '', ''},
		{'aotearoa:silver_fern_tree', 'aotearoa:silver_fern_tree', 'aotearoa:silver_fern_tree'},
	}
})
minetest.register_craft({
	output = 'aotearoa:ponga_fence',
	recipe = {
		{'', '', ''},
		{'', '', ''},
		{'aotearoa:mamaku_tree', 'aotearoa:mamaku_tree', 'aotearoa:mamaku_tree'},
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "aotearoa:ponga_fence",
	burntime = 3,
})
]]--
