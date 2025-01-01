---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_silt_fine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.valleys_c.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_silt_fine.init()

    return {
        description = "Fine silty dirt",
    }

end

function unilib.pkg.dirt_silt_fine.exec()

    unilib.register_fertile_dirt({
        -- From valleys_c:dirt_silty. Creates unilib:dirt_silt_fine
        part_name = "dirt_silt_fine",
        orig_name = "valleys_c:dirt_silty",
        def_table = {
            description = S("Fine Silty Dirt"),
            tiles = {"unilib_dirt_silt_fine.png"},
            groups = {crumbly = 3, soil = 1},
            sounds = unilib.global.sound_table.dirt,

            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        },

        replace_mode = mode,
        compressed_description = S("Compressed Fine Silty Dirt"),
        compressed_group_table = {crumbly = 2},
    })

end
