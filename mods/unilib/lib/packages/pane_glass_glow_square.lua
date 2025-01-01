---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_glass_glow_square = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_glass_glow_square.init()

    return {
        description = "Square glow glass pane",
        depends = "glass_glow_square",
    }

end

function unilib.pkg.pane_glass_glow_square.exec()

    local img = "unilib_glass_glow_square.png"
    local c_glass = "unilib:glass_glow_square"

    unilib.register_pane({
        -- Original to unilib. Creates unilib:pane_glass_glow_square_flat,
        --      unilib:pane_glass_glow_square_crossed
        part_name = "glass_glow_square",
        orig_name = {},
        def_table = {
            description = S("Square Glow Glass Pane"),
            textures = {img, "", "unilib_pane_glass_obsidian_edge.png"},
            groups = {cracky = 3, oddly_breakable_by_hand = 3},
            sounds = unilib.global.sound_table.glass,

            inventory_image = img,
            light_source = unilib.constant.light_max - 3,
            recipe = {
                {c_glass, c_glass, c_glass},
                {c_glass, c_glass, c_glass},
            },
            wield_image = img,
        },

        replace_mode = mode,
    })

end
