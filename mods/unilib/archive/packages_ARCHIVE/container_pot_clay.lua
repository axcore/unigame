---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local function is_owner(pos, name)
	local owner = minetest.get_meta(pos):get_string("owner")
	if owner == "" or owner == name or minetest.check_player_privs(name, "protection_bypass") then
		return true
	end
	return false
end

local function get_storage_formspec(pos)
	local formspec ="size[8,7]" ..
		default.gui_bg ..
		default.gui_bg_img ..
		default.gui_slots ..
		"list[current_name;main;0,0.3;8,2]" ..
		"list[current_player;main;0,2.85;8,1]" ..
		"list[current_player;main;0,4.08;8,3;8]" ..
		"listring[current_name;main]" ..
		"listring[current_player;main]"
	return formspec
end

minetest.register_craftitem("earthbuild:storage_pot_unfired", {
	description = "Unfired Clay Storage Pot",
	inventory_image = "earthbuild_storage_pot_unfired.png",
	stack_max = 99,
})
minetest.register_craft({
	output = "earthbuild:storage_pot_unfired",
	recipe = {
		{"default:clay_lump", "default:clay_lump", "default:clay_lump"},
		{"default:clay_lump", "", "default:clay_lump"},
		{"default:clay_lump", "default:clay_lump", "default:clay_lump"},
	}
})
minetest.register_craft({
	output = "default:clay_lump 8",
	recipe = {
		{"earthbuild:storage_pot_unfired"}}
})

minetest.register_node("earthbuild:storage_pot", {
	description = "Clay Storage Pot",
	tiles = {"earthbuild_storage_pot_top.png",
		"earthbuild_storage_pot_top.png",
		"earthbuild_storage_pot.png",
		"earthbuild_storage_pot.png",
		"earthbuild_storage_pot.png"},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.375, -0.5, -0.375, 0.375, -0.375, 0.375},
				{-0.375, 0.375, -0.375, 0.375, 0.5, 0.375},
				{-0.4375, -0.375, -0.4375, 0.4375, -0.25, 0.4375},
				{-0.4375, 0.25, -0.4375, 0.4375, 0.375, 0.4375},
				{-0.5, -0.25, -0.5, 0.5, 0.25, 0.5},
			}
		},
	groups = {oddly_breakable_by_hand = 3},
	sounds = default.node_sound_stone_defaults(),

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_storage_formspec(pos, 8, 2))
		local inv = meta:get_inventory()
		inv:set_size("main", 8*3)
		meta:set_string("infotext", "Clay Storage Pot")
	end,

	can_dig = function(pos, player)
		local inv = minetest.get_meta(pos):get_inventory()
		local name = ""
		if player then
			name = player:get_player_name()
		end
		return is_owner(pos, name) and inv:is_empty("main")
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if is_owner(pos, player:get_player_name()) then
			return count
		end
		return 0
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if is_owner(pos, player:get_player_name())
		and not string.match(stack:get_name(), "backpacks:") then
			return stack:get_count()
		end
		return 0
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if is_owner(pos, player:get_player_name()) then
			return stack:get_count()
		end
		return 0
	end,

	on_blast = function(pos)
	end,
})
minetest.register_craft({
	type = "cooking",
	output = "earthbuild:storage_pot",
	recipe = "earthbuild:storage_pot_unfired",
	cooktime = 10,
})
]]--
