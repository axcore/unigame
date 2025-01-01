---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_schist_green_pale = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_schist_green_pale.init()

    return {
        description = "Pale green schist sand",
    }

end

function unilib.pkg.sand_schist_green_pale.exec()

    unilib.register_node("unilib:sand_schist_green_pale", nil, mode, {
        -- Texture from UGBC, greenschist_sand.png. Original code
        description = S("Pale Green Schist Sand"),
        tiles = {"unilib_sand_schist_green_pale.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,
    })

    if unilib.setting.squeezed_sand_flag then

        unilib.register_node("unilib:sand_schist_green_pale_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Pale Green Schist Sand"),
            tiles = {"unilib_sand_schist_green_pale_compressed.png"},
            groups = {compressedsand = 1, crumbly = 2},
            sounds = unilib.global.sound_table.sand,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_squeezed_recipes(
            -- Original to unilib
            "unilib:sand_schist_green_pale", "unilib:sand_schist_green_pale_compressed"
        )

    end

end
