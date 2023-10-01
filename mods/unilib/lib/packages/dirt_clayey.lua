---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_clayey = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.valleys_c.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_clayey.init()

    return {
        description = "Clayey dirt",
    }

end

function unilib.pkg.dirt_clayey.exec()

    unilib.register_fertile_dirt({
        -- From valleys_c:dirt_clayey. Creates unilib:dirt_clayey
        part_name = "dirt_clayey",
        orig_name = "valleys_c:dirt_clayey",
        def_table = {
            description = S("Clayey Dirt"),
            tiles = {"unilib_dirt_clayey.png"},
            groups = {crumbly = 3, soil = 1},
            sounds = unilib.sound_table.dirt,

            is_ground_content = unilib.caves_chop_dirt_flag,
        },

        replace_mode = mode,
    })

end
