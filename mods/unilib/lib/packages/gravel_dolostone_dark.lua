---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_dolostone_dark = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_dolostone_dark.init()

    return {
        description = "Dark dolostone gravel",
    }

end

function unilib.pkg.gravel_dolostone_dark.exec()

    unilib.register_node("unilib:gravel_dolostone_dark", nil, mode, {
        -- Texture from UGBC, dolomite_gravel.png. Original code
        description = S("Dark Dolostone Gravel"),
        tiles = {"unilib_gravel_dolostone_dark.png"},
        groups = {crumbly = 3, falling_node = 1, gravel = 1},
        sounds = unilib.global.sound_table.gravel,
    })

    if unilib.setting.squeezed_gravel_flag then

        unilib.register_node("unilib:gravel_dolostone_dark_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Dark Dolostone Gravel"),
            tiles = {"unilib_gravel_dolostone_dark_compressed.png"},
            groups = {compressedgravel = 1, crumbly = 2},
            sounds = unilib.global.sound_table.gravel,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_squeezed_recipes(
            -- Original to unilib
            "unilib:gravel_dolostone_dark", "unilib:gravel_dolostone_dark_compressed"
        )

    end

end
