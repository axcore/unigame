---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_glass_ornamental_tiles_pale = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_glass_ornamental_tiles_pale.init()

    return {
        description = "Ornamental glass pane with pale tiles",
        depends = "glass_ornamental_tiles_pale",
    }

end

function unilib.pkg.pane_glass_ornamental_tiles_pale.exec()

    local img = "unilib_glass_ornamental_tiles_pale.png"
    local c_glass = "unilib:glass_ornamental_tiles_pale"

    unilib.register_pane({
        -- Original to unilib. Creates unilib:pane_glass_ornamental_tiles_pale_flat,
        --      unilib:pane_glass_ornamental_tiles_pale_crossed
        part_name = "glass_ornamental_tiles_pale",
        orig_name = {},
        def_table = {
            description = unilib.utils.brackets(S("Ornamental Glass Pane"), S("Pale Tiles")),
            textures = {img, "", "unilib_pane_glass_ordinary_edge.png"},
            groups = {cracky = 3},
            sounds = unilib.global.sound_table.glass,

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
