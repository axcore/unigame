---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("cucina_vegana:flax_roasted", {
	description = S("Flax"),
	inventory_image = "cucina_vegana_flax.png",
	groups = {flammable = 1, string = 1},
})
minetest.register_craft({
	type = "cooking",
	output = "cucina_vegana:flax_roasted",
	recipe = "cucina_vegana:flax",
	cooktime = 10,
})
minetest.register_craft({
	type = "fuel",
	recipe = "cucina_vegana:flax_roasted",
	burntime = 7
})
minetest.register_craft({
	output = "wool:white",
	recipe = {	{"cucina_vegana:flax_roasted", "cucina_vegana:flax_roasted", "cucina_vegana:flax_roasted"},
				{"cucina_vegana:flax_roasted", "cucina_vegana:flax_roasted", "cucina_vegana:flax_roasted"},
			}
})
minetest.register_craft({
	output = "default:paper 4",
	recipe = {	{"default:stone", "cucina_vegana:flax_roasted", "default:stone"},
				{"default:stone", "cucina_vegana:flax_roasted", "default:stone"},
                {"", "bucket:bucket_water", ""},
			},
    replacements = {
                    {"default:stone", "default:stone 4"},
                    {"bucket:bucket_water", "bucket:bucket_empty"},
                    }
})
minetest.register_craft({
	output = "default:paper 4",
	recipe = {	{"default:desert_stone", "cucina_vegana:flax_roasted", "default:desert_stone"},
				{"default:desert_stone", "cucina_vegana:flax_roasted", "default:desert_stone"},
                {"", "bucket:bucket_water", ""},
			},
    replacements = {
                    {"default:desert_stone", "default:desert_stone 4"},
                    {"bucket:bucket_water", "bucket:bucket_empty"},
                    }
})
minetest.register_craft({
	output = "default:paper 4",
	recipe = {	{"default:cobble", "cucina_vegana:flax_roasted", "default:cobble"},
				{"default:cobble", "cucina_vegana:flax_roasted", "default:cobble"},
                {"", "bucket:bucket_water", ""},
			},
    replacements = {
                    {"default:cobble", "default:cobble 4"},
                    {"bucket:bucket_water", "bucket:bucket_empty"},
                    }
})
minetest.register_craft({
	output = "default:paper 4",
	recipe = {	{"default:desert_cobble", "cucina_vegana:flax_roasted", "default:desert_cobble"},
				{"default:desert_cobble", "cucina_vegana:flax_roasted", "default:desert_cobble"},
                {"", "bucket:bucket_water", ""},
			},
    replacements = {
                    {"default:desert_cobble", "default:desert_cobble 4"},
                    {"bucket:bucket_water", "bucket:bucket_empty"},
                    }
})
minetest.register_craft({
	output = "default:paper 4",
	recipe = {	{"default:stone", "cucina_vegana:flax_roasted", "default:stone"},
				{"default:stone", "cucina_vegana:flax_roasted", "default:stone"},
                {"", "bucket:bucket_river_water", ""},
			},
    replacements = {
                    {"default:stone", "default:stone 4"},
                    {"bucket:bucket_river_water", "bucket:bucket_empty"},
                    }
})
minetest.register_craft({
	output = "default:paper 4",
	recipe = {	{"default:desert_stone", "cucina_vegana:flax_roasted", "default:desert_stone"},
				{"default:desert_stone", "cucina_vegana:flax_roasted", "default:desert_stone"},
                {"", "bucket:bucket_river_water", ""},
			},
    replacements = {
                    {"default:desert_stone", "default:desert_stone 4"},
                    {"bucket:bucket_river_water", "bucket:bucket_empty"},
                    }
})
minetest.register_craft({
	output = "default:paper 4",
	recipe = {	{"default:cobble", "cucina_vegana:flax_roasted", "default:cobble"},
				{"default:cobble", "cucina_vegana:flax_roasted", "default:cobble"},
                {"", "bucket:bucket_river_water", ""},
			},
    replacements = {
                    {"default:cobble", "default:cobble 4"},
                    {"bucket:bucket_river_water", "bucket:bucket_empty"},
                    }
})
minetest.register_craft({
	output = "default:paper 4",
	recipe = {	{"default:desert_cobble", "cucina_vegana:flax_roasted", "default:desert_cobble"},
				{"default:desert_cobble", "cucina_vegana:flax_roasted", "default:desert_cobble"},
                {"", "bucket:bucket_river_water", ""},
			},
    replacements = {
                    {"default:desert_cobble", "default:desert_cobble 4"},
                    {"bucket:bucket_river_water", "bucket:bucket_empty"},
                    }
})
minetest.register_craft({
	output = "farming:cotton 2",
	recipe = {
              {"cucina_vegana:flax_roasted","default:stick","cucina_vegana:flax_roasted"},
            },
    replacements = {
                    {"default:stick", "default:stick"},
                },
})

if minetest.get_modpath("ropes") then
	minetest.register_craft({
		output = 'ropes:ropesegment',
		recipe = {
			{'cucina_vegana:flax_roasted','cucina_vegana:flax_roasted'},
			{'cucina_vegana:flax_roasted','cucina_vegana:flax_roasted'},
			{'cucina_vegana:flax_roasted','cucina_vegana:flax_roasted'},
		}
	})

	minetest.register_craft({
		output = 'ropes:rope',
		recipe = {
			{'cucina_vegana:flax_roasted'},
			{'cucina_vegana:flax_roasted'},
		}
	})

end

if minetest.get_modpath("cottages") then
    minetest.register_craft({
        output = "cottages:rope",
        recipe = {
            {"cucina_vegana:flax_roasted","",""},
            {"","cucina_vegana:flax_roasted",""},
            {"","","cucina_vegana:flax_roasted"},
            }
    })

end

if minetest.get_modpath("moreblocks") then
    minetest.register_craft({
        output = "moreblocks:rope 3",
        recipe = {
            {"cucina_vegana:flax_roasted"},
            {"cucina_vegana:flax_roasted"},
            {"cucina_vegana:flax_roasted"},
        }
    })

end
]]--
