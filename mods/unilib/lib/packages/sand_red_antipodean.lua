---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_red_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

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
        sounds = unilib.sound_table.sand,
    })

end
