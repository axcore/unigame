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
minetest.register_node("vallee_des_roses:brittle_poppy", {
    description = "A Brittle Poppy Flower",
    drawtype = "plantlike",
    -- Only one texture used
    tiles = {"vallee_des_roses_brittle_poppy.png"},

    selection_box = {
        type = "fixed",
        fixed = {-4 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
    },
    walkable = false,
	buildable_to = true,
})
]]--
