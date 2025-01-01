---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_glauconite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_glauconite.init()

    return {
        description = "Glauconite sand",
    }

end

function unilib.pkg.sand_glauconite.exec()

    unilib.register_node("unilib:sand_glauconite", nil, mode, {
        -- Texture from PFAA, weakOreSand_glauconite.png. Original code
        description = S("Glauconite Sand"),
        tiles = {"unilib_sand_glauconite.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,
    })

    if unilib.setting.squeezed_sand_flag then

        unilib.register_node("unilib:sand_glauconite_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Glauconite Sand"),
            tiles = {"unilib_sand_glauconite_compressed.png"},
            groups = {compressedsand = 1, crumbly = 2},
            sounds = unilib.global.sound_table.sand,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_squeezed_recipes(
            -- Original to unilib
            "unilib:sand_glauconite", "unilib:sand_glauconite_compressed"
        )

    end

end
