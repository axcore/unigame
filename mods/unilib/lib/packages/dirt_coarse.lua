---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_coarse = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_coarse.init()

    return {
        description = "Coarse dirt",
    }

end

function unilib.pkg.dirt_coarse.exec()

    unilib.register_fertile_dirt({
        -- From farlands, mapgen:coarse_dirt. Creates unilib:dirt_coarse
        part_name = "dirt_coarse",
        orig_name = "mapgen:coarse_dirt",
        def_table = {
            description = S("Coarse Dirt"),
            tiles = {"unilib_dirt_coarse.png"},
            groups = {crumbly = 3},
            sounds = unilib.global.sound_table.dirt,

            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        },

        replace_mode = mode,
        compressed_description = S("Compressed Coarse Dirt"),
        compressed_group_table = {crumbly = 2},
    })

end
