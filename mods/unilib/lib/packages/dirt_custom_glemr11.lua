---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_custom_glemr11 = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

-- If false, produces a set of biome-dependent turfs using a greyscale base, which results in turfs
--      in many (unrealistic) colours. This is similar to the behaviour in GLEMr4 and GLEMr6
-- If true, produces a set of biome-dependent turfs using existing texture bases, which results in
--      a narrower and more realistic range of turf colours (green, browns and yellow)
local use_realistic_turf_flag = false

local biome_list = {
    {"hot_humid", S("Hot Humid Turf"), "#93fc54:80"},
    {"hot_semihumid", S("Hot Semi-Humid Turf"), "#fcd953:80"},
    {"hot_temperate", S("Hot Temperate Turf"), "#fc9754:80"},
    {"hot_semiarid", S("Hot Semi-Arid Turf"), "#fc5458:80"},
    {"warm_humid", S("Warm Humid Turf"), "#81da62:72"},
    {"warm_semihumid", S("Warm Semi-Humid Turf"), "#dacf61:72"},
    {"warm_temperate", S("Warm Temperate Turf"), "#daa062:72"},
    {"warm_semiarid", S("Warm Semi-Arid Turf"), "#da6e62:72"},
    {"temperate_humid", S("Temperate Humid Turf"), "#36e44b:64"},
    {"temperate_semihumid", S("Temperate Semi-Humid Turf"), "#b1e436:64"},
    {"temperate_temperate", S("Temperate Temperate Turf"), "#e4d136:64"},
    {"temperate_semiarid", S("Temperate Semi-Arid Turf"), "#e48836:64"},
    {"cool_humid", S("Cool Humid Turf"), "#43e9a5:48"},
    {"cool_semihumid", S("Cool Semi-Humid Turf"), "#69e942:48"},
    {"cool_temperate", S("Cool Temperate Turf"), "#ace943:48"},
    {"cool_semiarid", S("Cool Semi-Arid Turf"), "#e9df43:48"},
}

local texture_table = {}
if use_realistic_turf_flag then

    texture_table = {
        coastal = {
            "unilib_turf_custom_rainforest_top.png",
            "unilib_turf_custom_rainforest_side_overlay.png"
        },
        lowland = {
            "unilib_turf_custom_ordinary_top.png", "unilib_turf_custom_ordinary_side_overlay.png"
        },
        shelf = {
            "unilib_turf_dry_top.png", "unilib_turf_dry_side_overlay.png"
        },
        highland = {
            "unilib_turf_custom_brown_top.png", "unilib_turf_custom_brown_side_overlay.png"
        }
    }

else

    texture_table = {
        coastal = {
            "unilib_turf_custom_coastal_top.png", "unilib_turf_custom_coastal_side_overlay.png"
        },
        lowland = {
            "unilib_turf_custom_lowland_top.png", "unilib_turf_custom_lowland_side_overlay.png"
        },
        shelf = {
            "unilib_turf_custom_shelf_top.png", "unilib_turf_custom_shelf_side_overlay.png"
        },
        highland = {
            "unilib_turf_custom_highland_top.png", "unilib_turf_custom_highland_side_overlay.png"
        }
    }

end

