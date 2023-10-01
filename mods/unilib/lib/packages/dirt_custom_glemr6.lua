---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_custom_glemr6 = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr6.add_mode

-- Custom dirt palettes
local TURF_HUMID_PALETTE_1 = "#43e9a5:80"
local TURF_HUMID_PALETTE_2 = "#36e44b:80"
local TURF_HUMID_PALETTE_3 = "#81da62:80"
local TURF_HUMID_PALETTE_4 = "#93fc54:80"
local TURF_SEMIHUMID_PALETTE_1 = "#69e942:80"
local TURF_SEMIHUMID_PALETTE_2 = "#b1e436:80"
local TURF_SEMIHUMID_PALETTE_3 = "#dacf61:80"
local TURF_SEMIHUMID_PALETTE_4 = "#fcd953:80"
local TURF_TEMPERATE_PALETTE_1 = "#ace943:80"
local TURF_TEMPERATE_PALETTE_2 = "#e4d136:80"
local TURF_TEMPERATE_PALETTE_3 = "#daa062:80"
local TURF_TEMPERATE_PALETTE_4 = "#fc9754:80"
local TURF_SEMIARID_PALETTE_1 = "#e9df43:80"
local TURF_SEMIARID_PALETTE_2 = "#e48836:80"
local TURF_SEMIARID_PALETTE_3 = "#da6e62:80"
local TURF_SEMIARID_PALETTE_4 = "#fc5458:80"

local TURF_WET_PALETTE_1 = "#43e9a5:80"
local TURF_WET_PALETTE_2 = "#36e44b:80"
local TURF_WET_PALETTE_3 = "#81da62:80"
local TURF_WET_PALETTE_4 = "#93fc54:80"
local TURF_LUSH_PALETTE_1 = "#69e942:80"
local TURF_LUSH_PALETTE_2 = "#b1e436:80"
local TURF_LUSH_PALETTE_3 = "#dacf61:80"
local TURF_LUSH_PALETTE_4 = "#fcd953:80"
local TURF_DRY_PALETTE_1 = "#ace943:80"
local TURF_DRY_PALETTE_2 = "#e4d136:80"
local TURF_DRY_PALETTE_3 = "#daa062:80"
local TURF_DRY_PALETTE_4 = "#fc9754:80"
local TURF_BROWN_PALETTE_1 = "#e9df43:80"
local TURF_BROWN_PALETTE_2 = "#e48836:80"
local TURF_BROWN_PALETTE_3 = "#da6e62:80"
local TURF_BROWN_PALETTE_4 = "#fc5458:80"

-- Customisable turf textures
-- (From lib_materials_grass_coastal_top.png)
local TURF_COASTAL_TEXTURE_TOP = "unilib_turf_custom_coastal_top.png"
-- (From lib_materials_grass_coastal_side.png)
local TURF_COASTAL_TEXTURE_SIDE = "unilib_turf_custom_coastal_side_overlay.png"
-- (From lib_materials_grass_lowland_top.png)
local TURF_LOWLAND_TEXTURE_TOP = "unilib_turf_custom_lowland_top.png"
-- (From lib_materials_grass_lowland_side.png)
local TURF_LOWLAND_TEXTURE_SIDE = "unilib_turf_custom_lowland_side_overlay.png"
-- (From lib_materials_grass_shelf_top.png)
local TURF_SHELF_TEXTURE_TOP = "unilib_turf_custom_shelf_top.png"
-- (From lib_materials_grass_shelf_side.png)
local TURF_SHELF_TEXTURE_SIDE = "unilib_turf_custom_shelf_side_overlay.png"
-- (From lib_materials_grass_highland_top.png)
local TURF_HIGHLAND_TEXTURE_TOP = "unilib_turf_custom_highland_top.png"
-- (From lib_materials_grass_highland_side.png)
local TURF_HIGHLAND_TEXTURE_SIDE = "unilib_turf_custom_highland_side_overlay.png"

