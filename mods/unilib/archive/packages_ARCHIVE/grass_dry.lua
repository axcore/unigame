---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("default:dry_grass_1", {
	description = S("Savanna Grass"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"default_dry_grass_1.png"},
	inventory_image = "default_dry_grass_3.png",
	wield_image = "default_dry_grass_3.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, flora = 1,
		attached_node = 1, grass = 1, dry_grass = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -3 / 16, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random dry grass node
		local stack = ItemStack("default:dry_grass_" .. math.random(1, 5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("default:dry_grass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})
minetest.register_craft({
	type = "fuel",
	recipe = "default:dry_grass_1",
	burntime = 2,
})

for i = 2, 5 do
	minetest.register_node("default:dry_grass_" .. i, {
		description = S("Savanna Grass"),
		drawtype = "plantlike",
		waving = 1,
		tiles = {"default_dry_grass_" .. i .. ".png"},
		inventory_image = "default_dry_grass_" .. i .. ".png",
		wield_image = "default_dry_grass_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1,
			not_in_creative_inventory = 1, grass = 1, dry_grass = 1},
		drop = "default:dry_grass_1",
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -1 / 16, 6 / 16},
		},
	})
end

local function register_dry_grass_decoration(offset, scale, length)
    minetest.register_decoration({
        name = "default:dry_grass_" .. length,
        deco_type = "simple",
        place_on = {"default:dry_dirt_with_dry_grass"},
        sidelen = 16,
        noise_params = {
            offset = offset,
            scale = scale,
            spread = {x = 200, y = 200, z = 200},
            seed = 329,
            octaves = 3,
            persist = 0.6
        },
        biomes = {"savanna"},
        y_max = 31000,
        y_min = 1,
        decoration = "default:dry_grass_" .. length,
    })
end

register_dry_grass_decoration(0.01, 0.05,  5)
register_dry_grass_decoration(0.03, 0.03,  4)
register_dry_grass_decoration(0.05, 0.01,  3)
register_dry_grass_decoration(0.07, -0.01, 2)
register_dry_grass_decoration(0.09, -0.03, 1)
]]--

--[[
for i = 4, 5 do

	if minetest.registered_nodes["default:dry_grass_1"] then

		minetest.override_item("default:dry_grass_" .. i, {
			drop = {
				max_items = 1,
				items = {
					{items = {"farming:seed_barley"}, rarity = 5},
					{items = {"farming:seed_rye"},rarity = 5},
					{items = {"default:dry_grass_1"}}
				}
			}
		})
	end

end
]]--