local basic_list_with_turf = {
    -- (From default)
    {
        "turf", "grass", S("Ordinary Turf"),
        "unilib_turf_ordinary_top.png", "unilib_turf_ordinary_side_overlay.png",
    },
    {
        "turf_dry", "grass_dry", S("Dry Turf"),
        "unilib_turf_dry_top.png", "unilib_turf_dry_side_overlay.png",
    },
    -- (From GLEM)
    {
        "turf_brown", "grass_brown", S("Brown Turf"),
        "unilib_turf_custom_brown_top.png", "unilib_turf_custom_brown_side_overlay.png",
    },
    {
        "turf_jungle", "grass_jungle_01", S("Jungle Turf"),
        "unilib_turf_custom_jungle_top.png", "unilib_turf_custom_jungle_side_overlay.png",
    },
    -- (From ethereal)
    {
        "turf_bamboo", "grass_bamboo", S("Bamboo Turf"),
        "unilib_turf_bamboo_top.png", "unilib_turf_bamboo_side_overlay.png",
    },
    {
        "turf_cold", "grass_cold", S("Cold Turf"),
        "unilib_turf_cold_top.png", "unilib_turf_cold_side_overlay.png",
    },
    {
        "turf_crystal", "grass_crystal", S("Crystal Turf"),
        "unilib_turf_crystal_top.png", "unilib_turf_crystal_side_overlay.png",
    },
    {
        "turf_fiery", "grass_fiery", S("Fiery Turf"),
        "unilib_turf_fiery_top.png", "unilib_turf_fiery_side_overlay.png",
    },
    {
        "turf_grey", "grass_gray", S("Grey Turf"),
        "unilib_turf_grey_top.png", "unilib_turf_grey_side_overlay.png",
    },
    {
        "turf_grove", "grass_grove", S("Grove Turf"),
        "unilib_turf_grove_top.png", "unilib_turf_grove_side_overlay.png",
    },
    {
        "turf_mushroom", "grass_mushroom", S("Mushroom Turf"),
        "unilib_turf_mushroom_top.png", "unilib_turf_mushroom_side_overlay.png",
    },
    {
        "turf_prairie", "grass_prairie", S("Prairie Turf"),
        "unilib_turf_prairie_top.png", "unilib_turf_prairie_side_overlay.png",
    },
}

local basic_list_no_turf = {
    -- (From default)
    {
        "litter_coniferous", "litter_coniferous", S("Coniferous Litter"),
        "unilib_litter_coniferous.png", "unilib_litter_coniferous_side_overlay.png",
    },
    {
        "litter_rainforest", "litter_rainforest", S("Rainforest Litter"),
        "unilib_litter_rainforest.png", "unilib_litter_rainforest_side_overlay.png",
    },
    {
        "snow_ordinary", "snow", S("Snow"), "unilib_snow_ordinary.png",
        "unilib_snow_ordinary_side_overlay.png",
    },
}

local advanced_list_no_turf = {
    {
        "litter_fungi", "litter_fungi", S("Fungal Litter"),
        "unilib_litter_vine_overlay.png", "unilib_cover_fungi_alt_side_overlay.png",
    },
    {
        "litter_leaf", "litter_leaf_01", S("Leaf Litter"),
        "unilib_litter_forest_leaf_overlay.png", "unilib_litter_coniferous_side_alt_overlay.png",
    },
    {
        "litter_light", "litter_leaf_02", S("Light Litter"),
        "unilib_litter_forest_light_overlay.png", "unilib_litter_coniferous_side_alt_overlay.png",
    },
    {
        "litter_stone", "litter_stones", S("Stones"),
        "unilib_litter_forest_stone_overlay.png", "unilib_litter_forest_stone_side_overlay.png",
    },
    {
        "litter_vine", "litter_vine", S("Vines"),
        "unilib_litter_vine_overlay.png", "unilib_litter_coniferous_side_alt_overlay.png",
    },
}

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

-- (Also used by the "biome_glemr11" and "deco_glemr11" packages)

-- Custom dirts on demand. If unilib.glem_dirt_on_demand_flag is true, the code below stores dirt
--      definitions here, instead of creating the nodes directly. Then, the corresponding biome
--      package can retrieve the definitions to create any custom dirts that it needs. This prevents
--      dirts that never appear in the world from clogging up the user's inventory
-- (If unilib.glem_dirt_on_demand_flag is false, the table remains empty)
--
-- Table in the form
--      table[full_name] = data_table
-- ...in which "data_table" is in the form expected by a call to unilib.register_dirt_with_turf().
--      For dirts without turf, no call to that function is necessary; so data_table consists of
--      two fields, .orig_name (the node's name in the original mod code), and .def_table (the
--      node definition)
unilib.pkg.dirt_custom_glemr11.dirt_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_description(dirt_name, turf_description)

    -- Original to unilib
    -- Creates a dirt/turf description in a standard format, e.g. "Ordinary Dirt with Green Turf"

    local def_table = minetest.registered_nodes[dirt_name]
    return S("@1 with @2", def_table.description, turf_description)

