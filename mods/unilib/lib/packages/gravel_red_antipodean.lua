---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_red_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_red_antipodean.init()

    return {
        description = "Antipodean red gravel",
    }

end

function unilib.pkg.gravel_red_antipodean.exec()

    unilib.register_node("unilib:gravel_red_antipodean", "australia:red_gravel", mode, {
        -- From australia:red_gravel
        description = S("Antipodean Red Gravel"),
        tiles = {"unilib_gravel_red_antipodean.png"},
        groups = {crumbly = 2, falling_node = 1},
        sounds = unilib.node_sound_dirt_defaults({
            footstep = {name = "unilib_gravel_footstep", gain = 0.5},
            dug = {name = "unilib_gravel_footstep", gain = 1.0},
        }),
    })

end
