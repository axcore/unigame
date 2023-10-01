---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_vintage
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lantern_vintage = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morelights_vintage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lantern_vintage.init()

    return {
        description = "Vintage lantern",
        depends = {"light_bulb_normal", "pane_glass_ordinary", "tree_jungle"}
    }

end

function unilib.pkg.light_lantern_vintage.exec()

    local c_pane = "unilib:pane_glass_ordinary_flat"
    local c_wood = "unilib:tree_jungle_wood"

    unilib.register_node("unilib:light_lantern_vintage", "morelights_vintage:block", mode, {
        -- From morelights_vintage:block
        description = S("Vintage Lantern"),
        tiles = {"unilib_light_lantern_vintage.png^unilib_light_lantern_vintage_overlay.png"},
        groups = {cracky = 2, handy = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.glass,

        light_source = unilib.light_max,
        paramtype = "light",
    })
    unilib.register_craft({
        -- From morelights_vintage:block
        output = "unilib:light_lantern_vintage",
        recipe = {
            {"", c_wood, ""},
            {c_pane, "unilib:light_bulb_normal", c_pane},
            {"", c_wood, ""},
        },
    })

end
