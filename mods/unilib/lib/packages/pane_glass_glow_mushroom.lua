---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_glass_glow_mushroom = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_glass_glow_mushroom.init()

    return {
        description = "Mushroom glow glass pane",
        depends = "glass_glow_mushroom",
    }

end

function unilib.pkg.pane_glass_glow_mushroom.exec()

    local img = "unilib_glass_glow_mushroom.png"
    local c_glass = "unilib:glass_glow_mushroom"

    unilib.register_pane({
        -- Original to unilib. Creates unilib:pane_glass_glow_mushroom_flat,
        --      unilib:pane_glass_glow_mushroom_crossed
        part_name = "glass_glow_mushroom",
        orig_name = {},
        def_table = {
            description = S("Mushroom Glow Glass Pane"),
            textures = {img, "", "unilib_pane_glass_ordinary_edge.png^[colorize:#868200"},
            groups = {cracky = 3, oddly_breakable_by_hand = 3},
            sounds = unilib.sound_table.glass,

            inventory_image = img,
            light_source = 3,
            recipe = {
                {c_glass, c_glass, c_glass},
                {c_glass, c_glass, c_glass},
            },
            wield_image = img,
        },

        replace_mode = mode,
    })

end
