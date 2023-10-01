---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local function get_cheese(rack_type)

	if cheese.astral then
		local event, event_name = astral.get_astral_event()
		if not ( event == nil or event == "none" or  event == "normal" ) then

			if event_name == "Blue Moon" then
				return "cheese:".. producable["mossy"][math.random(1,2)].." "..math.random(3,5) -- only gorgo and stilton

			elseif event_name == "Super Moon" then
				return "cheese:".. producable[rack_type][math.random(#producable[rack_type])].." "..math.random(4,7) -- more of it ;)

			elseif event_name == "Rainbow Sun" then
				return "cheese:".. producable[rack_type][1].." "..math.random(3,5) -- the first in the lists is an italian one

			elseif event_name == "Ring Sun"  or event_name == "Crescent Sun" then -- ring_sun = sun eclipse
				return "cheese:".. producable[rack_type][4].." "..math.random(3,5)
			end
		end
	end
	return "cheese:".. producable[rack_type][math.random(#producable[rack_type])].." "..math.random(2,4)

end

local cheese_rack_empty = {
	description = "Cheese Rack",
	tiles = { "default_wood.png", },
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.4375, 0.5, -0.375, 0.375}, -- base
			{-0.5, 0.375, -0.4375, 0.5, 0.5, 0.375}, -- top
			{-0.5, -0.5, 0.375, 0.5, 0.5, 0.5}, -- back
			{0.375, -0.375, -0.375, 0.5, 0.375, 0.375}, -- right
			{-0.5, -0.375, -0.375, -0.375, 0.375, 0.375}, -- left
			{-0.4375, -0.0625, -0.4375, 0.4375, 0.0625, 0.375}, -- middle
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.4375, 0.5, 0.5, 0.5}, -- selection
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.4375, 0.5, 0.5, 0.5}, -- selection
		}
	},
}

local cheese_rack_with_aging_cheese = {
	description = "Cheese Rack with Aging Cheese",
	tiles = {
		"default_wood.png",
		"default_wood.png",
		"default_wood.png",
		"default_wood.png",
		"default_wood.png",
		"default_wood.png^fresh_cheese_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.4375, 0.5, -0.375, 0.375}, -- base
			{-0.5, 0.375, -0.4375, 0.5, 0.5, 0.375}, -- top
			{-0.5, -0.5, 0.375, 0.5, 0.5, 0.5}, -- back
			{0.375, -0.375, -0.375, 0.5, 0.375, 0.375}, -- right
			{-0.5, -0.375, -0.375, -0.375, 0.375, 0.375}, -- left
			{-0.4375, -0.0625, -0.4375, 0.4375, 0.0625, 0.375}, -- middle
			{-0.375, -0.375, -0.3125, 0.375, 0.375, 0.375}, -- cheese1
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.4375, 0.5, 0.5, 0.5}, -- selection
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.4375, 0.5, 0.5, 0.5}, -- selection
		}
	},
}

local cheese_rack_with_cheese = {
	description = "Cheese Rack with Cheese",
	tiles = {
		"default_wood.png",
		"default_wood.png",
		"default_wood.png",
		"default_wood.png",
		"default_wood.png",
		"default_wood.png^cheese_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.4375, 0.5, -0.375, 0.375}, -- base
			{-0.5, 0.375, -0.4375, 0.5, 0.5, 0.375}, -- top
			{-0.5, -0.5, 0.375, 0.5, 0.5, 0.5}, -- back
			{0.375, -0.375, -0.375, 0.5, 0.375, 0.375}, -- right
			{-0.5, -0.375, -0.375, -0.375, 0.375, 0.375}, -- left
			{-0.4375, -0.0625, -0.4375, 0.4375, 0.0625, 0.375}, -- middle
			{-0.375, -0.375, -0.3125, 0.375, 0.375, 0.375}, -- cheese1
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.4375, 0.5, 0.5, 0.5}, -- selection
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.4375, 0.5, 0.5, 0.5}, -- selection
		}
	},
}

