---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_diatomite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_diatomite.init()

    return {
        description = "Diatomite sand",
    }

end

function unilib.pkg.sand_diatomite.exec()

    unilib.register_node("unilib:sand_diatomite", nil, mode, {
        -- Texture from PFAA, weakOreSand_diatomite.png. Original code
        description = S("Diatomite Sand"),
        tiles = {"unilib_sand_diatomite.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,
    })

    if unilib.setting.squeezed_sand_flag then

        unilib.register_node("unilib:sand_diatomite_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Diatomite Sand"),
            tiles = {"unilib_sand_diatomite_compressed.png"},
            groups = {compressedsand = 1, crumbly = 2},
            sounds = unilib.global.sound_table.sand,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_squeezed_recipes(
            -- Original to unilib
            "unilib:sand_diatomite", "unilib:sand_diatomite_compressed"
        )

    end

end
