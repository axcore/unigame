---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_silt_coarse = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.valleys_c.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_silt_coarse.init()

    return {
        description = "Coarse silty dirt",
    }

end

function unilib.pkg.dirt_silt_coarse.exec()

    unilib.register_fertile_dirt({
        -- From valleys_c:silt. Creates unilib:dirt_silt_coarse
        part_name = "dirt_silt_coarse",
        orig_name = "valleys_c:silt",
        def_table = {
            description = S("Coarse Silty Dirt"),
            tiles = {"unilib_dirt_silt_coarse.png"},
            groups = {crumbly = 3},
            sounds = unilib.global.sound_table.dirt,

            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        },

        replace_mode = mode,
        compressed_description = S("Compressed Coarse Silty Dirt"),
        compressed_group_table = {crumbly = 2},
    })

end
