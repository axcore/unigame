---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_icicle = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_icicle.init()

    return {
        description = "Icicle",
    }

end

function unilib.pkg.misc_icicle.exec()

    unilib.register_node("unilib:misc_icicle", "mapgen:icicle", mode, {
        -- From farlands, mapgen:icicle
        description = S("Icicle"),
        tiles = {"unilib_misc_icicle.png"},
        groups = {crumbly = 1, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_misc_icicle.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.3, -0.2, -0.3, 0.3, 0.5, 0.3},
            },
        },
        sunlight_propagates = true,
        walkable = false,
    })

end
