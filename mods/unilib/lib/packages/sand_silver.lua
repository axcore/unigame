---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_silver = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_silver.init()

    return {
        description = "Silver sand",
    }

end

function unilib.pkg.sand_silver.exec()

    unilib.register_node("unilib:sand_silver", "default:silver_sand", mode, {
        -- From default:silver_sand
        description = S("Silver Sand"),
        tiles = {"unilib_sand_silver.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
