---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    flowerpot
-- Code:    LGPLv2.1
-- Media:   CC-BY-SA-3.0/Public Domain
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local function get_tile(def)
	local tile = def.tiles[1]
	if type (tile) == "table" then
		return tile.name
	end
	return tile
end

local function flowerpot_on_rightclick(pos, node, clicker, itemstack, pointed_thing)
	if clicker and not minetest.check_player_privs(clicker, "protection_bypass") then
		local name = clicker:get_player_name()
		if minetest.is_protected(pos, name) then
			minetest.record_protection_violation(pos, name)
			return false
		end
	end

	local nodename = itemstack:get_name()
	if not nodename then
		return false
	end

	if nodename:match("grass_1") then
		nodename = nodename:gsub("grass_1", "grass_" .. math.random(5))
	end

	local name = "flowerpot:" .. nodename:gsub(":", "_")
	local def = minetest.registered_nodes[name]
	if not def then
		return itemstack
	end
	minetest.sound_play(def.sounds.place, {pos = pos})
	minetest.swap_node(pos, {name = name})
	if not minetest.settings:get_bool("creative_mode") then
		itemstack:take_item()
	end
	return itemstack
end

minetest.register_node("flowerpot:empty", {
	description = S("Flowerpot"),
	drawtype = "mesh",
	mesh = "flowerpot.obj",
	inventory_image = "flowerpot_item.png",
	wield_image = "flowerpot_item.png",
	tiles = {
		{name = "flowerpot.png"},
		{name = "blank.png"},
		{name = "blank.png"},
	},
	paramtype = "light",
	sunlight_propagates = true,
	use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "clip" or true,
	collision_box = {
		type = "fixed",
		fixed = {-1/4, -1/2, -1/4, 1/4, -1/8, 1/4},
	},
	selection_box = {
		type = "fixed",
		fixed = {-1/4, -1/2, -1/4, 1/4, -1/16, 1/4},
	},
	sounds = default.node_sound_defaults(),
	groups = {attached_node = 1, oddly_breakable_by_hand = 3, cracky = 1, dig_immediate = 3},
	on_rightclick = flowerpot_on_rightclick,
})
minetest.register_craft({
	output = "flowerpot:empty",
	recipe = {
		{"default:clay_brick", "", "default:clay_brick"},
		{"", "default:clay_brick", ""},
	}
})

function flowerpot.register_node(nodename)
	assert(nodename, "no nodename passed")
	local nodedef = minetest.registered_nodes[nodename]
	if not nodedef then
		minetest.log("error", S("@1 is not a known node, unable to register flowerpot", nodename))
		return false
	end

	local desc = nodedef.description
	local name = nodedef.name:gsub(":", "_")
	local tiles

	if nodedef.drawtype == "plantlike" then
		tiles = {
			{name = "flowerpot.png"},
			{name = get_tile(nodedef)},
			{name = "blank.png"},
		}
	else
		tiles = {
			{name = "flowerpot.png"},
			{name = "blank.png"},
			{name = get_tile(nodedef)},
		}
	end

	local dropname = nodename:gsub("grass_%d", "grass_1")

	minetest.register_node(":flowerpot:" .. name, {
		description = S("Flowerpot with @1", desc),
		drawtype = "mesh",
		mesh = "flowerpot.obj",
		tiles = tiles,
		paramtype = "light",
		sunlight_propagates = true,
		use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "clip" or true,
		collision_box = {
			type = "fixed",
			fixed = {-1/4, -1/2, -1/4, 1/4, -1/8, 1/4},
		},
		selection_box = {
			type = "fixed",
			fixed = {-1/4, -1/2, -1/4, 1/4, 7/16, 1/4},
		},
		sounds = default.node_sound_defaults(),
		groups = {attached_node = 1, oddly_breakable_by_hand = 1, snappy = 3, not_in_creative_inventory = 1},
		flowerpot_plantname = nodename,
		on_dig = function(pos, node, digger)
			minetest.set_node(pos, {name = "flowerpot:empty"})
			local def = minetest.registered_nodes[node.name]
			minetest.add_item(pos, dropname)
		end,
		drop = {
			max_items = 2,
			items = {
				{
					items = {"flowerpot:empty", dropname},
					rarity = 1,
				},
			}
		},
	})
end
]]--
