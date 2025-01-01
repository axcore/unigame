---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_mud_mangrove = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_mud_mangrove.init()

    return {
        description = "Mangrove mud",
    }

end

function unilib.pkg.dirt_mud_mangrove.exec()

    unilib.register_node("unilib:dirt_mud_mangrove", "australia:mangrove_mud", mode, {
        -- From australia:mangrove_mud
        description = S("Mangrove Mud"),
        tiles = {"unilib_dirt_mud_mangrove.png"},
        groups = {crumbly = 2, soil = 1},
        sounds = unilib.sound.generate_dirt({
            footstep = {name = "unilib_dirt_mud_mangrove", gain = 0.4},
            dug = {name = "unilib_dirt_mud_mangrove", gain = 0.4},
        }),

        is_ground_content = unilib.setting.caves_chop_dirt_flag,
    })

end
