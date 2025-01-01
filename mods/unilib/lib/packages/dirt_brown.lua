---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_brown = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_brown.init()

    return {
        description = "Brown dirt",
    }

end

function unilib.pkg.dirt_brown.exec()

    unilib.register_fertile_dirt({
        -- From GLEMr4, lib_materials:dirt_02. Creates unilib:dirt_brown
        part_name = "dirt_brown",
        orig_name = "lib_materials:dirt_02",
        def_table = {
            description = S("Brown Dirt"),
            tiles = {"unilib_dirt_brown.png"},
            groups = {crumbly = 3, soil = 1},
            sounds = unilib.global.sound_table.dirt,

            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        },

        replace_mode = mode,
        compressed_description = S("Compressed Brown Dirt"),
        compressed_group_table = {crumbly = 2},
        dry_soil = "unilib:soil_ordinary",
        wet_soil = "unilib:soil_ordinary_wet",
    })

end
