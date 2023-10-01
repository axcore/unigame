---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_glass_ornamental_cross = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_glass_ornamental_cross.init()

    return {
        description = "Ornamental glass pane with cross pattern",
        depends = "glass_ornamental_cross",
    }

end

function unilib.pkg.pane_glass_ornamental_cross.exec()

    local img = "unilib_glass_ornamental_cross.png"
    local c_glass = "unilib:glass_ornamental_cross"

    unilib.register_pane({
        -- Original to unilib. Creates unilib:pane_glass_ornamental_cross_flat,
        --      unilib:pane_glass_ornamental_cross_crossed
        part_name = "glass_ornamental_cross",
        orig_name = {},
        def_table = {
            description = unilib.brackets(S("Ornamental Glass Pane"), S("Cross Pattern")),
            textures = {img, "", "unilib_pane_glass_obsidian_edge.png"},
            groups = {cracky = 3},
            sounds = unilib.sound_table.glass,

            inventory_image = img,
            light_source = 5,
            recipe = {
                {c_glass, c_glass, c_glass},
                {c_glass, c_glass, c_glass},
            },
            use_texture_alpha = "blend",
            wield_image = img,
        },

        replace_mode = mode,
    })

end