end

local function do_reverse_description(dirt_name, other_description)

    -- Modified version of do_description(), in which the dirt description comes last

    local def_table = minetest.registered_nodes[dirt_name]
    return S("@1 with @2", other_description, def_table.description)

end

local function add_soil(full_name, dry_dirt_flag)

    -- Original to unilib
    -- Makes a dirt node farmable, using one of two varieties of soil
    -- Only suitable dirts should call this function. Dirts with turf should not call this function
    --      at all

    local soil_table
    if not dry_dirt_flag and unilib.pkg_executed_table["soil_ordinary"] ~= nil then

        soil_table = {
            base = full_name,
            dry = "unilib:soil_ordinary",
            wet = "unilib:soil_ordinary_wet",
        }

    elseif dry_dirt_flag and unilib.pkg_executed_table["soil_arid"] ~= nil then

        soil_table = {
            base = full_name,
            dry = "unilib:soil_arid",
            wet = "unilib:soil_arid_wet",
        }

    end

    if not unilib.glem_dirt_on_demand_flag then

        unilib.override_item(full_name, {
            soil = soil_table,
        })

    elseif unilib.pkg.dirt_custom_glemr11.dirt_table[full_name] ~= nil then

        unilib.pkg.dirt_custom_glemr11.dirt_table[full_name]["def_table"]["soil"] = soil_table

    end

end