for k, v in pairs(rack_types) do
	cheese_rack_empty.description = S(v[4] .." Cheese Rack")
	cheese_rack_with_aging_cheese.description = S(v[4] .." Cheese Rack with Aging Cheese")
	cheese_rack_with_cheese.description = S(v[4] .." Cheese Rack with Cheese")

	cheese_rack_empty.tiles = {"default_"..v[2]..".png"}
	cheese_rack_with_aging_cheese.tiles = {
		"default_"..v[2]..".png",
		"default_"..v[2]..".png",
		"default_"..v[2]..".png",
		"default_"..v[2]..".png",
		"default_"..v[2]..".png",
		"default_"..v[2]..".png^fresh_cheese_front.png"
	}
	cheese_rack_with_cheese.tiles = {
		"default_"..v[2]..".png",
		"default_"..v[2]..".png",
		"default_"..v[2]..".png",
		"default_"..v[2]..".png",
		"default_"..v[2]..".png",
		"default_"..v[2]..".png^cheese_front.png"
	}
	if v[3] == "wooden" then
		cheese_rack_empty.groups = {choppy = 2, cheese_rack = 1}
		cheese_rack_with_aging_cheese.groups = {choppy = 2, not_in_creative_inventory = 1, cheese_rack = 1 }
		cheese_rack_with_cheese.groups = {choppy = 2, not_in_creative_inventory = 1, cheese_rack = 1 }
	else
		cheese_rack_empty.groups = {cracky = 2, cheese_rack = 1}
		cheese_rack_with_aging_cheese.groups = {cracky = 2, not_in_creative_inventory = 1, cheese_rack = 1 }
		cheese_rack_with_cheese.groups = {cracky = 2, not_in_creative_inventory = 1, cheese_rack = 1 }

		cheese_rack_empty.sounds = default.node_sound_stone_defaults()
		cheese_rack_with_aging_cheese.sounds = default.node_sound_stone_defaults()
		cheese_rack_with_cheese.sounds = default.node_sound_stone_defaults()
	end

	cheese_rack_empty.on_rightclick = function(pos, node, player, itemstack, pointed_thing) -- pointed_thing can be nil when called by a mod :/
		if player:is_player() and itemstack:get_name() == "cheese:curd" then
			itemstack:take_item()
			minetest.sound_play("ftsp_0".. math.random(1, 2) ,
				{pos = pos, max_hear_distance = 8, gain = 0.5})
			minetest.set_node(pos, {name = "cheese:"..v[3].."_cheese_rack_with_aging_cheese", param2 = node.param2})
			local meta = minetest.get_meta(pos)
			meta:set_string("aging", itemstack:get_name())
		end
		return itemstack
	end

	cheese_rack_with_aging_cheese.on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		if meta:get_string("aging") == nil or meta:get_string("aging") == "" then
			meta:set_string("aging", producable[v[3] ][1])
		end
		local timer = minetest.get_node_timer(pos)
		timer:start( v[5] + math.random(-3.0 , 3.0) )
	end

	cheese_rack_with_aging_cheese.on_timer = function(pos)
		if minetest.get_node_light(pos) <= 11 and math.random(1,10) <= 1 then
			local node = minetest.get_node(pos)
			if node.name ~= "ignore" then
				minetest.set_node(pos, {name = "cheese:"..v[3].."_cheese_rack_with_cheese", param2 = node.param2})
				return false
			end
		end
		return true
	end

	cheese_rack_with_cheese.on_punch = function(pos, node, player, pointed_thing)
		local inv
		local leftover
		local given = get_cheese(v[3]) -- returns "cheese:name"

		if player:is_player() then
			minetest.sound_play("ftspw_0".. math.random(1, 3) ,
				{pos = pos, max_hear_distance = 8, gain = 0.5})

			inv = player:get_inventory()
			if inv:room_for_item("main", given) then
				leftover = inv:add_item("main", given)
				if not leftover:is_empty() then
					minetest.add_item(player:get_pos(), leftover)
				end
			else
				minetest.add_item(player:get_pos(), given)
			end
			local node = minetest.get_node(pos)
			minetest.set_node(pos, {name = "cheese:"..v[3].."_cheese_rack_empty", param2 = node.param2})
		end
	end

	cheese_rack_with_aging_cheese.drop = "cheese:"..v[3].."_cheese_rack_empty"
	cheese_rack_with_cheese.drop = "cheese:"..v[3].."_cheese_rack_empty"

	minetest.register_node ("cheese:"..v[3].."_cheese_rack_empty", table.copy(cheese_rack_empty))
	minetest.register_node ("cheese:"..v[3].."_cheese_rack_with_aging_cheese", table.copy(cheese_rack_with_aging_cheese))
	minetest.register_node ("cheese:"..v[3].."_cheese_rack_with_cheese", table.copy(cheese_rack_with_cheese))

	minetest.register_craft({
		output = "cheese:"..v[3].."_cheese_rack_empty",
		recipe = {
			{""..v[1], slab..v[2], ""..v[1]},
			{""..v[1], slab..v[2], ""..v[1]},
			{""..v[1], slab..v[2], ""..v[1]},
		}
	})

end

local craft_type_table = {
	-- type name,					description,				icon
	{"cheese_rack_aging", S("Cheese Rack Aging"), "default_wood.png^cheese_front.png"},
}
-- each register craft recipe is in their own respective file
for k,v in pairs(craft_type_table) do
	if cheese.ui then
		unified_inventory.register_craft_type(v[1], {
		   description = v[2],
		   icon = v[3],
		   width = 1,
		   height = 1,
		   uses_crafting_grid = false
		})
	end
	if cheese.i3 then
		i3.register_craft_type(v[1], {
			description = v[2],
			icon = v[3],
		})
	end
end

for k, v in pairs(cheese.aged_cheeses) do
	local aged = {
		description = S(""..v:gsub("_", " "):gsub("(%a)(%a+)", function(a, b) return string.upper(a) .. string.lower(b) end) ),
		inventory_image = v..".png",
		on_use = minetest.item_eat(2),
		groups = {food = 2, food_cheese = 1},
	}
	minetest.register_craftitem("cheese:"..v, aged )
	if cheese.ui then
		unified_inventory.register_craft({
			type = "cheese_rack_aging",
			items = {"cheese:curd"},
			output = "cheese:"..v
		})
	end
	if cheese.i3 then
		i3.register_craft({
			type = "cheese_rack_aging",
			items = {"cheese:curd"},
			result = "cheese:"..v
		})
	end
end
]]--
