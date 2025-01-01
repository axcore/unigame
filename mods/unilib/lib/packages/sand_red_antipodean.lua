---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_red_antipodean = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_red_antipodean.init()

    return {
        description = "Antipodean red sand",
    }

end

function unilib.pkg.sand_red_antipodean.exec()

    unilib.register_node("unilib:sand_red_antipodean", "australia:red_sand", mode, {
        -- From australia:red_sand
        description = S("Antipodean Red Sand"),
        tiles = {"unilib_sand_red_antipodean.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,
    })

    if unilib.setting.squeezed_sand_flag then

        unilib.register_node("unilib:sand_red_antipodean_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Antipodean Red Sand"),
            tiles = {"unilib_sand_red_antipodean_compressed.png"},
            groups = {compressedsand = 1, crumbly = 2},
            sounds = unilib.global.sound_table.sand,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_squeezed_recipes(
            -- Original to unilib
            "unilib:sand_red_antipodean", "unilib:sand_red_antipodean_compressed"
        )

    end

end
