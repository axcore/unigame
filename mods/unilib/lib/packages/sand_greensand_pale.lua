---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_greensand_pale = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_greensand_pale.init()

    return {
        description = "Pale greensand sand",
    }

end

function unilib.pkg.sand_greensand_pale.exec()

    unilib.register_node("unilib:sand_greensand_pale", nil, mode, {
        -- Original to unilib
        description = S("Pale Greensand Sand"),
        tiles = {"unilib_sand_greensand_pale.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,
    })

    if unilib.setting.squeezed_sand_flag then

        unilib.register_node("unilib:sand_greensand_pale_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Pale Greensand Sand"),
            tiles = {"unilib_sand_greensand_pale_compressed.png"},
            groups = {compressedsand = 1, crumbly = 2},
            sounds = unilib.global.sound_table.sand,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_squeezed_recipes(
            -- Original to unilib
            "unilib:sand_greensand_pale", "unilib:sand_greensand_pale_compressed"
        )

    end

end