-- (From lib_materials_grass.png)
local TURF_TEXTURE_TOP = "unilib_turf_custom_top.png"
-- (From lib_materials_grass_side.png)
local TURF_TEXTURE_SIDE = "unilib_turf_custom_side_overlay.png"
-- (From lib_materials_grass_brown.png)
local TURF_BROWN_TEXTURE_TOP = "unilib_turf_custom_brown_top.png"
-- (From lib_materials_grass_brown_side.png)
local TURF_BROWN_TEXTURE_SIDE = "unilib_turf_custom_brown_side_overlay.png"
-- (From lib_materials_dry_grass.png)
local TURF_DRY_TEXTURE_TOP = "unilib_turf_custom_dry_top.png"
-- (From lib_materials_dry_grass_side.png)
local TURF_DRY_TEXTURE_SIDE = "unilib_turf_custom_dry_side_overlay.png"
-- (From lib_materials_grass_jungle_01_top.png)
local TURF_JUNGLE_TEXTURE_TOP = "unilib_turf_custom_jungle_top.png"
-- (From lib_materials_grass_jungle_01_side.png)
local TURF_JUNGLE_TEXTURE_SIDE = "unilib_turf_custom_jungle_side_overlay.png"

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

-- (Also used by the "biome_glemr6" and "deco_glemr6" packages)

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
unilib.pkg.dirt_custom_glemr6.dirt_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_description(dirt_name, turf_description)

    -- Original to unilib
    -- Creates a dirt/turf description in a standard format, e.g. "Ordinary Dirt with Green Turf"

    local def_table = minetest.registered_nodes[dirt_name]
    return S("@1 with @2", def_table.description, turf_description)

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

    elseif unilib.pkg.dirt_custom_glemr6.dirt_table[full_name] ~= nil then

        unilib.pkg.dirt_custom_glemr6.dirt_table[full_name]["def_table"]["soil"] = soil_table

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
            unilib.pkg.dirt_custom_glemr6.dirt_table[full_name] = {}
            unilib.pkg.dirt_custom_glemr6.dirt_table[full_name]["def_table"] = def_table
            unilib.pkg.dirt_custom_glemr6.dirt_table[full_name]["orig_name"] = orig_name

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
            unilib.pkg.dirt_custom_glemr6.dirt_table[full_name] = data_table

        end

    end

end

