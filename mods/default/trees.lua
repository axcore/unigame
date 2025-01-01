-- default/trees.lua

-- support for MT game translation.
local S = default.get_translator

local random = math.random

--
-- Grow trees from saplings
--

-- 'can grow' function

function default.can_grow(pos)
	local node_under = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
	if not node_under then
		return false
	end
	if minetest.get_item_group(node_under.name, "soil") == 0 then
		return false
	end
	local light_level = minetest.get_node_light(pos)
	if not light_level or light_level < 13 then
		return false
	end
	return true
end

function default.on_grow_failed(pos)
	minetest.get_node_timer(pos):start(300)
end


--
-- Sapling 'on place' function to check protection of node and resulting tree volume
--

function default.sapling_on_place(itemstack, placer, pointed_thing,
		sapling_name, minp_relative, maxp_relative, interval)
	-- Position of sapling
	local pos = pointed_thing.under
	local node = minetest.get_node_or_nil(pos)
	local pdef = node and minetest.registered_nodes[node.name]

	if pdef and pdef.on_rightclick and
			not (placer and placer:is_player() and
			placer:get_player_control().sneak) then
		return pdef.on_rightclick(pos, node, placer, itemstack, pointed_thing)
	end

	if not pdef or not pdef.buildable_to then
		pos = pointed_thing.above
		node = minetest.get_node_or_nil(pos)
		pdef = node and minetest.registered_nodes[node.name]
		if not pdef or not pdef.buildable_to then
			return itemstack
		end
	end

	local player_name = placer and placer:get_player_name() or ""
	-- Check sapling position for protection
	if minetest.is_protected(pos, player_name) then
		minetest.record_protection_violation(pos, player_name)
		return itemstack
	end
	-- Check tree volume for protection
	if minetest.is_area_protected(
			vector.add(pos, minp_relative),
			vector.add(pos, maxp_relative),
			player_name,
			interval) then
		minetest.record_protection_violation(pos, player_name)
		-- Print extra information to explain
		minetest.chat_send_player(player_name,
		    S("@1 will intersect protection on growth.",
			itemstack:get_definition().description))
		return itemstack
	end

	if placer then
		default.log_player_action(placer, "places node", sapling_name, "at", pos)
	end

	local take_item = not minetest.is_creative_enabled(player_name)
	local newnode = {name = sapling_name}
	local ndef = minetest.registered_nodes[sapling_name]
	minetest.set_node(pos, newnode)

	-- Run callback
	if ndef and ndef.after_place_node then
		-- Deepcopy place_to and pointed_thing because callback can modify it
		if ndef.after_place_node(table.copy(pos), placer,
				itemstack, table.copy(pointed_thing)) then
			take_item = false
		end
	end

	-- Run script hook
	for _, callback in ipairs(minetest.registered_on_placenodes) do
		-- Deepcopy pos, node and pointed_thing because callback can modify them
		if callback(table.copy(pos), table.copy(newnode),
				placer, table.copy(node or {}),
				itemstack, table.copy(pointed_thing)) then
			take_item = false
		end
	end

	if take_item then
		itemstack:take_item()
	end

	return itemstack
end

-- Grow sapling

default.sapling_growth_defs = {}

function default.register_sapling_growth(name, def)
	default.sapling_growth_defs[name] = {
		can_grow = def.can_grow or default.can_grow,
		on_grow_failed = def.on_grow_failed or default.on_grow_failed,
        -- @@@ Removed the assert() as it causes an instant crash
--		grow = assert(def.grow)
		grow = def.grow
	}
end

function default.grow_sapling(pos)
	local node = minetest.get_node(pos)
	local sapling_def = default.sapling_growth_defs[node.name]

	if not sapling_def then
		minetest.log("warning", "default.grow_sapling called on undefined sapling " .. node.name)
		return
	end

	if not sapling_def.can_grow(pos) then
		sapling_def.on_grow_failed(pos)
		return
	end

	minetest.log("action", "Growing sapling " .. node.name .. " at " .. minetest.pos_to_string(pos))
	sapling_def.grow(pos)
end

local function register_sapling_growth(nodename, grow)
	default.register_sapling_growth("default:" .. nodename, {grow = grow})
end

if minetest.get_mapgen_setting("mg_name") == "v6" then
	register_sapling_growth("sapling", function(pos)
		default.grow_tree(pos, random(1, 4) == 1)
	end)
	register_sapling_growth("junglesapling", default.grow_jungle_tree)
	register_sapling_growth("pine_sapling", function(pos)
		local snow = is_snow_nearby(pos)
		default.grow_pine_tree(pos, snow)
	end)
else
	register_sapling_growth("sapling", default.grow_new_apple_tree)
	register_sapling_growth("junglesapling", default.grow_new_jungle_tree)
	register_sapling_growth("pine_sapling", function(pos)
		local snow = is_snow_nearby(pos)
		if snow then
			default.grow_new_snowy_pine_tree(pos)
		else
			default.grow_new_pine_tree(pos)
		end
	end)
end
