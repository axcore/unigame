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
local function is_accettable_source(item_name)
	for k, v in pairs(churnable) do
		if item_name == v[1] or (minetest.get_item_group( item_name , "food_milk" ) > 0 and minetest.get_item_group( item_name , "food_vegan" ) == 0) then -- cow milk, not vegan
			return true, v[2]
		end
	end
	return false, "no"
end

local function should_return (item_name) -- only inside the is_accettable_source check therefor there is no need for the food_vegan check
	if item_name == "mobs:wooden_bucket_milk" then
		return "wooden_bucket:bucket_wood_empty"
	elseif minetest.get_item_group( item_name , "food_milk") > 0 then
		return "bucket:bucket_empty"
	end
	return "no"
end

minetest.register_node("cheese:churn", {
	description = S("Churn"),
	tiles = {
		"churn_top.png",
		"churn_bottom.png",
		"churn.png",
		"churn.png",
		"churn.png",
		"churn.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.375, 0.375, -0.3125, 0.375}, -- Bottom
			{-0.3125, -0.3125, -0.3125, 0.3125, -0.125, 0.3125}, -- Middle
			{-0.25, -0.125, -0.25, 0.25, 0.0625, 0.25}, -- Top
			{-0.0625, 0.0625, -0.0625, 0.0625, 0.5, 0.0625}, -- Pole
			{-0.25, 0.0625, -0.25, 0.25, 0.125, -0.1875}, -- Side1
			{-0.25, 0.0625, 0.1875, 0.25, 0.125, 0.25}, -- Side2
			{-0.25, 0.0625, -0.1875, -0.1875, 0.125, 0.1875}, -- Side3
			{0.1875, 0.0625, -0.1875, 0.25, 0.125, 0.1875}, -- Side4
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.375, 0.375, -0.3125, 0.375}, -- Bottom
			{-0.3125, -0.3125, -0.3125, 0.3125, -0.125, 0.3125}, -- Middle
			{-0.25, -0.125, -0.25, 0.25, 0.125, 0.25},
			{-0.0625, 0.0625, -0.0625, 0.0625, 0.5, 0.0625}, -- Pole
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.375, 0.375, -0.3125, 0.375}, -- Bottom
			{-0.3125, -0.3125, -0.3125, 0.3125, -0.125, 0.3125}, -- Middle
			{-0.25, -0.125, -0.25, 0.25, 0.125, 0.25},
			{-0.0625, 0.0625, -0.0625, 0.0625, 0.5, 0.0625}, -- Pole
		}
	},
	groups = {choppy = 2, cracky = 1, attached_node = 1},
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		if player:is_player() and itemstack:is_empty() == false then
			local itemname = itemstack:get_name()
			local accettable, given = is_accettable_source(itemname)
			if accettable then

				minetest.sound_play( {name = "churn".. math.random(1, 3), pos = pos, max_hear_distance = 16, gain = 1.0, })

				local inv = player:get_inventory()
				if inv:room_for_item("main", given) then
					leftover = inv:add_item("main", given)
					itemstack:take_item()
					if not leftover:is_empty() then
						minetest.add_item(player:get_pos(), leftover)
					end
				else
					itemstack:take_item()
					minetest.add_item(player:get_pos(), given)
				end
				local sr = should_return ( itemname )
				if not( sr == "no" )then
					if inv:room_for_item("main", sr) then
						inv:add_item("main", sr)
					else
						minetest.add_item(player:get_pos(), sr)
					end
				end
			end
		end
		return itemstack
	end,
	after_place_node = function(pos, placer, itemstack)
		local meta = minetest.get_meta(pos)
		meta:set_string('infotext', S('Churn') ..'\n'.. S('Makes butter from milk, or milk cream.'))
	end,
	on_rotate = function(pos, node)
		return false
	end,
})
minetest.register_craft({
	output = "cheese:churn",
	recipe = {
		{"", "default:stick", ""},
		{"", "default:wood", ""},
		{"default:wood", "default:steel_ingot", "default:wood"},
	}
})

if cheese.there_is_milk then
	minetest.register_craftitem("cheese:butter", {
		description = S("Butter"),
		inventory_image = "butter.png",
		groups = {milk_product = 1, food_butter = 1},
	})
	if minetest.registered_items["mobs:wooden_bucket_milk"] then
		table.insert(churnable, {"mobs:wooden_bucket_milk", "cheese:butter"})
	end
	table.insert(churnable, {"group:food_milk", 	"cheese:butter"		} )
	table.insert(churnable, {"cheese:milk_cream", "cheese:butter 2" } )
end

table.insert(churnable, {"cheese:vegetable_butter_prep", "cheese:vegetable_butter 2"})

local craft_type_table = {
	-- type name,					description,				icon
	{"churning", S("Churning"), "churn.png"},
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

for k, v in pairs(churnable) do
	if cheese.ui then
		unified_inventory.register_craft({
			type = "churning",
			items = {v[1]},
			output = v[2]
		})
	end -- if ui
	if cheese.i3 then
		i3.register_craft({
			type = "churning",
			items = {v[1]},
			result = v[2]
		})
	end -- if i3
end -- for
]]--
