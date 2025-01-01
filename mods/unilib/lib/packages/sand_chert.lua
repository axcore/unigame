---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_chert = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_chert.init()

    return {
        description = "Chert sand",
    }

end

function unilib.pkg.sand_chert.exec()

    unilib.register_node("unilib:sand_chert", nil, mode, {
        -- Texture from UGBC, chert_sand.png. Original code
        description = S("Chert Sand"),
        tiles = {"unilib_sand_chert.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,
    })

    if unilib.setting.squeezed_sand_flag then

        unilib.register_node("unilib:sand_chert_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Chert Sand"),
            tiles = {"unilib_sand_chert_compressed.png"},
            groups = {compressedsand = 1, crumbly = 2},
            sounds = unilib.global.sound_table.sand,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        -- Original to unilib
        unilib.misc.set_squeezed_recipes("unilib:sand_chert", "unilib:sand_chert_compressed")

    end

end
