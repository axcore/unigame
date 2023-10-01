---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_glass_ornamental_green = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_glass_ornamental_green.init()

    return {
        description = "Green ornamental glass pane",
        depends = "glass_ornamental_green",
    }

end

function unilib.pkg.pane_glass_ornamental_green.exec()

    local img = "unilib_glass_ornamental_green.png"
    local c_glass = "unilib:glass_ornamental_green"

    unilib.register_pane({
        -- Original to unilib. Creates unilib:pane_glass_ornamental_green_flat,
        --      unilib:pane_glass_ornamental_green_crossed
        part_name = "glass_ornamental_green",
        orig_name = {},
        def_table = {
            description = unilib.brackets(S("Ornamental Glass Pane"), S("Green")),
            textures = {img, "", "unilib_pane_glass_ordinary_edge.png"},
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