local function register_biome_dirt(
    dirt_name, orig_name, dirt_img, group_table, part_biome_name, part_description, palette,
    soil_flag, dry_dirt_flag
)
    -- Original to unilib
    -- This function is called with a biome indication (e.g. "hot_humid") and a palette
    --      (e.g. TURF_HUMID_PALETTE_4) to create four dirt/turf nodes

    local item_name = unilib.get_item_name(dirt_name)

    local part_name = "_with_turf_" .. part_biome_name .. "_coastal"
    register_dirt_with_turf(
        item_name,
        "turf_" .. part_biome_name .. "_coastal",
        orig_name .. part_name,
        {
            description = do_description(dirt_name, part_description),
            tiles = {
                "" .. TURF_COASTAL_TEXTURE_TOP .. "^[colorize:" .. palette .. "",
                dirt_img,
                dirt_img .. "^(" .. TURF_COASTAL_TEXTURE_SIDE .. "^[colorize:" .. palette .. ")",
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
                "" .. TURF_LOWLAND_TEXTURE_TOP .. "^[colorize:" .. palette .. "",
                dirt_img,
                dirt_img .. "^(" .. TURF_LOWLAND_TEXTURE_SIDE .. "^[colorize:" .. palette .. ")",
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
                "" .. TURF_SHELF_TEXTURE_TOP .. "^[colorize:" .. palette .. "",
                dirt_img,
                dirt_img .. "^(" .. TURF_SHELF_TEXTURE_SIDE .. "^[colorize:" .. palette .. ")",
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

    part_name = "_with_turf_" .. part_biome_name .. "_highland"
    register_dirt_with_turf(
        item_name,
        "turf_" .. part_biome_name .. "_highland",
        orig_name .. part_name,
        {
            description = do_description(dirt_name, part_description),
            tiles = {
                "" .. TURF_HIGHLAND_TEXTURE_TOP .. "^[colorize:" .. palette .. "",
                dirt_img,
                dirt_img .. "^(" .. TURF_HIGHLAND_TEXTURE_SIDE .. "^[colorize:" .. palette .. ")",
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
    --      basic_dirt_flag (bool): true if only dirt nodes with ordinary and dry turfs should be
    --          created; false if all dirt-with-turf nodes should be created
    --      dry_dirt_flag (bool): true for dry dirts, false otherwise (n.B. not to be confused with
    --          dry turfs)

    local item_name = data_table.item_name
    local orig_name = data_table.orig_name
    local soil_flag = data_table.soil_flag

    local basic_dirt_flag = data_table.basic_dirt_flag or false
    local dry_dirt_flag = data_table.dry_dirt_flag or false

    if unilib.pkg_executed_table[item_name] == nil then
        return
    end

    local dirt_name = "unilib:" .. item_name
    local dirt_img = "unilib_" .. item_name .. ".png"

    -- N.B. spreading_dirt_type not in original GLEMr4 code, but is in original minetest_game
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

    -- The "dirt_ordinary" package already provides several of these nodes
    if item_name ~= "dirt_ordinary" then

        -- N.B. This variant is not defined by the original GLEMr6 code, but it is used by its
        --      biomes
        register_dirt_with_turf(
            item_name,
            "turf",
            orig_name .. "_with_grass",
            {
                description = do_description(dirt_name, S("Turf")),
                tiles = {
                    "unilib_turf_ordinary_top.png",
                    dirt_img,
                    dirt_img .. "^unilib_turf_ordinary_side_overlay.png",
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
            S("Turf")
        )

        register_dirt(
            dirt_name .. "_with_litter_coniferous",
            orig_name .. "_with_coniferous_litter",
            {
                description = do_description(dirt_name, S("Coniferous Litter")),
                tiles = {
                    "unilib_litter_coniferous.png",
                    dirt_img,
                    {
                        name = dirt_img .. "^unilib_litter_coniferous_side_overlay.png",
                        tileable_vertical = false,
                    },
                },
                groups = group_table,
                sounds = unilib.node_sound_dirt_defaults({
                    footstep = {name = "unilib_grass_footstep", gain = 0.4},
                }),

                drop = dirt_name,
                is_ground_content = unilib.caves_chop_dirt_flag,
            }
        )
        add_soil(dirt_name .. "_with_litter_coniferous", dry_dirt_flag)

        register_dirt(
            dirt_name .. "_with_litter_rainforest",
            orig_name .. "_with_rainforest_litter",
            {
                description = do_description(dirt_name, S("Rainforest Litter")),
                tiles = {
                    "unilib_litter_rainforest.png",
                    dirt_img,
                    {
                        name = dirt_img .. "^unilib_litter_rainforest_side_overlay.png",
                        tileable_vertical = false,
                    },
                },
                groups = group_table,
                sounds = unilib.node_sound_dirt_defaults({
                    footstep = {name = "unilib_grass_footstep", gain = 0.4},
                }),

                drop = dirt_name,
                is_ground_content = unilib.caves_chop_dirt_flag,
            }
        )
        add_soil(dirt_name .. "_with_litter_rainforest", dry_dirt_flag)

        register_dirt(
            dirt_name .. "_with_snow_ordinary",
            orig_name .. "_with_snow",
            {
                description = do_description(dirt_name, S("Snow")),
                tiles = {
                    "unilib_snow_ordinary.png",
                    dirt_img,
                    {
                        name = dirt_img .. "^unilib_snow_ordinary_side_overlay.png",
                        tileable_vertical = false,
                    },
                },
                -- N.B. snowy and spreading_dirt_type not in original GLEMr6 code, but is in
                --      original minetest_game code
                groups = {
                    crumbly = 3, dry_dirt = dry_dirt, snowy = 1, soil = soil,
                    spreading_dirt_type = 1,
                },
                -- N.B. Gain is 0.25 in original GLEMr6 code, but 0.2 in original minetest_game
                --      code
                sounds = unilib.node_sound_dirt_defaults({
                    footstep = {name = "unilib_snow_footstep", gain = 0.2},
                }),

                drop = dirt_name,
                is_ground_content = unilib.caves_chop_dirt_flag,
            }
        )
        -- N.B. GLEMr6 does specify soil here, but we don't do that, because it doesn't match GLEMr4
        -- (No soil)

        -- N.B. This variant is not defined by the original GLEMr6 code, but it is used by its
        --      biomes
        register_dirt_with_turf(
            item_name,
            "turf_dry",
            orig_name .. "_with_dry_grass",
            {
                description = do_description(dirt_name, S("Dry Turf")),
                tiles = {
                    "unilib_turf_dry_top.png",
                    dirt_img,
                    {
                        name = dirt_img .. "^unilib_turf_dry_side_overlay.png",
                        tileable_vertical = false,
                    },
                },
                -- N.B. As in the original minetest_game code, dry turf does not spread
                groups = {crumbly = 3, dry_dirt = dry_dirt, soil = soil},
                sounds = unilib.node_sound_dirt_defaults({
                    footstep = {name = "unilib_grass_footstep", gain = 0.4},
                }),

                drop = dirt_name,
                is_ground_content = unilib.caves_chop_dirt_flag,
            },
            soil_flag,
            dry_dirt_flag,
            S("Dry Turf")
        )

    end

    -- (Some basic dirt types only have three covers, and no turfs)
    if basic_dirt_flag then
        return
    end

    -- Biome-specific turfs
    register_biome_dirt(
        dirt_name, orig_name, dirt_img, group_table,
        "hot_humid", S("Hot Humid Turf"), TURF_HUMID_PALETTE_4,
        soil_flag, dry_dirt_flag
    )
    register_biome_dirt(
        dirt_name, orig_name, dirt_img, group_table,
        "hot_semihumid", S("Hot Semi-Humid Turf"), TURF_SEMIHUMID_PALETTE_4,
        soil_flag, dry_dirt_flag
    )
    register_biome_dirt(
        dirt_name, orig_name, dirt_img, group_table,
        "hot_temperate", S("Hot Temperate Turf"), TURF_TEMPERATE_PALETTE_4,
        soil_flag, dry_dirt_flag
    )
    register_biome_dirt(
        dirt_name, orig_name, dirt_img, group_table,
        "hot_semiarid", S("Hot Semi-Arid Turf"), TURF_SEMIARID_PALETTE_4,
        soil_flag, dry_dirt_flag
    )

    register_biome_dirt(
        dirt_name, orig_name, dirt_img, group_table,
        "warm_humid", S("Warm Humid Turf"), TURF_HUMID_PALETTE_3,
        soil_flag, dry_dirt_flag
    )
    register_biome_dirt(
        dirt_name, orig_name, dirt_img, group_table,
        "warm_semihumid", S("Warm Semi-Humid Turf"), TURF_SEMIHUMID_PALETTE_3,
        soil_flag, dry_dirt_flag
    )
    register_biome_dirt(
        dirt_name, orig_name, dirt_img, group_table,
        "warm_temperate", S("Warm Temperate Turf"), TURF_TEMPERATE_PALETTE_3,
        soil_flag, dry_dirt_flag
    )
    register_biome_dirt(
        dirt_name, orig_name, dirt_img, group_table,
        "warm_semiarid", S("Warm Semi-Arid Turf"), TURF_SEMIARID_PALETTE_3,
        soil_flag, dry_dirt_flag
    )

    register_biome_dirt(
        dirt_name, orig_name, dirt_img, group_table,
        "temperate_humid", S("Temperate Humid Turf"), TURF_HUMID_PALETTE_2,
        soil_flag, dry_dirt_flag
    )
    register_biome_dirt(
        dirt_name, orig_name, dirt_img, group_table,
        "temperate_semihumid", S("Temperate Semi-Humid Turf"), TURF_SEMIHUMID_PALETTE_2,
        soil_flag, dry_dirt_flag
    )
    register_biome_dirt(
        dirt_name, orig_name, dirt_img, group_table,
        "temperate_temperate", S("Temperate Temperate Turf"), TURF_TEMPERATE_PALETTE_2,
        soil_flag, dry_dirt_flag
    )
    register_biome_dirt(
        dirt_name, orig_name, dirt_img, group_table,
        "temperate_semiarid", S("Temperate Semi-Arid Turf"), TURF_SEMIARID_PALETTE_2,
        soil_flag, dry_dirt_flag
    )

    register_biome_dirt(
        dirt_name, orig_name, dirt_img, group_table,
        "cool_humid", S("Cool Humid Turf"), TURF_HUMID_PALETTE_1,
        soil_flag, dry_dirt_flag
    )
    register_biome_dirt(
        dirt_name, orig_name, dirt_img, group_table,
        "cool_semihumid", S("Cool Semi-Humid Turf"), TURF_SEMIHUMID_PALETTE_1,
        soil_flag, dry_dirt_flag
    )
    register_biome_dirt(
        dirt_name, orig_name, dirt_img, group_table,
        "cool_temperate", S("Cool Temperate Turf"), TURF_TEMPERATE_PALETTE_1,
        soil_flag, dry_dirt_flag
    )
    register_biome_dirt(
        dirt_name, orig_name, dirt_img, group_table,
        "cool_semiarid", S("Cool Semi-Arid Turf"), TURF_SEMIARID_PALETTE_1,
        soil_flag, dry_dirt_flag
    )

    -- Exotic turfs
    for i, palette in ipairs({
        TURF_WET_PALETTE_1, TURF_WET_PALETTE_2, TURF_WET_PALETTE_3, TURF_WET_PALETTE_4,
        TURF_LUSH_PALETTE_1, TURF_LUSH_PALETTE_2, TURF_LUSH_PALETTE_3, TURF_LUSH_PALETTE_4,
        TURF_DRY_PALETTE_1, TURF_DRY_PALETTE_2, TURF_DRY_PALETTE_3, TURF_DRY_PALETTE_4,
        TURF_BROWN_PALETTE_1, TURF_BROWN_PALETTE_2, TURF_BROWN_PALETTE_3, TURF_BROWN_PALETTE_4,
    }) do

        register_dirt_with_turf(
            item_name,
            "turf_exotic_wet_"  .. tostring(i),
            orig_name .. "_with_grass_wet_" .. string.format("%02d", i),
            {
                description = do_description(dirt_name, S("Wet Exotic Turf")),
                tiles = {
                    "" .. TURF_JUNGLE_TEXTURE_TOP .. "^[colorize:" .. palette .. "",
                    dirt_img,
                    dirt_img .. "^(" .. TURF_JUNGLE_TEXTURE_SIDE .. "^[colorize:" .. palette .. ")",
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
            S("Wet Exotic Turf")
        )

        register_dirt_with_turf(
            item_name,
            "turf_exotic_lush_"  .. tostring(i),
            orig_name .. "_with_grass_lush_" .. string.format("%02d", i),
            {
                description = do_description(dirt_name, S("Lush Exotic Turf")),
                tiles = {
                    "" .. TURF_TEXTURE_TOP .. "^[colorize:" .. palette .. "",
                    dirt_img,
                    dirt_img .. "^(" .. TURF_TEXTURE_SIDE .. "^[colorize:" .. palette .. ")",
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
            S("Lush Exotic Turf")
        )

        register_dirt_with_turf(
            item_name,
            "turf_exotic_dry_"  .. tostring(i),
            orig_name .. "_with_grass_dry_" .. string.format("%02d", i),
            {
                description = do_description(dirt_name, S("Dry Exotic Turf")),
                tiles = {
                    "" .. TURF_DRY_TEXTURE_TOP .. "^[colorize:" .. palette .. "",
                    dirt_img,
                    dirt_img .. "^(" .. TURF_DRY_TEXTURE_SIDE .. "^[colorize:" .. palette .. ")",
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
            S("Dry Exotic Turf")
        )

        register_dirt_with_turf(
            item_name,
            "turf_exotic_brown_"  .. tostring(i),
            orig_name .. "_with_grass_brown_" .. string.format("%02d", i),
            {
                description = do_description(dirt_name, S("Exotic Brown Turf")),
                tiles = {
                    "" .. TURF_BROWN_TEXTURE_TOP .. "^[colorize:" .. palette .. "",
                    dirt_img,
                    dirt_img .. "^(" .. TURF_BROWN_TEXTURE_SIDE .. "^[colorize:" .. palette .. ")",
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
            S("Exotic Brown Turf")
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_custom_glemr6.init()

    return {
        description = "Creates various dirts with various turf covers from GLEMr6",
        notes = "Combines various dirt types with various soil types to provide a set of" ..
                " \"custom\" dirts",
        optional = {
            -- Basic dirt types
            "clay_ordinary",
            "clay_red",
            "dirt_black",
            "dirt_brown",
            "dirt_clayey",
            "dirt_coarse",
            "dirt_dark",
            "dirt_mud_swamp",
            "dirt_ordinary",
            "dirt_parched",
            "dirt_sandy",
            "dirt_silt_coarse",
            "dirt_silt_fine",
            "sand_silt",
            -- Additional dirt types
--          "dirt_ordinary",
            -- Soil types
            "soil_arid",
            "soil_ordinary",
        },
    }

end

function unilib.pkg.dirt_custom_glemr6.exec()

    -- (Full set of turfs/covers)

    register_dirt_set({
        item_name = "dirt_ordinary",
        orig_name = "lib_materials:dirt",
        soil_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_brown",
        orig_name = "lib_materials:dirt_brown",
        soil_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_black",
        orig_name = "lib_materials:dirt_black",
        soil_flag = true,
    })

    register_dirt_set({
        item_name = "clay_red",
        orig_name = "lib_materials:dirt_clay_red",
        soil_flag = false,
    })

    register_dirt_set({
        item_name = "dirt_clayey",
        orig_name = "lib_materials:dirt_clayey",
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

    -- (New in GLEMr6)
    register_dirt_set({
        item_name = "clay_ordinary",
        orig_name = "lib_materials:dirt_clay_white",
        soil_flag = false,
    })

    -- (No turfs, just a small selection of covers)

    register_dirt_set({
        item_name = "dirt_coarse",
        orig_name = "lib_materials:dirt_coarse",
        soil_flag = false,

        basic_dirt_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_dark",
        orig_name = "lib_materials:dirt_dark",
        soil_flag = false,

        basic_dirt_flag = true,
    })

    register_dirt_set({
        item_name = "dirt_parched",
        orig_name = "lib_materials:dirt_dry",
        soil_flag = true,

        basic_dirt_flag = true,
        dry_dirt_flag = true,
    })

    -- N.B. The player will slowly sink into the dirt, but not the dirt-with-turf nodes created by
    --      this package
    register_dirt_set({
        item_name = "dirt_mud_swamp",
        orig_name = "lib_materials:dirt_mud_01",
        soil_flag = false,

        basic_dirt_flag = true,
    })

end