local function register_dirt(full_name, orig_name, def_table)

    -- Original to unilib
    -- Depending on settings, register the dirt node now, or store it, so it can be registered on
    --      demand (for example, by the corresponding GLEM biome package)
    -- Only dirts without turf should call this function

    -- (Don't replace a dirt node that already exists)
    if minetest.registered_nodes[full_name] == nil then

        if not unilib.glem_dirt_on_demand_flag then

            -- Register the node now
            unilib.register_node(full_name, orig_name, mode, def_table)

        else

            -- Store the definition table so the node can be registered on demand
            unilib.pkg.dirt_custom_glemr11.dirt_table[full_name] = {}
            unilib.pkg.dirt_custom_glemr11.dirt_table[full_name]["def_table"] = def_table
            unilib.pkg.dirt_custom_glemr11.dirt_table[full_name]["orig_name"] = orig_name

        end

    end

end

local function register_dirt_with_turf(
    dirt_part_name, turf_part_name, orig_name, def_table, soil_flag, dry_dirt_flag, turf_description
)
    -- Original to unilib
    -- Depending on settings, register the dirt node now, or store it, so it can be registered on
    --      demand (for example, by the corresponding GLEM biome package)
    -- Only dirts with turf should call this function

    -- (Don't replace a dirt node that already exists)
    local full_name = "unilib:" .. dirt_part_name .. "_with_" .. turf_part_name
    if minetest.registered_nodes[full_name] == nil then

        local data_table = {
            dirt_part_name = dirt_part_name,
            turf_part_name = turf_part_name,
            orig_name = orig_name,
            def_table = def_table,

            replace_mode = mode,
            turf_description = turf_description,
        }

        if soil_flag then

            if not dry_dirt_flag and unilib.pkg_executed_table["soil_ordinary"] ~= nil then

                data_table.dry_soil = "unilib:soil_ordinary"
                data_table.wet_soil = "unilib:soil_ordinary_wet"

            elseif dry_dirt_flag and unilib.pkg_executed_table["soil_arid"] ~= nil then

                data_table.dry_soil = "unilib:soil_arid"
                data_table.wet_soil = "unilib:soil_arid_wet"

            end

        end

        if not unilib.glem_dirt_on_demand_flag then

            -- Register the node now
            unilib.register_dirt_with_turf(data_table)

        else

            -- Store the definition table so the node can be registered on demand
            unilib.pkg.dirt_custom_glemr11.dirt_table[full_name] = data_table

        end

    end

end

local function register_biome_dirt(
    dirt_name, orig_name, dirt_img, group_table, part_biome_name, part_description, palette,
    soil_flag, dry_dirt_flag
)
    -- Original to unilib
    -- This function is called with a biome indication (e.g. "hot_humid") and a palette
    --      (e.g. "#93fc54:80") to create four dirt/turf nodes

    local item_name = unilib.get_item_name(dirt_name)

    local part_name = "_with_turf_" .. part_biome_name .. "_coastal"
    register_dirt_with_turf(
        item_name,
        "turf_" .. part_biome_name .. "_coastal",
        orig_name .. part_name,
        {
            description = do_description(dirt_name, part_description),
            tiles = {
                "" .. texture_table["coastal"][1] .. "^[colorize:" .. palette .. "",
                dirt_img,
                dirt_img .. "^(" .. texture_table["coastal"][2] .. "^[colorize:" .. palette .. ")",
            },
            groups = group_table,
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            drop = dirt_name,
            is_ground_content = unilib.caves_chop_dirt_flag,
        },
        soil_flag,
        dry_dirt_flag,
        part_description
    )

    part_name = "_with_turf_" .. part_biome_name .. "_lowland"
    register_dirt_with_turf(
        item_name,
        "turf_" .. part_biome_name .. "_lowland",
        orig_name .. part_name,
        {
            description = do_description(dirt_name, part_description),
            tiles = {
                "" .. texture_table["lowland"][1] .. "^[colorize:" .. palette .. "",
                dirt_img,
                dirt_img .. "^(" .. texture_table["lowland"][2] .. "^[colorize:" .. palette .. ")",
            },
            groups = group_table,
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            drop = dirt_name,
            is_ground_content = unilib.caves_chop_dirt_flag,
        },
        soil_flag,
        dry_dirt_flag,
        part_description
    )

    part_name = "_with_turf_" .. part_biome_name .. "_shelf"
    register_dirt_with_turf(
        item_name,
        "turf_" .. part_biome_name .. "_shelf",
        orig_name .. part_name,
        {
            description = do_description(dirt_name, part_description),
            tiles = {
                "" .. texture_table["shelf"][1] .. "^[colorize:" .. palette .. "",
                dirt_img,
                dirt_img .. "^(" .. texture_table["shelf"][2] .. "^[colorize:" .. palette .. ")",
            },
            groups = group_table,
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            drop = dirt_name,
            is_ground_content = unilib.caves_chop_dirt_flag,
        },
        soil_flag,
        dry_dirt_flag,
        part_description
    )

    register_dirt_with_turf(
        item_name,
        "turf_" .. part_biome_name .. "_highland",
        orig_name .. part_name,
        {
            description = do_description(dirt_name, part_description),
            tiles = {
                "" .. texture_table["highland"][1] .. "^[colorize:" .. palette .. "",
                dirt_img,
                dirt_img .. "^(" .. texture_table["highland"][2] .. "^[colorize:" .. palette .. ")",
            },
            groups = group_table,
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            drop = dirt_name,
            is_ground_content = unilib.caves_chop_dirt_flag,
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
    --      orig_name (str): e.g. "lib_materials:dirt"
    --      soil_flag (bool): true if the dirt (and its corresponding dirt-with-turf nodes) can be
    --          converted to soil using a hoe; false if not
    --
    -- data_table optional fields:
    --      dry_dirt_flag (bool): true for dry dirts, false otherwise (n.B. not to be confused with
    --          dry turfs)

    local item_name = data_table.item_name
    local orig_name = data_table.orig_name
    local soil_flag = data_table.soil_flag

    local dry_dirt_flag = data_table.dry_dirt_flag or false

    if unilib.pkg_executed_table[item_name] == nil then
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
    end

    local group_table = {crumbly = 3, dry_dirt = dry_dirt, soil = soil, spreading_dirt_type = 1}

    -- Basic dirt with turf
    for _, mini_list in pairs(basic_list_with_turf) do

        register_dirt_with_turf(
            item_name,
            mini_list[1],
            orig_name .. "_with_" .. mini_list[2],
            {
                description = do_description(dirt_name, mini_list[3]),
                tiles = {
                    mini_list[4],
                    dirt_img,
                    dirt_img .. "^" .. mini_list[5],
                },
                groups = group_table,
                sounds = unilib.node_sound_dirt_defaults({
                    footstep = {name = "unilib_grass_footstep", gain = 0.4},
                }),

                drop = dirt_name,
                is_ground_content = unilib.caves_chop_dirt_flag,
            },
            soil_flag,
            dry_dirt_flag,
            S("Turf")
        )

    end

    -- Dirt with basic litter covers
    for _, mini_list in pairs(basic_list_no_turf) do

        register_dirt(
            dirt_name .. "_with_" .. mini_list[1],
            orig_name .. "_with_" .. mini_list[2],
            {
                description = do_description(dirt_name, mini_list[3]),
                tiles = {
                    mini_list[4],
                    dirt_img,
                    dirt_img .. "^" .. mini_list[5],
                },
                groups = group_table,
                sounds = unilib.node_sound_dirt_defaults({
                    footstep = {name = "unilib_grass_footstep", gain = 0.4},
                }),

                drop = dirt_name,
                is_ground_content = unilib.caves_chop_dirt_flag,
            }
        )
        add_soil(dirt_name .. "_with_" .. mini_list[1], dry_dirt_flag)

    end

    -- Dirt with advanced litter covers
    for _, mini_list in pairs(advanced_list_no_turf) do

        register_dirt(
            dirt_name .. "_with_" .. mini_list[1],
            orig_name .. "_with_" .. mini_list[2],
            {
                description = do_description(dirt_name, mini_list[3]),
                tiles = {
                    dirt_img .. "^" .. mini_list[4],
                    dirt_img .. "^" .. mini_list[5],
                },
                groups = group_table,
                sounds = unilib.node_sound_dirt_defaults({
                    footstep = {name = "unilib_grass_footstep", gain = 0.4},
                }),

                drop = dirt_name,
                is_ground_content = unilib.caves_chop_dirt_flag,
            }
        )
        add_soil(dirt_name .. "_with_" .. mini_list[1], dry_dirt_flag)

    end

    -- Biome-specific turfs
    for _, mini_list in pairs(biome_list) do

        register_biome_dirt(
            dirt_name, orig_name, dirt_img, group_table,
            mini_list[1], mini_list[2], mini_list[3],
            soil_flag, dry_dirt_flag
        )

    end

    -- Dirt-stone mixes
    register_dirt(
        "unilib:stone_ordinary_with_" .. item_name,
        orig_name .. "_with_stone",
        {
            description = do_reverse_description(dirt_name, S("Ordinary Stone")),
            tiles = {
                "unilib_stone_ordinary.png^(" .. dirt_img .. "^[mask:unilib_mask_stone.png)",
            },
            groups = group_table,
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.4},
            }),

            is_ground_content = unilib.caves_chop_dirt_flag,
        }
    )

    register_dirt(
        "unilib:stone_ordinary_cobble_with_" .. item_name,
        orig_name .. "_with_stone_cobble",
        {
            description = do_reverse_description(dirt_name, S("Ordinary Cobblestone")),
            tiles = {
                "unilib_stone_ordinary_cobble.png^(" .. dirt_img ..
                        "^[mask:unilib_mask_stone_cobble.png)",
            },
            groups = group_table,
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.4},
            }),

            is_ground_content = unilib.caves_chop_dirt_flag,
        }
    )

    register_dirt(
        "unilib:stone_desert_cobble_with_" .. item_name,
        orig_name .. "_with_stone_desert_cobble",
        {
            description = do_reverse_description(dirt_name, S("Desert Cobblestone")),
            tiles = {
                "unilib_stone_desert_cobble.png^(" .. dirt_img ..
                        "^[mask:unilib_mask_stone_cobble.png)",
            },
            groups = group_table,
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.4},
            }),

            is_ground_content = unilib.caves_chop_dirt_flag,
        }
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_custom_glemr11.init()

    return {
        description = "Creates various dirts with various turf covers from GLEMr11",
        notes = "Combines various dirt types with various soil types to provide a set of" ..
                " \"custom\" dirts",
        optional = {
            -- Basic dirt types
            "clay_antipodean",
            "clay_ordinary",
            "clay_red",
            "dirt_black",
            "dirt_brown",
            "dirt_clayey",
            "dirt_coarse",
            "dirt_dark",
            "dirt_dried",
            "dirt_mud_dry",
            "dirt_mud_swamp",
            "dirt_ordinary",
            "dirt_parched",
            "dirt_peat_antipodean",
            "dirt_permafrost_dark",
            "dirt_red_antipodean",
            "dirt_sandy",
            "dirt_silt_coarse",
            "dirt_silt_fine",
            "mineral_sodalite_rock",
            "sand_silt",
            "sand_silt_antipodean",
            -- Soil types
            "soil_arid",
            "soil_ordinary",
        },
    }

