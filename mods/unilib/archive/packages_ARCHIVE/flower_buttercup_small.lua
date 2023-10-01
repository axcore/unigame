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
minetest.register_node("vallee_des_roses:buttercup", {
    description = "A Buttercup Flower",
    drawtype = "plantlike",
    -- Only one texture used
    tiles = {"vallee_des_roses_buttercup.png"},

    selection_box = {
        type = "fixed",
        fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
    },
    groups = {snappy=3,oddly_breakable_by_hand=3},
    walkable = false,
	buildable_to = true,
    drop = "vallee_des_roses:buttercup"
})

minetest.register_decoration({ -- Buttercup
    deco_type = "simple",
    place_on = {"base:dirt_with_grass"},
    sidelen = 16,
    fill_ratio = 0.06,
    biomes = {"grasslands", "coniferous_forest", "deciduous_forest"},
    y_max = 200,
    y_min = 1,
    decoration = "vallee_des_roses:buttercup",
})
]]--
