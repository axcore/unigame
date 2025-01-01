---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_glass_glow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_glass_glow.init()

    return {
        description = "Glow glass panes",
        depends = "glass_glow",
    }

end

function unilib.pkg.pane_glass_glow.exec()

    local glow_img = "unilib_glass_ordinary.png^[colorize:#E9CD61"
    local clean_img = "unilib_glass_clean.png^[colorize:#E9CD61"

    unilib.register_pane({
        -- Original to unilib. Creates unilib:pane_glass_glow_flat,
        --      unilib:pane_glass_glow_crossed
        part_name = "glass_glow",
        orig_name = {},
        def_table = {
            description = S("Glow Glass Pane"),
            textures = {glow_img, "", "unilib_pane_glass_ordinary_edge.png^[colorize:#E9CD61"},
            groups = {cracky = 3, oddly_breakable_by_hand = 3, snappy = 2},
            sounds = unilib.global.sound_table.glass,

            inventory_image = glow_img,
            recipe = {
                {"unilib:glass_glow", "unilib:glass_glow", "unilib:glass_glow"},
                {"unilib:glass_glow", "unilib:glass_glow", "unilib:glass_glow"},
            },
            wield_image = glow_img,
        },

        replace_mode = mode,
    })

    unilib.register_pane({
        -- Original to unilib. Creates unilib:pane_glass_glow_clean_flat,
        --      unilib:pane_glass_glow_clean_crossed
        part_name = "glass_glow_clean",
        orig_name = {},
        def_table = {
            description = S("Clean Glow Glass Pane"),
            textures = {clean_img, "", "unilib_pane_glass_ordinary_edge.png^[colorize:#E9CD61"},
            groups = {cracky = 3, oddly_breakable_by_hand = 3, snappy = 2},
            sounds = unilib.global.sound_table.glass,

            inventory_image = clean_img,
            recipe = {
                {"unilib:glass_glow_clean", "unilib:glass_glow_clean", "unilib:glass_glow_clean"},
                {"unilib:glass_glow_clean", "unilib:glass_glow_clean", "unilib:glass_glow_clean"},
            },
            wield_image = clean_img,
        },

        replace_mode = mode,
    })

end
