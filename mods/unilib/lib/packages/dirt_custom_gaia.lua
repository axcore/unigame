---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_custom_gaia = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- If false, produces a set of biome-dependent turfs using a greyscale base, which results in turfs
--      in many (unrealistic) colours. This is similar to the behaviour in GLEMr4 and GLEMr6
-- If true, produces a set of biome-dependent turfs using existing texture bases, which results in
--      a narrower and more realistic range of turf colours (green, browns and yellow)
local use_realistic_turf_flag = false
-- If true, check that at least one dirt-with-turf node has been created for every available turf
--      type (applies also to litters and covers)
local debug_flag = false
local debug_check_table = {}

local biome_list = {
    -- Hot biomes
    {
        "hot_humid", S("Hot Humid Turf"), "#e9e900:80", nil,
    },
    {
        "hot_semihumid", S("Hot Semi-Humid Turf"), "#fcd953:80", nil,
    },
    {
        "hot_temperate", S("Hot Temperate Turf"), "#fc9754:80", nil,
    },
    {
        "hot_semiarid", S("Hot Semi-Arid Turf"), "#daa062:80", nil,
    },
    {
        "hot_arid", S("Hot Arid Turf"), "#7c9800:128", nil,
    },

    -- Warm biomes
    {
        "warm_humid", S("Warm Humid Turf"), "#fc5458:80",
        {base = "glemr4_jungle"},
    },
    {
        -- All altitudes but coastal, use glemr11 palettes
        "warm_semihumid", S("Warm Semi-Humid Turf"), "#dacf61:72",
        -- Coastal altitude, use glemr4 palettes and base textures
        {base = "glemr4_jungle", coastal = "#da6e62:80"},
    },
    {
        -- All altitudes but coastal, use glemr11 palettes
        "warm_temperate", S("Warm Temperate Turf"), "#daa062:72",
        -- Coastal altitude, use glemr4 palettes (tweaked) and base textures
        {base = "glemr4_default", coastal = "#69e942:24"},
    },
    {
        "warm_semiarid", S("Warm Semi-Arid Turf"), "#da6e62:72", nil,
    },
    {
        "warm_arid", S("Warm Semi-Arid Turf"), "#d6d600:72",
        {base = "glemr4_dry"},
    },

    -- Mild biomes
    {
        "mild_humid", S("Mild Humid Turf"), "#69e942:80",
        {base = "glemr4_default"},
    },
    {
        "mild_semihumid", S("Mild Semi-Humid Turf"), "#f2ff00:80", nil,
    },
    {
        -- All altitudes but coastal, use glemr11 palettes
        "mild_temperate", S("Mild Temperate Turf"), "#e4d136:64",
        -- Coastal altitude, use glemr4 palettes and base textures
        {base = "glemr4_default", coastal = "#ace943:80"},
    },
    {
        "mild_semiarid", S("Mild Semi-Arid Turf"), "#e4d136:80", nil,
    },
    {
        "mild_arid", S("Mild Arid Turf"), "#956401:128", nil,
    },

    -- Cool biomes
    {
        "cool_humid", S("Cool Humid Turf"), "#43e9a5:48", nil,
    },
    {
        "cool_semihumid", S("Cool Semi-Humid Turf"), "#69e942:48", nil,
    },
    {
        "cool_temperate", S("Cool Temperate Turf"), "#69e942:80",
        {base = "glemr4_dry", coastal = "#69e942:80"},

    },
    {
        "cool_semiarid", S("Cool Semi-Arid Turf"), "#e9df43:48", nil,
    },
    {
        "cool_arid", S("Cool Arid Turf"), "#c5bf71:128", nil,
    },

    -- Cold biomes
    {
        "cold_humid", S("Cold Humid Turf"), "#6c8265:64", nil,
    },
    {
        "cold_semihumid", S("Cold Semi-Humid Turf"), "#7f9464:64", nil,
    },
    {
        "cold_temperate", S("Cold Temperate Turf"), "#945f5c:48", nil,
    },
    {
        "cold_semiarid", S("Cold Semi-Arid Turf"), "#79775e:48", nil,
    },
    {
        "cold_arid", S("Cold Arid Turf"), "#546979:64", nil,
    },
}

local texture_table = {}
if not use_realistic_turf_flag then

    texture_table = {
        coastal = {
            "unilib_turf_custom_coastal_top.png", "unilib_turf_custom_coastal_side_overlay.png",
        },
        lowland = {
            "unilib_turf_custom_lowland_top.png", "unilib_turf_custom_lowland_side_overlay.png",
        },
        shelf = {
            "unilib_turf_custom_shelf_top.png", "unilib_turf_custom_shelf_side_overlay.png",
        },
        highland = {
            "unilib_turf_custom_highland_top.png", "unilib_turf_custom_highland_side_overlay.png",
        },
    }

