---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_dark.init()

    return {
        description = "Dark dirt",
        depends = {"dirt_ordinary", "gravel_ordinary"},
    }

end

function unilib.pkg.dirt_dark.exec()

    unilib.register_fertile_dirt({
        -- From darkage:darkdirt. Creates unilib:dirt_dark
        part_name = "dirt_dark",
        orig_name = "darkage:darkdirt",
        def_table = {
            description = S("Dark Dirt"),
            tiles = {"unilib_dirt_dark.png"},
            groups = {crumbly = 2},
            sounds = unilib.sound_table.dirt,

            is_ground_content = unilib.caves_chop_dirt_flag,
        },

        replace_mode = mode,
    })
    unilib.register_craft({
        -- From darkage:darkdirt
        output = "unilib:dirt_dark 4",
        recipe = {
            {"unilib:dirt_ordinary", "unilib:dirt_ordinary"},
            {"unilib:gravel_ordinary", "unilib:gravel_ordinary"},
        }
    })

end
