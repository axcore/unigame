---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_komatiite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_komatiite.init()

    return {
        description = "Komatiite sand",
    }

end

function unilib.pkg.sand_komatiite.exec()

    unilib.register_node("unilib:sand_komatiite", nil, mode, {
        -- Texture from UGBC, komatiite_sand.png. Original code
        description = S("Komatiite Sand"),
        tiles = {"unilib_sand_komatiite.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,
    })

    if unilib.setting.squeezed_sand_flag then

        unilib.register_node("unilib:sand_komatiite_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Komatiite Sand"),
            tiles = {"unilib_sand_komatiite_compressed.png"},
            groups = {compressedsand = 1, crumbly = 2},
            sounds = unilib.global.sound_table.sand,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_squeezed_recipes(
            -- Original to unilib
            "unilib:sand_komatiite", "unilib:sand_komatiite_compressed"
        )

    end

end
