---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_sandy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.valleys_c.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_sandy.init()

    return {
        description = "Sandy dirt",
    }

end

function unilib.pkg.dirt_sandy.exec()

    unilib.register_fertile_dirt({
        -- From valleys_c:dirt_sandy. Creates unilib:dirt_sandy
        part_name = "dirt_sandy",
        orig_name = "valleys_c:dirt_sandy",
        def_table = {
            description = S("Sandy Dirt"),
            tiles = {"unilib_dirt_sandy.png"},
            groups = {crumbly = 3, soil = 1},
            sounds = unilib.sound_table.dirt,

            is_ground_content = unilib.caves_chop_dirt_flag,
        },

        replace_mode = mode,
    })

end
