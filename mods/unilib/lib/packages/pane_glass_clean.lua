---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_glass_clean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_glass_clean.init()

    return {
        description = "Clean glass pane",
        depends = "glass_clean",
    }

end

function unilib.pkg.pane_glass_clean.exec()

    unilib.register_pane({
        -- Original to unilib. Creates unilib:pane_glass_clean_flat,
        --      unilib:pane_glass_clean_crossed
        part_name = "glass_clean",
        orig_name = {},
        def_table = {
            description = S("Clean Glass Pane"),
            textures = {"unilib_glass_clean.png", "", "unilib_pane_glass_ordinary_edge.png"},
            groups = {cracky = 3, oddly_breakable_by_hand = 3, snappy = 2},
            sounds = unilib.sound_table.glass,

            inventory_image = "unilib_glass_clean.png",
            recipe = {
                {"unilib:glass_clean", "unilib:glass_clean", "unilib:glass_clean"},
                {"unilib:glass_clean", "unilib:glass_clean", "unilib:glass_clean"},
            },
            wield_image = "unilib_glass_clean.png",
        },

        replace_mode = mode,
    })

end
