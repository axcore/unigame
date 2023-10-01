---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_ordinary.init()

    return {
        description = "Ordinary sand",
    }

end

function unilib.pkg.sand_ordinary.exec()

    unilib.register_node("unilib:sand_ordinary", "default:sand", mode, {
        -- From default:sand
        description = S("Ordinary Sand"),
        tiles = {"unilib_sand_ordinary.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
