---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_desert_nosoil = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_desert_nosoil.init()

    return {
        description = "Desert sand",
        notes = "To enable farming, use the \"sand_desert\" package instead",
        excludes = "sand_desert",
    }

end

function unilib.pkg.sand_desert_nosoil.exec()

    unilib.register_node("unilib:sand_desert", "default:desert_sand", mode, {
        -- From default:desert_sand
        description = S("Desert Sand"),
        tiles = {"unilib_sand_desert.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
