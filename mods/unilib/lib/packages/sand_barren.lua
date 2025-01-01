---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    badlands
-- Code:    LGPL-3.0
-- Media:   LGPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_barren = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.badlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_barren.init()

    return {
        description = "Barren sand",
    }

end

function unilib.pkg.sand_barren.exec()

    unilib.register_node("unilib:sand_barren", "badlands:red_sand", mode, {
        -- From badlands:red_sand
        description = S("Barren Sand"),
        tiles = {"unilib_sand_ordinary.png^[colorize:sienna:175^[colorize:red:40"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,
    })

end
