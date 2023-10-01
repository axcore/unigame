---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.roof_rustic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.roof_rustic.init()

    return {
        description = "Rustic roofing nodes",
        depends = "shared_cottages",
        optional = {
            "brick_ordinary",
            "dirt_ordinary",
            "material_terracotta",
            "mineral_coal",
            "misc_straw_ordinary",
            "plant_papyrus_ordinary",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.roof_rustic.exec()

    local roof_wood_img = "unilib_tree_apple_trunk.png"
    local roof_side_img = "unilib_tree_apple_wood.png"

    if unilib.pkg_executed_table["misc_straw_ordinary"] ~= nil then

        unilib.pkg.shared_cottages.register_roof({
            -- From cottages:roof_straw, cottages:roof_connector_straw and cottages:roof_flat_straw.
            --      Creates unilib:roof_rustic_straw, unilib:roof_rustic_connector_straw and
            --      unilib:roof_rustic_flat_straw
            part_name = "straw",
            orig_part_name = "straw",
            description = S("Straw"),
            ingredient = "unilib:bed_mat_straw",
            tile_table = {
                "unilib_misc_straw_ordinary.png",
            },

            replace_mode = mode,
        })

    end

    if unilib.pkg_executed_table["plant_papyrus_ordinary"] ~= nil then

        unilib.pkg.shared_cottages.register_roof({
            part_name = "thatch",
            orig_part_name = "reet",
            description = S("Thatch"),
            ingredient = "unilib:plant_papyrus_ordinary",
            tile_table = {
                "unilib_material_thatch.png",
            },

            replace_mode = mode,
        })

    end

    unilib.pkg.shared_cottages.register_roof({
        part_name = "wood",
        orig_part_name = "wood",
        description = S("Wood"),
        ingredient = "group:wood",
        tile_table = {
            roof_wood_img,
            roof_side_img,
            roof_side_img,
            roof_side_img,
            roof_side_img,
            roof_wood_img,
        },

        replace_mode = mode,
    })

    if unilib.pkg_executed_table["mineral_coal"] ~= nil then

        unilib.pkg.shared_cottages.register_roof({
            part_name = "shingles_asphalt",
            orig_part_name = "black",
            description = S("Asphalt Shingles"),
            ingredient = "unilib:mineral_coal_lump",
            tile_table = {
                "unilib_roof_shingles_asphalt.png",
                roof_side_img,
                roof_side_img,
                roof_side_img,
                roof_side_img,
                "unilib_roof_shingles_asphalt.png"
            },

            replace_mode = mode,
            shingles_flag = true,
        })

    end

    if unilib.pkg_executed_table["brick_ordinary"] ~= nil then

        unilib.pkg.shared_cottages.register_roof({
            part_name = "shingles_terracotta",
            orig_part_name = "red",
            description = S("Terracotta Shingles"),
            ingredient = "unilib:brick_ordinary",
            tile_table = {
                "unilib_roof_shingles_terracotta.png",
                roof_side_img,
                roof_side_img,
                roof_side_img,
                roof_side_img,
                "unilib_roof_shingles_terracotta.png"
            },

            replace_mode = mode,
            shingles_flag = true,
        })

        if unilib.pkg_executed_table["material_terracotta"] ~= nil then

            unilib.register_craft({
                -- Original to unilib
                output = "unilib:roof_rustic_shingles_terracotta 3",
                   recipe = {
                    {"unilib:material_terracotta_base", "", "unilib:roof_rustic_wood"},
                    {"", "unilib:roof_rustic_wood", ""},
                    {"unilib:roof_rustic_wood", "", ""}
                }
            })

        end

    end

    if unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.pkg.shared_cottages.register_roof({
            part_name = "shingles_dirt",
            orig_part_name = "brown",
            description = S("Dirt Shingles"),
            ingredient = "unilib:dirt_ordinary",
            tile_table = {
                "unilib_roof_shingles_dirt.png",
                roof_side_img,
                roof_side_img,
                roof_side_img,
                roof_side_img,
                "unilib_roof_shingles_dirt.png"
            },

            replace_mode = mode,
            shingles_flag = true,
        })

    end

    if unilib.pkg_executed_table["stone_ordinary"] ~= nil then

        unilib.pkg.shared_cottages.register_roof({
            part_name = "slate",
            orig_part_name = "slate",
            description = S("Slates"),
            ingredient = "unilib:stone_ordinary",
            tile_table = {
                "unilib_roof_slate_normal.png",
                roof_side_img,
                "unilib_roof_slate_normal.png",
                "unilib_roof_slate_normal.png",
                roof_side_img,
                "unilib_roof_slate_normal.png"
            },

            replace_mode = mode,
        })

    end

end
