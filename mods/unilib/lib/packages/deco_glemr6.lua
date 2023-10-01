---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_glemr6 = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr6.add_mode

-- Environmental constants (from lib_ecology/init.lua; must match values in the "biome_glemr6"
--      package)
local ALTITUDE_RANGE = 40

local HEIGHT_OCEAN = -192
local HEIGHT_BEACH_MIN = -4
local HEIGHT_SEA = 0
local HEIGHT_BEACH_MAX = 4
local HEIGHT_SNOW_MIN = 285
local HEIGHT_SNOW_MAX = 485

local HEIGHT_COASTAL = HEIGHT_SEA + ALTITUDE_RANGE
local HEIGHT_LOWLAND = HEIGHT_COASTAL + ALTITUDE_RANGE
local HEIGHT_SHELF = HEIGHT_LOWLAND + ALTITUDE_RANGE
local HEIGHT_HIGHLAND = HEIGHT_SHELF + ALTITUDE_RANGE
local HEIGHT_MOUNTAIN = HEIGHT_HIGHLAND + ALTITUDE_RANGE
local HEIGHT_STRATO = 1800

-- Flag set to true, if miscellaneous decorations for waterlilies, cactus, baked clay etc should
--      be placed
local place_misc_decos_flag = true
-- Flag set to true, if we should check that specified nodes and biomes exist, showing a warning for
--      any problems. This flag can be disabled once any changes to the remix and its packages have
--      been checked
local debug_warning_flag = false

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function check_biomes(biome_list)

    -- Check arguments
    for _, biome_name in pairs(biome_list) do

        if minetest.registered_biomes[biome_name] == nil then

            if debug_warning_flag then
                unilib.show_warning("deco_glemr6 package: Unrecognised biome", biome_name)
            end

            return false

        end

    end

    return true

end

local function check_nodes(node_list)

    -- Register dirt on demand (see comments in the "dirt_custom_glemr6" package)
    if unilib.glem_dirt_on_demand_flag then

        for _, full_name in pairs(node_list) do

            if minetest.registered_nodes[full_name] == nil and
                    unilib.pkg.dirt_custom_glemr6.dirt_table[full_name] ~= nil then

                local data_table = unilib.pkg.dirt_custom_glemr6.dirt_table[full_name]
                if data_table.dirt_part_name == nil then

                    -- Short format, specifying only orig_name and the node definition
                    unilib.register_node(
                        full_name, data_table.orig_name, mode, data_table.def_table
                    )

                else

                    -- Long format, specifying everything required by calls to
                    --      unilib.register_dirt_with_turf()
                    unilib.register_dirt_with_turf(data_table)

                end

            end

        end

    end

    -- Check arguments
    for _, full_name in pairs(node_list) do

        if not unilib.is_registered_node_or_mtgame_alias(full_name) then

            if debug_warning_flag then
                unilib.show_warning("deco_glemr6 package: Unrecognised node", full_name)
            end

            return false

        elseif unilib.get_mod_name(full_name) ~= "unilib" then

            -- (Not a fatal error)
            if debug_warning_flag then
                unilib.show_warning("deco_glemr6 package: Non-unilib node", full_name)
            end

        end

    end

    return true

end

local function add_node(a, b, c, d, e, f, g, h, i)

    if not check_biomes(c) or not check_nodes(a) then
        return
    end

    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = f,

        place_on = a,
        sidelen = 80,
        fill_ratio = b,
        biomes = c,
        y_min = d,
        y_max = e,
        height_max = g,
        spawn_by = h,
        num_spawn_by = i,
    })

end

local function add_schem(a, b, c, d, e, f, g, h)

    if not check_biomes(d) or not check_nodes(a) then
        return
    end

    unilib.register_decoration_simple({
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/" .. g .. ".mts",

        place_on = a,
        sidelen = b,
        fill_ratio = c,
        biomes = d,
        y_min = e,
        y_max = f,
        flags = h or "place_center_x, place_center_z",
        rotation = "random",
    })

end

local function add_schem_offset(a, b, c, d, e, f, g, h, i)

    if not check_biomes(d) or not check_nodes(a) then
        return
    end

    unilib.register_decoration_simple({
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/" .. g .. ".mts",

        place_on = a,
        sidelen = b,
        fill_ratio = c,
        biomes = d,
        y_min = e,
        y_max = f,
        place_offset_y = h,
        flags = i or "place_center_x, place_center_z",
        rotation = "random",
    })

end

local function add_schem_no_rotate(a, b, c, d, e, f, g, h)

    if not check_biomes(d) or not check_nodes(a) then
        return
    end

    unilib.register_decoration_simple({
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/" .. g .. ".mts",

        place_on = a,
        sidelen = b,
        fill_ratio = c,
        biomes = d,
        y_min = e,
        y_max = f,
        flags = h or "place_center_x, place_center_z",
        rotation = "0",
    })

end

---------------------------------------------------------------------------------------------------
-- Hot biomes
---------------------------------------------------------------------------------------------------

