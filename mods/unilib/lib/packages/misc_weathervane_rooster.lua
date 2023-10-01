---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_weathervane_rooster = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_weathervane_rooster.init()

    return {
        description = "Rooster weathervane",
        depends = "metal_gold",
    }

end

function unilib.pkg.misc_weathervane_rooster.exec()

    unilib.register_node("unilib:misc_weathervane_rooster", "xdecor:rooster", mode, {
        -- From xdecor:rooster
        description = S("Rooster Weathervane"),
        tiles = {"unilib_misc_weathervane_rooster.png"},
        groups = {attached_node = 1, snappy = 3},
        sounds = unilib.sound_table.node,

        drawtype = "torchlike",
        inventory_image = "unilib_misc_weathervane_rooster.png",
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        walkable = false,
    })
    unilib.register_craft({
        -- From xdecor:rooster
        output = "unilib:misc_weathervane_rooster",
        recipe = {
            {"unilib:metal_gold_ingot", "", "unilib:metal_gold_ingot"},
            {"", "unilib:metal_gold_ingot", ""},
            {"unilib:metal_gold_ingot", "", "unilib:metal_gold_ingot"},
        },
    })

end
