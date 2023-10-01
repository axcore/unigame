---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/trunks
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local cbox = {
	type = "wallmounted",
	wall_top =    {-1/2,  1/2, -1/2,    1/2,  15/32, 1/2},
	wall_bottom = {-1/2, -1/2, -1/2,    1/2, -15/32, 1/2},
	wall_side =   {-1/2, -1/2, -1/2, -15/32,    1/2, 1/2}
}

for r = 0, 3 do
	local xform = ""
	if r > 0 then xform = "^[transformR"..r*90 end

	minetest.register_node("trunks:moss_plain_"..r, {
		description = S("Moss"),
		drawtype = "nodebox",
		tiles = {"trunks_moss.png"..xform},
		inventory_image = "trunks_moss.png",
		wield_image = "trunks_moss.png",
		paramtype = "light",
		paramtype2 = "wallmounted",
		sunlight_propagates = true,
		walkable = false,
		node_box = cbox,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, attached_node=1, not_in_creative_inventory = r},
		sounds = default.node_sound_leaves_defaults(),
		drop = "trunks:moss_plain_0",
	})

	-----------------------------------------------------------------------------------------------
	-- MoSS & FuNGuS
	-----------------------------------------------------------------------------------------------
	minetest.register_node("trunks:moss_with_fungus_"..r, {
		description = S("Moss with Fungus"),
		drawtype = "nodebox",
		tiles = {"trunks_moss_fungus.png"..xform},
		inventory_image = "trunks_moss_fungus.png",
		wield_image = "trunks_moss_fungus.png",
		paramtype = "light",
		paramtype2 = "wallmounted",
		sunlight_propagates = true,
		walkable = false,
		node_box = cbox,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, attached_node=1, not_in_creative_inventory = r},
		sounds = default.node_sound_leaves_defaults(),
		drop = "trunks:moss_with_fungus_0",
	})
end

if Moss_on_ground == true then
abstract_trunks.grow_moss_on_ground = function(pos)
	local on_ground = {x=pos.x, y=pos.y+1, z=pos.z}
	local moss_type = math.random(1,21)
	local rot = math.random(0,3)

	if moss_type == 1 then
		minetest.swap_node(on_ground, {name="trunks:moss_with_fungus_"..rot, param2=1})
	else
		minetest.swap_node(on_ground, {name="trunks:moss_plain_"..rot, param2=1})
	end

end

biome_lib.register_on_generate({
    surface = {"default:dirt_with_grass"},
    max_count = Moss_on_ground_Max_Count,
    rarity = Moss_on_ground_Rarity,
    min_elevation = 1,
	max_elevation = 40,
	near_nodes = {
		"group:tree",
		"ferns:fern_03",
		"ferns:fern_02",
		"ferns:fern_01"
	},
	near_nodes_size = 2,
	near_nodes_vertical = 1,
	near_nodes_count = 1,
    plantlife_limit = -0.9,
  },
  abstract_trunks.grow_moss_on_ground
)
end
]]--
