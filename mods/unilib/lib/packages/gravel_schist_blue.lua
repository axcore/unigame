---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_schist_blue = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_schist_blue.init()

    return {
        description = "Blue schist gravel",
    }

end

function unilib.pkg.gravel_schist_blue.exec()

    unilib.register_node("unilib:gravel_schist_blue", nil, mode, {
        -- Texture from UGBC, blueschist_gravel.png. Original code
        description = S("Blue Schist Gravel"),
        tiles = {"unilib_gravel_schist_blue.png"},
        groups = {crumbly = 3, falling_node = 1, gravel = 1},
        sounds = unilib.global.sound_table.gravel,
    })

    if unilib.setting.squeezed_gravel_flag then

        unilib.register_node("unilib:gravel_schist_blue_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Blue Schist Gravel"),
            tiles = {"unilib_gravel_schist_blue_compressed.png"},
            groups = {compressedgravel = 1, crumbly = 2},
            sounds = unilib.global.sound_table.gravel,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_squeezed_recipes(
            -- Original to unilib
            "unilib:gravel_schist_blue", "unilib:gravel_schist_blue_compressed"
        )

    end

end
