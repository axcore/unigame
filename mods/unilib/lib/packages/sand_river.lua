---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_river = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_river.init()

    return {
        description = "River sand",
    }

end

function unilib.pkg.sand_river.exec()

    unilib.register_node("unilib:sand_river", "aotearoa:river_sand", mode, {
        -- From aotearoa:river_sand
        description = S("River Sand"),
        tiles = {"unilib_sand_river.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,
    })

    if unilib.setting.squeezed_sand_flag then

        unilib.register_node("unilib:sand_river_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed River Sand"),
            tiles = {"unilib_sand_river_compressed.png"},
            groups = {compressedsand = 1, crumbly = 2},
            sounds = unilib.global.sound_table.sand,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        -- Original to unilib
        unilib.misc.set_squeezed_recipes("unilib:sand_river", "unilib:sand_river_compressed")

    end

end