else

    texture_table = {
        coastal = {
            "unilib_turf_custom_rainforest_top.png",
            "unilib_turf_custom_rainforest_side_overlay.png",
        },
        lowland = {
            "unilib_turf_custom_ordinary_top.png", "unilib_turf_custom_ordinary_side_overlay.png",
        },
        shelf = {
            "unilib_turf_dry_top.png", "unilib_turf_dry_side_overlay.png",
        },
        highland = {
            "unilib_turf_custom_brown_top.png", "unilib_turf_custom_brown_side_overlay.png",
        },
    }

end

-- (Additional base textures, so that GLEMr4 dirts can be imported in their original colours)
texture_table["glemr4_default"] =
        {"unilib_turf_custom_top.png", "unilib_turf_custom_side_overlay.png"}
texture_table["glemr4_brown"] =
        {"unilib_turf_custom_brown_top.png", "unilib_turf_custom_brown_side_overlay.png"}
texture_table["glemr4_dry"] =
        {"unilib_turf_custom_dry_top.png", "unilib_turf_custom_dry_side_overlay.png"}
texture_table["glemr4_jungle"] =
        {"unilib_turf_custom_jungle_top.png", "unilib_turf_custom_jungle_side_overlay.png"}

local basic_list_with_turf = {
    -- (From default)
    {
        "turf", S("Ordinary Turf"),
        "unilib_turf_ordinary_top.png", "unilib_turf_ordinary_side_overlay.png",
    },
    {
        "turf_dry", S("Dry Turf"),
        "unilib_turf_dry_top.png", "unilib_turf_dry_side_overlay.png",
    },
--  -- (From GLEM - removed as the "gaia" remix does not use them)
--  {
--      "turf_brown", S("Brown Turf"),
--      "unilib_turf_custom_brown_top.png", "unilib_turf_custom_brown_side_overlay.png",
--  },
--  {
--      "turf_jungle", S("Jungle Turf"),
--      "unilib_turf_custom_jungle_top.png", "unilib_turf_custom_jungle_side_overlay.png",
--  },
}

local basic_list_no_turf = {
    -- (From default)
    {
        "litter_coniferous", S("Coniferous Litter"),
        "unilib_litter_coniferous.png", "unilib_litter_coniferous_side_overlay.png",
    },
    {
        "litter_rainforest", S("Rainforest Litter"),
        "unilib_litter_rainforest.png", "unilib_litter_rainforest_side_overlay.png",
    },
    {
        "cover_snow", S("Snow Cover"), "unilib_snow_ordinary.png",
        "unilib_snow_ordinary_side_overlay.png",
    },
}

-- N.B. "litter_forest_heavy" is added to this list in the code below, if woodsoils are available
local advanced_list_no_turf = {
    {
        "cover_fungi", S("Fungal Cover"),
        "unilib_cover_fungi.png",
        "unilib_cover_fungi_side_overlay.png",
    },
    {
        "cover_vine", S("Vine Cover"),
        "unilib_cover_vine_overlay.png",
        "unilib_cover_vine_side_overlay.png",
    },
    {
        "litter_forest_leafy", S("Leafy Forest Litter"),
        "unilib_litter_forest_leafy_overlay.png",
        "unilib_litter_forest_leafy_side_overlay.png",
    },
    {
        "litter_forest_light", S("Light Forest Litter"),
        "unilib_litter_forest_light_overlay.png",
        "unilib_litter_forest_light_side_overlay.png",
    },
    {
        "litter_forest_medium", S("Medium Forest Litter"),
        "unilib_litter_forest_medium_overlay.png",
        "unilib_litter_forest_medium_side_overlay.png",
    },
--  {
--      "litter_forest_heavy", S("Heavy Forest Litter"),
--      "unilib_litter_forest_heavy_underlay.png",
--      "unilib_litter_forest_heavy_side_overlay.png",
--  },
    {
        "litter_stone", S("Stone Litter"),
        "unilib_litter_stone_overlay.png",
        "unilib_litter_stone_side_overlay.png",
    },
}

-- N.B. this list is populated in the code below, if woodsoils are available
local woodsoils_list_with_turf = {
--  {
--      "litter_forest_medium", S("Medium Forest Litter"),
--      "unilib_litter_forest_medium_overlay.png", "unilib_litter_forest_medium_side_overlay.png",
--  },
--  {
--      "litter_forest_light", S("Light Forest Litter"),
--      "unilib_litter_forest_medium_overlay.png", "unilib_litter_forest_medium_side_overlay.png",
--  },
}

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

