---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- Leaves
local leaves = minetest.registered_nodes["default:leaves"]
nodedef = {
	description = "Snow Leaves",
	tiles = {"snow_leaves.png"},
	waving = 1,
	visual_scale = leaves.visual_scale,
	drawtype = leaves.drawtype,
	paramtype = leaves.paramtype,
	groups = leaves.groups,
	drop = leaves.drop,
	sounds = leaves.sounds,
}
nodedef.groups.flammable = 1

minetest.register_node("snow:leaves", nodedef)

if not snow.disable_mapgen then
	-- decay from default/nodes.lua:2537
	default.register_leafdecay{
		trunks = {"default:tree"},
		leaves = {"snow:apple", "snow:leaves"},
		radius = minetest.get_mapgen_setting"mg_name" == "v6" and 2 or 3,
	}
end
]]--
