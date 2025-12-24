---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_showcase_butterfly = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_showcase_butterfly.init()

    return {
        description = "Butterfly showcase",
        notes = "Only works with \"large\" butterflies from the \"mob_butterfly_large\" package",
        depends = "pane_glass_ordinary",
    }

end

function unilib.pkg.misc_showcase_butterfly.exec()

    local c_spawnegg = "unilib:spawnegg_butterfly_large"

    unilib.register_node("unilib:misc_showcase_butterfly", "petz:butterfly_showcase", mode, {
        -- From petz:butterfly_showcase
        description = S("Butterfly Showcase"),
        tiles = {"unilib_misc_showcase_butterfly.png"},
        groups = {
            carpet = 1, choppy = 2, flammable = 3, leafdecay = 3, leaves = 1,
            oddly_breakable_by_hand = 3, snappy = 2,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        inventory_image = "unilib_misc_showcase_butterfly.png",
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, 0.49, 0.5, 0.5, 0.5},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        walkable = true,
        wield_image = "unilib_misc_showcase_butterfly.png",
    })
    unilib.register_craft({
        -- From petz:butterfly_showcase
        type = "shaped",
        output = "unilib:misc_showcase_butterfly",
        recipe = {
            {"group:wood", c_spawnegg, "group:wood"},
            {c_spawnegg, "unilib:pane_glass_ordinary_flat", c_spawnegg},
            {"group:wood", c_spawnegg, "group:wood"},
        },
    })

end
