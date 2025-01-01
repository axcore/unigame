---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_chert = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_chert.init()

    return {
        description = "Chert gravel",
    }

end

function unilib.pkg.gravel_chert.exec()

    unilib.register_node("unilib:gravel_chert", nil, mode, {
        -- Texture from UGBC, chert_gravel.png. Original code
        description = S("Chert Gravel"),
        tiles = {"unilib_gravel_chert.png"},
        groups = {crumbly = 3, falling_node = 1, gravel = 1},
        sounds = unilib.global.sound_table.gravel,
    })

    if unilib.setting.squeezed_gravel_flag then

        unilib.register_node("unilib:gravel_chert_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Chert Gravel"),
            tiles = {"unilib_gravel_chert_compressed.png"},
            groups = {compressedgravel = 1, crumbly = 2},
            sounds = unilib.global.sound_table.gravel,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        -- Original to unilib
        unilib.misc.set_squeezed_recipes("unilib:gravel_chert", "unilib:gravel_chert_compressed")

    end

end
