---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_basalt_pale = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_basalt_pale.init()

    return {
        description = "Pale basalt gravel",
    }

end

function unilib.pkg.gravel_basalt_pale.exec()

    unilib.register_node("unilib:gravel_basalt_pale", nil, mode, {
        -- Texture from UGBC, basalt_gravel.png. Original code
        description = S("Pale Basalt Gravel"),
        tiles = {"unilib_gravel_basalt_pale.png"},
        groups = {crumbly = 3, falling_node = 1, gravel = 1},
        sounds = unilib.global.sound_table.gravel,
    })

    if unilib.setting.squeezed_gravel_flag then

        unilib.register_node("unilib:gravel_basalt_pale_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Pale Basalt Gravel"),
            tiles = {"unilib_gravel_basalt_pale_compressed.png"},
            groups = {compressedgravel = 1, crumbly = 2},
            sounds = unilib.global.sound_table.gravel,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_squeezed_recipes(
            -- Original to unilib
            "unilib:gravel_basalt_pale", "unilib:gravel_basalt_pale_compressed"
        )

    end

end
