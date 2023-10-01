---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
--
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("farming:straw", {
	description = S("Straw"),
	tiles = {"farming_straw.png"},
	is_ground_content = false,
	groups = {snappy=3, flammable=4, fall_damage_add_percent=-30},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_craft({
	output = "farming:straw 3",
	recipe = {
		{"farming:wheat", "farming:wheat", "farming:wheat"},
		{"farming:wheat", "farming:wheat", "farming:wheat"},
		{"farming:wheat", "farming:wheat", "farming:wheat"},
	}
})
minetest.register_craft({
	output = "farming:wheat 3",
	recipe = {
		{"farming:straw"},
	}
})
-- Registered before the stairs so the stairs get fuel recipes.
minetest.register_craft({
	type = "fuel",
	recipe = "farming:straw",
	burntime = 3,
})

do
    local recipe = "farming:straw"
    local groups = {snappy = 3, flammable = 4}
    local images = {"farming_straw.png"}
    local sounds = default.node_sound_leaves_defaults()
--
    stairs.register_stair("straw", recipe, groups, images, S("Straw Stair"),
        sounds, true)
    stairs.register_stair_inner("straw", recipe, groups, images, "",
        sounds, true, S("Inner Straw Stair"))
    stairs.register_stair_outer("straw", recipe, groups, images, "",
        sounds, true, S("Outer Straw Stair"))
    stairs.register_slab("straw", recipe, groups, images, S("Straw Slab"),
        sounds, true)
end

minetest.register_node("darkage:straw_bale", {
	description = "Straw Bale",
	tiles = {"darkage_straw_bale.png"},
	is_ground_content = false,
	drop = 'farming:straw 4',
	groups = {snappy=2, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_craft({
	output = "darkage:straw_bale",
	recipe = {
		{"farming:straw","farming:straw"},
		{"farming:straw","farming:straw"},
	}
})
]]--
