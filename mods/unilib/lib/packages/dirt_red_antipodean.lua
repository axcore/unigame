---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_red_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_red_antipodean.init()

    return {
        description = "Antipodean red dirt",
    }

end

function unilib.pkg.dirt_red_antipodean.exec()

    unilib.register_node("unilib:dirt_red_antipodean", "australia:red_dirt", mode, {
        -- From australia:red_dirt
        description = S("Antipodean Red Dirt"),
        tiles = {"unilib_dirt_red_antipodean.png"},
        groups = {crumbly = 3, soil = 1},
        sounds = unilib.sound_table.dirt,

        is_ground_content = unilib.caves_chop_dirt_flag,
    })

end
