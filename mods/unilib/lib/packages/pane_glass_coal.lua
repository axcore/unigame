---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_glass_coal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_glass_coal.init()

    return {
        description = "Coal glass pane",
        depends = "glass_coal",
    }

end

function unilib.pkg.pane_glass_coal.exec()

    local img = "unilib_glass_ordinary.png^[colorize:#828282"
    local c_glass = "unilib:glass_coal"

    unilib.register_pane({
        -- Original to unilib. Creates unilib:pane_glass_coal_flat, unilib:pane_glass_coal_crossed
        part_name = "glass_coal",
        orig_name = {},
        def_table = {
            description = S("Coal Glass Pane"),
            textures = {img, "", "unilib_pane_glass_ordinary_edge.png^[colorize:#828282"},
            groups = {cracky = 3, oddly_breakable_by_hand = 3},
            sounds = unilib.sound_table.glass,

            inventory_image = img,
            recipe = {
                {c_glass, c_glass, c_glass},
                {c_glass, c_glass, c_glass},
            },
            wield_image = img,
        },

        replace_mode = mode,
    })

end
