---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_peat = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_peat.init()

    return {
        description = "Peat",
    }

end

function unilib.pkg.dirt_peat.exec()

    unilib.register_node("unilib:dirt_peat", "real_minerals:peat", mode, {
        -- From real_minerals:peat
        description = S("Peat"),
        tiles = {"unilib_dirt_peat.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.sound_table.dirt,

        is_ground_content = unilib.caves_chop_dirt_flag,
    })
    unilib.register_craft({
        -- From real_minerals:peat
        type = "fuel",
        recipe = "unilib:dirt_peat",
        burntime = 15,
    })

end
