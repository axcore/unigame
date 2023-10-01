---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_ordinary_with_turf_forest = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_ordinary_with_turf_forest.init()

    return {
        description = "Ordinary dirt with forest turf",
        depends = "dirt_ordinary",
        optional = "soil_ordinary",
    }

end

function unilib.pkg.dirt_ordinary_with_turf_forest.exec()

    unilib.register_dirt_with_turf({
        -- From farlands, mapgen:dirt_with_junglegrass. Creates
        --      unilib:dirt_ordinary_with_turf_forest
        dirt_part_name = "dirt_ordinary",
        turf_part_name = "turf_forest",
        orig_name = "mapgen:dirt_with_junglegrass",
        def_table = {
            description = S("Ordinary Dirt with Forest Turf"),
            tiles = {
                "unilib_turf_forest_top.png",
                "unilib_dirt_ordinary.png",
                "unilib_dirt_ordinary.png^unilib_turf_forest_side.png",
            },
            groups = {crumbly = 3},
            sounds = unilib.sound_table.dirt,

            -- N.B. Not in original code
            drop = "unilib:dirt_ordinary",
            is_ground_content = unilib.caves_chop_dirt_flag,
        },

        replace_mode = mode,
        -- N.B. Not in original code
        dry_soil = "unilib:soil_ordinary",
        wet_soil = "unilib:soil_ordinary_wet",
        turf_description = S("Forest Turf"),
    })

end