-- (Also used by the "biome_gaia" and "deco_gaia" packages)

-- Custom dirts on demand. If unilib.setting.dirt_on_demand_flag is true, the code below stores dirt
--      definitions here, instead of creating the nodes directly. Then, the corresponding biome
--      package can retrieve the definitions to create any custom dirts that it needs. This prevents
--      dirts that never appear in the world from clogging up the user's inventory
-- (If unilib.setting.dirt_on_demand_flag is false, the table remains empty)
--
-- Table in the form
--      dirt_table[full_name] = data_table
-- ...in which "data_table" is in the form expected by a call to unilib.register_dirt_with_turf().
--      For dirts without turf, no call to that function is necessary; so data_table consists of
--      one fields, .def_table (the node definition)
unilib.pkg.dirt_custom_gaia.dirt_table = {}
-- Table containing a subset of the keys in "dirt_table", omitting any that are not dirt-with-turf
--      nodes or which don't have soils
-- Table in the form
--      woodsoil_table[turf_full_name] = dirt_full_name
unilib.pkg.dirt_custom_gaia.woodsoil_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_description(dirt_name, turf_description)

    -- Original to unilib
    -- Creates a dirt/turf description in a standard format, e.g. "Ordinary Dirt with Green Turf"

    local def_table = core.registered_nodes[dirt_name]
    return S("@1 with @2", def_table.description, turf_description)

end

local function do_reverse_description(dirt_name, other_description)

    -- Modified version of do_description(), in which the dirt description comes last

    local def_table = core.registered_nodes[dirt_name]
    return S("@1 with @2", other_description, def_table.description)

end

local function add_soil_to_basic_dirt(full_name, dry_dirt_flag)

    -- Original to unilib
    -- Makes a basic dirt node farmable, using one of two varieties of soil
    -- Only basic dirts should call this function (as there is no guarantee that the original dirt
    --      node, created by some other package, is farmable, even when the related nodes created by
    --      this package are farmable)

    local def_table = core.registered_nodes[full_name]
    if def_table == nil or def_table.groups == nil then
        return
    end

    local group_table = def_table.groups
    if group_table.soil ~= nil then
        return
    else
        group_table.soil = 1
    end

    local soil_table
    if not dry_dirt_flag and unilib.global.pkg_executed_table["soil_ordinary"] ~= nil then

        soil_table = {
            base = full_name,
            dry = "unilib:soil_ordinary",
            wet = "unilib:soil_ordinary_wet",
        }

    elseif dry_dirt_flag and unilib.global.pkg_executed_table["soil_arid"] ~= nil then

        soil_table = {
            base = full_name,
            dry = "unilib:soil_arid",
            wet = "unilib:soil_arid_wet",
        }

    end

    unilib.override_item(full_name, {
        groups = group_table,
        soil = soil_table,
    })

end

local function add_soil_to_other_dirt(full_name, dry_dirt_flag)

    -- Original to unilib
    -- Makes a dirt node (other than the basic dirt) farmable, using one of two varieties of soil
    -- Only suitable nodes should call this function. Dirts with turf should not call this function
    --      at all

    local soil_table
    if not dry_dirt_flag and unilib.global.pkg_executed_table["soil_ordinary"] ~= nil then

        soil_table = {
            base = full_name,
            dry = "unilib:soil_ordinary",
            wet = "unilib:soil_ordinary_wet",
        }

    elseif dry_dirt_flag and unilib.global.pkg_executed_table["soil_arid"] ~= nil then

        soil_table = {
            base = full_name,
            dry = "unilib:soil_arid",
            wet = "unilib:soil_arid_wet",
        }

    end

    if not unilib.setting.dirt_on_demand_flag then

        unilib.override_item(full_name, {
            soil = soil_table,
        })

    elseif unilib.pkg.dirt_custom_gaia.dirt_table[full_name] ~= nil then

        unilib.pkg.dirt_custom_gaia.dirt_table[full_name]["def_table"]["soil"] = soil_table

    end

end

