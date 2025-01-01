---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_gneiss_grey = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_gneiss_grey.init()

    return {
        description = "Grey gneiss gravel",
    }

end

function unilib.pkg.gravel_gneiss_grey.exec()

    unilib.register_node("unilib:gravel_gneiss_grey", nil, mode, {
        -- Texture from UGBC, gneiss_gravel.png. Original code
        description = S("Grey Gneiss Gravel"),
        tiles = {"unilib_gravel_gneiss_grey.png"},
        groups = {crumbly = 3, falling_node = 1, gravel = 1},
        sounds = unilib.global.sound_table.gravel,
    })

    if unilib.setting.squeezed_gravel_flag then

        unilib.register_node("unilib:gravel_gneiss_grey_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Grey Gneiss Gravel"),
            tiles = {"unilib_gravel_gneiss_grey_compressed.png"},
            groups = {compressedgravel = 1, crumbly = 2},
            sounds = unilib.global.sound_table.gravel,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_squeezed_recipes(
            -- Original to unilib
            "unilib:gravel_gneiss_grey", "unilib:gravel_gneiss_grey_compressed"
        )

    end

end
