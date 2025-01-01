---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_eclogite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_eclogite.init()

    return {
        description = "Eclogite sand",
    }

end

function unilib.pkg.sand_eclogite.exec()

    unilib.register_node("unilib:sand_eclogite", nil, mode, {
        -- Texture from UGBC, eclogite_sand.png. Original code
        description = S("Eclogite Sand"),
        tiles = {"unilib_sand_eclogite.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,
    })

    if unilib.setting.squeezed_sand_flag then

        unilib.register_node("unilib:sand_eclogite_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Eclogite Sand"),
            tiles = {"unilib_sand_eclogite_compressed.png"},
            groups = {compressedsand = 1, crumbly = 2},
            sounds = unilib.global.sound_table.sand,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        -- Original to unilib
        unilib.misc.set_squeezed_recipes("unilib:sand_eclogite", "unilib:sand_eclogite_compressed")

    end

end