local function add_decorations_hot_humid()

    -- glemr6_hot_humid_ocean

    -- glemr6_hot_humid_beach
    -- trees
    add_schem({"unilib:sand_silt"}, 80, 0.35, {"glemr6_hot_humid_beach"}, 0, 2, "unilib_glem_tree_mangrove_green_1")
    add_schem({"unilib:sand_silt"}, 80, 0.35, {"glemr6_hot_humid_beach"}, 0, 2, "unilib_glem_tree_mangrove_green_2")
    add_schem({"unilib:sand_silt"}, 80, 0.35, {"glemr6_hot_humid_beach"}, 0, 2, "unilib_glem_tree_mangrove_green_3")
    add_schem({"unilib:sand_silt"}, 80, 0.35, {"glemr6_hot_humid_beach"}, 0, 2, "unilib_glem_tree_mangrove_green_4")
    add_schem({"unilib:sand_silt"}, 80, 0.35, {"glemr6_hot_humid_beach"}, 0, 2, "unilib_glem_tree_mangrove_green_5")
    add_schem({"unilib:sand_silt"}, 80, 0.35, {"glemr6_hot_humid_beach"}, 0, 2, "unilib_glem_tree_mangrove_green_6")
    -- saplings

    -- glemr6_hot_humid_coastal
    -- trees
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.02, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_jungle_exotic_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.02, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_jungle_exotic_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.02, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_jungle_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.02, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_jungle_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.02, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_plain_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.02, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_plain_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.02, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.02, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_3")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.02, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_5")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.02, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_exotic_7")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.02, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_exotic_9")
    -- saplings
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_coastal"}, 0.01, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_jungle"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_coastal"}, 0.01, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_coastal"}, 0.03, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_rainforest_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_coastal"}, 0.03, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_rainforest_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_coastal"}, 0.03, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_rainforest_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_coastal"}, 0.03, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_rainforest_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_coastal"}, 0.03, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_rainforest_5"}, nil, nil, nil)
    -- ferns
    add_schem_no_rotate({"unilib:dirt_ordinary_with_turf_hot_humid_coastal"}, 80, 0.02, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_fern_giant_1")
    add_schem_no_rotate({"unilib:dirt_ordinary_with_turf_hot_humid_coastal"}, 80, 0.02, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_fern_yellow")
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_coastal"}, 0.02, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:tree_fern_giant_sapling"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_coastal"}, 0.02, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:tree_fern_sapling"}, nil, nil, nil)
    -- flowers
    -- plants
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_coastal"}, 0.01, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_deciduous"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_coastal"}, 0.01, {"glemr6_hot_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:tree_young_jungle"}, nil, nil, nil)

    -- glemr6_hot_humid_lowland
    -- trees
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.04, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_exotic_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.04, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_exotic_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.04, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_jungle_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.04, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_jungle_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.04, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_plain_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.04, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_plain_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.04, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.04, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_3")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.04, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_4")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.04, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_exotic_5")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.04, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_exotic_7")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.04, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_exotic_8")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.04, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_exotic_10")
    -- saplings
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_lowland"}, 0.01, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_jungle"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_lowland"}, 0.01, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_lowland"}, 0.01, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_lowland"}, 0.01, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_lowland"}, 0.01, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_lowland"}, 0.01, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_lowland"}, 0.01, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_5"}, nil, nil, nil)
    -- ferns
    add_schem_no_rotate({"unilib:dirt_ordinary_with_turf_hot_humid_lowland"}, 80, 0.003, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fern_giant_1")
    add_schem_no_rotate({"unilib:dirt_ordinary_with_turf_hot_humid_lowland"}, 80, 0.002, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fern_yellow")
    -- flowers
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_lowland"}, 0.003, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:flower_orchid"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_lowland"}, 0.003, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_deciduous"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_lowland"}, 0.003, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:produce_pineapple_grow_8"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_lowland"}, 0.003, {"glemr6_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:tree_young_jungle"}, nil, nil, nil)

    -- glemr6_hot_humid_shelf
    -- trees
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.06, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_plant_bamboo_small_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.06, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.06, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.06, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_3")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.06, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_exotic_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.06, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_exotic_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.06, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_exotic_3")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.06, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_exotic_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.06, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_exotic_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.06, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_jungle_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.06, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_jungle_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.06, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_plain_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.06, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_plain_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.06, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.06, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_3")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.06, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_4")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.06, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_exotic_6")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.06, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_exotic_8")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_shelf"}, 0.01, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_jungle"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_shelf"}, 0.01, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_bamboo"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_shelf"}, 0.01, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_shelf"}, 0.01, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_shelf"}, 0.01, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_shelf"}, 0.01, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_shelf"}, 0.01, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_5"}, nil, nil, nil)
    -- ferns
    add_schem_no_rotate({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.003, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fern_giant_1")
    add_schem_no_rotate({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.002, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fern_yellow")
    add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.002, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:tree_fern_giant_sapling"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.002, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:tree_fern_sapling"}, nil, nil, nil)
    -- flowers
    -- plants
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_shelf"}, 0.003, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_deciduous"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.003, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:produce_pineapple_grow_8"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_shelf"}, 0.003, {"glemr6_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:tree_young_jungle"}, nil, nil, nil)

    -- glemr6_hot_humid_highland
    -- trees
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_plant_bamboo_small_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_bamboo_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_bamboo_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_bamboo_3")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_bamboo_exotic_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_bamboo_exotic_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_bamboo_exotic_3")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_5")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_mature_5")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_exotic_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_exotic_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_palm_jungle_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_palm_jungle_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_palm_plain_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_palm_plain_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_palm_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_palm_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_palm_5")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_palm_exotic_7")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_palm_exotic_8")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_palm_exotic_9")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_highland"}, 0.01, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_jungle"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_highland"}, 0.01, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_bamboo"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_highland"}, 0.01, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_highland"}, 0.01, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_highland"}, 0.01, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_highland"}, 0.01, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_highland"}, 0.01, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_5"}, nil, nil, nil)
    -- ferns
    add_schem_no_rotate({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.003, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fern_giant_1")
    add_schem_no_rotate({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.002, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fern_yellow")
    add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.002, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:tree_fern_giant_sapling"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.002, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:tree_fern_sapling"}, nil, nil, nil)
    -- flowers
    -- plants
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_highland"}, 0.003, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_aloe_vera"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_humid_highland"}, 0.003, {"glemr6_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:tree_young_jungle"}, nil, nil, nil)

    -- glemr6_hot_humid_mountain

end

local function add_decorations_hot_semihumid()

    -- glemr6_hot_semihumid_ocean

    -- glemr6_hot_semihumid_beach
    -- trees
    -- N.B. "glemr6_hot_semihumid_coastal" in original code - appears to be a mistake
    add_schem({"unilib:sand_silt"}, 80, 0.008, {"glemr6_hot_semihumid_beach"}, 0, 1, "unilib_glem_tree_mangrove_green_1")
    add_schem({"unilib:sand_silt"}, 80, 0.008, {"glemr6_hot_semihumid_beach"}, 0, 1, "unilib_glem_tree_mangrove_green_2")
    add_schem({"unilib:sand_silt"}, 80, 0.008, {"glemr6_hot_semihumid_beach"}, 0, 1, "unilib_glem_tree_mangrove_green_3")
    add_schem({"unilib:sand_silt"}, 80, 0.008, {"glemr6_hot_semihumid_beach"}, 0, 1, "unilib_glem_tree_mangrove_green_4")
    add_schem({"unilib:sand_silt"}, 80, 0.008, {"glemr6_hot_semihumid_beach"}, 0, 1, "unilib_glem_tree_mangrove_green_5")
    add_schem({"unilib:sand_silt"}, 80, 0.008, {"glemr6_hot_semihumid_beach"}, 0, 1, "unilib_glem_tree_mangrove_green_6")
    -- saplings

    -- glemr6_hot_semihumid_coastal
    -- trees
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_coastal"}, 80, 0.02, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_jungle_exotic_1")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_coastal"}, 80, 0.02, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_jungle_exotic_2")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_coastal"}, 80, 0.02, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_jungle_1")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_coastal"}, 80, 0.02, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_jungle_2")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_coastal"}, 80, 0.02, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_plain_1")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_coastal"}, 80, 0.02, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_plain_2")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_coastal"}, 80, 0.02, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_1")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_coastal"}, 80, 0.02, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_4")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_coastal"}, 80, 0.02, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_7")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_coastal"}, 80, 0.02, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_jungle_6")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_coastal"}, 80, 0.02, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_jungle_mature_6")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_coastal"}, 80, 0.02, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_jungle_ancient_6")
    -- saplings
    -- grasses
    add_node({"unilib:dirt_black_with_turf_hot_semihumid_coastal"}, 0.01, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_jungle"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_coastal"}, 0.01, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_rainforest_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_coastal"}, 0.01, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_rainforest_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_coastal"}, 0.01, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_rainforest_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_coastal"}, 0.01, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_rainforest_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_coastal"}, 0.01, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_rainforest_5"}, nil, nil, nil)
    -- ferns
    add_schem_no_rotate({"unilib:dirt_silt_fine_with_turf_hot_semihumid_coastal"}, 80, 0.003, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_fern_giant_1")
    add_schem_no_rotate({"unilib:dirt_silt_fine_with_turf_hot_semihumid_coastal"}, 80, 0.003, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_fern_yellow")
    add_node({"unilib:dirt_silt_fine_with_turf_hot_semihumid_coastal"}, 0.002, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:tree_fern_giant_sapling"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_hot_semihumid_coastal"}, 0.002, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:tree_fern_sapling"}, nil, nil, nil)
    -- flowers
    -- plants
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_coastal"}, 0.005, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:plant_shrub_banana"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_coastal"}, 0.003, {"glemr6_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:tree_young_jungle"}, nil, nil, nil)

    -- glemr6_hot_semihumid_lowland
    -- trees
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_exotic_1")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_exotic_2")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_jungle_1")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_jungle_2")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_plain_1")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_plain_2")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_3")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_4")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_5")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_6")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_7")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_8")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_mature_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_mature_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_mature_3")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_mature_4")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_mature_5")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_mature_6")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_mature_7")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_mature_8")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_ancient_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_ancient_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_ancient_3")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_ancient_4")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_ancient_5")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_ancient_6")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_ancient_7")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.04, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_ancient_8")
    -- grasses
    add_node({"unilib:dirt_black_with_turf_hot_semihumid_lowland"}, 0.01, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_jungle"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_lowland"}, 0.01, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_lowland"}, 0.01, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_lowland"}, 0.01, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_lowland"}, 0.01, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_lowland"}, 0.01, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_5"}, nil, nil, nil)
    -- ferns
    add_schem_no_rotate({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.003, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fern_giant_1")
    add_schem_no_rotate({"unilib:dirt_silt_fine_with_turf_hot_semihumid_lowland"}, 80, 0.003, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fern_yellow")
    -- flowers
    -- plants
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_lowland"}, 0.005, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_shrub_banana"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_lowland"}, 0.003, {"glemr6_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:tree_young_jungle"}, nil, nil, nil)

    -- glemr6_hot_semihumid_shelf
    -- trees
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_shelf"}, 80, 0.06, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_plant_bamboo_small_1")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_shelf"}, 80, 0.06, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_1")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_shelf"}, 80, 0.06, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_2")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_shelf"}, 80, 0.06, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_3")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_shelf"}, 80, 0.06, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_exotic_1")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_shelf"}, 80, 0.06, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_exotic_2")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_shelf"}, 80, 0.06, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_exotic_3")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_shelf"}, 80, 0.06, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_exotic_1")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_shelf"}, 80, 0.06, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_jungle_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_shelf"}, 80, 0.06, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_shelf"}, 80, 0.06, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_5")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_shelf"}, 80, 0.06, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_mature_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_shelf"}, 80, 0.06, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_mature_5")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_shelf"}, 80, 0.06, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_ancient_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_shelf"}, 80, 0.06, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_ancient_5")
    -- grasses
    add_node({"unilib:dirt_black_with_turf_hot_semihumid_shelf"}, 0.01, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_jungle"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_shelf"}, 0.01, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_shelf"}, 0.01, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_shelf"}, 0.01, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_shelf"}, 0.01, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_shelf"}, 0.01, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_5"}, nil, nil, nil)
    -- ferns
    add_schem_no_rotate({"unilib:dirt_silt_fine_with_turf_hot_semihumid_shelf"}, 80, 0.003, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fern_giant_1")
    add_schem_no_rotate({"unilib:dirt_silt_fine_with_turf_hot_semihumid_shelf"}, 80, 0.003, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fern_yellow")
    add_node({"unilib:dirt_silt_fine_with_turf_hot_semihumid_shelf"}, 0.004, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_dicksonia"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_hot_semihumid_shelf"}, 0.001, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_lady"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_hot_semihumid_shelf"}, 0.001, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_broad_leaf"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_hot_semihumid_shelf"}, 0.003, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"lib_ecology:fern_boston"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_hot_semihumid_shelf"}, 0.001, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_horsetail_young"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_hot_semihumid_shelf"}, 0.001, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_horsetail_small"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_hot_semihumid_shelf"}, 0.001, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_horsetail_medium"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_hot_semihumid_shelf"}, 0.001, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_horsetail_large"}, nil, nil, nil)
    -- flowers
    -- plants
    add_node({"unilib:dirt_silt_fine_with_turf_hot_semihumid_shelf"}, 0.003, {"glemr6_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:tree_young_jungle"}, nil, nil, nil)

    -- glemr6_hot_semihumid_highland
    -- trees
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_highland"}, 80, 0.08, {"glemr6_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_plant_bamboo_small_1")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_highland"}, 80, 0.08, {"glemr6_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_bamboo_2")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_highland"}, 80, 0.08, {"glemr6_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_bamboo_exotic_2")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_highland"}, 80, 0.08, {"glemr6_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_exotic_1")
    add_schem({"unilib:dirt_black_with_turf_hot_semihumid_highland"}, 80, 0.08, {"glemr6_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_palm_jungle_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_highland"}, 80, 0.08, {"glemr6_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_7")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_highland"}, 80, 0.08, {"glemr6_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_8")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_highland"}, 80, 0.08, {"glemr6_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_mature_7")
    add_schem({"unilib:dirt_silt_fine_with_turf_hot_semihumid_highland"}, 80, 0.08, {"glemr6_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_mature_8")
    -- grasses
    add_node({"unilib:dirt_black_with_turf_hot_semihumid_highland"}, 0.01, {"glemr6_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_highland"}, 0.01, {"glemr6_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_highland"}, 0.01, {"glemr6_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_highland"}, 0.01, {"glemr6_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_highland"}, 0.01, {"glemr6_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_ordinary_with_turf_hot_semihumid_highland"}, 0.003, {"glemr6_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:tree_young_jungle"}, nil, nil, nil)

    -- glemr6_hot_semihumid_mountain

end

local function add_decorations_hot_temperate()

    -- glemr6_hot_temperate_ocean

    -- glemr6_hot_temperate_beach
    -- trees
    add_schem({"unilib:sand_volcanic_dust"}, 80, 0.002, {"glemr6_hot_temperate_beach"}, 1, 2, "unilib_glem_tree_palm_1")
    add_schem({"unilib:sand_volcanic_dust"}, 80, 0.002, {"glemr6_hot_temperate_beach"}, 1, 2, "unilib_glem_tree_palm_2")

    -- glemr6_hot_temperate_coastal
    -- trees
    add_schem({"unilib:dirt_black_with_turf_hot_temperate_coastal"}, 80, 0.02, {"glemr6_hot_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_jungle_1")
    add_schem({"unilib:dirt_black_with_turf_hot_temperate_coastal"}, 80, 0.02, {"glemr6_hot_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_jungle_2")
    add_schem({"unilib:dirt_black_with_turf_hot_temperate_coastal"}, 80, 0.02, {"glemr6_hot_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_jungle_3")
    add_schem({"unilib:dirt_black_with_turf_hot_temperate_coastal"}, 80, 0.02, {"glemr6_hot_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_jungle_4")
    add_schem({"unilib:dirt_black_with_turf_hot_temperate_coastal"}, 80, 0.02, {"glemr6_hot_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_jungle_5")
    add_schem({"unilib:dirt_black_with_turf_hot_temperate_coastal"}, 80, 0.02, {"glemr6_hot_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_jungle_6")
    add_schem({"unilib:dirt_black_with_turf_hot_temperate_coastal"}, 80, 0.02, {"glemr6_hot_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_jungle_7")
    add_schem({"unilib:dirt_ordinary_with_turf_hot_temperate_coastal"}, 80, 0.02, {"glemr6_hot_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_jungle_8")
    add_schem({"unilib:dirt_ordinary_with_turf_hot_temperate_coastal"}, 80, 0.02, {"glemr6_hot_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_jungle_mature_1")
    add_schem({"unilib:dirt_ordinary_with_turf_hot_temperate_coastal"}, 80, 0.02, {"glemr6_hot_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_jungle_ancient_1")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_hot_temperate_coastal"}, 0.01, {"glemr6_hot_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_rainforest_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_temperate_coastal"}, 0.01, {"glemr6_hot_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_rainforest_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_temperate_coastal"}, 0.01, {"glemr6_hot_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_rainforest_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_temperate_coastal"}, 0.01, {"glemr6_hot_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_rainforest_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_temperate_coastal"}, 0.01, {"glemr6_hot_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_rainforest_5"}, nil, nil, nil)

    -- glemr6_hot_temperate_lowland
    -- trees
    add_schem({"unilib:dirt_black_with_turf_hot_temperate_lowland"}, 80, 0.04, {"glemr6_hot_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_1")
    add_schem({"unilib:dirt_black_with_turf_hot_temperate_lowland"}, 80, 0.04, {"glemr6_hot_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_2")
    add_schem({"unilib:dirt_black_with_turf_hot_temperate_lowland"}, 80, 0.04, {"glemr6_hot_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_4")
    add_schem({"unilib:dirt_black_with_turf_hot_temperate_lowland"}, 80, 0.04, {"glemr6_hot_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_6")
    add_schem({"unilib:dirt_black_with_turf_hot_temperate_lowland"}, 80, 0.04, {"glemr6_hot_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_8")
    add_schem({"unilib:dirt_ordinary_with_turf_hot_temperate_lowland"}, 80, 0.04, {"glemr6_hot_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_mature_1")
    add_schem({"unilib:dirt_ordinary_with_turf_hot_temperate_lowland"}, 80, 0.04, {"glemr6_hot_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_ancient_1")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_hot_temperate_lowland"}, 0.01, {"glemr6_hot_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_temperate_lowland"}, 0.01, {"glemr6_hot_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_temperate_lowland"}, 0.01, {"glemr6_hot_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_temperate_lowland"}, 0.01, {"glemr6_hot_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_temperate_lowland"}, 0.01, {"glemr6_hot_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_5"}, nil, nil, nil)

    -- glemr6_hot_temperate_shelf
    -- trees
    add_schem({"unilib:dirt_black_with_turf_hot_temperate_shelf"}, 80, 0.06, {"glemr6_hot_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_1")
    add_schem({"unilib:dirt_black_with_turf_hot_temperate_shelf"}, 80, 0.06, {"glemr6_hot_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_5")
    add_schem({"unilib:dirt_black_with_turf_hot_temperate_shelf"}, 80, 0.06, {"glemr6_hot_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_6")
    add_schem({"unilib:dirt_black_with_turf_hot_temperate_shelf"}, 80, 0.06, {"glemr6_hot_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_7")
    add_schem({"unilib:dirt_black_with_turf_hot_temperate_shelf"}, 80, 0.06, {"glemr6_hot_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_8")
    add_schem({"unilib:dirt_ordinary_with_turf_hot_temperate_shelf"}, 80, 0.06, {"glemr6_hot_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_mature_1")
    add_schem({"unilib:dirt_ordinary_with_turf_hot_temperate_shelf"}, 80, 0.06, {"glemr6_hot_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_ancient_1")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_hot_temperate_shelf"}, 0.01, {"glemr6_hot_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_temperate_shelf"}, 0.01, {"glemr6_hot_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_temperate_shelf"}, 0.01, {"glemr6_hot_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_temperate_shelf"}, 0.01, {"glemr6_hot_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_temperate_shelf"}, 0.01, {"glemr6_hot_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_5"}, nil, nil, nil)

    -- glemr6_hot_temperate_highland
    -- trees
    add_schem({"unilib:dirt_black_with_turf_hot_temperate_highland"}, 80, 0.08, {"glemr6_hot_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_1")
    add_schem({"unilib:dirt_black_with_turf_hot_temperate_highland"}, 80, 0.08, {"glemr6_hot_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_2")
    add_schem({"unilib:dirt_black_with_turf_hot_temperate_highland"}, 80, 0.08, {"glemr6_hot_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_3")
    add_schem({"unilib:dirt_black_with_turf_hot_temperate_highland"}, 80, 0.08, {"glemr6_hot_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_4")
    add_schem({"unilib:dirt_black_with_turf_hot_temperate_highland"}, 80, 0.08, {"glemr6_hot_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_5")
    add_schem({"unilib:dirt_ordinary_with_turf_hot_temperate_highland"}, 80, 0.08, {"glemr6_hot_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_mature_1")
    add_schem({"unilib:dirt_ordinary_with_turf_hot_temperate_highland"}, 80, 0.08, {"glemr6_hot_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_ancient_1")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_hot_temperate_highland"}, 0.01, {"glemr6_hot_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_temperate_highland"}, 0.01, {"glemr6_hot_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_temperate_highland"}, 0.01, {"glemr6_hot_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_temperate_highland"}, 0.01, {"glemr6_hot_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_temperate_highland"}, 0.01, {"glemr6_hot_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_5"}, nil, nil, nil)

    -- glemr6_hot_temperate_mountain

end

local function add_decorations_hot_semiarid()

    -- glemr6_hot_semiarid_ocean

    -- glemr6_hot_semiarid_beach

    -- glemr6_hot_semiarid_coastal
    -- trees
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_coastal"}, 80, 0.02, {"glemr6_hot_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_acacia_2")
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_coastal"}, 80, 0.02, {"glemr6_hot_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_acacia_1")
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_coastal"}, 80, 0.02, {"glemr6_hot_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_acacia_3")
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_coastal"}, 80, 0.02, {"glemr6_hot_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_acacia_log", "place_center_x, place_center_z")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_hot_semiarid_coastal"}, 0.01, {"glemr6_hot_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semiarid_coastal"}, 0.01, {"glemr6_hot_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semiarid_coastal"}, 0.01, {"glemr6_hot_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semiarid_coastal"}, 0.01, {"glemr6_hot_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semiarid_coastal"}, 0.01, {"glemr6_hot_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr6_hot_semiarid_lowland
    -- trees
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_lowland"}, 80, 0.04, {"glemr6_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_acacia_2")
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_lowland"}, 80, 0.04, {"glemr6_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_acacia_1")
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_lowland"}, 80, 0.04, {"glemr6_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_acacia_3")
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_lowland"}, 80, 0.04, {"glemr6_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_acacia_log", "place_center_x, place_center_z")
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_lowland"}, 80, 0.04, {"glemr6_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_date_1")
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_lowland"}, 80, 0.04, {"glemr6_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_date_2")
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_lowland"}, 80, 0.04, {"glemr6_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_date_3")
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_lowland"}, 80, 0.04, {"glemr6_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_date_4")
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_lowland"}, 80, 0.04, {"glemr6_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_date_5")
     -- saplings
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_hot_semiarid_lowland"}, 0.01, {"glemr6_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semiarid_lowland"}, 0.01, {"glemr6_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semiarid_lowland"}, 0.01, {"glemr6_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semiarid_lowland"}, 0.01, {"glemr6_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semiarid_lowland"}, 0.01, {"glemr6_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr6_hot_semiarid_shelf
    -- trees
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_shelf"}, 80, 0.06, {"glemr6_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_acacia_2")
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_shelf"}, 80, 0.06, {"glemr6_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_acacia_1")
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_shelf"}, 80, 0.06, {"glemr6_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_acacia_3")
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_shelf"}, 80, 0.06, {"glemr6_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_acacia_log", "place_center_x, place_center_z")
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_shelf"}, 80, 0.06, {"glemr6_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_date_1")
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_shelf"}, 80, 0.06, {"glemr6_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_date_2")
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_shelf"}, 80, 0.06, {"glemr6_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_date_3")
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_shelf"}, 80, 0.06, {"glemr6_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_date_4")
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_shelf"}, 80, 0.06, {"glemr6_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_date_5")
    -- saplings
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_hot_semiarid_shelf"}, 0.01, {"glemr6_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semiarid_shelf"}, 0.01, {"glemr6_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semiarid_shelf"}, 0.01, {"glemr6_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semiarid_shelf"}, 0.01, {"glemr6_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semiarid_shelf"}, 0.01, {"glemr6_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr6_hot_semiarid_highland
    -- trees
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_highland"}, 80, 0.08, {"glemr6_hot_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_acacia_2")
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_highland"}, 80, 0.08, {"glemr6_hot_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_acacia_1")
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_highland"}, 80, 0.08, {"glemr6_hot_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_acacia_3")
    add_schem({"unilib:dirt_sandy_with_turf_hot_semiarid_highland"}, 80, 0.08, {"glemr6_hot_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_acacia_log", "place_center_x, place_center_z")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_hot_semiarid_highland"}, 0.01, {"glemr6_hot_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semiarid_highland"}, 0.01, {"glemr6_hot_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semiarid_highland"}, 0.01, {"glemr6_hot_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semiarid_highland"}, 0.01, {"glemr6_hot_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_hot_semiarid_highland"}, 0.01, {"glemr6_hot_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr6_hot_semiarid_mountain

end

local function add_decorations_hot_arid()

    -- glemr6_hot_arid_ocean

    -- glemr6_hot_arid_beach
     -- grasses
    add_node({"unilib:sand_silica"}, 0.01, {"glemr6_hot_arid_beach"}, 1, HEIGHT_BEACH_MAX, {"unilib:grass_ordinary_1"}, nil, nil, nil)

    -- glemr6_hot_arid_coastal
     -- grasses
    add_node({"unilib:stone_sandstone_white"}, 0.01, {"glemr6_hot_arid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_1"}, nil, nil, nil)

    -- glemr6_hot_arid_lowland
     -- grasses
    add_node({"unilib:stone_sandstone_white"}, 0.01, {"glemr6_hot_arid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)

    -- glemr6_hot_arid_shelf
     -- grasses
    add_node({"unilib:stone_sandstone_white"}, 0.01, {"glemr6_hot_arid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_1"}, nil, nil, nil)

    -- glemr6_hot_arid_highland
     -- grasses
    add_node({"unilib:stone_sandstone_white"}, 0.01, {"glemr6_hot_arid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)

    -- glemr6_hot_arid_mountain

end

---------------------------------------------------------------------------------------------------
-- Warm biomes
---------------------------------------------------------------------------------------------------

local function add_decorations_warm_humid()

    -- glemr6_warm_humid_ocean
    add_node({"unilib:sand_silt"}, 0.04, {"glemr6_warm_humid_ocean"}, -35, -2, {"unilib:plant_kelp_yellow"}, nil, nil, nil)

    -- glemr6_warm_humid_beach

    -- glemr6_warm_humid_coastal
    -- trees
    add_schem({"unilib:sand_silt"}, 80, 0.05, {"glemr6_warm_humid_coastal"}, 0, 1, "unilib_glem_tree_mangrove_green_1")
    add_schem({"unilib:sand_silt"}, 80, 0.05, {"glemr6_warm_humid_coastal"}, 0, 1, "unilib_glem_tree_mangrove_green_2")
    add_schem({"unilib:sand_silt"}, 80, 0.05, {"glemr6_warm_humid_coastal"}, 0, 1, "unilib_glem_tree_mangrove_green_3")
    add_schem({"unilib:sand_silt"}, 80, 0.05, {"glemr6_warm_humid_coastal"}, 0, 1, "unilib_glem_tree_mangrove_green_4")
    add_schem({"unilib:sand_silt"}, 80, 0.05, {"glemr6_warm_humid_coastal"}, 0, 1, "unilib_glem_tree_mangrove_green_5")
    add_schem({"unilib:dirt_black_with_turf_warm_humid_coastal"}, 80, 0.02, {"glemr6_warm_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_cypress_1")
    add_schem({"unilib:dirt_black_with_turf_warm_humid_coastal"}, 80, 0.02, {"glemr6_warm_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_cypress_2")
    add_schem({"unilib:dirt_black_with_turf_warm_humid_coastal"}, 80, 0.02, {"glemr6_warm_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_normal_1")
    add_schem({"unilib:dirt_black_with_turf_warm_humid_coastal"}, 80, 0.02, {"glemr6_warm_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_normal_2")
    add_schem({"unilib:dirt_black_with_turf_warm_humid_coastal"}, 80, 0.02, {"glemr6_warm_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_mature_2")
    add_schem({"unilib:dirt_black_with_turf_warm_humid_coastal"}, 80, 0.02, {"glemr6_warm_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_mature_4")
    -- saplings
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_coastal"}, 0.01, {"glemr6_warm_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_coastal"}, 0.01, {"glemr6_warm_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_swamp_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_coastal"}, 0.01, {"glemr6_warm_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_swamp_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_coastal"}, 0.01, {"glemr6_warm_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_swamp_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_coastal"}, 0.01, {"glemr6_warm_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_swamp_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_coastal"}, 0.01, {"glemr6_warm_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_swamp_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_coastal"}, 0.01, {"glemr6_warm_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:plant_juncus_white"}, nil, nil, nil)

    -- glemr6_warm_humid_lowland
    -- trees
    add_schem({"unilib:dirt_black_with_turf_warm_humid_lowland"}, 80, 0.04, {"glemr6_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_cypress_1")
    add_schem({"unilib:dirt_black_with_turf_warm_humid_lowland"}, 80, 0.04, {"glemr6_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_cypress_2")
    add_schem({"unilib:dirt_black_with_turf_warm_humid_lowland"}, 80, 0.04, {"glemr6_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_normal_1")
    add_schem({"unilib:dirt_black_with_turf_warm_humid_lowland"}, 80, 0.04, {"glemr6_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_normal_2")
    add_schem({"unilib:dirt_black_with_turf_warm_humid_lowland"}, 80, 0.04, {"glemr6_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_mature_2")
    add_schem({"unilib:dirt_black_with_turf_warm_humid_lowland"}, 80, 0.04, {"glemr6_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_mature_4")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_lowland"}, 0.01, {"glemr6_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_lowland"}, 0.01, {"glemr6_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_lowland"}, 0.01, {"glemr6_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_lowland"}, 0.01, {"glemr6_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_lowland"}, 0.01, {"glemr6_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_lowland"}, 0.01, {"glemr6_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_lowland"}, 0.01, {"glemr6_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_juncus_white"}, nil, nil, nil)
    add_node({"unilib:dirt_black_with_turf_warm_humid_lowland"}, 0.01, {"glemr6_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_palmetto_saw"}, nil, nil, nil)

    -- glemr6_warm_humid_shelf
    -- trees
    add_schem({"unilib:dirt_black_with_turf_warm_humid_shelf"}, 80, 0.06, {"glemr6_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_cypress_1")
    add_schem({"unilib:dirt_black_with_turf_warm_humid_shelf"}, 80, 0.06, {"glemr6_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_cypress_2")
    add_schem({"unilib:dirt_black_with_turf_warm_humid_shelf"}, 80, 0.06, {"glemr6_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_normal_1")
    add_schem({"unilib:dirt_black_with_turf_warm_humid_shelf"}, 80, 0.06, {"glemr6_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_normal_2")
    add_schem({"unilib:dirt_black_with_turf_warm_humid_shelf"}, 80, 0.06, {"glemr6_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_mature_2")
    add_schem({"unilib:dirt_black_with_turf_warm_humid_shelf"}, 80, 0.06, {"glemr6_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_mature_4")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_shelf"}, 0.01, {"glemr6_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_shelf"}, 0.01, {"glemr6_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_shelf"}, 0.01, {"glemr6_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_shelf"}, 0.01, {"glemr6_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_shelf"}, 0.01, {"glemr6_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_shelf"}, 0.01, {"glemr6_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_shelf"}, 0.01, {"glemr6_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_juncus_white"}, nil, nil, nil)
    add_node({"unilib:dirt_black_with_turf_warm_humid_shelf"}, 0.01, {"glemr6_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_palmetto_saw"}, nil, nil, nil)

    -- glemr6_warm_humid_highland
    -- trees
    add_schem({"unilib:dirt_black_with_turf_warm_humid_highland"}, 80, 0.08, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_deciduous_normal_1")
    add_schem({"unilib:dirt_black_with_turf_warm_humid_highland"}, 80, 0.08, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_deciduous_normal_2")
    add_schem({"unilib:dirt_black_with_turf_warm_humid_highland"}, 80, 0.08, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_deciduous_mature_2")
    add_schem({"unilib:dirt_black_with_turf_warm_humid_highland"}, 80, 0.08, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_deciduous_mature_4")
    add_schem({"unilib:dirt_black_with_turf_warm_humid_highland"}, 80, 0.08, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_deciduous_mature_4")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_mature_3")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_mature_4")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_mature_5")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_ancient_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_ancient_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_ancient_3")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_ancient_4")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_ancient_5")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_ancient_6")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_ancient_7")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.08, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_ancient_8")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_highland"}, 0.02, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_swamp_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_highland"}, 0.02, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_swamp_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_highland"}, 0.02, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_swamp_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_highland"}, 0.02, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_swamp_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_highland"}, 0.02, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_swamp_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_highland"}, 0.02, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_juncus_white"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_humid_highland"}, 0.01, {"glemr6_warm_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_palmetto_saw"}, nil, nil, nil)

    -- glemr6_warm_humid_mountain

end

local function add_decorations_warm_semihumid()

    -- glemr6_warm_semihumid_ocean

    -- glemr6_warm_semihumid_beach

    -- glemr6_warm_semihumid_coastal
    -- trees
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_coastal"}, 80, 0.02, {"glemr6_warm_semihumid_coastal"}, 8, HEIGHT_COASTAL, "unilib_glem_tree_eucalyptus_1")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_coastal"}, 80, 0.02, {"glemr6_warm_semihumid_coastal"}, 8, HEIGHT_COASTAL, "unilib_glem_tree_eucalyptus_large_1")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_coastal"}, 80, 0.02, {"glemr6_warm_semihumid_coastal"}, 6, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_normal_2")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_coastal"}, 80, 0.02, {"glemr6_warm_semihumid_coastal"}, 6, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_normal_3")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_coastal"}, 80, 0.02, {"glemr6_warm_semihumid_coastal"}, 6, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_mature_1")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_coastal"}, 80, 0.02, {"glemr6_warm_semihumid_coastal"}, 6, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_mature_2")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_coastal"}, 80, 0.02, {"glemr6_warm_semihumid_coastal"}, 6, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_mature_3")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_coastal"}, 80, 0.02, {"glemr6_warm_semihumid_coastal"}, 6, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_mature_4")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_coastal"}, 0.01, {"glemr6_warm_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_coastal"}, 0.08, {"glemr6_warm_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_swamp_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_coastal"}, 0.08, {"glemr6_warm_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_swamp_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_coastal"}, 0.08, {"glemr6_warm_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_swamp_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_coastal"}, 0.08, {"glemr6_warm_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_swamp_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_coastal"}, 0.08, {"glemr6_warm_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_swamp_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_coastal"}, 0.01, {"glemr6_warm_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_shrub_banana_large"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_coastal"}, 0.01, {"glemr6_warm_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:fern_christmas"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_coastal"}, 0.01, {"glemr6_warm_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_juncus_white"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_coastal"}, 0.01, {"glemr6_warm_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_palmetto_saw"}, nil, nil, nil)

    -- glemr6_warm_semihumid_lowland
    -- trees
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_lowland"}, 80, 0.04, {"glemr6_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_eucalyptus_1")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_lowland"}, 80, 0.04, {"glemr6_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_eucalyptus_large_1")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_lowland"}, 80, 0.04, {"glemr6_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_normal_2")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_lowland"}, 80, 0.04, {"glemr6_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_normal_3")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_lowland"}, 80, 0.04, {"glemr6_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_mature_1")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_lowland"}, 80, 0.04, {"glemr6_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_mature_2")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_lowland"}, 80, 0.04, {"glemr6_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_mature_3")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_lowland"}, 80, 0.04, {"glemr6_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_mature_4")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_lowland"}, 80, 0.04, {"glemr6_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_rubber_1")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_lowland"}, 80, 0.04, {"glemr6_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_rubber_3")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_lowland"}, 0.01, {"glemr6_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_lowland"}, 0.08, {"glemr6_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_lowland"}, 0.08, {"glemr6_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_lowland"}, 0.08, {"glemr6_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_lowland"}, 0.08, {"glemr6_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_lowland"}, 0.08, {"glemr6_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_lowland"}, 0.01, {"glemr6_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_shrub_banana_large"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_lowland"}, 0.01, {"glemr6_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:fern_christmas"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_lowland"}, 0.01, {"glemr6_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_juncus_white"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_lowland"}, 0.01, {"glemr6_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_palmetto_saw"}, nil, nil, nil)

    -- glemr6_warm_semihumid_shelf
    -- trees
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_shelf"}, 80, 0.06, {"glemr6_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_eucalyptus_1")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_shelf"}, 80, 0.06, {"glemr6_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_eucalyptus_large_1")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_shelf"}, 80, 0.06, {"glemr6_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_normal_2")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_shelf"}, 80, 0.06, {"glemr6_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_normal_3")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_shelf"}, 80, 0.06, {"glemr6_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_mature_1")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_shelf"}, 80, 0.06, {"glemr6_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_mature_2")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_shelf"}, 80, 0.06, {"glemr6_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_mature_3")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_shelf"}, 80, 0.06, {"glemr6_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_mature_4")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_shelf"}, 80, 0.06, {"glemr6_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_rubber_2")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_shelf"}, 80, 0.06, {"glemr6_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_rubber_4")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_shelf"}, 0.01, {"glemr6_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_shelf"}, 0.08, {"glemr6_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_shelf"}, 0.08, {"glemr6_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_shelf"}, 0.08, {"glemr6_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_shelf"}, 0.08, {"glemr6_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_shelf"}, 0.08, {"glemr6_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_shelf"}, 0.01, {"glemr6_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_christmas"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_shelf"}, 0.01, {"glemr6_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_juncus_white"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_shelf"}, 0.01, {"glemr6_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_palmetto_saw"}, nil, nil, nil)

    -- glemr6_warm_semihumid_highland
    -- trees
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_highland"}, 80, 0.08, {"glemr6_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_eucalyptus_1")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_highland"}, 80, 0.08, {"glemr6_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_eucalyptus_large_1")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_highland"}, 80, 0.08, {"glemr6_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_deciduous_normal_2")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_highland"}, 80, 0.08, {"glemr6_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_deciduous_normal_3")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_highland"}, 80, 0.08, {"glemr6_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_deciduous_mature_1")
    add_schem({"unilib:dirt_black_with_turf_warm_semihumid_highland"}, 80, 0.08, {"glemr6_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_deciduous_mature_3")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_highland"}, 0.01, {"glemr6_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_highland"}, 0.08, {"glemr6_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_swamp_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_highland"}, 0.08, {"glemr6_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_swamp_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_highland"}, 0.08, {"glemr6_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_swamp_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_highland"}, 0.08, {"glemr6_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_swamp_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_highland"}, 0.08, {"glemr6_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_swamp_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_ordinary_with_turf_warm_semihumid_highland"}, 0.01, {"glemr6_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_juncus_white"}, nil, nil, nil)

    -- glemr6_warm_semihumid_mountain

end

local function add_decorations_warm_temperate()

    -- glemr6_warm_temperate_ocean

    -- glemr6_warm_temperate_beach
    -- trees
    add_schem({"unilib:sand_ordinary"}, 80, 0.002, {"glemr6_warm_temperate_beach"}, 1, 2, "unilib_glem_tree_palm_1")
    add_schem({"unilib:sand_ordinary"}, 80, 0.002, {"glemr6_warm_temperate_beach"}, 1, 2, "unilib_glem_tree_palm_2")
    add_schem({"unilib:sand_ordinary"}, 80, 0.002, {"glemr6_warm_temperate_beach"}, 1, 2, "unilib_glem_tree_palm_3")

    -- glemr6_warm_temperate_coastal
    -- trees
    add_schem({"unilib:dirt_brown_with_turf_warm_temperate_coastal"}, 80, 0.005, {"glemr6_warm_temperate_coastal"}, 6, HEIGHT_COASTAL, "unilib_glem_tree_apple_1")
    add_schem({"unilib:dirt_brown_with_turf_warm_temperate_coastal"}, 80, 0.02, {"glemr6_warm_temperate_coastal"}, 6, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_normal_tall_1")
    add_schem({"unilib:dirt_clayey_with_turf_warm_temperate_coastal"}, 80, 0.02, {"glemr6_warm_temperate_coastal"}, 8, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_mature_1")
    add_schem({"unilib:dirt_clayey_with_turf_warm_temperate_coastal"}, 80, 0.02, {"glemr6_warm_temperate_coastal"}, 8, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_mature_3")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_coastal"}, 0.09, {"glemr6_warm_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_coastal"}, 0.07, {"glemr6_warm_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_swamp_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_coastal"}, 0.07, {"glemr6_warm_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_swamp_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_coastal"}, 0.07, {"glemr6_warm_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_swamp_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_coastal"}, 0.07, {"glemr6_warm_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_swamp_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_coastal"}, 0.07, {"glemr6_warm_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_swamp_5"}, nil, nil, nil)

    -- glemr6_warm_temperate_lowland
    -- trees
    if unilib.pkg_executed_table["tree_apple_mature"] ~= nil then
        add_schem({"unilib:dirt_brown_with_turf_warm_temperate_lowland"}, 80, 0.015, {"glemr6_warm_temperate_lowland"}, 35, 42, "unilib_glem_tree_banana_1")
    end
    add_schem({"unilib:dirt_brown_with_turf_warm_temperate_lowland"}, 80, 0.04, {"glemr6_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_apple_1")
    add_schem({"unilib:dirt_brown_with_turf_warm_temperate_lowland"}, 80, 0.005, {"glemr6_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_mature_5")
    add_schem({"unilib:dirt_clayey_with_turf_warm_temperate_lowland"}, 80, 0.04, {"glemr6_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_normal_tall_1")
    add_schem({"unilib:dirt_clayey_with_turf_warm_temperate_lowland"}, 80, 0.04, {"glemr6_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_mature_1")
    add_schem({"unilib:dirt_clayey_with_turf_warm_temperate_lowland"}, 80, 0.04, {"glemr6_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_mature_3")
    add_schem({"unilib:dirt_clayey_with_turf_warm_temperate_lowland"}, 80, 0.002, {"glemr6_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_ipe_yellow_1")
     -- saplings
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_lowland"}, 0.12, {"glemr6_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_lowland"}, 0.07, {"glemr6_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_lowland"}, 0.07, {"glemr6_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_lowland"}, 0.07, {"glemr6_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_lowland"}, 0.07, {"glemr6_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_lowland"}, 0.07, {"glemr6_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_5"}, nil, nil, nil)

    -- glemr6_warm_temperate_shelf
    -- trees
    add_schem({"unilib:dirt_brown_with_turf_warm_temperate_shelf"}, 80, 0.005, {"glemr6_warm_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_apple_1")
    add_schem({"unilib:dirt_brown_with_turf_warm_temperate_shelf"}, 80, 0.06, {"glemr6_warm_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_normal_tall_1")
    add_schem({"unilib:dirt_clayey_with_turf_warm_temperate_shelf"}, 80, 0.06, {"glemr6_warm_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_mature_1")
    add_schem({"unilib:dirt_clayey_with_turf_warm_temperate_shelf"}, 80, 0.06, {"glemr6_warm_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_mature_3")
    add_schem({"unilib:dirt_clayey_with_turf_warm_temperate_shelf"}, 80, 0.002, {"glemr6_warm_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_ipe_yellow_1")
    -- saplings
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_shelf"}, 0.08, {"glemr6_warm_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_shelf"}, 0.06, {"glemr6_warm_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_shelf"}, 0.06, {"glemr6_warm_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_shelf"}, 0.06, {"glemr6_warm_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_shelf"}, 0.06, {"glemr6_warm_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_shelf"}, 0.06, {"glemr6_warm_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_5"}, nil, nil, nil)

    -- glemr6_warm_temperate_highland
    add_schem({"unilib:dirt_brown_with_turf_warm_temperate_highland"}, 80, 0.004, {"glemr6_warm_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_apple_1")
    add_schem({"unilib:dirt_brown_with_turf_warm_temperate_highland"}, 80, 0.08, {"glemr6_warm_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_deciduous_normal_tall_1")
    add_schem({"unilib:dirt_clayey_with_turf_warm_temperate_highland"}, 80, 0.08, {"glemr6_warm_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_deciduous_mature_1")
    add_schem({"unilib:dirt_clayey_with_turf_warm_temperate_highland"}, 80, 0.08, {"glemr6_warm_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_deciduous_mature_3")
    -- saplings
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_highland"}, 0.04, {"glemr6_warm_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_highland"}, 0.06, {"glemr6_warm_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_swamp_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_highland"}, 0.06, {"glemr6_warm_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_swamp_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_highland"}, 0.06, {"glemr6_warm_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_swamp_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_highland"}, 0.06, {"glemr6_warm_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_swamp_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_temperate_highland"}, 0.06, {"glemr6_warm_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_swamp_5"}, nil, nil, nil)

    -- glemr6_warm_temperate_mountain

end

local function add_decorations_warm_semiarid()

    -- glemr6_warm_semiarid_ocean

    -- glemr6_warm_semiarid_beach

    -- glemr6_warm_semiarid_coastal
    -- trees
    add_schem({"unilib:dirt_sandy_with_turf_warm_semiarid_coastal"}, 80, 0.02, {"glemr6_warm_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_acacia_2")
    add_schem({"unilib:dirt_sandy_with_turf_warm_semiarid_coastal"}, 80, 0.02, {"glemr6_warm_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_acacia_1")
    add_schem({"unilib:dirt_sandy_with_turf_warm_semiarid_coastal"}, 80, 0.02, {"glemr6_warm_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_acacia_3")
    add_schem({"unilib:dirt_sandy_with_turf_warm_semiarid_coastal"}, 80, 0.02, {"glemr6_warm_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_acacia_log", "place_center_x, place_center_z")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_warm_semiarid_coastal"}, 0.03, {"glemr6_warm_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semiarid_coastal"}, 0.03, {"glemr6_warm_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semiarid_coastal"}, 0.03, {"glemr6_warm_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semiarid_coastal"}, 0.03, {"glemr6_warm_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semiarid_coastal"}, 0.03, {"glemr6_warm_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr6_warm_semiarid_lowland
    -- trees
    add_schem({"unilib:dirt_sandy_with_turf_warm_semiarid_lowland"}, 80, 0.04, {"glemr6_warm_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_acacia_2")
    add_schem({"unilib:dirt_sandy_with_turf_warm_semiarid_lowland"}, 80, 0.04, {"glemr6_warm_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_acacia_1")
    add_schem({"unilib:dirt_sandy_with_turf_warm_semiarid_lowland"}, 80, 0.04, {"glemr6_warm_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_acacia_3")
    add_schem({"unilib:dirt_sandy_with_turf_warm_semiarid_lowland"}, 80, 0.04, {"glemr6_warm_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_acacia_log", "place_center_x, place_center_z")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_warm_semiarid_lowland"}, 0.03, {"glemr6_warm_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semiarid_lowland"}, 0.03, {"glemr6_warm_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semiarid_lowland"}, 0.03, {"glemr6_warm_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semiarid_lowland"}, 0.03, {"glemr6_warm_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semiarid_lowland"}, 0.03, {"glemr6_warm_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr6_warm_semiarid_shelf
    -- trees
    add_schem({"unilib:dirt_sandy_with_turf_warm_semiarid_shelf"}, 80, 0.002, {"glemr6_warm_semiarid_shelf"},HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_acacia_1")
    add_schem({"unilib:dirt_sandy_with_turf_warm_semiarid_shelf"}, 80, 0.002, {"glemr6_warm_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_acacia_2")
    add_schem({"unilib:dirt_sandy_with_turf_warm_semiarid_shelf"}, 80, 0.002, {"glemr6_warm_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_acacia_3")
    add_schem({"unilib:dirt_sandy_with_turf_warm_semiarid_shelf"}, 80, 0.002, {"glemr6_warm_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_acacia_log", "place_center_x, place_center_z")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_warm_semiarid_shelf"}, 0.03, {"glemr6_warm_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semiarid_shelf"}, 0.03, {"glemr6_warm_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semiarid_shelf"}, 0.03, {"glemr6_warm_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semiarid_shelf"}, 0.03, {"glemr6_warm_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semiarid_shelf"}, 0.03, {"glemr6_warm_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr6_warm_semiarid_highland
    -- trees
    add_schem({"unilib:dirt_sandy_with_turf_warm_semiarid_highland"}, 80, 0.001, {"glemr6_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_acacia_1")
    add_schem({"unilib:dirt_sandy_with_turf_warm_semiarid_highland"}, 80, 0.001, {"glemr6_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_acacia_2")
    add_schem({"unilib:dirt_sandy_with_turf_warm_semiarid_highland"}, 80, 0.001, {"glemr6_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_acacia_3")
    add_schem({"unilib:dirt_sandy_with_turf_warm_semiarid_highland"}, 80, 0.001, {"glemr6_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_acacia_log", "place_center_x, place_center_z")
    add_schem({"unilib:dirt_clayey_with_turf_warm_semiarid_highland"}, 80, 0.001, {"glemr6_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_baobab_1")
    add_schem({"unilib:dirt_clayey_with_turf_warm_semiarid_highland"}, 80, 0.001, {"glemr6_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_baobab_2")
    add_schem({"unilib:dirt_clayey_with_turf_warm_semiarid_highland"}, 80, 0.001, {"glemr6_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_baobab_3")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_warm_semiarid_highland"}, 0.03, {"glemr6_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semiarid_highland"}, 0.03, {"glemr6_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semiarid_highland"}, 0.03, {"glemr6_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semiarid_highland"}, 0.03, {"glemr6_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_warm_semiarid_highland"}, 0.03, {"glemr6_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr6_warm_semiarid_mountain

end

local function add_decorations_warm_arid()

    -- glemr6_warm_arid_ocean

    -- glemr6_warm_arid_beach

    -- glemr6_warm_arid_coastal

    -- glemr6_warm_arid_lowland

    -- glemr6_warm_arid_shelf

    -- glemr6_warm_arid_highland

    -- glemr6_warm_arid_mountain

end

---------------------------------------------------------------------------------------------------
-- Temperate biomes
---------------------------------------------------------------------------------------------------

local function add_decorations_temperate_humid()

    -- glemr6_temperate_humid_ocean
    add_node({"unilib:sand_silt"}, 0.04, {"glemr6_temperate_humid_ocean"}, -35, -2, {"unilib:plant_seaweed_undersea"}, nil, nil, nil)

    -- glemr6_temperate_humid_beach
    add_node({"unilib:sand_ordinary"}, 0.04, {"glemr6_temperate_humid_beach"}, 1, 4, {"unilib:grass_marram_1"}, nil, nil, nil)
    add_node({"unilib:sand_ordinary"}, 0.04, {"glemr6_temperate_humid_beach"}, 1, 4, {"unilib:grass_marram_2"}, nil, nil, nil)
    add_node({"unilib:sand_ordinary"}, 0.04, {"glemr6_temperate_humid_beach"}, 1, 4, {"unilib:grass_marram_3"}, nil, nil, nil)

    -- glemr6_temperate_humid_coastal
    -- trees
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_coastal"}, 80, 0.02, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_ash_1")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_coastal"}, 80, 0.02, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_chestnut_exotic_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_temperate_humid_coastal"}, 80, 0.02, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_chestnut_exotic_2")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_coastal"}, 80, 0.02, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_poplar_1")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_coastal"}, 80, 0.02, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_poplar_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_temperate_humid_coastal"}, 80, 0.02, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_poplar_3")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_coastal"}, 80, 0.02, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_poplar_small_1")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_coastal"}, 80, 0.02, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_poplar_small_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_temperate_humid_coastal"}, 80, 0.02, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_poplar_small_3")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_coastal"}, 80, 0.02, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_willow_large_1")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_coastal"}, 80, 0.02, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_willow_large_2")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_coastal"}, 80, 0.02, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_willow_large_3")
    add_schem({"unilib:dirt_silt_fine_with_turf_temperate_humid_coastal"}, 80, 0.02, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_willow_ancient_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_temperate_humid_coastal"}, 80, 0.02, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_willow_ancient_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_temperate_humid_coastal"}, 80, 0.02, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_willow_ancient_3")
    add_schem({"unilib:dirt_silt_fine_with_turf_temperate_humid_coastal"}, 80, 0.02, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_willow_weeping_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_temperate_humid_coastal"}, 80, 0.02, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_willow_weeping_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_temperate_humid_coastal"}, 80, 0.02, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_willow_weeping_3")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_coastal"}, 0.08, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_coastal"}, 0.08, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_coastal"}, 0.08, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_coastal"}, 0.08, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_coastal"}, 0.08, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_5"}, nil, nil, nil)
    --ferns
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_coastal"}, 0.01, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:fern_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_coastal"}, 0.01, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:fern_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_coastal"}, 0.01, {"glemr6_temperate_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:fern_ordinary_3"}, nil, nil, nil)

    -- glemr6_temperate_humid_lowland
    -- trees
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_lowland"}, 80, 0.04, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_ash_1")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_lowland"}, 80, 0.04, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_chestnut_exotic_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_temperate_humid_lowland"}, 80, 0.04, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_chestnut_exotic_2")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_lowland"}, 80, 0.04, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_poplar_small_1")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_lowland"}, 80, 0.04, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_poplar_small_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_temperate_humid_lowland"}, 80, 0.04, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_poplar_small_3")
    add_schem({"unilib:dirt_silt_fine_with_turf_temperate_humid_lowland"}, 80, 0.04, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_poplar_small_4")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_lowland"}, 80, 0.04, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_poplar_small_5")
    add_schem({"unilib:dirt_ordinary_with_turf_temperate_humid_lowland"}, 80, 0.04, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_poplar_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_temperate_humid_lowland"}, 80, 0.04, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_poplar_2")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_lowland"}, 80, 0.04, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_poplar_3")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_lowland"}, 80, 0.04, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_willow_large_1")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_lowland"}, 80, 0.04, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_willow_large_3")
    add_schem({"unilib:dirt_ordinary_with_turf_temperate_humid_lowland"}, 80, 0.04, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_willow_ancient_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_temperate_humid_lowland"}, 80, 0.04, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_willow_ancient_3")
    add_schem({"unilib:dirt_silt_fine_with_turf_temperate_humid_lowland"}, 80, 0.04, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_willow_weeping_1")
    add_schem({"unilib:dirt_ordinary_with_turf_temperate_humid_lowland"}, 80, 0.04, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_willow_weeping_2")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_lowland"}, 0.08, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_lowland"}, 0.08, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_lowland"}, 0.08, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_lowland"}, 0.08, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_lowland"}, 0.08, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)
     --ferns
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_lowland"}, 0.01, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:fern_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_lowland"}, 0.01, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:fern_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_lowland"}, 0.01, {"glemr6_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:fern_ordinary_3"}, nil, nil, nil)

    -- glemr6_temperate_humid_shelf
    -- trees
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_shelf"}, 80, 0.06, {"glemr6_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_beech_mature_1")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_shelf"}, 80, 0.06, {"glemr6_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_beech_mature_2")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_shelf"}, 80, 0.06, {"glemr6_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_oak_1")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_shelf"}, 80, 0.06, {"glemr6_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_oak_2")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_shelf"}, 80, 0.06, {"glemr6_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_oak_4")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_shelf"}, 80, 0.06, {"glemr6_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_oak_5")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_shelf"}, 0.08, {"glemr6_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_shelf"}, 0.08, {"glemr6_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_shelf"}, 0.08, {"glemr6_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_shelf"}, 0.08, {"glemr6_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_shelf"}, 0.08, {"glemr6_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_5"}, nil, nil, nil)
     --ferns
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_shelf"}, 0.01, {"glemr6_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_shelf"}, 0.01, {"glemr6_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_shelf"}, 0.01, {"glemr6_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_shelf"}, 0.01, {"glemr6_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_shelf"}, 0.01, {"glemr6_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_ordinary_3"}, nil, nil, nil)

    -- glemr6_temperate_humid_highland
    -- trees
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_highland"}, 80, 0.08, {"glemr6_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_ancient_1")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_highland"}, 80, 0.08, {"glemr6_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_ancient_1")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_highland"}, 80, 0.08, {"glemr6_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_2")
    add_schem({"unilib:dirt_black_with_turf_temperate_humid_highland"}, 80, 0.08, {"glemr6_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_exposed_3")
    add_schem({"unilib:dirt_silt_fine_with_turf_temperate_humid_highland"}, 80, 0.08, {"glemr6_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_sequoia_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_temperate_humid_highland"}, 80, 0.08, {"glemr6_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_sequoia_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_temperate_humid_highland"}, 80, 0.08, {"glemr6_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_sequoia_3")
    add_schem({"unilib:dirt_silt_fine_with_turf_temperate_humid_highland"}, 80, 0.001, {"glemr6_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_sequoia_giant_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_temperate_humid_highland"}, 80, 0.001, {"glemr6_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_sequoia_giant_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_temperate_humid_highland"}, 80, 0.001, {"glemr6_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_sequoia_giant_3")
    add_schem({"unilib:dirt_silt_fine_with_turf_temperate_humid_highland"}, 80, 0.001, {"glemr6_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_sequoia_giant_4")
    -- saplings
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_highland"}, 0.06, {"glemr6_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_highland"}, 0.06, {"glemr6_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_highland"}, 0.06, {"glemr6_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_highland"}, 0.06, {"glemr6_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_highland"}, 0.06, {"glemr6_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)
     --ferns
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_highland"}, 0.01, {"glemr6_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:fern_broad_leaf"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_highland"}, 0.01, {"glemr6_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:fern_broad_leaf_young"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_highland"}, 0.01, {"glemr6_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:fern_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_humid_highland"}, 0.01, {"glemr6_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:fern_ordinary_3"}, nil, nil, nil)

    -- glemr6_temperate_humid_mountain

end

local function add_decorations_temperate_semihumid()

    -- glemr6_temperate_semihumid_ocean

    -- glemr6_temperate_semihumid_beach
    add_node({"unilib:sand_ordinary"}, 0.05, {"glemr6_temperate_semihumid_beach"}, 1, 4, {"unilib:grass_marram_1"}, nil, nil, nil)
    add_node({"unilib:sand_ordinary"}, 0.05, {"glemr6_temperate_semihumid_beach"}, 1, 4, {"unilib:grass_marram_2"}, nil, nil, nil)
    add_node({"unilib:sand_ordinary"}, 0.05, {"glemr6_temperate_semihumid_beach"}, 1, 4, {"unilib:grass_marram_3"}, nil, nil, nil)

    -- glemr6_temperate_semihumid_coastal
    -- trees
    add_schem({"unilib:dirt_black_with_turf_temperate_semihumid_coastal"}, 80, 0.02, {"glemr6_temperate_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_beech_mature_1")
    add_schem({"unilib:dirt_black_with_turf_temperate_semihumid_coastal"}, 80, 0.02, {"glemr6_temperate_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_beech_mature_2")
    add_schem({"unilib:dirt_black_with_turf_temperate_semihumid_coastal"}, 80, 0.02, {"glemr6_temperate_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_beech_mature_3")
    add_schem({"unilib:dirt_black_with_turf_temperate_semihumid_coastal"}, 80, 0.02, {"glemr6_temperate_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_maple_sugar_1")
    add_schem({"unilib:dirt_black_with_turf_temperate_semihumid_coastal"}, 80, 0.02, {"glemr6_temperate_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_oak_1")
    add_schem({"unilib:dirt_black_with_turf_temperate_semihumid_coastal"}, 80, 0.02, {"glemr6_temperate_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_oak_2")
    add_schem({"unilib:dirt_black_with_turf_temperate_semihumid_coastal"}, 80, 0.02, {"glemr6_temperate_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_oak_3")
    -- saplings
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_coastal"}, 0.05, {"glemr6_temperate_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_coastal"}, 0.05, {"glemr6_temperate_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_coastal"}, 0.05, {"glemr6_temperate_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_coastal"}, 0.05, {"glemr6_temperate_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_coastal"}, 0.05, {"glemr6_temperate_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_5"}, nil, nil, nil)
    -- plants
    add_schem({"unilib:dirt_ordinary_with_turf_temperate_semihumid_coastal"}, 80, 0.01, {"glemr6_temperate_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_bush_ordinary")
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_coastal"}, 0.01, {"glemr6_temperate_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_coastal"}, 0.01, {"glemr6_temperate_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_shrub_forest_deciduous"}, nil, nil, nil)

    -- glemr6_temperate_semihumid_lowland
    -- trees
    add_schem({"unilib:dirt_brown_with_turf_temperate_semihumid_lowland"}, 80, 0.04, {"glemr6_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_beech_mature_1")
    add_schem({"unilib:dirt_brown_with_turf_temperate_semihumid_lowland"}, 80, 0.04, {"glemr6_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_beech_mature_2")
    add_schem({"unilib:dirt_brown_with_turf_temperate_semihumid_lowland"}, 80, 0.04, {"glemr6_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_beech_mature_3")
    add_schem({"unilib:dirt_brown_with_turf_temperate_semihumid_lowland"}, 80, 0.04, {"glemr6_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_maple_sugar_1")
    add_schem({"unilib:dirt_brown_with_turf_temperate_semihumid_lowland"}, 80, 0.04, {"glemr6_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_oak_1")
    add_schem({"unilib:dirt_brown_with_turf_temperate_semihumid_lowland"}, 80, 0.04, {"glemr6_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_oak_2")
    add_schem({"unilib:dirt_brown_with_turf_temperate_semihumid_lowland"}, 80, 0.04, {"glemr6_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_oak_3")
     -- saplings
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_lowland"}, 0.05, {"glemr6_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_lowland"}, 0.05, {"glemr6_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_lowland"}, 0.05, {"glemr6_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_lowland"}, 0.05, {"glemr6_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_lowland"}, 0.05, {"glemr6_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)
    -- plants
    add_schem({"unilib:dirt_ordinary_with_turf_temperate_semihumid_lowland"}, 80, 0.01, {"glemr6_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_bush_ordinary")
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_lowland"}, 0.01, {"glemr6_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_lowland"}, 0.01, {"glemr6_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_shrub_forest_deciduous"}, nil, nil, nil)

    -- glemr6_temperate_semihumid_shelf
    -- trees
    add_schem({"unilib:dirt_black_with_turf_temperate_semihumid_shelf"}, 80, 0.06, {"glemr6_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_beech_mature_1")
    add_schem({"unilib:dirt_brown_with_turf_temperate_semihumid_shelf"}, 80, 0.06, {"glemr6_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_beech_mature_2")
    add_schem({"unilib:dirt_brown_with_turf_temperate_semihumid_shelf"}, 80, 0.06, {"glemr6_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_beech_mature_3")
    add_schem({"unilib:dirt_brown_with_turf_temperate_semihumid_shelf"}, 80, 0.06, {"glemr6_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_maple_sugar_1")
    add_schem({"unilib:dirt_brown_with_turf_temperate_semihumid_shelf"}, 80, 0.06, {"glemr6_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_maple_sugar_large_1")
    add_schem({"unilib:dirt_black_with_turf_temperate_semihumid_shelf"}, 80, 0.06, {"glemr6_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_oak_1")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_shelf"}, 0.05, {"glemr6_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_shelf"}, 0.05, {"glemr6_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_shelf"}, 0.05, {"glemr6_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_shelf"}, 0.05, {"glemr6_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_shelf"}, 0.05, {"glemr6_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_5"}, nil, nil, nil)
     -- plants
    add_schem({"unilib:dirt_ordinary_with_turf_temperate_semihumid_shelf"}, 80, 0.01, {"glemr6_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_bush_ordinary")
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_shelf"}, 0.01, {"glemr6_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_shelf"}, 0.01, {"glemr6_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_shrub_forest_deciduous"}, nil, nil, nil)

    -- glemr6_temperate_semihumid_highland
    add_schem({"unilib:dirt_black_with_turf_temperate_semihumid_highland"}, 80, 0.08, {"glemr6_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_beech_mature_1")
    add_schem({"unilib:dirt_brown_with_turf_temperate_semihumid_highland"}, 80, 0.08, {"glemr6_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_beech_mature_2")
    add_schem({"unilib:dirt_brown_with_turf_temperate_semihumid_highland"}, 80, 0.08, {"glemr6_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_beech_mature_3")
    add_schem({"unilib:dirt_brown_with_turf_temperate_semihumid_highland"}, 80, 0.08, {"glemr6_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_maple_sugar_1")
    add_schem({"unilib:dirt_brown_with_turf_temperate_semihumid_highland"}, 80, 0.08, {"glemr6_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_maple_sugar_large_1")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_highland"}, 0.04, {"glemr6_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_highland"}, 0.04, {"glemr6_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_highland"}, 0.04, {"glemr6_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_highland"}, 0.04, {"glemr6_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_highland"}, 0.04, {"glemr6_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)
     -- plants
    add_schem({"unilib:dirt_ordinary_with_turf_temperate_semihumid_highland"}, 80, 0.01, {"glemr6_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_bush_ordinary")
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_highland"}, 0.01, {"glemr6_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semihumid_highland"}, 0.01, {"glemr6_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_shrub_forest_deciduous"}, nil, nil, nil)

    -- glemr6_temperate_semihumid_mountain

end

local function add_decorations_temperate_temperate()

    -- glemr6_temperate_temperate_ocean

    -- glemr6_temperate_temperate_beach
    add_node({"unilib:sand_ordinary"}, 0.05, {"glemr6_temperate_temperate_beach"}, 1, 4, {"unilib:grass_marram_1"}, nil, nil, nil)
    add_node({"unilib:sand_ordinary"}, 0.05, {"glemr6_temperate_temperate_beach"}, 1, 4, {"unilib:grass_marram_2"}, nil, nil, nil)
    add_node({"unilib:sand_ordinary"}, 0.05, {"glemr6_temperate_temperate_beach"}, 1, 4, {"unilib:grass_marram_3"}, nil, nil, nil)

    -- glemr6_temperate_temperate_coastal
    -- trees
    add_schem({"unilib:dirt_brown_with_turf_temperate_temperate_coastal"}, 80, 0.02, {"glemr6_temperate_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_beech_mature_1")
    add_schem({"unilib:dirt_brown_with_turf_temperate_temperate_coastal"}, 80, 0.02, {"glemr6_temperate_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_beech_mature_2")
    add_schem({"unilib:dirt_brown_with_turf_temperate_temperate_coastal"}, 80, 0.02, {"glemr6_temperate_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_beech_mature_3")
    add_schem({"unilib:dirt_brown_with_turf_temperate_temperate_coastal"}, 80, 0.02, {"glemr6_temperate_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_oak_1")
    add_schem({"unilib:dirt_brown_with_turf_temperate_temperate_coastal"}, 80, 0.02, {"glemr6_temperate_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_oak_2")
    add_schem({"unilib:dirt_clayey_with_turf_temperate_temperate_coastal"}, 80, 0.02, {"glemr6_temperate_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_oak_3")
    add_schem({"unilib:dirt_clayey_with_turf_temperate_temperate_coastal"}, 80, 0.02, {"glemr6_temperate_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_oak_4")
    add_schem({"unilib:dirt_clayey_with_turf_temperate_temperate_coastal"}, 80, 0.02, {"glemr6_temperate_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_oak_5")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_coastal"}, 0.04, {"glemr6_temperate_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_coastal"}, 0.04, {"glemr6_temperate_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_coastal"}, 0.04, {"glemr6_temperate_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_coastal"}, 0.04, {"glemr6_temperate_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_coastal"}, 0.04, {"glemr6_temperate_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_5"}, nil, nil, nil)
     -- flowers
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_coastal"}, 0.01, {"glemr6_temperate_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:flower_daisy_oxeye"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_temperate_temperate_coastal"}, 0.01, {"glemr6_temperate_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:flower_petunia_blue"}, nil, nil, nil)
    add_node({"unilib:dirt_brown_with_turf_temperate_temperate_coastal"}, 0.01, {"glemr6_temperate_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:flower_petunia_pink"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_temperate_temperate_coastal"}, 0.01, {"glemr6_temperate_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:flower_petunia_white"}, nil, nil, nil)
     -- plants
    add_schem({"unilib:dirt_ordinary_with_turf_temperate_temperate_coastal"}, 80, 0.01, {"glemr6_temperate_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_bush_ordinary")
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_coastal"}, 0.01, {"glemr6_temperate_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_coastal"}, 0.01, {"glemr6_temperate_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_shrub_forest_deciduous"}, nil, nil, nil)

    -- glemr6_temperate_temperate_lowland
    -- trees
    add_schem({"unilib:dirt_clayey_with_turf_temperate_temperate_lowland"}, 80, 0.04, {"glemr6_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_beech_mature_1")
    add_schem({"unilib:dirt_brown_with_turf_temperate_temperate_lowland"}, 80, 0.04, {"glemr6_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_beech_mature_2")
    add_schem({"unilib:dirt_clayey_with_turf_temperate_temperate_lowland"}, 80, 0.04, {"glemr6_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_beech_mature_3")
    add_schem({"unilib:dirt_clayey_with_turf_temperate_temperate_lowland"}, 80, 0.04, {"glemr6_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_oak_1")
    add_schem({"unilib:dirt_brown_with_turf_temperate_temperate_lowland"}, 80, 0.04, {"glemr6_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_oak_2")
    add_schem({"unilib:dirt_clayey_with_turf_temperate_temperate_lowland"}, 80, 0.04, {"glemr6_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_oak_3")
    add_schem({"unilib:dirt_brown_with_turf_temperate_temperate_lowland"}, 80, 0.04, {"glemr6_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_oak_4")
    add_schem({"unilib:dirt_clayey_with_turf_temperate_temperate_lowland"}, 80, 0.04, {"glemr6_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_oak_5")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_lowland"}, 0.04, {"glemr6_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_lowland"}, 0.04, {"glemr6_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_lowland"}, 0.04, {"glemr6_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_lowland"}, 0.04, {"glemr6_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_lowland"}, 0.04, {"glemr6_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)
    -- plants
    add_schem({"unilib:dirt_ordinary_with_turf_temperate_temperate_lowland"}, 80, 0.03, {"glemr6_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_bush_ordinary")
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_lowland"}, 0.03, {"glemr6_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_lowland"}, 0.03, {"glemr6_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_shrub_forest_deciduous"}, nil, nil, nil)

    -- glemr6_temperate_temperate_shelf
    -- trees
    add_schem({"unilib:dirt_clayey_with_turf_temperate_temperate_shelf"}, 80, 0.06, {"glemr6_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_beech_mature_1")
    add_schem({"unilib:dirt_brown_with_turf_temperate_temperate_shelf"}, 80, 0.06, {"glemr6_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_beech_mature_2")
    add_schem({"unilib:dirt_clayey_with_turf_temperate_temperate_shelf"}, 80, 0.06, {"glemr6_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_beech_mature_3")
    add_schem({"unilib:dirt_clayey_with_turf_temperate_temperate_shelf"}, 80, 0.06, {"glemr6_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_oak_1")
    add_schem({"unilib:dirt_brown_with_turf_temperate_temperate_shelf"}, 80, 0.06, {"glemr6_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_oak_2")
    add_schem({"unilib:dirt_clayey_with_turf_temperate_temperate_shelf"}, 80, 0.06, {"glemr6_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_oak_3")
    add_schem({"unilib:dirt_clayey_with_turf_temperate_temperate_shelf"}, 80, 0.06, {"glemr6_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_oak_4")
    add_schem({"unilib:dirt_clayey_with_turf_temperate_temperate_shelf"}, 80, 0.06, {"glemr6_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_oak_5")
    add_schem({"unilib:dirt_clayey_with_turf_temperate_temperate_shelf"}, 80, 0.06, {"glemr6_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_pine_ancient_5")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_shelf"}, 0.4, {"glemr6_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_shelf"}, 0.4, {"glemr6_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_shelf"}, 0.4, {"glemr6_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_shelf"}, 0.4, {"glemr6_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_shelf"}, 0.4, {"glemr6_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_5"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_shelf"}, 0.02, {"glemr6_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_tall"}, nil, nil, nil)
     -- plants
    add_schem({"unilib:dirt_ordinary_with_turf_temperate_temperate_shelf"}, 80, 0.02, {"glemr6_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_bush_ordinary")
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_shelf"}, 0.02, {"glemr6_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_shelf"}, 0.02, {"glemr6_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_shrub_forest_deciduous"}, nil, nil, nil)

    -- glemr6_temperate_temperate_highland
    -- trees
    add_schem({"unilib:dirt_clayey_with_turf_temperate_temperate_highland"}, 80, 0.08, {"glemr6_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_cedar_1")
    add_schem({"unilib:dirt_brown_with_turf_temperate_temperate_highland"}, 80, 0.08, {"glemr6_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_cherry_blossom_1")
    add_schem({"unilib:dirt_brown_with_turf_temperate_temperate_highland"}, 80, 0.08, {"glemr6_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_cherry_blossom_2")
    add_schem({"unilib:dirt_brown_with_turf_temperate_temperate_highland"}, 80, 0.08, {"glemr6_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_cherry_blossom_3")
    add_schem({"unilib:dirt_brown_with_turf_temperate_temperate_highland"}, 80, 0.08, {"glemr6_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_exposed_1")
    add_schem({"unilib:dirt_brown_with_turf_temperate_temperate_highland"}, 80, 0.08, {"glemr6_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_exposed_2")
    add_schem({"unilib:dirt_clayey_with_turf_temperate_temperate_highland"}, 80, 0.08, {"glemr6_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_exposed_8")
    add_schem({"unilib:dirt_clayey_with_turf_temperate_temperate_highland"}, 80, 0.08, {"glemr6_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_exposed_9")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_highland"}, 0.03, {"glemr6_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_highland"}, 0.03, {"glemr6_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_highland"}, 0.03, {"glemr6_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_highland"}, 0.03, {"glemr6_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_highland"}, 0.03, {"glemr6_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)
    -- plants
    add_schem({"unilib:dirt_ordinary_with_turf_temperate_temperate_highland"}, 80, 0.01, {"glemr6_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_bush_ordinary")
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_highland"}, 0.01, {"glemr6_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_temperate_highland"}, 0.01, {"glemr6_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_shrub_forest_deciduous"}, nil, nil, nil)

    -- glemr6_temperate_temperate_mountain

end

local function add_decorations_temperate_semiarid()

    -- glemr6_temperate_semiarid_ocean

    -- glemr6_temperate_semiarid_beach

    -- glemr6_temperate_semiarid_coastal
    -- trees
    add_schem({"unilib:dirt_clayey_with_turf_temperate_semiarid_coastal"}, 80, 0.02, {"glemr6_temperate_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_cedar_1")
    add_schem({"unilib:dirt_sandy_with_turf_temperate_semiarid_coastal"}, 80, 0.02, {"glemr6_temperate_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_pine_5")
    add_schem({"unilib:dirt_clayey_with_turf_temperate_semiarid_coastal"}, 80, 0.02, {"glemr6_temperate_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_pine_6")
    add_schem({"unilib:dirt_sandy_with_turf_temperate_semiarid_coastal"}, 80, 0.02, {"glemr6_temperate_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_pine_exposed_1")
    add_schem({"unilib:dirt_sandy_with_turf_temperate_semiarid_coastal"}, 80, 0.02, {"glemr6_temperate_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_pine_exposed_2")
    add_schem({"unilib:dirt_sandy_with_turf_temperate_semiarid_coastal"}, 80, 0.02, {"glemr6_temperate_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_pine_exposed_3")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_coastal"}, 0.02, {"glemr6_temperate_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_coastal"}, 0.02, {"glemr6_temperate_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_coastal"}, 0.02, {"glemr6_temperate_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_coastal"}, 0.02, {"glemr6_temperate_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_coastal"}, 0.02, {"glemr6_temperate_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_clayey_with_turf_temperate_semiarid_coastal"}, 0.01, {"glemr6_temperate_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_cactus_purple_small"}, nil, nil, nil)
    add_node({"unilib:dirt_sandy_with_turf_temperate_semiarid_coastal"}, 0.01, {"glemr6_temperate_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_cactus_purple"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_coastal"}, 0.01, {"glemr6_temperate_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_cactus_small"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_coastal"}, 0.01, {"glemr6_temperate_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_cactus_small_flowering"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_coastal"}, 0.01, {"glemr6_temperate_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_cactus_tiny"}, nil, nil, nil)

    -- glemr6_temperate_semiarid_lowland
    -- trees
    add_schem({"unilib:dirt_clayey_with_turf_temperate_semiarid_lowland"}, 80, 0.001, {"glemr6_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_cedar_1")
    add_schem({"unilib:dirt_sandy_with_turf_temperate_semiarid_lowland"}, 80, 0.001, {"glemr6_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_pine_5")
    add_schem({"unilib:dirt_clayey_with_turf_temperate_semiarid_lowland"}, 80, 0.001, {"glemr6_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_pine_6")
    add_schem({"unilib:dirt_sandy_with_turf_temperate_semiarid_lowland"}, 80, 0.001, {"glemr6_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_pine_exposed_1")
    add_schem({"unilib:dirt_sandy_with_turf_temperate_semiarid_lowland"}, 80, 0.001, {"glemr6_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_pine_exposed_2")
    add_schem({"unilib:dirt_sandy_with_turf_temperate_semiarid_lowland"}, 80, 0.001, {"glemr6_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_pine_exposed_3")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_lowland"}, 0.02, {"glemr6_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_lowland"}, 0.02, {"glemr6_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_lowland"}, 0.02, {"glemr6_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_lowland"}, 0.02, {"glemr6_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_lowland"}, 0.02, {"glemr6_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_5"}, nil, nil, nil)
     -- plants
    add_node({"unilib:dirt_clayey_with_turf_temperate_semiarid_lowland"}, 0.001, {"glemr6_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_cactus_purple_small"}, nil, nil, nil)
    add_node({"unilib:dirt_sandy_with_turf_temperate_semiarid_lowland"}, 0.001, {"glemr6_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_cactus_purple"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_lowland"}, 0.001, {"glemr6_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_cactus_small"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_lowland"}, 0.001, {"glemr6_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_cactus_small_flowering"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_lowland"}, 0.001, {"glemr6_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_cactus_tiny"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_lowland"}, 0.001, {"glemr6_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:tree_young_palm_desert"}, nil, nil, nil)

    -- glemr6_temperate_semiarid_shelf
    -- trees
    add_schem({"unilib:dirt_clayey_with_turf_temperate_semiarid_shelf"}, 80, 0.001, {"glemr6_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_cedar_1")
    add_schem({"unilib:dirt_sandy_with_turf_temperate_semiarid_shelf"}, 80, 0.001, {"glemr6_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_pine_5")
    add_schem({"unilib:dirt_clayey_with_turf_temperate_semiarid_shelf"}, 80, 0.001, {"glemr6_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_pine_6")
    add_schem({"unilib:dirt_sandy_with_turf_temperate_semiarid_shelf"}, 80, 0.001, {"glemr6_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_pine_exposed_1")
    add_schem({"unilib:dirt_sandy_with_turf_temperate_semiarid_shelf"}, 80, 0.001, {"glemr6_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_pine_exposed_2")
    add_schem({"unilib:dirt_sandy_with_turf_temperate_semiarid_shelf"}, 80, 0.001, {"glemr6_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_pine_exposed_3")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_shelf"}, 0.02, {"glemr6_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_shelf"}, 0.02, {"glemr6_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_shelf"}, 0.02, {"glemr6_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_shelf"}, 0.02, {"glemr6_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_shelf"}, 0.02, {"glemr6_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_5"}, nil, nil, nil)
     -- plants
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_shelf"}, 0.01, {"glemr6_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_cactus_thorny"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_temperate_semiarid_shelf"}, 0.01, {"glemr6_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_cactus_purple_small"}, nil, nil, nil)
    add_node({"unilib:dirt_sandy_with_turf_temperate_semiarid_shelf"}, 0.01, {"glemr6_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_cactus_purple"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_shelf"}, 0.01, {"glemr6_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_cactus_small"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_shelf"}, 0.01, {"glemr6_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_cactus_small_flowering"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_shelf"}, 0.01, {"glemr6_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_cactus_tiny"}, nil, nil, nil)

    -- glemr6_temperate_semiarid_highland
    -- trees
    add_schem({"unilib:dirt_clayey_with_turf_temperate_semiarid_highland"}, 80, 0.001, {"glemr6_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_cedar_1")
    add_schem({"unilib:dirt_sandy_with_turf_temperate_semiarid_highland"}, 80, 0.001, {"glemr6_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_5")
    add_schem({"unilib:dirt_clayey_with_turf_temperate_semiarid_highland"}, 80, 0.001, {"glemr6_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_6")
    add_schem({"unilib:dirt_sandy_with_turf_temperate_semiarid_highland"}, 80, 0.001, {"glemr6_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_exposed_1")
    add_schem({"unilib:dirt_sandy_with_turf_temperate_semiarid_highland"}, 80, 0.001, {"glemr6_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_exposed_2")
    add_schem({"unilib:dirt_sandy_with_turf_temperate_semiarid_highland"}, 80, 0.001, {"glemr6_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_exposed_3")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_highland"}, 0.02, {"glemr6_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_highland"}, 0.02, {"glemr6_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_highland"}, 0.02, {"glemr6_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_highland"}, 0.02, {"glemr6_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_highland"}, 0.02, {"glemr6_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_5"}, nil, nil, nil)
     -- plants
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_highland"}, 0.01, {"glemr6_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_cactus_thorny"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_temperate_semiarid_highland"}, 0.01, {"glemr6_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_cactus_small"}, nil, nil, nil)

    -- glemr6_temperate_semiarid_mountain

end

local function add_decorations_temperate_arid()

    -- glemr6_temperate_arid_ocean

    -- glemr6_temperate_arid_beach

    -- glemr6_temperate_arid_coastal
    -- grasses
    add_node({"unilib:dirt_coarse"}, 0.01, {"glemr6_temperate_arid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse"}, 0.01, {"glemr6_temperate_arid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse"}, 0.01, {"glemr6_temperate_arid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse"}, 0.01, {"glemr6_temperate_arid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse"}, 0.01, {"glemr6_temperate_arid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_5"}, nil, nil, nil)
     -- plants
    add_node({"unilib:dirt_coarse"}, 0.01, {"glemr6_temperate_arid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_cactus_small"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse"}, 0.01, {"glemr6_temperate_arid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_cactus_small_flowering"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse"}, 0.01, {"glemr6_temperate_arid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_enigma"}, nil, nil, nil)
    add_schem({"unilib:dirt_coarse"}, 80, 0.01, {"glemr6_temperate_arid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_plant_cactus_ordinary_large")
    add_node({"unilib:dirt_coarse"}, 0.01, {"glemr6_temperate_arid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_cactus_thorny"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse"}, 0.01, {"glemr6_temperate_arid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_nettle_scotch_broom"}, nil, nil, nil)

    -- glemr6_temperate_arid_lowland
     -- grasses
    add_node({"unilib:dirt_parched"}, 0.01, {"glemr6_temperate_arid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_parched"}, 0.01, {"glemr6_temperate_arid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_parched"}, 0.01, {"glemr6_temperate_arid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_parched"}, 0.01, {"glemr6_temperate_arid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_parched"}, 0.01, {"glemr6_temperate_arid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_5"}, nil, nil, nil)
     -- plants
    add_node({"unilib:dirt_parched"}, 0.01, {"glemr6_temperate_arid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_cactus_small"}, nil, nil, nil)
    add_node({"unilib:dirt_parched"}, 0.01, {"glemr6_temperate_arid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_cactus_small_flowering"}, nil, nil, nil)
    add_node({"unilib:dirt_parched"}, 0.01, {"glemr6_temperate_arid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_enigma"}, nil, nil, nil)
    add_schem({"unilib:dirt_parched"}, 80, 0.01, {"glemr6_temperate_arid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_plant_cactus_ordinary_large")
    add_node({"unilib:dirt_parched"}, 0.01, {"glemr6_temperate_arid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_cactus_thorny"}, nil, nil, nil)
    add_node({"unilib:dirt_parched"}, 0.01, {"glemr6_temperate_arid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_nettle_scotch_broom"}, nil, nil, nil)

    -- glemr6_temperate_arid_shelf
     -- grasses
    add_node({"unilib:dirt_clayey"}, 0.01, {"glemr6_temperate_arid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey"}, 0.01, {"glemr6_temperate_arid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey"}, 0.01, {"glemr6_temperate_arid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey"}, 0.01, {"glemr6_temperate_arid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey"}, 0.01, {"glemr6_temperate_arid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_5"}, nil, nil, nil)
     -- plants
    add_node({"unilib:dirt_clayey"}, 0.01, {"glemr6_temperate_arid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_cactus_small"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey"}, 0.01, {"glemr6_temperate_arid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_cactus_small_flowering"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey"}, 0.01, {"glemr6_temperate_arid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_enigma"}, nil, nil, nil)
    add_schem({"unilib:dirt_clayey"}, 80, 0.01, {"glemr6_temperate_arid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_plant_cactus_ordinary_large")
    add_node({"unilib:dirt_clayey"}, 0.01, {"glemr6_temperate_arid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_cactus_thorny"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey"}, 0.01, {"glemr6_temperate_arid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_nettle_scotch_broom"}, nil, nil, nil)

    -- glemr6_temperate_arid_highland
     -- grasses
    add_node({"unilib:dirt_sandy"}, 0.01, {"glemr6_temperate_arid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_sandy"}, 0.01, {"glemr6_temperate_arid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_sandy"}, 0.01, {"glemr6_temperate_arid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_sandy"}, 0.01, {"glemr6_temperate_arid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_sandy"}, 0.01, {"glemr6_temperate_arid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_5"}, nil, nil, nil)
     -- plants
    add_node({"unilib:dirt_sandy"}, 0.01, {"glemr6_temperate_arid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_cactus_small"}, nil, nil, nil)
    add_node({"unilib:dirt_sandy"}, 0.01, {"glemr6_temperate_arid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_cactus_small_flowering"}, nil, nil, nil)
    add_node({"unilib:dirt_sandy"}, 0.01, {"glemr6_temperate_arid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_enigma"}, nil, nil, nil)
    add_schem({"unilib:dirt_sandy"}, 80, 0.01, {"glemr6_temperate_arid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_plant_cactus_ordinary_large")
    add_node({"unilib:dirt_sandy"}, 0.01, {"glemr6_temperate_arid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_cactus_thorny"}, nil, nil, nil)
    add_node({"unilib:dirt_sandy"}, 0.01, {"glemr6_temperate_arid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_nettle_scotch_broom"}, nil, nil, nil)

    -- glemr6_temperate_arid_mountain

end

---------------------------------------------------------------------------------------------------
-- Cool biomes
---------------------------------------------------------------------------------------------------

local function add_decorations_cool_humid()

    -- glemr6_cool_humid_ocean

    -- glemr6_cool_humid_beach

    -- glemr6_cool_humid_coastal
    -- trees
    add_schem({"unilib:dirt_black_with_turf_cool_humid_coastal"}, 80, 0.02, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_birch_1")
    add_schem({"unilib:dirt_black_with_turf_cool_humid_coastal"}, 80, 0.02, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_birch_small_1")
    add_schem({"unilib:dirt_black_with_turf_cool_humid_coastal"}, 80, 0.02, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_birch_small_2")
    add_schem({"unilib:dirt_black_with_turf_cool_humid_coastal"}, 80, 0.02, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_birch_small_3")
    add_schem({"unilib:dirt_black_with_turf_cool_humid_coastal"}, 80, 0.02, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_birch_large_1")
    add_schem({"unilib:dirt_black_with_turf_cool_humid_coastal"}, 80, 0.02, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_birch_large_2")
    add_schem({"unilib:dirt_black_with_turf_cool_humid_coastal"}, 80, 0.02, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_birch_large_3")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.02, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.02, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_fir_douglas_coast_2")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.02, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_fir_douglas_coast_3")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.02, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_fir_douglas_coast_14")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.02, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_fir_douglas_coast_15")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.02, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_fir_douglas_coast_16")
     --grass
    add_node({"unilib:dirt_ordinary_with_turf_cool_humid_coastal"}, 0.01, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_humid_coastal"}, 0.01, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_humid_coastal"}, 0.01, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_humid_coastal"}, 0.01, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_humid_coastal"}, 0.01, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_5"}, nil, nil, nil)
     -- plants
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:fern_broad_leaf"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:fern_lady"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:fern_broad_leaf_young"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:fern_lady_small"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr6_cool_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)

    -- glemr6_cool_humid_lowland
    -- trees
    add_schem({"unilib:dirt_black_with_turf_cool_humid_lowland"}, 80, 0.04, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_1")
    add_schem({"unilib:dirt_black_with_turf_cool_humid_lowland"}, 80, 0.04, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_small_1")
    add_schem({"unilib:dirt_black_with_turf_cool_humid_lowland"}, 80, 0.04, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_small_2")
    add_schem({"unilib:dirt_black_with_turf_cool_humid_lowland"}, 80, 0.04, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_small_3")
    add_schem({"unilib:dirt_black_with_turf_cool_humid_lowland"}, 80, 0.04, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_large_1")
    add_schem({"unilib:dirt_black_with_turf_cool_humid_lowland"}, 80, 0.04, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_large_2")
    add_schem({"unilib:dirt_black_with_turf_cool_humid_lowland"}, 80, 0.04, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_large_3")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.04, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.04, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fir_douglas_coast_2")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.04, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fir_douglas_coast_3")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.04, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fir_douglas_coast_14")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.04, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fir_douglas_coast_15")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.04, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fir_douglas_coast_16")
     --grass
    add_node({"unilib:dirt_ordinary_with_turf_cool_humid_lowland"}, 0.01, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_humid_lowland"}, 0.01, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_humid_lowland"}, 0.01, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_humid_lowland"}, 0.01, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_humid_lowland"}, 0.01, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:fern_broad_leaf"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:fern_lady"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:fern_broad_leaf"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:fern_lady"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr6_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)

    -- glemr6_cool_humid_shelf
    -- trees
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.06, {"glemr6_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.06, {"glemr6_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_douglas_coast_2")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.06, {"glemr6_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_douglas_coast_3")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.06, {"glemr6_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_douglas_coast_14")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.06, {"glemr6_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_douglas_coast_15")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.06, {"glemr6_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_douglas_coast_16")
     --grass
    add_node({"unilib:dirt_ordinary_with_turf_cool_humid_shelf"}, 0.01, {"glemr6_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_humid_shelf"}, 0.01, {"glemr6_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_humid_shelf"}, 0.01, {"glemr6_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_humid_shelf"}, 0.01, {"glemr6_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_humid_shelf"}, 0.01, {"glemr6_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_5"}, nil, nil, nil)
     -- plants
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr6_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_broad_leaf"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr6_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_lady"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr6_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_broad_leaf_young"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr6_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_lady_small"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr6_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)

    -- glemr6_cool_humid_highland
    -- trees
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.08, {"glemr6_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.08, {"glemr6_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_douglas_coast_2")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.08, {"glemr6_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_douglas_coast_3")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.08, {"glemr6_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_douglas_coast_14")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.08, {"glemr6_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_douglas_coast_15")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.08, {"glemr6_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_douglas_coast_16")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.001, {"glemr6_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_redwood_1")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.001, {"glemr6_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_redwood_2")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.001, {"glemr6_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_redwood_3")
     --grass
    add_node({"unilib:dirt_ordinary_with_turf_cool_humid_highland"}, 0.01, {"glemr6_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_humid_highland"}, 0.01, {"glemr6_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_humid_highland"}, 0.01, {"glemr6_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_humid_highland"}, 0.01, {"glemr6_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_humid_highland"}, 0.01, {"glemr6_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)
     -- plants
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr6_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:fern_broad_leaf"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr6_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:fern_lady"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr6_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:fern_broad_leaf_young"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr6_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:fern_lady_small"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr6_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)

    -- glemr6_cool_humid_mountain

end

local function add_decorations_cool_semihumid()

    -- glemr6_cool_semihumid_ocean

    -- glemr6_cool_semihumid_beach

    -- glemr6_cool_semihumid_coastal
    -- trees
    add_schem({"unilib:dirt_black_with_turf_cool_semihumid_coastal"}, 80, 0.02, {"glemr6_cool_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_birch_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_semihumid_coastal"}, 80, 0.02, {"glemr6_cool_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_birch_small_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_semihumid_coastal"}, 80, 0.02, {"glemr6_cool_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_birch_small_2")
    add_schem({"unilib:dirt_brown_with_turf_cool_semihumid_coastal"}, 80, 0.02, {"glemr6_cool_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_birch_small_3")
    add_schem({"unilib:dirt_black_with_turf_cool_semihumid_coastal"}, 80, 0.02, {"glemr6_cool_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_maple_sugar_1")
    add_schem({"unilib:dirt_black_with_turf_cool_semihumid_coastal"}, 80, 0.02, {"glemr6_cool_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_fir_2")
    add_schem({"unilib:dirt_black_with_turf_cool_semihumid_coastal"}, 80, 0.02, {"glemr6_cool_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_fir_3")
    --grass
    add_node({"unilib:dirt_ordinary_with_turf_cool_semihumid_coastal"}, 0.05, {"glemr6_cool_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semihumid_coastal"}, 0.05, {"glemr6_cool_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semihumid_coastal"}, 0.05, {"glemr6_cool_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semihumid_coastal"}, 0.05, {"glemr6_cool_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semihumid_coastal"}, 0.05, {"glemr6_cool_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_5"}, nil, nil, nil)

    -- glemr6_cool_semihumid_lowland
    -- trees
    add_schem({"unilib:dirt_black_with_turf_cool_semihumid_lowland"}, 80, 0.04, {"glemr6_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_semihumid_lowland"}, 80, 0.04, {"glemr6_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_small_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_semihumid_lowland"}, 80, 0.04, {"glemr6_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_small_2")
    add_schem({"unilib:dirt_brown_with_turf_cool_semihumid_lowland"}, 80, 0.04, {"glemr6_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_small_3")
    add_schem({"unilib:dirt_black_with_turf_cool_semihumid_lowland"}, 80, 0.04, {"glemr6_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_large_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_semihumid_lowland"}, 80, 0.04, {"glemr6_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_large_2")
    add_schem({"unilib:dirt_brown_with_turf_cool_semihumid_lowland"}, 80, 0.04, {"glemr6_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_large_3")
    add_schem({"unilib:dirt_brown_with_turf_cool_semihumid_lowland"}, 80, 0.04, {"glemr6_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_maple_sugar_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_semihumid_lowland"}, 80, 0.04, {"glemr6_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_maple_sugar_large_1")
    add_schem({"unilib:dirt_black_with_turf_cool_semihumid_lowland"}, 80, 0.04, {"glemr6_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fir_2")
    add_schem({"unilib:dirt_black_with_turf_cool_semihumid_lowland"}, 80, 0.04, {"glemr6_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fir_3")
    --grass
    add_node({"unilib:dirt_ordinary_with_turf_cool_semihumid_lowland"}, 0.05, {"glemr6_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semihumid_lowland"}, 0.05, {"glemr6_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semihumid_lowland"}, 0.05, {"glemr6_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semihumid_lowland"}, 0.05, {"glemr6_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semihumid_lowland"}, 0.05, {"glemr6_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)

    -- glemr6_cool_semihumid_shelf
    -- trees
    add_schem({"unilib:dirt_black_with_turf_cool_semihumid_shelf"}, 80, 0.06, {"glemr6_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_semihumid_shelf"}, 80, 0.06, {"glemr6_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_small_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_semihumid_shelf"}, 80, 0.06, {"glemr6_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_small_2")
    add_schem({"unilib:dirt_brown_with_turf_cool_semihumid_shelf"}, 80, 0.06, {"glemr6_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_small_3")
    add_schem({"unilib:dirt_black_with_turf_cool_semihumid_shelf"}, 80, 0.06, {"glemr6_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_large_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_semihumid_shelf"}, 80, 0.06, {"glemr6_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_large_2")
    add_schem({"unilib:dirt_brown_with_turf_cool_semihumid_shelf"}, 80, 0.06, {"glemr6_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_large_3")
    add_schem({"unilib:dirt_brown_with_turf_cool_semihumid_shelf"}, 80, 0.06, {"glemr6_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_maple_sugar_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_semihumid_shelf"}, 80, 0.06, {"glemr6_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_maple_sugar_large_1")
    add_schem({"unilib:dirt_black_with_turf_cool_semihumid_shelf"}, 80, 0.06, {"glemr6_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_2")
    add_schem({"unilib:dirt_black_with_turf_cool_semihumid_shelf"}, 80, 0.06, {"glemr6_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_3")
    -- saplings
    --grass
    add_node({"unilib:dirt_ordinary_with_turf_cool_semihumid_shelf"}, 0.05, {"glemr6_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semihumid_shelf"}, 0.05, {"glemr6_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semihumid_shelf"}, 0.05, {"glemr6_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semihumid_shelf"}, 0.05, {"glemr6_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semihumid_shelf"}, 0.05, {"glemr6_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_5"}, nil, nil, nil)

    -- glemr6_cool_semihumid_highland
    -- trees
    add_schem({"unilib:dirt_black_with_turf_cool_semihumid_highland"}, 80, 0.08, {"glemr6_cool_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_large_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_semihumid_highland"}, 80, 0.08, {"glemr6_cool_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_large_2")
    add_schem({"unilib:dirt_brown_with_turf_cool_semihumid_highland"}, 80, 0.08, {"glemr6_cool_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_large_3")
    add_schem({"unilib:dirt_brown_with_turf_cool_semihumid_highland"}, 80, 0.08, {"glemr6_cool_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_maple_sugar_large_1")
    add_schem({"unilib:dirt_black_with_turf_cool_semihumid_highland"}, 80, 0.08, {"glemr6_cool_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_black_with_turf_cool_semihumid_highland"}, 80, 0.08, {"glemr6_cool_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_2")
    add_schem({"unilib:dirt_black_with_turf_cool_semihumid_highland"}, 80, 0.08, {"glemr6_cool_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_3")
    -- saplings
    --grass
    add_node({"unilib:dirt_ordinary_with_turf_cool_semihumid_highland"}, 0.05, {"glemr6_cool_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semihumid_highland"}, 0.05, {"glemr6_cool_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semihumid_highland"}, 0.05, {"glemr6_cool_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semihumid_highland"}, 0.05, {"glemr6_cool_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semihumid_highland"}, 0.05, {"glemr6_cool_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)

    -- glemr6_cool_semihumid_mountain

end

local function add_decorations_cool_temperate()

    -- glemr6_cool_temperate_ocean

    -- glemr6_cool_temperate_beach

    -- glemr6_cool_temperate_coastal
    -- trees
    add_schem({"unilib:dirt_clayey_with_turf_cool_temperate_coastal"}, 80, 0.02, {"glemr6_cool_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_ash_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_coastal"}, 80, 0.02, {"glemr6_cool_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_birch_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_coastal"}, 80, 0.02, {"glemr6_cool_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_birch_small_1")
    add_schem({"unilib:dirt_clayey_with_turf_cool_temperate_coastal"}, 80, 0.02, {"glemr6_cool_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_birch_small_2")
    add_schem({"unilib:dirt_clayey_with_turf_cool_temperate_coastal"}, 80, 0.02, {"glemr6_cool_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_birch_small_3")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_coastal"}, 80, 0.02, {"glemr6_cool_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_chestnut_exotic_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_coastal"}, 80, 0.02, {"glemr6_cool_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_poplar_small_1")
    add_schem({"unilib:dirt_clayey_with_turf_cool_temperate_coastal"}, 80, 0.02, {"glemr6_cool_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_poplar_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_coastal"}, 80, 0.02, {"glemr6_cool_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_willow_weeping_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_coastal"}, 80, 0.02, {"glemr6_cool_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_willow_weeping_2")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_coastal"}, 80, 0.02, {"glemr6_cool_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_willow_weeping_3")
    --grass
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_coastal"}, 0.05, {"glemr6_cool_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_coastal"}, 0.05, {"glemr6_cool_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_coastal"}, 0.05, {"glemr6_cool_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_coastal"}, 0.05, {"glemr6_cool_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_coastal"}, 0.05, {"glemr6_cool_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_ordinary_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_coastal"}, 0.2, {"glemr6_cool_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_arrow_arum"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_coastal"}, 0.01, {"glemr6_cool_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:flower_lily_calla"}, nil, nil, nil)
    add_schem({"unilib:dirt_ordinary_with_turf_cool_temperate_coastal"}, 80, 0.2, {"glemr6_cool_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_bush_ordinary")
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_coastal"}, 0.2, {"glemr6_cool_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_oat_wild_dry"}, nil, nil, nil)

    -- glemr6_cool_temperate_lowland
    -- trees
    add_schem({"unilib:dirt_clayey_with_turf_cool_temperate_lowland"}, 80, 0.04, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_ash_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_lowland"}, 80, 0.04, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_lowland"}, 80, 0.04, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_small_1")
    add_schem({"unilib:dirt_clayey_with_turf_cool_temperate_lowland"}, 80, 0.04, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_small_2")
    add_schem({"unilib:dirt_clayey_with_turf_cool_temperate_lowland"}, 80, 0.04, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_small_3")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_lowland"}, 80, 0.04, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_large_1")
    add_schem({"unilib:dirt_clayey_with_turf_cool_temperate_lowland"}, 80, 0.04, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_large_2")
    add_schem({"unilib:dirt_clayey_with_turf_cool_temperate_lowland"}, 80, 0.04, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_large_3")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_lowland"}, 80, 0.04, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_chestnut_exotic_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_lowland"}, 80, 0.04, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_maple_sugar_1")
    add_schem({"unilib:dirt_clayey_with_turf_cool_temperate_lowland"}, 80, 0.04, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_maple_sugar_large_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_lowland"}, 80, 0.04, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_poplar_small_1")
    add_schem({"unilib:dirt_clayey_with_turf_cool_temperate_lowland"}, 80, 0.04, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_poplar_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_lowland"}, 80, 0.04, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_willow_weeping_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_lowland"}, 80, 0.04, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_willow_weeping_2")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_lowland"}, 80, 0.04, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_willow_weeping_3")
    --grass
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_lowland"}, 0.05, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_lowland"}, 0.05, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_lowland"}, 0.05, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_lowland"}, 0.05, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_lowland"}, 0.05, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)
     -- plants
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_lowland"}, 0.2, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_arrow_arum"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_lowland"}, 0.01, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:flower_lily_calla"}, nil, nil, nil)
    add_schem({"unilib:dirt_ordinary_with_turf_cool_temperate_lowland"}, 80, 0.2, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_bush_ordinary")
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_lowland"}, 0.2, {"glemr6_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_oat_wild_dry"}, nil, nil, nil)

    -- glemr6_cool_temperate_shelf
    -- trees
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_shelf"}, 80, 0.06, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_aspen_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_shelf"}, 80, 0.06, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_aspen_2")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_shelf"}, 80, 0.06, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_aspen_3")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_shelf"}, 80, 0.06, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_aspen_4")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_shelf"}, 80, 0.06, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_aspen_5")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_shelf"}, 80, 0.06, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_aspen_6")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_shelf"}, 80, 0.06, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_aspen_log", "place_center_x")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_shelf"}, 80, 0.06, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_shelf"}, 80, 0.06, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_small_1")
    add_schem({"unilib:dirt_clayey_with_turf_cool_temperate_shelf"}, 80, 0.06, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_small_2")
    add_schem({"unilib:dirt_clayey_with_turf_cool_temperate_shelf"}, 80, 0.06, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_small_3")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_shelf"}, 80, 0.06, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_large_1")
    add_schem({"unilib:dirt_clayey_with_turf_cool_temperate_shelf"}, 80, 0.06, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_large_2")
    add_schem({"unilib:dirt_clayey_with_turf_cool_temperate_shelf"}, 80, 0.06, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_large_3")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_shelf"}, 80, 0.06, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_maple_sugar_1")
    add_schem({"unilib:dirt_clayey_with_turf_cool_temperate_shelf"}, 80, 0.06, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_maple_sugar_large_1")
    add_schem({"unilib:dirt_clayey_with_turf_cool_temperate_shelf"}, 80, 0.06, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_1")
    --grass
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_shelf"}, 0.05, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_shelf"}, 0.05, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_shelf"}, 0.05, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_shelf"}, 0.05, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_shelf"}, 0.05, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_5"}, nil, nil, nil)
     -- plants
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_shelf"}, 0.2, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_arrow_arum"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_shelf"}, 0.01, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:flower_lily_calla"}, nil, nil, nil)
    add_schem({"unilib:dirt_ordinary_with_turf_cool_temperate_shelf"}, 80, 0.2, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_bush_ordinary")
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_shelf"}, 0.2, {"glemr6_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_oat_wild_dry"}, nil, nil, nil)

    -- glemr6_cool_temperate_highland
    -- trees
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_highland"}, 80, 0.08, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_aspen_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_highland"}, 80, 0.08, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_aspen_2")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_highland"}, 80, 0.08, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_aspen_3")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_highland"}, 80, 0.08, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_aspen_4")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_highland"}, 80, 0.08, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_aspen_5")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_highland"}, 80, 0.08, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_aspen_6")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_highland"}, 80, 0.08, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_aspen_log", "place_center_x")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_highland"}, 80, 0.08, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_1")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_highland"}, 80, 0.08, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_small_1")
    add_schem({"unilib:dirt_clayey_with_turf_cool_temperate_highland"}, 80, 0.08, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_small_2")
    add_schem({"unilib:dirt_clayey_with_turf_cool_temperate_highland"}, 80, 0.08, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_small_3")
    add_schem({"unilib:dirt_brown_with_turf_cool_temperate_highland"}, 80, 0.08, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_large_1")
    add_schem({"unilib:dirt_clayey_with_turf_cool_temperate_highland"}, 80, 0.08, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_large_2")
    add_schem({"unilib:dirt_clayey_with_turf_cool_temperate_highland"}, 80, 0.08, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_large_3")
    add_schem({"unilib:dirt_clayey_with_turf_cool_temperate_highland"}, 80, 0.08, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_1")
    --grass
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_highland"}, 0.05, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_highland"}, 0.05, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_highland"}, 0.05, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_highland"}, 0.05, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_highland"}, 0.05, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)
     -- plants
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_highland"}, 0.2, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_arrow_arum"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_highland"}, 0.01, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:flower_lily_calla"}, nil, nil, nil)
    add_schem({"unilib:dirt_ordinary_with_turf_cool_temperate_highland"}, 80, 0.2, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_bush_ordinary")
    add_node({"unilib:dirt_ordinary_with_turf_cool_temperate_highland"}, 0.2, {"glemr6_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_oat_wild_dry"}, nil, nil, nil)

    -- glemr6_cool_temperate_mountain

end

local function add_decorations_cool_semiarid()

    -- glemr6_cool_semiarid_ocean

    -- glemr6_cool_semiarid_beach

    -- glemr6_cool_semiarid_coastal
    -- trees
    add_schem({"unilib:dirt_ordinary_with_turf_cool_semiarid_coastal"}, 80, 0.002, {"glemr6_cool_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_pine_ancient_1")
    add_schem({"unilib:dirt_ordinary_with_turf_cool_semiarid_coastal"}, 80, 0.002, {"glemr6_cool_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_pine_ancient_6")
    add_schem({"unilib:dirt_ordinary_with_turf_cool_semiarid_coastal"}, 80, 0.002, {"glemr6_cool_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_pine_ancient_3")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_cool_semiarid_coastal"}, 0.01, {"glemr6_cool_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semiarid_coastal"}, 0.01, {"glemr6_cool_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semiarid_coastal"}, 0.01, {"glemr6_cool_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semiarid_coastal"}, 0.01, {"glemr6_cool_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semiarid_coastal"}, 0.01, {"glemr6_cool_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr6_cool_semiarid_lowland
    -- trees
    add_schem({"unilib:dirt_ordinary_with_turf_cool_semiarid_lowland"}, 80, 0.002, {"glemr6_cool_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_pine_ancient_3")
    add_schem({"unilib:dirt_ordinary_with_turf_cool_semiarid_lowland"}, 80, 0.002, {"glemr6_cool_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_pine_ancient_5")
    add_schem({"unilib:dirt_ordinary_with_turf_cool_semiarid_lowland"}, 80, 0.002, {"glemr6_cool_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_pine_ancient_6")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_cool_semiarid_lowland"}, 0.01, {"glemr6_cool_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semiarid_lowland"}, 0.01, {"glemr6_cool_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semiarid_lowland"}, 0.01, {"glemr6_cool_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semiarid_lowland"}, 0.01, {"glemr6_cool_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semiarid_lowland"}, 0.01, {"glemr6_cool_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr6_cool_semiarid_shelf
    -- trees
    add_schem({"unilib:dirt_ordinary_with_turf_cool_semiarid_shelf"}, 80, 0.002, {"glemr6_cool_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_pine_ancient_7")
    add_schem({"unilib:dirt_ordinary_with_turf_cool_semiarid_shelf"}, 80, 0.002, {"glemr6_cool_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_pine_ancient_8")
    add_schem({"unilib:dirt_ordinary_with_turf_cool_semiarid_shelf"}, 80, 0.002, {"glemr6_cool_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_pine_ancient_9")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_cool_semiarid_shelf"}, 0.01, {"glemr6_cool_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semiarid_shelf"}, 0.01, {"glemr6_cool_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semiarid_shelf"}, 0.01, {"glemr6_cool_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semiarid_shelf"}, 0.01, {"glemr6_cool_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semiarid_shelf"}, 0.01, {"glemr6_cool_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr6_cool_semiarid_highland
    -- trees
    add_schem({"unilib:dirt_ordinary_with_turf_cool_semiarid_highland"}, 80, 0.002, {"glemr6_cool_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_ancient_1")
    add_schem({"unilib:dirt_ordinary_with_turf_cool_semiarid_highland"}, 80, 0.002, {"glemr6_cool_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_ancient_2")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_cool_semiarid_highland"}, 0.01, {"glemr6_cool_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semiarid_highland"}, 0.01, {"glemr6_cool_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semiarid_highland"}, 0.01, {"glemr6_cool_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semiarid_highland"}, 0.01, {"glemr6_cool_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cool_semiarid_highland"}, 0.01, {"glemr6_cool_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr6_cool_semiarid_mountain

end

local function add_decorations_cool_arid()

    -- glemr6_cool_arid_ocean

    -- glemr6_cool_arid_beach

    -- glemr6_cool_arid_coastal
     -- grasses
    add_node({"unilib:dirt_clayey_with_litter_coniferous"}, 0.01, {"glemr6_cool_arid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_1", "unilib:grass_dry_2", "unilib:grass_dry_3", "unilib:grass_dry_4", "unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr6_cool_arid_lowland
     -- grasses
    add_node({"unilib:dirt_clayey_with_litter_coniferous"}, 0.01, {"glemr6_cool_arid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_1", "unilib:grass_dry_2", "unilib:grass_dry_3", "unilib:grass_dry_4", "unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr6_cool_arid_shelf
     -- grasses
    add_node({"unilib:dirt_clayey_with_litter_coniferous"}, 0.01, {"glemr6_cool_arid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_1", "unilib:grass_dry_2", "unilib:grass_dry_3", "unilib:grass_dry_4", "unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr6_cool_arid_highland
     -- grasses
    add_node({"unilib:dirt_clayey_with_litter_coniferous"}, 0.01, {"glemr6_cool_arid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_1", "unilib:grass_dry_2", "unilib:grass_dry_3", "unilib:grass_dry_4", "unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr6_cool_arid_mountain

end

---------------------------------------------------------------------------------------------------
-- Cold biomes
---------------------------------------------------------------------------------------------------

local function add_decorations_cold_humid()

    -- glemr6_cold_humid_ocean

    -- glemr6_cold_humid_beach
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_beach"}, 1, HEIGHT_BEACH_MAX, {"unilib:grass_frozen_1", "unilib:grass_frozen_2", "unilib:grass_frozen_3", "unilib:grass_frozen_4", "unilib:grass_frozen_5"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.001, {"glemr6_cold_humid_beach"}, 1, HEIGHT_BEACH_MAX, {"unilib:plant_shrub_snowy"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_beach"}, 1, HEIGHT_BEACH_MAX, {"unilib:stone_brownstone_dark"}, nil, nil, nil)

    -- glemr6_cold_humid_coastal
    -- trees
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_spruce_2")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_spruce_3")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_spruce_4")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_spruce_5")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_spruce_6")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_spruce_7")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_pine_1")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_shrub_snowy"}, nil, nil, nil)
    -- N.B. unilib:grass_dry_1 etc in the original code, but that is surely a mistake
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_frozen_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_frozen_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_frozen_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_frozen_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_frozen_5"}, nil, nil, nil)
    -- saplings

    -- glemr6_cold_humid_lowland
    -- trees
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_spruce_2")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_spruce_3")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_spruce_4")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_spruce_5")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_spruce_6")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_spruce_7")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_pine_1")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_shrub_snowy"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_5"}, nil, nil, nil)
    -- saplings

    -- glemr6_cold_humid_shelf
    -- trees
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_spruce_2")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_spruce_3")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_spruce_4")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_spruce_5")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_spruce_6")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_spruce_7")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_pine_1")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_shrub_snowy"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_frozen_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_frozen_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_frozen_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_frozen_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_frozen_5"}, nil, nil, nil)
    -- saplings

    -- glemr6_cold_humid_highland
    -- trees
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_2")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_3")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_4")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_5")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_6")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_7")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_3")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_douglas_coast_5")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_douglas_coast_6")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_douglas_coast_14")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_douglas_coast_15")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.001, {"glemr6_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_mature_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.001, {"glemr6_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_mature_2")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.001, {"glemr6_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_mature_3")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_shrub_snowy"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_frozen_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_frozen_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_frozen_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_frozen_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_frozen_5"}, nil, nil, nil)
    -- saplings

    -- glemr6_cold_humid_mountain

end

local function add_decorations_cold_semihumid()

    -- glemr6_cold_semihumid_ocean

    -- glemr6_cold_semihumid_beach
    add_node({"unilib:dirt_silt_fine_with_snow_ordinary"}, 0.01, {"glemr6_cold_semihumid_beach"}, 1, HEIGHT_BEACH_MAX, {"unilib:grass_frozen_1"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_snow_ordinary"}, 0.01, {"glemr6_cold_semihumid_beach"}, 1, HEIGHT_BEACH_MAX, {"unilib:grass_frozen_2"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_snow_ordinary"}, 0.01, {"glemr6_cold_semihumid_beach"}, 1, HEIGHT_BEACH_MAX, {"unilib:grass_frozen_3"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_snow_ordinary"}, 0.01, {"glemr6_cold_semihumid_beach"}, 1, HEIGHT_BEACH_MAX, {"unilib:grass_frozen_4"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_snow_ordinary"}, 0.01, {"glemr6_cold_semihumid_beach"}, 1, HEIGHT_BEACH_MAX, {"unilib:grass_frozen_5"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_snow_ordinary"}, 0.01, {"glemr6_cold_semihumid_beach"}, 1, HEIGHT_BEACH_MAX, {"unilib:plant_shrub_snowy"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_snow_ordinary"}, 0.01, {"glemr6_cold_semihumid_beach"}, 1, HEIGHT_BEACH_MAX, {"unilib:stone_brownstone_dark"}, nil, nil, nil)

    -- glemr6_cold_semihumid_coastal
    -- trees
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_fir_douglas_coast_14")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_frozen_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_frozen_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_frozen_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_frozen_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_frozen_5"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.001, {"glemr6_cold_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_shrub_snowy"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_nettle_carduus"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.001, {"glemr6_cold_semihumid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:stone_brownstone_dark"}, nil, nil, nil)
    -- saplings

    -- glemr6_cold_semihumid_lowland
    -- trees
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fir_douglas_coast_14")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_5"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.001, {"glemr6_cold_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_shrub_snowy"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_nettle_carduus"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.001, {"glemr6_cold_semihumid_lowland"}, 30, 45, {"unilib:grass_frozen_4"}, nil, nil, nil)
    -- saplings

    -- glemr6_cold_semihumid_shelf
    -- trees
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_douglas_coast_14")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_frozen_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_frozen_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_frozen_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_frozen_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_frozen_5"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.001, {"glemr6_cold_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_shrub_snowy"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_nettle_carduus"}, nil, nil, nil)
    -- saplings

    -- glemr6_cold_semihumid_highland
    -- trees
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_douglas_coast_14")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_frozen_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_frozen_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_frozen_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_frozen_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_frozen_5"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.001, {"glemr6_cold_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_shrub_snowy"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_nettle_carduus"}, nil, nil, nil)
    -- saplings

    -- glemr6_cold_semihumid_mountain

end

local function add_decorations_cold_temperate()

    -- glemr6_cold_temperate_ocean

    -- glemr6_cold_temperate_beach
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_beach"}, 1, 4, {"unilib:grass_frozen_1", "unilib:grass_frozen_2", "unilib:grass_frozen_3", "unilib:grass_frozen_4", "unilib:grass_frozen_5"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_beach"}, 1, 4, {"unilib:plant_nettle_carduus"}, nil, nil, nil)

    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_beach"}, 1, 4, {"unilib:stone_basalt_dark"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_beach"}, 1, 4, {"unilib:stone_gneiss_brown"}, nil, nil, nil)

    -- glemr6_cold_temperate_coastal
    -- trees
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_fir_1")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_frozen_1", "unilib:grass_frozen_2", "unilib:grass_frozen_3", "unilib:grass_frozen_4", "unilib:grass_frozen_5"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_shrub_snowy"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_nettle_carduus"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_weed_stone"}, nil, nil, nil)
    -- saplings

    -- glemr6_cold_temperate_lowland
    -- trees
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.007, {"glemr6_cold_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.007, {"glemr6_cold_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fir_1")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_1", "unilib:grass_frozen_2", "unilib:grass_frozen_3", "unilib:grass_frozen_4", "unilib:grass_frozen_5"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_shrub_snowy"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_nettle_carduus"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_weed_stone"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_shrub_taiga"}, nil, nil, nil)
    -- saplings

    -- glemr6_cold_temperate_shelf
    -- trees
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.006, {"glemr6_cold_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.006, {"glemr6_cold_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_1")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_frozen_1", "unilib:grass_frozen_2", "unilib:grass_frozen_3", "unilib:grass_frozen_4", "unilib:grass_frozen_5"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_shrub_snowy"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_nettle_carduus"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_weed_stone"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_shrub_taiga"}, nil, nil, nil)
    -- saplings

    -- glemr6_cold_temperate_highland
    -- trees
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr6_cold_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_1")
     -- grasses
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_frozen_1", "unilib:grass_frozen_2", "unilib:grass_frozen_3", "unilib:grass_frozen_4", "unilib:grass_frozen_5"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_shrub_snowy"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_nettle_carduus"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_weed_stone"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_shrub_taiga"}, nil, nil, nil)
    -- saplings

    -- glemr6_cold_temperate_mountain

end

local function add_decorations_cold_semiarid()

    -- glemr6_cold_semiarid_ocean

    -- glemr6_cold_semiarid_beach
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_semiarid_beach"}, 1, 4, {"unilib:grass_frozen_1", "unilib:grass_frozen_2", "unilib:grass_frozen_3", "unilib:grass_frozen_4", "unilib:grass_frozen_5"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_semiarid_beach"}, 1, 4, {"unilib:plant_nettle_carduus"}, nil, nil, nil)

    -- glemr6_cold_semiarid_coastal
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr6_cold_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_frozen_1", "unilib:grass_frozen_2", "unilib:grass_frozen_3", "unilib:grass_frozen_4", "unilib:grass_frozen_5"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_shrub_snowy"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_nettle_carduus"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_semiarid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_weed_stone"}, nil, nil, nil)

    -- glemr6_cold_semiarid_lowland
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.0075, {"glemr6_cold_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_1", "unilib:grass_frozen_2", "unilib:grass_frozen_3", "unilib:grass_frozen_4", "unilib:grass_frozen_5"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_shrub_taiga"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_shrub_snowy"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_nettle_carduus"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_weed_stone"}, nil, nil, nil)

    -- glemr6_cold_semiarid_shelf
    add_node({"unilib:dirt_permafrost_dark"}, 0.01, {"glemr6_cold_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_frozen_1", "unilib:grass_frozen_2", "unilib:grass_frozen_3", "unilib:grass_frozen_4", "unilib:grass_frozen_5"}, nil, nil, nil)
    add_node({"unilib:dirt_permafrost_dark"}, 0.005, {"glemr6_cold_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_shrub_taiga"}, nil, nil, nil)
    add_node({"unilib:dirt_permafrost_dark"}, 0.005, {"glemr6_cold_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_nettle_carduus"}, nil, nil, nil)
    add_node({"unilib:dirt_permafrost_dark"}, 0.005, {"glemr6_cold_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_weed_stone"}, nil, nil, nil)

    -- glemr6_cold_semiarid_highland
    add_node({"unilib:dirt_permafrost_dark"}, 0.01, {"glemr6_cold_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_frozen_1", "unilib:grass_frozen_2", "unilib:grass_frozen_3", "unilib:grass_frozen_4", "unilib:grass_frozen_5"}, nil, nil, nil)
    add_node({"unilib:dirt_permafrost_dark"}, 0.005, {"glemr6_cold_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_shrub_taiga"}, nil, nil, nil)
    add_node({"unilib:dirt_permafrost_dark"}, 0.005, {"glemr6_cold_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_nettle_carduus"}, nil, nil, nil)

    -- glemr6_cold_semiarid_mountain

end

local function add_decorations_cold_arid()

    -- glemr6_cold_arid_ocean

    -- glemr6_cold_arid_beach
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_arid_beach"}, 1, 4, {"unilib:stone_basalt_dark"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_arid_beach"}, 1, 4, {"unilib:stone_granite_dark"}, nil, nil, nil)

    -- glemr6_cold_arid_coastal
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_arid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:plant_weed_stone"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_arid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:stone_basalt_dark"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr6_cold_arid_coastal"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:stone_granite_dark"}, nil, nil, nil)

    -- glemr6_cold_arid_lowland
    add_node({"unilib:dirt_permafrost_dark"}, 0.005, {"glemr6_cold_arid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_shrub_taiga"}, nil, nil, nil)
    add_node({"unilib:dirt_permafrost_dark"}, 0.005, {"glemr6_cold_arid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_weed_stone"}, nil, nil, nil)
    add_node({"unilib:dirt_permafrost_dark"}, 0.005, {"glemr6_cold_arid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:stone_granite_dark"}, nil, nil, nil)
    add_node({"unilib:dirt_permafrost_dark"}, 0.005, {"glemr6_cold_arid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:stone_gabbro_red"}, nil, nil, nil)

    -- glemr6_cold_arid_shelf
    add_node({"unilib:dirt_permafrost_dark"}, 0.005, {"glemr6_cold_arid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_shrub_taiga"}, nil, nil, nil)
    add_node({"unilib:dirt_permafrost_dark"}, 0.005, {"glemr6_cold_arid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_weed_stone"}, nil, nil, nil)

    -- glemr6_cold_arid_highland
    add_node({"unilib:dirt_permafrost_dark"}, 0.005, {"glemr6_cold_arid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_shrub_taiga"}, nil, nil, nil)

    -- glemr6_cold_arid_mountain

end

---------------------------------------------------------------------------------------------------
-- Generic biomes
---------------------------------------------------------------------------------------------------

local function add_decorations_generic()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        -- glemr6_generic_burned
        add_node({"unilib:dirt_ordinary_with_turf_grey"}, 0.006, {"glemr6_generic_burned"}, 130, 145, {"unilib:tree_scorched_trunk"}, 6, nil, nil)

        -- glemr6_generic_volcanic
        add_node({"unilib:dirt_ordinary_with_turf_grey"}, 0.006, {"glemr6_generic_volcanic"}, 145, unilib.y_max, {"unilib:tree_scorched_trunk"}, 6, nil, nil)

        -- glemr6_generic_mushroom
        add_schem({"unilib:dirt_ordinary_with_cover_fungi"}, 80, 0.003, {"glemr6_generic_mushroom"}, 30, 50, "unilib_glem_mushroom_blotchy", "place_center_x, place_center_z")
        add_schem({"unilib:dirt_ordinary_with_cover_fungi"}, 80, 0.003, {"glemr6_generic_mushroom"}, 30, 50, "unilib_glem_mushroom_blotchy_large", "place_center_x, place_center_z")

    end

end

---------------------------------------------------------------------------------------------------
-- valleys_c biomes (following the pattern of GLEMr4, but many of these are original to GLEMr6)
---------------------------------------------------------------------------------------------------

local function add_decorations_deciduous_forest_swamp()

    -- glemr6_valleys_deciduous_forest_swamp
    -- plants
    add_schem({"unilib:dirt_mud_swamp"}, 80, 0.15, {"glemr6_valleys_deciduous_forest_swamp"}, 1, 2, "unilib_glem_plant_bulrush_1")
    add_schem({"unilib:dirt_mud_swamp"}, 80, 0.02, {"glemr6_valleys_deciduous_forest_swamp"}, 1, 2, "unilib_glem_plant_bulrush_2")
    add_schem({"unilib:dirt_mud_swamp"}, 80, 0.05, {"glemr6_valleys_deciduous_forest_swamp"}, -2, 0, "unilib_glem_flower_waterlily_exotic_pink")
    add_schem({"unilib:dirt_mud_swamp"}, 80, 0.05, {"glemr6_valleys_deciduous_forest_swamp"}, -2, 0, "unilib_glem_flower_waterlily_exotic_yellow")
    add_node({"unilib:dirt_mud_swamp"}, 0.2, {"glemr6_valleys_deciduous_forest_swamp"}, -1, 1, {"unilib:plant_papyrus_ordinary"}, 4, "unilib:liquid_water_ordinary_source", 1)
    add_node({"unilib:dirt_mud_swamp"}, 0.08, {"glemr6_valleys_deciduous_forest_swamp"}, -1, 1, {"unilib:plant_papyrus_ordinary"}, 3, "unilib:dirt_mud_swamp", 1)
    add_node({"unilib:dirt_mud_swamp"}, 0.1, {"glemr6_valleys_deciduous_forest_swamp"}, 1, 2, {"unilib:plant_nettle_impatiens"}, 1, nil, nil)
    add_node({"unilib:dirt_mud_swamp"}, 0.1, {"glemr6_valleys_deciduous_forest_swamp"}, 2, 4, {"unilib:misc_patch_grass"}, 1, nil, nil)
    add_node({"unilib:dirt_mud_swamp"}, 0.1, {"glemr6_valleys_deciduous_forest_swamp"}, 2, 4, {"unilib:grass_giant"}, 1, nil, nil)
    add_node({"unilib:dirt_mud_swamp"}, 0.05, {"glemr6_valleys_deciduous_forest_swamp"}, -2, 0, {"unilib:flower_waterlily_exotic_pink"}, 1, nil, nil)
    add_node({"unilib:dirt_mud_swamp"}, 0.05, {"glemr6_valleys_deciduous_forest_swamp"}, -2, 0, {"unilib:flower_waterlily_exotic_yellow"}, 1, nil, nil)

end

local function add_decorations_tropical_rainforest()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        -- glemr6_valleys_tropical_rainforest
        -- trees
        add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr6_valleys_tropical_rainforest"}, 30, 180, "unilib_glem_plant_bamboo_small_1")
        add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr6_valleys_tropical_rainforest"}, 30, 180, "unilib_glem_tree_bamboo_1")
        add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr6_valleys_tropical_rainforest"}, 30, 180, "unilib_glem_tree_bamboo_2")
        add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr6_valleys_tropical_rainforest"}, 30, 180, "unilib_glem_tree_bamboo_3")
        add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr6_valleys_tropical_rainforest"}, 30, 180, "unilib_glem_tree_bamboo_exotic_1")
        add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr6_valleys_tropical_rainforest"}, 30, 180, "unilib_glem_tree_bamboo_exotic_2")
        add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr6_valleys_tropical_rainforest"}, 30, 180, "unilib_glem_tree_bamboo_exotic_3")
        add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr6_valleys_tropical_rainforest"}, 30, 180, "unilib_glem_tree_jungle_exotic_1")
        add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr6_valleys_tropical_rainforest"}, 30, 180, "unilib_glem_tree_jungle_exotic_2")
        add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr6_valleys_tropical_rainforest"}, 30, 180, "unilib_glem_tree_palm_jungle_1")
        add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr6_valleys_tropical_rainforest"}, 30, 180, "unilib_glem_tree_palm_jungle_2")
        add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr6_valleys_tropical_rainforest"}, 30, 180, "unilib_glem_tree_palm_plain_1")
        add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr6_valleys_tropical_rainforest"}, 30, 180, "unilib_glem_tree_palm_plain_2")
        add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr6_valleys_tropical_rainforest"}, 30, 180, "unilib_glem_tree_palm_1")
        add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr6_valleys_tropical_rainforest"}, 30, 180, "unilib_glem_tree_palm_3")
        add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr6_valleys_tropical_rainforest"}, 30, 180, "unilib_glem_tree_palm_4")
        add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr6_valleys_tropical_rainforest"}, 30, 180, "unilib_glem_tree_palm_exotic_6")
        add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr6_valleys_tropical_rainforest"}, 30, 180, "unilib_glem_tree_palm_exotic_8")
        -- grasses
        add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.01, {"glemr6_valleys_tropical_rainforest"}, 30, 180, {"unilib:grass_jungle"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.01, {"glemr6_valleys_tropical_rainforest"}, 30, 180, {"unilib:grass_bamboo"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.01, {"glemr6_valleys_tropical_rainforest"}, 30, 180, {"unilib:grass_rainforest_1"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.01, {"glemr6_valleys_tropical_rainforest"}, 30, 180, {"unilib:grass_rainforest_2"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.01, {"glemr6_valleys_tropical_rainforest"}, 30, 180, {"unilib:grass_rainforest_3"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.01, {"glemr6_valleys_tropical_rainforest"}, 30, 180, {"unilib:grass_rainforest_4"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.01, {"glemr6_valleys_tropical_rainforest"}, 30, 180, {"unilib:grass_rainforest_5"}, nil, nil, nil)
        -- ferns
        add_schem_no_rotate({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.003, {"glemr6_valleys_tropical_rainforest"}, 30, 180, "unilib_glem_tree_fern_giant_1")
        add_schem_no_rotate({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.002, {"glemr6_valleys_tropical_rainforest"}, 30, 180, "unilib_glem_tree_fern_yellow")
        add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.002, {"glemr6_valleys_tropical_rainforest"}, 30, 180, {"unilib:tree_fern_giant_sapling"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.002, {"glemr6_valleys_tropical_rainforest"}, 30, 180, {"unilib:tree_fern_sapling"}, nil, nil, nil)
        -- flowers
        -- plants
        add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.003, {"glemr6_valleys_tropical_rainforest"}, 30, 180, {"unilib:grass_deciduous"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.003, {"glemr6_valleys_tropical_rainforest"}, 30, 180, {"unilib:produce_pineapple_grow_8"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.003, {"glemr6_valleys_tropical_rainforest"}, 30, 180, {"unilib:tree_young_jungle"}, nil, nil, nil)

    end

end

local function add_decorations_tropical_rainforest_swamp()

    -- glemr6_valleys_tropical_rainforest_swamp
    -- plants
    add_schem({"unilib:dirt_mud_swamp"}, 80, 0.15, {"glemr6_valleys_tropical_rainforest_swamp"}, 1, 2, "unilib_glem_plant_bulrush_1")
    add_schem({"unilib:dirt_mud_swamp"}, 80, 0.02, {"glemr6_valleys_tropical_rainforest_swamp"}, 1, 2, "unilib_glem_plant_bulrush_2")
    add_schem({"unilib:dirt_mud_swamp"}, 80, 0.05, {"glemr6_valleys_tropical_rainforest_swamp"}, -2, 0, "unilib_glem_flower_waterlily_exotic_pink")
    add_schem({"unilib:dirt_mud_swamp"}, 80, 0.05, {"glemr6_valleys_tropical_rainforest_swamp"}, -2, 0, "unilib_glem_flower_waterlily_exotic_yellow")
    add_node({"unilib:dirt_mud_swamp"}, 0.2, {"glemr6_valleys_tropical_rainforest_swamp"}, -1, 1, {"unilib:plant_papyrus_ordinary"}, 4, "unilib:liquid_water_ordinary_source", 1)
    add_node({"unilib:dirt_mud_swamp"}, 0.08, {"glemr6_valleys_tropical_rainforest_swamp"}, -1, 1, {"unilib:plant_papyrus_ordinary"}, 3, "unilib:dirt_mud_swamp", 1)
    add_node({"unilib:dirt_mud_swamp"}, 0.2, {"glemr6_valleys_tropical_rainforest_swamp"}, 1, 2, {"unilib:plant_bulrush_mature"}, 1, nil, nil)
    add_node({"unilib:dirt_mud_swamp"}, 0.1, {"glemr6_valleys_tropical_rainforest_swamp"}, 1, 2, {"unilib:plant_nettle_impatiens"}, 1, nil, nil)
    add_node({"unilib:dirt_mud_swamp"}, 0.1, {"glemr6_valleys_tropical_rainforest_swamp"}, 2, 4, {"unilib:misc_patch_grass"}, 1, nil, nil)
    add_node({"unilib:dirt_mud_swamp"}, 0.1, {"glemr6_valleys_tropical_rainforest_swamp"}, 2, 4, {"unilib:grass_giant"}, 1, nil, nil)
    add_node({"unilib:dirt_mud_swamp"}, 0.05, {"glemr6_valleys_tropical_rainforest_swamp"}, -2, 0, {"unilib:flower_waterlily_exotic_pink"}, 1, nil, nil)
    add_node({"unilib:dirt_mud_swamp"}, 0.05, {"glemr6_valleys_tropical_rainforest_swamp"}, -2, 0, {"unilib:flower_waterlily_exotic_yellow"}, 1, nil, nil)

end

local function add_decorations_subtropical_rainforest_swamp()

    -- glemr6_valleys_subtropical_rainforest_swamp
    -- plants
    add_schem({"unilib:dirt_mud_swamp"}, 80, 0.15, {"glemr6_valleys_subtropical_rainforest_swamp"}, 1, 2, "unilib_glem_plant_bulrush_1")
    add_schem({"unilib:dirt_mud_swamp"}, 80, 0.02, {"glemr6_valleys_subtropical_rainforest_swamp"}, 1, 2, "unilib_glem_plant_bulrush_2")
    add_schem({"unilib:dirt_mud_swamp"}, 80, 0.05, {"glemr6_valleys_subtropical_rainforest_swamp"}, -2, 0, "unilib_glem_flower_waterlily_exotic_pink")
    add_schem({"unilib:dirt_mud_swamp"}, 80, 0.05, {"glemr6_valleys_subtropical_rainforest_swamp"}, -2, 0, "unilib_glem_flower_waterlily_exotic_yellow")
    add_node({"unilib:dirt_mud_swamp"}, 0.2, {"glemr6_valleys_subtropical_rainforest_swamp"}, -1, 1, {"unilib:plant_papyrus_ordinary"}, 4, "unilib:liquid_water_ordinary_source", 1)
    add_node({"unilib:dirt_mud_swamp"}, 0.08, {"glemr6_valleys_subtropical_rainforest_swamp"}, -1, 1, {"unilib:plant_papyrus_ordinary"}, 3, "unilib:dirt_mud_swamp", 1)
    add_node({"unilib:dirt_mud_swamp"}, 0.2, {"glemr6_valleys_subtropical_rainforest_swamp"}, 1, 2, {"unilib:plant_cattail_normal"}, 1, nil, nil)
    add_node({"unilib:dirt_mud_swamp"}, 0.2, {"glemr6_valleys_subtropical_rainforest_swamp"}, 1, 2, {"unilib:plant_bulrush_mature"}, 1, nil, nil)
    add_node({"unilib:dirt_mud_swamp"}, 0.1, {"glemr6_valleys_subtropical_rainforest_swamp"}, 1, 2, {"unilib:plant_nettle_impatiens"}, 1, nil, nil)
    add_node({"unilib:dirt_mud_swamp"}, 0.1, {"glemr6_valleys_subtropical_rainforest_swamp"}, 2, 4, {"unilib:misc_patch_grass"}, 1, nil, nil)
    add_node({"unilib:dirt_mud_swamp"}, 0.1, {"glemr6_valleys_subtropical_rainforest_swamp"}, 2, 4, {"unilib:grass_giant"}, 1, nil, nil)
    add_node({"unilib:dirt_mud_swamp"}, 0.05, {"glemr6_valleys_subtropical_rainforest_swamp"}, -2, 0, {"unilib:flower_waterlily_exotic_pink"}, 1, nil, nil)
    add_node({"unilib:dirt_mud_swamp"}, 0.05, {"glemr6_valleys_subtropical_rainforest_swamp"}, -2, 0, {"unilib:flower_waterlily_exotic_yellow"}, 1, nil, nil)

end

local function add_decorations_temperate_rainforest_swamp()

    -- glemr6_valleys_temperate_rainforest_swamp
    -- plants
    add_schem({"unilib:dirt_mud_swamp"}, 80, 0.15, {"glemr6_valleys_temperate_rainforest_swamp"}, 1, 2, "unilib_glem_plant_bulrush_1")
    add_schem({"unilib:dirt_mud_swamp"}, 80, 0.02, {"glemr6_valleys_temperate_rainforest_swamp"}, 1, 2, "unilib_glem_plant_bulrush_2")
    add_schem({"unilib:dirt_mud_swamp"}, 80, 0.05, {"glemr6_valleys_temperate_rainforest_swamp"}, -2, 0, "unilib_glem_flower_waterlily_exotic_pink")
    add_schem({"unilib:dirt_mud_swamp"}, 80, 0.05, {"glemr6_valleys_temperate_rainforest_swamp"}, -2, 0, "unilib_glem_flower_waterlily_exotic_yellow")
    add_node({"unilib:dirt_mud_swamp"}, 0.2, {"glemr6_valleys_temperate_rainforest_swamp"}, -1, 1, {"unilib:plant_papyrus_ordinary"}, 4, "unilib:liquid_water_ordinary_source", 1)
    add_node({"unilib:dirt_mud_swamp"}, 0.08, {"glemr6_valleys_temperate_rainforest_swamp"}, -1, 1, {"unilib:plant_papyrus_ordinary"}, 3, "unilib:dirt_mud_swamp", 1)
    add_node({"unilib:dirt_mud_swamp"}, 0.2, {"glemr6_valleys_temperate_rainforest_swamp"}, 1, 2, {"unilib:plant_cattail_normal"}, 1, nil, nil)
    add_node({"unilib:dirt_mud_swamp"}, 0.1, {"glemr6_valleys_temperate_rainforest_swamp"}, 1, 2, {"unilib:plant_nettle_impatiens"}, 1, nil, nil)
    add_node({"unilib:dirt_mud_swamp"}, 0.1, {"glemr6_valleys_temperate_rainforest_swamp"}, 2, 4, {"unilib:misc_patch_grass"}, 1, nil, nil)
    add_node({"unilib:dirt_mud_swamp"}, 0.1, {"glemr6_valleys_temperate_rainforest_swamp"}, 2, 4, {"unilib:grass_giant"}, 1, nil, nil)
    add_node({"unilib:dirt_mud_swamp"}, 0.05, {"glemr6_valleys_temperate_rainforest_swamp"}, -2, 0, {"unilib:flower_waterlily_exotic_pink"}, 1, nil, nil)
    add_node({"unilib:dirt_mud_swamp"}, 0.05, {"glemr6_valleys_temperate_rainforest_swamp"}, -2, 0, {"unilib:flower_waterlily_exotic_yellow"}, 1, nil, nil)

end

local function add_decorations_savanna()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        -- glemr6_valleys_savanna
        -- trees
        add_schem({"unilib:dirt_clayey_with_turf_hot_semiarid_lowland"}, 80, 0.003, {"glemr6_valleys_savanna"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_acacia_2")
        add_schem({"unilib:dirt_clayey_with_turf_hot_semiarid_lowland"}, 80, 0.003, {"glemr6_valleys_savanna"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_acacia_1")
        add_schem({"unilib:dirt_clayey_with_turf_hot_semiarid_lowland"}, 80, 0.003, {"glemr6_valleys_savanna"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_acacia_3")
        add_schem({"unilib:dirt_clayey_with_turf_hot_semiarid_lowland"}, 80, 0.003, {"glemr6_valleys_savanna"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_acacia_log", "place_center_x, place_center_z")
        -- grasses
        add_node({"unilib:dirt_clayey_with_turf_hot_semiarid_lowland"}, 0.06, {"glemr6_valleys_savanna"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_1", "unilib:grass_dry_2", "unilib:grass_dry_3", "unilib:grass_dry_4", "unilib:grass_dry_5"}, nil, nil, nil)

    end

end

local function add_decorations_savanna_swamp()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        -- glemr6_valleys_savanna_swamp
        -- trees
        add_schem({"unilib:dirt_clayey"}, 80, 0.01, {"glemr6_valleys_savanna_swamp"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_acacia_2")
        add_schem({"unilib:dirt_clayey"}, 80, 0.01, {"glemr6_valleys_savanna_swamp"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_acacia_1")
        add_schem({"unilib:dirt_clayey"}, 80, 0.01, {"glemr6_valleys_savanna_swamp"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_acacia_3")
        add_schem({"unilib:dirt_clayey"}, 80, 0.01, {"glemr6_valleys_savanna_swamp"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, "unilib_glem_tree_acacia_log", "place_center_x, place_center_z")
        -- grasses
        add_node({"unilib:dirt_clayey"}, 0.08, {"glemr6_valleys_savanna_swamp"}, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, {"unilib:grass_dry_1", "unilib:grass_dry_2", "unilib:grass_dry_3", "unilib:grass_dry_4", "unilib:grass_dry_5"}, nil, nil, nil)

    end

end

---------------------------------------------------------------------------------------------------
-- Mixed/misc biomes
---------------------------------------------------------------------------------------------------

local function add_decorations_mixed()

    -- Wild oats
    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = "unilib:plant_oat_wild_dry",

        biomes = {"glemr6_cool_temperate_lowland"},
        fill_ratio = 0.01,
        height = 1,
        place_on = {"unilib:dirt_coarse_with_turf"},
        sidelen = 6,
    })

    -- Large cactus
    unilib.register_decoration_simple({
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_plant_cactus_ordinary_large.mts",

        biomes = {"glemr6_warm_arid_lowland", "glem6_temperate_arid_lowland"},
        fill_ratio = 0.002,
        flags = "place_center_x",
        place_on = {"unilib:dirt_parched_with_turf_dry", "unilib:sand_ordinary"},
        rotation = "random",
        sidelen = 16,
        y_max = unilib.y_max,
        y_min = 5,
    })

    -- Cactus
    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = "unilib:plant_cactus_ordinary",

        biomes = {
            "glemr6_hot_arid_lowland",
            "glemr6_warm_arid_lowland",
            "glemr6_temperate_arid_lowland",
        },
        fill_ratio = 0.002,
        height = 2,
        height_max = 5,
        place_on = {
            "unilib:dirt_parched_with_turf_dry",
            "unilib:sand_desert",
            "unilib:sand_ordinary",
        },
        sidelen = 16,
        y_max = unilib.y_max,
        y_min = 5,
    })

    -- Papyrus
    unilib.register_decoration_simple({
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_plant_papyrus_ordinary_farlands.mts",

        biomes = {
            "glemr6_hot_humid_coastal",
            "glemr6_hot_semihumid_coastal",
            "glemr6_warm_humid_coastal",
            "glemr6_warm_temperate_coastal",
        },
        fill_ratio = 0.002,
        place_on = {
            "unilib:dirt_clayey_with_litter_rainforest",
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_silt_fine_with_litter_rainforest",
            "unilib:dirt_silt_fine_with_turf",
        },
        sidelen = 16,
        y_max = 0,
        y_min = 0,
    })

end

local function add_decorations_bakedclay()

    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = "unilib:flower_delphinium_blue",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.004,
            seed = 7133,
            spread = {x = 100, y = 100, z = 100},
        },
        place_on = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary_with_turf_grove",
            "unilib:dirt_ordinary_with_turf_prairie",
        },
        sidelen = 16,
        y_max = 90,
        y_min = 10,
    })

    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = "unilib:flower_thistle",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.004,
            seed = 7134,
            spread = {x = 100, y = 100, z = 100},
        },
        place_on = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary_with_turf_bamboo",
            "unilib:dirt_ordinary_with_turf_grove",
            "unilib:dirt_ordinary_with_turf_prairie",
        },
        sidelen = 16,
        y_max = 90,
        y_min = 15,
    })

    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = "unilib:flower_lazarus_bell",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.01,
            seed = 7135,
            spread = {x = 100, y = 100, z = 100},
        },
        num_spawn_by = 1,
        place_on = {"unilib:dirt_ordinary_with_turf_rainforest"},
        sidelen = 16,
        spawn_by = "unilib:tree_jungle_trunk",
        y_max = 90,
        y_min = 1,
    })

    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = "unilib:flower_reed_mannagrass",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.009,
            seed = 7136,
            spread = {x = 100, y = 100, z = 100},
        },
        num_spawn_by = 1,
        place_on = {"unilib:dirt_ordinary_with_turf", "unilib:sand_ordinary"},
        sidelen = 16,
        spawn_by = "group:water",
        y_max = 15,
        y_min = 1,
    })

end

local function add_decorations_ocean()

    -- Coral reefs
    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = {
            "unilib:coral_block_brown",
            "unilib:coral_block_orange",
            "unilib:coral_block_skeleton",
            "unilib:coral_rooted_blue",
            "unilib:coral_rooted_cyan",
            "unilib:coral_rooted_green",
            "unilib:coral_rooted_orange",
            "unilib:coral_rooted_pink",
            "unilib:coral_rooted_red",
        },

        biomes = {
            "glemr6_warm_temperate_ocean",
            "glemr6_temperate_humid_ocean",
            "glemr6_temperate_semihumid_ocean",
            "glemr6_temperate_temperate_ocean",
        },
        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -4,
            persist = 0.7,
            scale = 4,
            seed = 7013,
            spread = {x = 50, y = 50, z = 50},
        },
        place_offset_y = -1,
        place_on = {"unilib:sand_ordinary", "unilib:dirt_silt_coarse"},
        sidelen = 4,
        y_max = -2,
        y_min = -12,
    })

    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = {
            "unilib:coral_block_skeleton",
            "unilib:coral_brain",
            "unilib:coral_rooted_blue_glow",
            "unilib:coral_rooted_green_glow",
            "unilib:coral_rooted_orange_glow",
            "unilib:coral_rooted_pink_big",
            "unilib:coral_rooted_pink_glow",
            "unilib:plant_anemone",
        },

        biomes = {
            "glemr6_warm_humid_ocean",
            "glemr6_warm_semihumid_ocean",
        },
        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -4,
            persist = 0.7,
            scale = 4,
            seed = 7013,
            spread = {x = 50, y = 50, z = 50},
        },
        place_offset_y = -1,
        place_on = {"unilib:sand_silica", "unilib:dirt_silt_coarse"},
        sidelen = 4,
        y_max = -4,
        y_min = -14,
    })

    -- Kelp
    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = {
            "unilib:plant_kelp_yellow",
            "unilib:plant_kelp_green",
            "unilib:plant_kelp_green_thick",
            "unilib:plant_seaweed_undersea",
        },

        biomes = {
            "glemr6_temperate_humid_ocean",
            "glemr6_temperate_semihumid_ocean",
            "glemr6_temperate_temperate_ocean",
            "glemr6_cool_humid_ocean",
            "glemr6_cool_semihumid_ocean",
            "glemr6_cool_temperate_ocean",
        },
        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -0.04,
            persist = 0.7,
            scale = 0.1,
            seed = 87112,
            spread = {x = 200, y = 200, z = 200},
        },
        param2 = 48,
        param2_max = 96,
        place_offset_y = -1,
        place_on = {"unilib:dirt_silt_coarse", "unilib:sand_ordinary"},
        sidelen = 16,
        y_max = -5,
        y_min = -10,
    })

    -- Sea Grass
    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = {
            "unilib:grass_seagrass_1",
            "unilib:grass_seagrass_2",
            "unilib:grass_seagrass_3",
        },

        biomes = {
            "glemr6_hot_semiarid_ocean",
            "glemr6_warm_semiarid_ocean",
            "glemr6_temperate_semiarid_ocean",
            "glemr6_cool_semiarid_ocean",
        },
        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -0.04,
            persist = 0.7,
            scale = 0.1,
            seed = 87112,
            spread = {x = 200, y = 200, z = 200},
        },
        param2 = 48,
        param2_max = 96,
        place_offset_y = -1,
        place_on = {"unilib:sand_ordinary"},
        sidelen = 16,
        y_max = -5,
        y_min = -10,
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_glemr6.init()

    return {
        description = "Decorations from GLEMr6",
        notes = "This package should be used with the corresponding remix, as it assumes that" ..
                " packages specified by the remix have been loaded",
        depends = "biome_glemr6",
        -- The mature apple tree package fails if the replace_mode for minetest_game mods is
        --      "defer", therefore we have to check it was executed, before we use schematics
        --      containing its leaves (confusingly, the schematic in question is
        --      "unilib_glem_tree_banana_1")
        optional = "tree_apple_mature",
    }

end

function unilib.pkg.deco_glemr6.post()

    if unilib.pkg.biome_glemr6.generic_biome_flag then
        add_decorations_generic()
    end

    if unilib.pkg.biome_glemr6.glem_biome_flag then

        add_decorations_hot_humid()
        add_decorations_hot_semihumid()
        add_decorations_hot_temperate()
        add_decorations_hot_semiarid()
        add_decorations_hot_arid()

        add_decorations_warm_humid()
        add_decorations_warm_semihumid()
        add_decorations_warm_temperate()
        add_decorations_warm_semiarid()
        add_decorations_warm_arid()

        add_decorations_temperate_humid()
        add_decorations_temperate_semihumid()
        add_decorations_temperate_temperate()
        add_decorations_temperate_semiarid()
        add_decorations_temperate_arid()

        add_decorations_cool_humid()
        add_decorations_cool_semihumid()
        add_decorations_cool_temperate()
        add_decorations_cool_semiarid()
        add_decorations_cool_arid()

        add_decorations_cold_humid()
        add_decorations_cold_semihumid()
        add_decorations_cold_temperate()
        add_decorations_cold_semiarid()
        add_decorations_cold_arid()

    end

    if unilib.pkg.biome_glemr6.valleys_biome_flag then

        add_decorations_deciduous_forest_swamp()
        add_decorations_tropical_rainforest()
        add_decorations_tropical_rainforest_swamp()
        add_decorations_subtropical_rainforest_swamp()
        add_decorations_temperate_rainforest_swamp()
        add_decorations_savanna()
        add_decorations_savanna_swamp()

    end

    if place_misc_decos_flag then

        add_decorations_mixed()
        add_decorations_bakedclay()
        add_decorations_ocean()

    end

end
