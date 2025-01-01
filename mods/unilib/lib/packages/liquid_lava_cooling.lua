---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.liquid_lava_cooling = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.liquid_lava_cooling.init()

    return {
        description = "Cooling lava",
        depends = "stone_ordinary",
        optional = "stone_obsidian",
    }

end

function unilib.pkg.liquid_lava_cooling.exec()

    -- (Creates unilib:bucket_steel_with_lava_cooling, etc)
    unilib.register_liquid({
        part_name = "lava_cooling",
        source_name = "unilib:liquid_lava_cooling_source",
        flowing_name = "unilib:liquid_lava_cooling_flowing",

        burntime = 30,
        description = S("Cooling Lava"),
        force_renew_flag = false,
    })

    unilib.register_node(
        -- From GLEMr11, lib_materials:liquid_lava_cooling_source
        "unilib:liquid_lava_cooling_source",
        "lib_materials:liquid_lava_cooling_source",
        mode,
        {
            description = S("Cooling Lava Source"),
            tiles = {
                {
                    name = "unilib_stone_ordinary_cobble.png" ..
                            "^(unilib_liquid_lava_ordinary_source_animated.png" ..
                            "^[mask:unilib_mask_stone_cobble.png)",
                    animation = {
                        type = "vertical_frames",
                        length = 3,
                        aspect_h = 16,
                        aspect_w = 16,
                    },
                    backface_culling = false,
                },
                {
                    name = "unilib_stone_ordinary_cobble.png" ..
                            "^(unilib_liquid_lava_ordinary_source_animated.png" ..
                            "^[mask:unilib_mask_stone_cobble.png)",
                    animation = {
                        type = "vertical_frames",
                        length = 3,
                        aspect_h = 16,
                        aspect_w = 16,
                    },
                    backface_culling = true,
                },
            },
            groups = {crumbly = 3, igniter = 1, lava = 3, liquid = 1},
            -- (no sounds)

            buildable_to = true,
            damage_per_second = 6,
            diggable = false,
            drawtype = "liquid",
            -- N.B. is_ground_content = false not in original code; added to match other liquids
            is_ground_content = false,
            light_source = 8,
            liquid_alternative_flowing = "unilib:liquid_lava_cooling_flowing",
            liquid_alternative_source = "unilib:liquid_lava_cooling_source",
            liquid_range = 3,
            liquid_renewable = false,
            liquid_viscosity = 7,
            liquidtype = "source",
            paramtype = "light",
            pointable = false,
            walkable = false,
        }
    )
    unilib.register_craft({
        -- Original to unilib. Half the burntime of ordinary lava
        type = "fuel",
        recipe = "unilib:liquid_lava_cooling_source",
        burntime = 30,
    })
    if unilib.global.pkg_executed_table["stone_obsidian"] ~= nil then

        unilib.register_lava({
            cooled_name = "unilib:stone_obsidian",
            lava_name = "unilib:liquid_lava_cooling_source",
        })

    end

    unilib.register_node(
        -- From GLEMr11, lib_materials:liquid_lava_cooling_flowing
        "unilib:liquid_lava_cooling_flowing",
        "lib_materials:liquid_lava_cooling_flowing",
        mode,
        {
            description = S("Flowing Cooling Lava"),
            tiles = {
                "unilib_stone_ordinary_cobble.png^(unilib_liquid_lava_ordinary.png" ..
                        "^[mask:unilib_mask_stone_cobble.png)",
            },
            groups = {
                crumbly = 3, igniter = 1, lava = 3, liquid = 1, not_in_creative_inventory = 1,
            },
            -- (no sounds)

            buildable_to = true,
            damage_per_second = 6,
            diggable = false,
            drawtype = "flowingliquid",
            -- N.B. is_ground_content = false not in original code; added to match other liquids
            is_ground_content = false,
            light_source = 8,
            liquid_alternative_flowing = "unilib:liquid_lava_cooling_flowing",
            liquid_alternative_source = "unilib:liquid_lava_cooling_source",
            liquid_range = 3,
            liquid_renewable = false,
            liquid_viscosity = 7,
            liquidtype = "flowing",
            paramtype = "light",
            paramtype2 = "flowingliquid",
            pointable = false,
            special_tiles = {
                {
                    name = "unilib_stone_ordinary_cobble.png" ..
                            "^(unilib_liquid_lava_ordinary_flowing_animated.png" ..
                            "^[mask:unilib_mask_stone_cobble.png)",
                    animation = {
                        type = "vertical_frames",
                        length = 3.3,
                        aspect_h = 16,
                        aspect_w = 16,
                    },
                    backface_culling = false,
                },
                {
                    name = "unilib_stone_ordinary_cobble.png" ..
                            "^(unilib_liquid_lava_ordinary_flowing_animated.png" ..
                            "^[mask:unilib_mask_stone_cobble.png)",
                    animation = {
                        type = "vertical_frames",
                        length = 3.3,
                        aspect_h = 16,
                        aspect_w = 16,
                    },
                    backface_culling = true,
                },
            },
            walkable = false,
        }
    )
    unilib.register_lava({
        cooled_name = "unilib:stone_ordinary",
        lava_name = "unilib:liquid_lava_cooling_flowing",
    })

end
