---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_mossy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_mossy.init()

    return {
        description = "Mossy dirt",
    }

end

function unilib.pkg.dirt_mossy.exec()

    unilib.register_node("unilib:dirt_mossy", "underch:mossy_dirt", mode, {
        -- From underch:mossy_dirt
        description = S("Mossy Dirt"),
        tiles = {"unilib_dirt_mossy.png"},
        groups = {crumbly = 3, soil = 1},
        sounds = unilib.sound_table.dirt,

        is_ground_content = unilib.caves_chop_dirt_flag,
    })
    unilib.register_stairs("unilib:dirt_mossy")

end
