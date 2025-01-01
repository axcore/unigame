---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_silica = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr6.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_silica.init()

    return {
        description = "Silica sand",
    }

end

function unilib.pkg.sand_silica.exec()

    unilib.register_node("unilib:sand_silica", "lib_materials:sand_white", mode, {
        -- From GLEMr6, lib_materials:sand_white
        description = S("Silica Sand"),
        tiles = {"unilib_sand_silica.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,
    })

    if unilib.setting.squeezed_sand_flag then

        unilib.register_node("unilib:sand_silica_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Silica Sand"),
            tiles = {"unilib_sand_silica_compressed.png"},
            groups = {compressedsand = 1, crumbly = 2},
            sounds = unilib.global.sound_table.sand,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        -- Original to unilib
        unilib.misc.set_squeezed_recipes("unilib:sand_silica", "unilib:sand_silica_compressed")

    end

end
