---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_black = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_black.init()

    return {
        description = "Black dirt",
        optional = "soil_ordinary",
    }

end

function unilib.pkg.dirt_black.exec()

    unilib.register_fertile_dirt({
        -- From GLEMr4, lib_materials:dirt_black. Creates unilib:dirt_black
        part_name = "dirt_black",
        orig_name = "lib_materials:dirt_black",
        def_table = {
            description = S("Black Dirt"),
            tiles = {"unilib_dirt_black.png"},
            groups = {crumbly = 3, soil = 1},
            sounds = unilib.sound_table.dirt,

            is_ground_content = unilib.caves_chop_dirt_flag,
        },

        replace_mode = mode,
        dry_soil = "unilib:soil_ordinary",
        wet_soil = "unilib:soil_ordinary_wet",
    })

end
