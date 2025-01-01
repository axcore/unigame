---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_dolostone_dark = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_dolostone_dark.init()

    return {
        description = "Dark dolostone sand",
    }

end

function unilib.pkg.sand_dolostone_dark.exec()

    unilib.register_node("unilib:sand_dolostone_dark", nil, mode, {
        -- Texture from UGBC, dolomite_sand.png. Original code
        description = S("Dark Dolostone Sand"),
        tiles = {"unilib_sand_dolostone_dark.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,
    })

    if unilib.setting.squeezed_sand_flag then

        unilib.register_node("unilib:sand_dolostone_dark_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Dark Dolostone Sand"),
            tiles = {"unilib_sand_dolostone_dark_compressed.png"},
            groups = {compressedsand = 1, crumbly = 2},
            sounds = unilib.global.sound_table.sand,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_squeezed_recipes(
            -- Original to unilib
            "unilib:sand_dolostone_dark", "unilib:sand_dolostone_dark_compressed"
        )

    end

end