end

function unilib.pkg.dirt_custom_glemr11.exec()

    register_dirt_set({
        item_name = "dirt_ordinary",
        orig_name = "lib_materials:dirt",
        soil_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_black",
        orig_name = "lib_materials:dirt_black",
        soil_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_brown",
        orig_name = "lib_materials:dirt_brown",
        soil_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_clayey",
        orig_name = "lib_materials:dirt_clayey",
        soil_flag = false,
    })

    register_dirt_set({
        item_name = "clay_red",
        orig_name = "lib_materials:dirt_clay_red",
        soil_flag = false,
    })

    register_dirt_set({
        item_name = "clay_ordinary",
        orig_name = "lib_materials:dirt_clay_white",
        soil_flag = false,
    })

    register_dirt_set({
        item_name = "dirt_coarse",
        orig_name = "lib_materials:dirt_coarse",
        soil_flag = false,
    })

    register_dirt_set({
        item_name = "dirt_dark",
        orig_name = "lib_materials:dirt_dark",
        soil_flag = false,
    })

    register_dirt_set({
        item_name = "dirt_parched",
        orig_name = "lib_materials:dirt_dry",
        soil_flag = true,

        dry_dirt_flag = true,
    })

    -- N.B. The player will slowly sink into the dirt, but not the dirt-with-turf nodes created by
    --      this package
    register_dirt_set({
        item_name = "dirt_mud_swamp",
        orig_name = "lib_materials:dirt_mud_01",
        soil_flag = false,
    })

    register_dirt_set({
        item_name = "dirt_sandy",
        orig_name = "lib_materials:dirt_sandy",
        soil_flag = false,
    })

    register_dirt_set({
        item_name = "sand_silt",
        orig_name = "lib_materials:dirt_silt_01",
        soil_flag = false,
    })

    register_dirt_set({
        item_name = "dirt_silt_coarse",
        orig_name = "lib_materials:dirt_silt_02",
        soil_flag = false,
    })

    register_dirt_set({
        item_name = "dirt_silt_fine",
        orig_name = "lib_materials:dirt_silty",
        soil_flag = false,
    })

    -- (New in GLEMr11)
    register_dirt_set({
        item_name = "clay_antipodean",
        orig_name = "lib_materials:dirt_clay",
        soil_flag = false,
    })

    register_dirt_set({
        item_name = "dirt_dried",
        orig_name = "lib_materials:dirt_dried",
        soil_flag = false,

        dry_dirt_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_mud_dry",
        orig_name = "lib_materials:dirt_mud_dried",
        soil_flag = false,

        dry_dirt_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_peat_antipodean",
        orig_name = "lib_materials:dirt_peat",
        soil_flag = false,
    })

    register_dirt_set({
        item_name = "dirt_permafrost_dark",
        orig_name = "lib_materials:dirt_permafrost",
        soil_flag = false,
    })

    register_dirt_set({
        item_name = "dirt_red_antipodean",
        orig_name = "lib_materials:dirt_red",
        soil_flag = false,
    })

    register_dirt_set({
        item_name = "mineral_sodalite_rock",
        orig_name = "lib_materials:dirt_sod",
        soil_flag = false,
    })

    register_dirt_set({
        item_name = "sand_silt_antipodean",
        orig_name = "lib_materials:dirt_silt_03",
        soil_flag = false,
    })

end