local function register_dirt(full_name, def_table)

    -- Original to unilib
    -- Depending on settings, register the dirt node now, or store it, so it can be registered on
    --      demand (for example, by the corresponding "gaia" remix biome package)
    -- Only dirts without turf should call this function

    -- (Don't replace a dirt node that already exists)
    if core.registered_nodes[full_name] == nil then

        if not unilib.setting.dirt_on_demand_flag then

            -- Register the node now
            unilib.register_node(full_name, nil, mode, def_table)

        else

            -- Store the definition table so the node can be registered on demand
            unilib.pkg.dirt_custom_gaia.dirt_table[full_name] = {}
            unilib.pkg.dirt_custom_gaia.dirt_table[full_name]["def_table"] = def_table
            unilib.pkg.dirt_custom_gaia.dirt_table[full_name]["orig_name"] = nil

        end

    end

end

local function register_dirt_with_turf(
    dirt_part_name, turf_part_name, def_table, soil_flag, dry_dirt_flag, turf_description
)
    -- Original to unilib
    -- Depending on settings, register the dirt node now, or store it, so it can be registered on
    --      demand (for example, by the corresponding GLEM biome package)
    -- Only dirts with turf should call this function

    -- (Don't replace a dirt node that already exists)
    local full_name = "unilib:" .. dirt_part_name .. "_with_" .. turf_part_name
    if core.registered_nodes[full_name] == nil then

        -- Set up the dirt definition
        local data_table = {
            dirt_part_name = dirt_part_name,
            turf_part_name = turf_part_name,
            orig_name = nil,
            def_table = def_table,

            replace_mode = mode,
            turf_description = turf_description,
        }

        if soil_flag then

            if not dry_dirt_flag and unilib.global.pkg_executed_table["soil_ordinary"] ~= nil then

                data_table.dry_soil = "unilib:soil_ordinary"
                data_table.wet_soil = "unilib:soil_ordinary_wet"

            elseif dry_dirt_flag and unilib.global.pkg_executed_table["soil_arid"] ~= nil then

                data_table.dry_soil = "unilib:soil_arid"
                data_table.wet_soil = "unilib:soil_arid_wet"

            end

        end

        if not unilib.setting.dirt_on_demand_flag then

            -- Register the node now
            unilib.register_dirt_with_turf(data_table)
            -- Also register woodsoils now, if available
            if soil_flag and unilib.global.pkg_executed_table["shared_woodsoils"] ~= nil then

                unilib.pkg.dirt_custom_gaia.register_woodsoils(
                    "unilib:" .. dirt_part_name, full_name
                )

            end

        else

            -- Store the definition table so the node can be registered on demand
            unilib.pkg.dirt_custom_gaia.dirt_table[full_name] = data_table
            -- Also store woodsoils, so they can be registered at the same time
            if soil_flag and unilib.global.pkg_executed_table["shared_woodsoils"] ~= nil then
                unilib.pkg.dirt_custom_gaia.woodsoil_table[full_name] = "unilib:" .. dirt_part_name
            end

        end

    end

    if debug_flag then
        debug_check_table[turf_part_name] = true
    end

end

local function register_biome_dirt(
    dirt_name, dirt_img, group_table, part_biome_name, part_description, palette, override_table,
    soil_flag, dry_dirt_flag
)
    -- Original to unilib
    -- This function is called with a biome indication (e.g. "hot_humid") and a palette
    --      (e.g. "#93fc54:80") to create four dirt/turf nodes
    -- If "override_table" is specified, then we tweak the default palette (in whole or in part)

    local item_name = unilib.utils.get_item_name(dirt_name)

    local coastal_base = "coastal"
    local lowland_base = "lowland"
    local shelf_base = "shelf"
    local highland_base = "highland"
    local coastal_palette = palette
    local lowland_palette = palette
    local shelf_palette = palette
    local highland_palette = palette
    if override_table ~= nil then

        -- We're trying to copy GLEMr4 dirt(s) which use a different set of base textures than
        --      GLEMr11 dirts did
        local all_flag = true
        for _, altitude in pairs({"coastal", "lowland", "shelf", "highland"}) do

            if override_table[altitude] ~= nil then

                all_flag = false
                coastal_base = override_table["base"] or altitude
                coastal_palette = override_table[altitude]

            end

        end

        -- If override_table does not contain any of the altitude strings as keys, then the value of
        --      the "base" key applies to all altitudes
        if all_flag then

            coastal_base = override_table["base"]
            lowland_base = override_table["base"]
            shelf_base = override_table["base"]
            highland_base = override_table["base"]

        end

    end

    local part_name = "_with_turf_" .. part_biome_name .. "_coastal"
    register_dirt_with_turf(
        item_name,
        "turf_" .. part_biome_name .. "_coastal",
        {
            description = do_description(dirt_name, part_description),
            tiles = {
                "" .. texture_table[coastal_base][1] .. "^[colorize:" .. coastal_palette .. "",
                dirt_img,
                dirt_img .. "^(" .. texture_table[coastal_base][2] .. "^[colorize:" ..
                        coastal_palette .. ")",
            },
            groups = group_table,
            sounds = unilib.sound.generate_dirt({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            drop = dirt_name,
            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        },
        soil_flag,
        dry_dirt_flag,
        part_description
    )

    part_name = "_with_turf_" .. part_biome_name .. "_lowland"
    register_dirt_with_turf(
        item_name,
        "turf_" .. part_biome_name .. "_lowland",
        {
            description = do_description(dirt_name, part_description),
            tiles = {
                "" .. texture_table[lowland_base][1] .. "^[colorize:" .. lowland_palette .. "",
                dirt_img,
                dirt_img .. "^(" .. texture_table[lowland_base][2] .. "^[colorize:" ..
                        lowland_palette .. ")",
            },
            groups = group_table,
            sounds = unilib.sound.generate_dirt({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            drop = dirt_name,
            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        },
        soil_flag,
        dry_dirt_flag,
        part_description
    )

    part_name = "_with_turf_" .. part_biome_name .. "_shelf"
    register_dirt_with_turf(
        item_name,
        "turf_" .. part_biome_name .. "_shelf",
        {
            description = do_description(dirt_name, part_description),
            tiles = {
                "" .. texture_table[shelf_base][1] .. "^[colorize:" .. shelf_palette .. "",
                dirt_img,
                dirt_img .. "^(" .. texture_table[shelf_base][2] .. "^[colorize:" ..
                        shelf_palette .. ")",
            },
            groups = group_table,
            sounds = unilib.sound.generate_dirt({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            drop = dirt_name,
            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        },
        soil_flag,
        dry_dirt_flag,
        part_description
    )

    register_dirt_with_turf(
        item_name,
        "turf_" .. part_biome_name .. "_highland",
        {
            description = do_description(dirt_name, part_description),
            tiles = {
                "" .. texture_table[highland_base][1] .. "^[colorize:" .. highland_palette .. "",
                dirt_img,
                dirt_img .. "^(" .. texture_table[highland_base][2] .. "^[colorize:" ..
                        highland_palette .. ")",
            },
            groups = group_table,
            sounds = unilib.sound.generate_dirt({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            drop = dirt_name,
            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        },
        soil_flag,
        dry_dirt_flag,
        part_description
    )

end

local function register_dirt_set(data_table)

    -- Original to unilib
    -- This function is called with a basic dirt type, in order to create nodes with various types
    --      of turf. The list of basic dirt types can be found at the bottom of this package
    --
    -- data_table compulsory fields:
    --      item_name (str): e.g. "dirt_ordinary" from "unilib:dirt_ordinary"; must also match
    --          the name of a package
    --      soil_flag (bool): true if the dirt (and its corresponding dirt-with-turf nodes) can be
    --          converted to soil using a hoe; false if not
    --
    -- data_table optional fields:
    --      dry_dirt_flag (bool): true for dry dirts, false otherwise (N.B. not to be confused with
    --          dry turfs)
    --      no_turf_flag (bool): true for permafrosts (etc) which can take litters/covers, but not
    --          turfs

    local item_name = data_table.item_name
    local soil_flag = data_table.soil_flag

    local dry_dirt_flag = data_table.dry_dirt_flag or false
    local no_turf_flag = data_table.no_turf_flag or false

    if unilib.global.pkg_executed_table[item_name] == nil then
        return
    end

    local dirt_name = "unilib:" .. item_name
    local dirt_img = "unilib_" .. item_name .. ".png"

    -- N.B. spreading_dirt_type not in original GLEMr11 code, but is in original minetest_game
    --      code
    local dry_dirt = nil
    if dry_dirt_flag == true then
        dry_dirt = 1
    end

    local soil = nil
    if soil_flag == true then

        soil = 1
        add_soil_to_basic_dirt(dirt_name, dry_dirt_flag)

    end

    local group_table = {
        crumbly = 3,
        dry_dirt = dry_dirt,
        not_in_creative_inventory = unilib.hide_covered_dirt_group,
        soil = soil,
        spreading_dirt_type = 1,
    }

    -- Basic dirt with turf
    if not no_turf_flag then

        for _, mini_list in pairs(basic_list_with_turf) do

            register_dirt_with_turf(
                item_name,
                mini_list[1],
                {
                    description = do_description(dirt_name, mini_list[2]),
                    tiles = {
                        mini_list[3],
                        dirt_img,
                        dirt_img .. "^" .. mini_list[4],
                    },
                    groups = group_table,
                    sounds = unilib.sound.generate_dirt({
                        footstep = {name = "unilib_grass_footstep", gain = 0.4},
                    }),

                    drop = dirt_name,
                    is_ground_content = unilib.setting.caves_chop_dirt_flag,
                },
                soil_flag,
                dry_dirt_flag,
                S("Turf")
            )

        end

    end

    -- Dirt with basic litter covers
    for _, mini_list in pairs(basic_list_no_turf) do

        register_dirt(
            dirt_name .. "_with_" .. mini_list[1],
            {
                description = do_description(dirt_name, mini_list[2]),
                tiles = {
                    mini_list[3],
                    dirt_img,
                    dirt_img .. "^" .. mini_list[4],
                },
                groups = group_table,
                sounds = unilib.sound.generate_dirt({
                    footstep = {name = "unilib_grass_footstep", gain = 0.4},
                }),

                drop = dirt_name,
                is_ground_content = unilib.setting.caves_chop_dirt_flag,
            }
        )

        if soil_flag then
            add_soil_to_other_dirt(dirt_name .. "_with_" .. mini_list[1], dry_dirt_flag)
        end

    end

    -- Dirt with advanced litter covers
    for _, mini_list in pairs(advanced_list_no_turf) do

        register_dirt(
            dirt_name .. "_with_" .. mini_list[1],
            {
                description = do_description(dirt_name, mini_list[2]),
                tiles = {
                    dirt_img .. "^" .. mini_list[3],
                    dirt_img .. "^" .. mini_list[4],
                },
                groups = group_table,
                sounds = unilib.sound.generate_dirt({
                    footstep = {name = "unilib_grass_footstep", gain = 0.4},
                }),

                drop = dirt_name,
                is_ground_content = unilib.setting.caves_chop_dirt_flag,
            }
        )

        if soil_flag then
            add_soil_to_other_dirt(dirt_name .. "_with_" .. mini_list[1], dry_dirt_flag)
        end

    end

    -- Biome-specific turfs
    if not no_turf_flag then

        for _, mini_list in pairs(biome_list) do

            register_biome_dirt(
                dirt_name, dirt_img, group_table,
                mini_list[1], mini_list[2], mini_list[3], mini_list[4],
                soil_flag, dry_dirt_flag
            )

        end

    end

    -- Dirt-stone mixes, not currently used (see the "decor_stone_dirty" and "decor_stone_sandy"
    --      packages instead)
--  register_dirt(
--      "unilib:stone_ordinary_with_" .. item_name,
--      {
--          description = do_reverse_description(dirt_name, S("Ordinary Stone")),
--          tiles = {
--              "unilib_stone_ordinary.png^(" .. dirt_img .. "^[mask:unilib_mask_stone.png)",
--          },
--          groups = {cracky = 3, stone = 2},
--          sounds = unilib.sound.generate_dirt({
--              footstep = {name = "unilib_grass_footstep", gain = 0.4},
--          }),

--          is_ground_content = unilib.setting.caves_chop_dirt_flag,
--      }
--  )

--  register_dirt(
--      "unilib:stone_ordinary_cobble_with_" .. item_name,
--      {
--          description = do_reverse_description(dirt_name, S("Ordinary Cobblestone")),
--          tiles = {
--              "unilib_stone_ordinary_cobble.png^(" .. dirt_img ..
--                      "^[mask:unilib_mask_stone_cobble.png)",
--          },
--          groups = {cracky = 3, stone = 2},
--          sounds = unilib.sound.generate_dirt({
--              footstep = {name = "unilib_grass_footstep", gain = 0.4},
--          }),

--          is_ground_content = unilib.setting.caves_chop_dirt_flag,
--      }
--  )

--  register_dirt(
--      "unilib:stone_desert_with_" .. item_name,
--      nil,
--      {
--          description = do_reverse_description(dirt_name, S("Desert Stone")),
--          tiles = {
--              "unilib_stone_desert.png^(" .. dirt_img .. "^[mask:unilib_mask_stone.png)",
--          },
--          groups = {cracky = 3, stone = 2},
--          sounds = unilib.sound.generate_dirt({
--              footstep = {name = "unilib_grass_footstep", gain = 0.4},
--          }),

--          is_ground_content = unilib.setting.caves_chop_dirt_flag,
--      }
--  )
--
--  register_dirt(
--      "unilib:stone_desert_cobble_with_" .. item_name,
--      {
--          description = do_reverse_description(dirt_name, S("Desert Cobblestone")),
--          tiles = {
--              "unilib_stone_desert_cobble.png^(" .. dirt_img ..
--                      "^[mask:unilib_mask_stone_cobble.png)",
--          },
--          groups = {cracky = 3, stone = 2},
--          sounds = unilib.sound.generate_dirt({
--              footstep = {name = "unilib_grass_footstep", gain = 0.4},
--          }),

--          is_ground_content = unilib.setting.caves_chop_dirt_flag,
--      }
--  )

    -- Any non-dirt nodes given turfs/litters/covers by this package, should be registered as
    --      super-dirts
    if string.sub(item_name, 1, 5) ~= "dirt_" then
        unilib.register_other_dirt(item_name)
    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_custom_gaia.register_woodsoils(dirt_full_name, turf_full_name)

    -- Handle woodsoil variants for a dirt-with-turf node. The calling code has already checked
    --      that woodsoils are available, and that the specified nodes have soils

    local dirt_def_table = core.registered_nodes[dirt_full_name]
    local turf_def_table = core.registered_nodes[turf_full_name]
    if dirt_def_table == nil or turf_def_table == nil then
        return
    end

    local dirt_img = dirt_def_table["tiles"][1]
    local turf_top_img = turf_def_table["tiles"][1]
    local turf_side_img = turf_def_table["tiles"][3]

    for _, woodsoil_mini_list in pairs(woodsoils_list_with_turf) do

        local woodsoil_full_name = turf_full_name .. "_with_" .. woodsoil_mini_list[1]

        unilib.register_node(woodsoil_full_name, nil, mode, {
            -- From woodsoils:grass_with_leaves_2
            description = S("@1 with @2", turf_def_table.description, woodsoil_mini_list[2]),
            tiles = {
                unilib.utils.concat_img(turf_top_img, woodsoil_mini_list[3]),
                dirt_img,
                unilib.utils.concat_img(turf_side_img, woodsoil_mini_list[4]),
            },
            groups = {
                crumbly = turf_def_table.groups.crumbly,
                dry_dirt = turf_def_table.groups.dry_dirt,
                not_in_creative_inventory = turf_def_table.groups.not_in_creative_inventory,
                soil = turf_def_table.groups.soil,
            },
            sounds = unilib.sound.generate_dirt({
                footstep = {name = "unilib_grass_footstep", gain = 0.4},
            }),

            drop = dirt_full_name,
            is_ground_content = unilib.setting.caves_chop_dirt_flag,
            soil = unilib.pkg.shared_woodsoils.get_soil_table(dirt_def_table, woodsoil_full_name),
        })

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_custom_gaia.init()

    return {
        description = "Custom dirts for the \"gaia\" remix",
        notes = "Based on \"dirt_custom_glemr11\". Removed original names",
        optional = {
            -- Basic dirt types
            "clay_red",
            "dirt_black",
            "dirt_brown",
            "dirt_clayey",
            "dirt_coarse",
            "dirt_dark",
            "dirt_dried",
            "dirt_ordinary",
            "dirt_parched",
            "dirt_permafrost_blue",
            "dirt_permafrost_blue_dark",
            "dirt_permafrost_brown",
            "dirt_permafrost_brown_dark",
            "dirt_permafrost_dark",
            "dirt_permafrost_green",
            "dirt_permafrost_green_dark",
            "dirt_permafrost_ordinary",
            "dirt_permafrost_red",
            "dirt_permafrost_red_dark",
            "dirt_sandy",
            "dirt_silt_coarse",
            "dirt_silt_fine",
            -- Basic dirt types, not currently used
--          "clay_ordinary",
--          "dirt_mud_dry",
--          "dirt_mud_swamp",
--          "sand_silt",
            -- This package supports woodsoils, if the following package has been loaded
            "shared_woodsoils",
            -- Soil types, used by this package
            "soil_arid",
            "soil_ordinary",
            -- Soil types, used by the "gaia" remix but not by this package specifically
--          "soil_sand_desert",
        },
    }

end

function unilib.pkg.dirt_custom_gaia.exec()

    -- Set up woodsoils, if available
    if unilib.global.pkg_executed_table["shared_woodsoils"] ~= nil then

        table.insert(
            advanced_list_no_turf,
            {
                "litter_forest_heavy", S("Heavy Forest Litter"),
                "unilib_litter_forest_heavy_underlay.png",
                "unilib_litter_forest_heavy_side_overlay.png",
            }
        )

        table.insert(
            woodsoils_list_with_turf,
            {
                "litter_forest_medium", S("Medium Forest Litter"),
                "unilib_litter_forest_medium_overlay.png",
                "unilib_litter_forest_medium_side_overlay.png",
            }
        )

        table.insert(
            woodsoils_list_with_turf,
            {
                "litter_forest_light", S("Light Forest Litter"),
                "unilib_litter_forest_light_overlay.png",
                "unilib_litter_forest_light_side_overlay.png",
            }
        )

    end

    -- Basic dirt types

    register_dirt_set({
        item_name = "clay_red",
        soil_flag = false,
    })

    register_dirt_set({
        item_name = "dirt_black",
        soil_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_brown",
        soil_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_clayey",
        soil_flag = false,
    })

    register_dirt_set({
        item_name = "dirt_coarse",
        soil_flag = false,
    })

    register_dirt_set({
        item_name = "dirt_dark",
        soil_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_dried",
        soil_flag = false,

        dry_dirt_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_ordinary",
        soil_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_parched",
        soil_flag = true,

        dry_dirt_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_permafrost_blue",
        soil_flag = false,

        no_turf_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_permafrost_blue_dark",
        soil_flag = false,

        no_turf_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_permafrost_brown",
        soil_flag = false,

        no_turf_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_permafrost_brown_dark",
        soil_flag = false,

        no_turf_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_permafrost_dark",
        soil_flag = false,

        no_turf_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_permafrost_green",
        soil_flag = false,

        no_turf_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_permafrost_green_dark",
        soil_flag = false,

        no_turf_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_permafrost_ordinary",
        soil_flag = false,

        no_turf_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_permafrost_red",
        soil_flag = false,

        no_turf_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_permafrost_red_dark",
        soil_flag = false,

        no_turf_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_sandy",
        soil_flag = false,
    })

    register_dirt_set({
        item_name = "dirt_silt_coarse",
        soil_flag = false,
    })

    register_dirt_set({
        item_name = "dirt_silt_fine",
        soil_flag = false,
    })

    -- Basic dirt types, not currently used

    --[[
    register_dirt_set({
        item_name = "clay_ordinary",
        soil_flag = false,
    })

    register_dirt_set({
        item_name = "dirt_mud_dry",
        soil_flag = false,

        no_turf_flag = true,
    })

    -- N.B. The player will slowly sink into the dirt, but not the dirt-with-turf nodes created by
    --      this package
    register_dirt_set({
        item_name = "dirt_mud_swamp",
        soil_flag = false,

        no_turf_flag = true,
    })

    register_dirt_set({
        item_name = "sand_silt",
        soil_flag = false,
    })
    ]]--

end

function unilib.pkg.dirt_custom_gaia.post()

    -- If woodsoils are available, set up an ABM/LBM for them
    if unilib.global.pkg_executed_table["shared_woodsoils"] ~= nil then

        -- ABM to place woodsoils around trees/ferns grown from saplings (over time)
        unilib.register_abm({
            label = "Place forest litter [dirt_custom_gaia]",
            nodenames = {"group:tree", "group:fern"},

            -- (Tree takes half an hour on average to drop litter over the surrounding soil)
            chance = 60,
            interval = 60,

            action = function(pos)
                unilib.pkg.shared_woodsoils.place_litter(pos)
            end,
        })

        -- LBM to place woodsoils around trees/ferns placed as decorations (immediately)
        unilib.register_lbm({
            label = "Place forest litter around trees/ferns [dirt_custom_gaia]",
            name = "unilib:lbm_dirt_custom_gaia",
            nodenames = {"group:tree", "group:fern"},
            run_at_every_load = true,

            action = function(pos)
                unilib.pkg.shared_woodsoils.place_litter(pos)
            end,
        })

    end

    if debug_flag then

        -- Save a bit of time, by only testing nodes with turf/cover/litter
        local node_table = {}
        for full_name, _ in pairs(core.registered_nodes) do

            if string.find(full_name, "turf") or
                    string.find(full_name, "litter") or
                    string.find(full_name, "cover") then
                node_table[full_name] = true
            end

        end

        -- Test each turf/cover/litter type, looking for at least one matching node
        local missing_list = {}
        for _, turf_type in ipairs(unilib.utils.sort_table(debug_check_table)) do

            local match_flag = false
            for full_name, _ in pairs(node_table) do

                if string.find(full_name, turf_type .. "$") then

                    match_flag = true
                    break

                end

            end

            if not match_flag then
                table.insert(missing_list, turf_type)
            end

        end

        if not unilib.utils.is_table_empty(missing_list) then

            unilib.utils.show_error("dirt_custom_gaia package: turf/cover/litter not found")
            for _, turf_type in ipairs(missing_list) do
                unilib.utils.show_error("   " .. turf_type)
            end

            unilib.utils.show_error("dirt_custom_gaia package: end of list")

        end

    end

end
