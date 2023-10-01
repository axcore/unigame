---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ropes
-- Code:    MIT
-- Media:   unknown (textures), CC0 (sounds)
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local rope_def = {
	description = S("Rope"),
	_doc_items_longdesc = ropes.doc.ropebox_longdesc,
    _doc_items_usagehelp = ropes.doc.ropebox_usage,
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	drop = "",
	tiles = { "ropes_3.png", "ropes_3.png", "ropes_3.png", "ropes_3.png", "ropes_5.png", "ropes_5.png" },
	use_texture_alpha = "clip",
	groups = {choppy=2, flammable=2, not_in_creative_inventory=1},
	sounds = {
            footstep = {name = "ropes_creak", gain = 0.8, max_hear_distance = 6},
            dig = "__group",
            dug = "__group",
	},
	drawtype = "nodebox",
	node_box = {
		type = "connected",
		fixed = {-1/16, -1/2, -1/16, 1/16, 1/2, 1/16},
		connect_top = {-1/16, 1/2, -1/16, 1/16, 3/4, 1/16}
	},
	connects_to = {"group:rope_block"},
	connect_sides = {"top"},
	selection_box = {
		type = "fixed",
		fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
	},
  	after_destruct = function(pos)
		ropes.hanging_after_destruct(pos, "ropes:rope_top", "ropes:rope", "ropes:rope_bottom")
	end,
}

local rope_extension_timer = ropes.make_rope_on_timer("ropes:rope")

local rope_bottom_def = {
	description = S("Rope"),
	_doc_items_create_entry = false,
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	drop = "",
	tiles = { "ropes_3.png", "ropes_3.png", "ropes_3.png", "ropes_3.png", "ropes_5.png", "ropes_5.png" },
	use_texture_alpha = "clip",
	drawtype = "nodebox",
	groups = {choppy=2, flammable=2, not_in_creative_inventory=1},
	sounds = {
            footstep = {name = "ropes_creak", gain = 0.8, max_hear_distance = 6},
            dig = "__group",
            dug = "__group",
	},
	node_box = {
		type = "connected",
		fixed = {
			{-1/16, -3/8, -1/16, 1/16, 1/2, 1/16},
			{-2/16, -5/16, -2/16, 2/16, -1/16, 2/16},
		},
		connect_top = {-1/16, 1/2, -1/16, 1/16, 3/4, 1/16}
	},
	connects_to = {"group:rope_block"},
	connect_sides = {"top"},
	selection_box = {
		type = "fixed",
		fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
	},
	
	on_construct = function( pos )
		local timer = minetest.get_node_timer( pos )
		timer:start( 1 )
	end,
	
	on_timer = rope_extension_timer,
	
    after_destruct = function(pos)
		ropes.hanging_after_destruct(pos, "ropes:rope_top", "ropes:rope", "ropes:rope_bottom")
	end,
}

minetest.register_node("ropes:rope", rope_def)
minetest.register_node("ropes:rope_bottom", rope_bottom_def)

minetest.register_craftitem("ropes:ropesegment", {
	description = S("Rope Segment"),
	_doc_items_longdesc = ropes.doc.ropesegment_longdesc,
    _doc_items_usagehelp = ropes.doc.ropesegment_usage,
	groups = {vines = 1},
	inventory_image = "ropes_item.png",
})
if minetest.get_modpath("farming") then
	minetest.register_craft({
		output = 'ropes:ropesegment',
		recipe = {
			{'farming:cotton','farming:cotton'},
			{'farming:cotton','farming:cotton'},
			{'farming:cotton','farming:cotton'},
		}
	})
end
if minetest.get_modpath("cottages") then
	minetest.register_craft({
		output = 'ropes:ropesegment',
		recipe = {
			{'cottages:rope'},
			{'cottages:rope'},
		}
	})
end
minetest.register_craft({
	output = 'ropes:ropesegment',
	recipe = {
		{'group:thread','group:thread'},
		{'group:thread','group:thread'},
		{'group:thread','group:thread'},
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "ropes:ropesegment",
	burntime = ropes.rope_burn_time,
})
]]--
