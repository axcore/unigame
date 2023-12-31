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
	for k, v in pairs(creamable) do
		if item_name == v[1]  then
			return true, v[2]
		elseif minetest.get_item_group( item_name , "food_milk" ) > 0 and minetest.get_item_group( item_name , "food_vegan" ) == 0 then --same as the churn
			return true, v[2]
		end
	end
	return false, "no"
end

local function should_return (item_name)
	if item_name == "moretrees:coconut_milk" or item_name == "cheese:coconut_milk" then
		return "vessels:drinking_glass"
	elseif item_name == "mobs:wooden_bucket_milk" then
		return "wooden_bucket:bucket_wood_empty"
	elseif minetest.get_item_group( item_name , "food_milk") or item_name == "cheese:bucket_cactus" then
		return "bucket:bucket_empty"
	end
	return "no"
end

minetest.register_node("cheese:cream_separator", {
	description = S("Cream Separator"),
	tiles = {
		"cream_separator_top.png",
		"cream_separator_top.png^[transform6",
		"cream_separator_right.png",
		"cream_separator_right.png",
		"cream_separator_front.png^[transform4",
		"cream_separator_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 1, attached_node = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875}, -- base1
			{-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125}, -- base2
			{-0.0625, -0.375, -0.0625, 0.0625, 0.125, 0.0625}, -- spine
			{-0.125, 0.125, -0.125, 0.125, 0.1875, 0.125}, -- topbase
			{-0.125, 0.1875, -0.1875, 0.125, 0.375, -0.125}, -- top1
			{-0.125, 0.1875, 0.125, 0.125, 0.375, 0.1875}, -- top2
			{-0.1875, 0.1875, -0.125, -0.125, 0.375, 0.125}, -- top3
			{0.125, 0.1875, -0.125, 0.1875, 0.375, 0.125}, -- top4
			{-0.125, -0.25, -0.125, 0.125, 0, 0.125}, -- separator
			{0.125, -0.1875, -0.0625, 0.3125, -0.125, 0}, -- lever1
			{0.25, -0.1875, -0.0625, 0.3125, 0, 0}, -- lever2
			{0.25, -0.0625, -0.0625, 0.4375, 0, 0}, -- lever3
			{-0.25, -0.175, -0.0625, -0.125, -0.1875, 0.0625}, -- output1
			{-0.25, -0.125, -0.0625, -0.125, -0.1875, -0.05}, -- output2
			{-0.25, -0.125, 0.0625, -0.125, -0.1875, 0.05}, -- output3
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, 0.375, 0.1875}, -- selection1
			{0.125, -0.1875, -0.0625, 0.3125, -0.125, 0}, -- lever1
			{0.25, -0.1875, -0.0625, 0.3125, 0, 0}, -- lever2
			{0.25, -0.0625, -0.0625, 0.4375, 0, 0}, -- lever3
			{-0.25, -0.125, -0.0625, -0.125, -0.1875, 0.0625}, -- selection3
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, 0.375, 0.1875}, -- selection1
			{0.125, -0.1875, -0.0625, 0.4375, 0, 0}, -- selection2
			{-0.25, -0.125, -0.0625, -0.125, -0.1875, 0.0625}, -- selection3
		}
	},
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		if player:is_player() and itemstack:is_empty() == false then
			local itemname = itemstack:get_name()
			local accettable, given = is_accettable_source(itemname)
			if accettable then

				minetest.sound_play( {name = "splash_0"..math.random(1,2) , pos = pos, max_hear_distance = 14, gain = 1.0, })

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
		meta:set_string('infotext', S('Cream Separator') ..'\n'.. S('Makes cream from milk or whey.'))
	end,
})
minetest.register_craft({
	output = "cheese:cream_separator",
	recipe = {
		{"default:copper_ingot", "", "default:copper_ingot"},
		{"", "default:copperblock", "default:stick"},
		{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
	}
})

if cheese.there_is_milk then
	minetest.register_craftitem("cheese:milk_cream", {
		description = S("Milk Cream"),
		inventory_image = "milk_cream.png",
		groups = {milk_product = 1, food_cream = 1},
	})
	if minetest.registered_items["mobs:wooden_bucket_milk"] then
		table.insert(creamable, {"mobs:wooden_bucket_milk", "cheese:milk_cream 3"})
	end
	table.insert(creamable, {"group:food_milk",	"cheese:milk_cream 3"})
	table.insert(creamable, {"cheese:whey",			"cheese:milk_cream"  })
end

if creamable[1] == nil then
	-- register a default alternative to still get access to cream, and consequently, butter
	minetest.register_craftitem("cheese:cactus_cream", {
		description = S("Cactus Cream"),
		inventory_image = "coconut_cream.png^[colorize:green:30",
		groups = {food_cream = 1, vegan_alternative = 1, food_vegan = 1},
	})
	--definition of bucket_cactus is in fantasy.lua
	table.insert(creamable, {"cheese:bucket_cactus",	"cheese:cactus_cream 2"})
end

local craft_type_table = {
	-- type name,					description,				icon
	{"cauldron_boiling", S("Boiling"), "milk_cauldron_active_side.png"},
	{"cheese_rack_aging", S("Cheese Rack Aging"), "default_wood.png^cheese_front.png"},
	{"churning", S("Churning"), "churn.png"},
	{"centrifugation", S("Centrifugation"), "cream_separator_front.png"},
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
]]--
