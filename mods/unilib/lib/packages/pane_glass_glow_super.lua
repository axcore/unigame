---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_glass_glow_super = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_glass_glow_super.init()

    return {
        description = "Super glow glass panes",
        depends = "glass_glow_super",
    }

end

function unilib.pkg.pane_glass_glow_super.exec()

    local glow_img = "unilib_glass_ordinary.png^[colorize:#FFFF78"
    local clean_img = "unilib_glass_clean.png^[colorize:#FFFF78"

    local c_glass = "unilib:glass_glow_super"
    local c_clean = "unilib:glass_glow_super_clean"

    unilib.register_pane({
        -- Original to unilib. Creates unilib:pane_glass_glow_super_flat,
        --      unilib:pane_glass_glow_super_crossed
        part_name = "glass_glow_super",
        orig_name = {},
        def_table = {
            description = S("Super Glow Glass Pane"),
            textures = {glow_img, "", "unilib_pane_glass_ordinary_edge.png^[colorize:#FFFF78"},
            groups = {cracky = 3, oddly_breakable_by_hand = 3, snappy = 2},
            sounds = unilib.global.sound_table.glass,

            inventory_image = glow_img,
            light_source = unilib.constant.light_max,
            recipe = {
                {c_glass, c_glass, c_glass},
                {c_glass, c_glass, c_glass},
            },
            wield_image = glow_img,
        },

        replace_mode = mode,
    })

    unilib.register_pane({
        -- Original to unilib. Creates unilib:pane_glass_glow_super_clean_flat,
        --      unilib:pane_glass_glow_super_clean_crossed
        part_name = "glass_glow_super_clean",
        orig_name = {},
        def_table = {
            description = S("Clean Super Glow Glass Pane"),
            textures = {clean_img, "", "unilib_pane_glass_ordinary_edge.png^[colorize:#FFFF78"},
            groups = {cracky = 3, oddly_breakable_by_hand = 3, snappy = 2},
            sounds = unilib.global.sound_table.glass,

            inventory_image = clean_img,
            light_source = unilib.constant.light_max,
            recipe = {
                {c_clean, c_clean, c_clean},
                {c_clean, c_clean, c_clean},
            },
            wield_image = clean_img,
        },

        replace_mode = mode,
    })

end
