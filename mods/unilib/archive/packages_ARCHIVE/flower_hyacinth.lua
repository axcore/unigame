---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    vallee_des_roses
-- Code:    Unlicense
-- Media:   Unlicense
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("vallee_des_roses:hyacinth", {
    description = "A Hyacinth Flower",
    drawtype = "plantlike",
    -- Only one texture used
    tiles = {"vallee_des_roses_hyacinth.png"},

    selection_box = {
        type = "fixed",
        fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
    },
    groups = {snappy=3,oddly_breakable_by_hand=3},
    walkable = false,
	buildable_to = true,
    drop = "vallee_des_roses:hyacinth"
})

minetest.register_decoration({ -- Hyacinth
    deco_type = "simple",
    place_on = {"base:dirt_with_grass", "base:dirt_with_snow", "base:dirt_with_coniferous_litter"},
    sidelen = 16,
    fill_ratio = 0.1,
    biomes = {"grassy_plains", "snowy_grassland", "taiga"},
    y_max = 200,
    y_min = 1,
    decoration = "vallee_des_roses:hyacinth",
})
]]--
