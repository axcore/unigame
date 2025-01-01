---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_granite_ebony = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_granite_ebony.init()

    return {
        description = "Ebony granite sand",
    }

end

function unilib.pkg.sand_granite_ebony.exec()

    unilib.register_node("unilib:sand_granite_ebony", nil, mode, {
        -- Texture from UGBC, black_granite_sand.png. Original code
        description = S("Ebony Granite Sand"),
        tiles = {"unilib_sand_granite_ebony.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,
    })

    if unilib.setting.squeezed_sand_flag then

        unilib.register_node("unilib:sand_granite_ebony_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Ebony Granite Sand"),
            tiles = {"unilib_sand_granite_ebony_compressed.png"},
            groups = {compressedsand = 1, crumbly = 2},
            sounds = unilib.global.sound_table.sand,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_squeezed_recipes(
            -- Original to unilib
            "unilib:sand_granite_ebony", "unilib:sand_granite_ebony_compressed"
        )

    end

end
