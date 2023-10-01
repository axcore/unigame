---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decoblocks
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_pale = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.decoblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_pale.init()

    return {
        description = "Pale sand",
    }

end

function unilib.pkg.sand_pale.exec()

    -- N.B. orig_name omitted to prevent Minetest alias warning
    unilib.register_node("unilib:sand_pale", nil, mode, {
        -- From decoblocks, default:sand
        description = S("Pale Sand"),
        tiles = {"unilib_sand_pale.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
