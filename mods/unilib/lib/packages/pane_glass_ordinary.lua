---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xpanes
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_glass_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xpanes.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_glass_ordinary.init()

    return {
        description = "Ordinary glass pane",
        depends = "glass_ordinary",
    }

end

function unilib.pkg.pane_glass_ordinary.exec()

    unilib.register_pane({
        -- From xpanes:pane_flat. Creates unilib:pane_glass_ordinary_flat,
        --      unilib:pane_glass_ordinary_crossed
        part_name = "glass_ordinary",
        orig_name = {"xpanes:pane", "xpanes:pane_flat"},
        def_table = {
            description = S("Ordinary Glass Pane"),
            textures = {"unilib_glass_ordinary.png", "", "unilib_pane_glass_ordinary_edge.png"},
            groups = {cracky = 3, oddly_breakable_by_hand = 3, snappy = 2},
            sounds = unilib.sound_table.glass,

            inventory_image = "unilib_glass_ordinary.png",
            recipe = {
                {"unilib:glass_ordinary", "unilib:glass_ordinary", "unilib:glass_ordinary"},
                {"unilib:glass_ordinary", "unilib:glass_ordinary", "unilib:glass_ordinary"},
            },
            wield_image = "unilib_glass_ordinary.png",
        },

        replace_mode = mode,
    })

end
