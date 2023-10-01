---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tsm_pyramids
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local trap_on_timer = function(pos, elapsed)
	local n = minetest.get_node(pos)
	if not (n and n.name) then
		return true
	end
	-- Drop trap stone when player is nearby
	local objs = minetest.get_objects_inside_radius(pos, 2)
	for i, obj in pairs(objs) do
		if obj:is_player() then
			if minetest.registered_nodes[n.name]._tsm_pyramids_crack and minetest.registered_nodes[n.name]._tsm_pyramids_crack < 2 then
				-- 70% chance to ignore player to make the time of falling less predictable
				if math.random(1, 10) >= 3 then
					return true
				end
				if n.name == "tsm_pyramids:trap" then
					minetest.set_node(pos, {name="tsm_pyramids:trap_2"})
					minetest.check_for_falling(pos)
				elseif n.name == "tsm_pyramids:desert_trap" then
					minetest.set_node(pos, {name="tsm_pyramids:desert_trap_2"})
					minetest.check_for_falling(pos)
				end
				return true
			end
		end
	end
	return true
end

local register_trap_stone = function(basename, desc_normal, desc_falling, base_tile, drop)
	minetest.register_node("tsm_pyramids:"..basename, {
		description = desc_normal,
		_doc_items_longdesc = S("This brick is old, porous and unstable and is barely able to hold itself. One should be careful not to disturb it."),
		tiles = { base_tile .. "^tsm_pyramids_crack.png" },
		is_ground_content = false,
		groups = {crumbly=3,cracky=3},
		sounds = default.node_sound_stone_defaults(),
		on_construct = function(pos)
			minetest.get_node_timer(pos):start(0.1)
		end,
		_tsm_pyramids_crack = 1,
		on_timer = trap_on_timer,
		drop = drop,
	})

	minetest.register_node("tsm_pyramids:"..basename.."_2", {
		description = desc_falling,
		_doc_items_longdesc = S("This old porous brick falls under its own weight."),
		tiles = { base_tile .. "^tsm_pyramids_crack2.png" },
		is_ground_content = false,
		groups = {crumbly=3,cracky=3,falling_node=1,not_in_creative_inventory=1},
		sounds = default.node_sound_stone_defaults(),
		drop = drop,
	})
end
]]--
