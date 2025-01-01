---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_custom_antipodean = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_custom_antipodean.generate_ordinary_dirt(part_name, turf_description, rgba)

    return unilib.register_dirt_with_turf({
        -- Original to unilib
        dirt_part_name = "dirt_ordinary",
        turf_part_name = "turf_" .. part_name,
        orig_name = nil,
        def_table = {
            description = S("@1 with @2", S("Ordinary Dirt"), turf_description),
            tiles = {
                "unilib_turf_custom_dry_top.png^[colorize:" .. rgba,
                "unilib_dirt_ordinary.png",
                "unilib_dirt_ordinary.png" ..
                        "^(unilib_turf_custom_dry_side_overlay.png^[colorize:" .. rgba .. ")",
            },
            groups = {crumbly = 3, not_in_creative_inventory = unilib.hide_covered_dirt_group},
            sounds = unilib.global.sound_table.dirt,

            drop = "unilib:dirt_ordinary",
            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        },

        replace_mode = mode,
        -- N.B. Not in original code
        dry_soil = "unilib:soil_ordinary",
        wet_soil = "unilib:soil_ordinary_wet",
        turf_description = turf_description,
    })

end

function unilib.pkg.dirt_custom_antipodean.generate_antipodean_dirt(
    part_name, turf_description, rgba
)
    return unilib.register_dirt_with_turf({
        -- Original to unilib
        dirt_part_name = "dirt_antipodean",
        turf_part_name = "turf_" .. part_name,
        orig_name = nil,
        def_table = {
            description = S("@1 with @2", S("Antipodean Dirt"), turf_description),
            tiles = {
                "unilib_turf_custom_top.png^[colorize:" .. rgba,
                "unilib_dirt_antipodean.png",
                "unilib_dirt_antipodean.png" ..
                        "^(unilib_turf_custom_side_overlay.png^[colorize:" .. rgba .. ")",
            },
            groups = {crumbly = 3, not_in_creative_inventory = unilib.hide_covered_dirt_group},
            sounds = unilib.global.sound_table.dirt,

            drop = "unilib:dirt_antipodean",
            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        },

        replace_mode = mode,
        -- N.B. Not in original code
        dry_soil = "unilib:soil_ordinary",
        wet_soil = "unilib:soil_ordinary_wet",
        turf_description = turf_description,
    })

end

function unilib.pkg.dirt_custom_antipodean.generate_dark_antipodean_dirt(
    part_name, turf_description, rgba
)
    return unilib.register_dirt_with_turf({
        -- Original to unilib
        dirt_part_name = "dirt_antipodean_dark",
        turf_part_name = "turf_" .. part_name,
        orig_name = nil,
        def_table = {
            description = S("@1 with @2", S("Dark Antipodean Dirt"), turf_description),
            tiles = {
                "unilib_turf_custom_coastal_top.png^[colorize:" .. rgba,
                "unilib_dirt_antipodean_dark.png",
                "unilib_dirt_antipodean_dark.png" ..
                        "^(unilib_turf_custom_coastal_side_overlay.png^[colorize:" .. rgba .. ")",
            },
            groups = {crumbly = 3, not_in_creative_inventory = unilib.hide_covered_dirt_group},
            sounds = unilib.global.sound_table.dirt,

            drop = "unilib:dirt_antipodean_dark",
            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        },

        replace_mode = mode,
        -- N.B. Not in original code
        dry_soil = "unilib:soil_ordinary",
        wet_soil = "unilib:soil_ordinary_wet",
        turf_description = turf_description,
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_custom_antipodean.init()

    return {
        description = "Creates various dirts with various turf covers for the \"australia\" and" ..
                " \"aotearoa\" remixes",
        notes = "Many biomes in the \"australia\" mod (and to a lesser extent in the" ..
                " \"aotearoa\" mod) look the same, because they over-use dirt-with-turf nodes" ..
                " from minetest_game, instead of creating their own unique dirt-with-turfs." ..
                " If this package is loaded, the familiar dirts are replaced by custom ones," ..
                " a different one for each biome; if not, both remixes continue using" ..
                " minetest_game dirt_with_turfs as before",
        depends = {"dirt_antipodean", "dirt_antipodean_dark"},
    }

end
