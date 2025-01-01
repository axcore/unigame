---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_glemr4 = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

-- Environmental constants (from lib_ecology/init.lua; must match values in the "biome_glemr4"
--      package)
local HEIGHT_BEACH = 4
local HEIGHT_COASTAL = 40
local HEIGHT_LOWLAND = 80
local HEIGHT_SHELF = 120
local HEIGHT_HIGHLAND = 160
local HEIGHT_MOUNTAIN = 200
local HEIGHT_STRATO = 1800

-- Flag set to true, if miscellaneous decorations for waterlilies, cactus, baked clay etc should
--      be placed
local misc_flag = true
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

        if core.registered_biomes[biome_name] == nil and
                unilib.global.biome_name_check_table[biome_name] == nil then

            if debug_warning_flag then
                unilib.utils.show_warning("deco_glemr4 package: Unrecognised biome", biome_name)
            end

            return false

        end

    end

    return true

end

local function check_nodes(node_list)

    -- Register dirt on demand (see comments in the "dirt_custom_glemr4" package)
    if unilib.setting.dirt_on_demand_flag then

        for _, full_name in pairs(node_list) do

            if core.registered_nodes[full_name] == nil and
                    unilib.pkg.dirt_custom_glemr4.dirt_table[full_name] ~= nil then

                local data_table = unilib.pkg.dirt_custom_glemr4.dirt_table[full_name]
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

        if not unilib.utils.is_registered_node_or_mtgame_alias(full_name) then

            if debug_warning_flag then
                unilib.utils.show_warning("deco_glemr4 package: Unrecognised node", full_name)
            end

            return false

        elseif unilib.utils.get_mod_name(full_name) ~= "unilib" then

            -- (Not a fatal error)
            if debug_warning_flag then
                unilib.utils.show_warning("deco_glemr4 package: Non-unilib node", full_name)
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
        schematic = unilib.core.path_mod .. "/mts/" .. g .. ".mts",

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

local function add_schem_no_rotate(a, b, c, d, e, f, g, h)

    if not check_biomes(d) or not check_nodes(a) then
        return
    end

    unilib.register_decoration_simple({
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/" .. g .. ".mts",

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

    -- glemr4_hot_humid_ocean

    -- glemr4_hot_humid_beach
    -- trees
    add_schem({"unilib:dirt_silt_coarse"}, 80, 0.35, {"glemr4_hot_humid_beach"}, 0, 2, "unilib_glem_tree_mangrove_green_1")
    add_schem({"unilib:dirt_silt_coarse"}, 80, 0.35, {"glemr4_hot_humid_beach"}, 0, 2, "unilib_glem_tree_mangrove_green_2")
    add_schem({"unilib:dirt_silt_coarse"}, 80, 0.35, {"glemr4_hot_humid_beach"}, 0, 2, "unilib_glem_tree_mangrove_green_3")
    add_schem({"unilib:dirt_silt_coarse"}, 80, 0.35, {"glemr4_hot_humid_beach"}, 0, 2, "unilib_glem_tree_mangrove_green_4")
    add_schem({"unilib:dirt_silt_coarse"}, 80, 0.35, {"glemr4_hot_humid_beach"}, 0, 2, "unilib_glem_tree_mangrove_green_5")
    add_schem({"unilib:dirt_silt_coarse"}, 80, 0.35, {"glemr4_hot_humid_beach"}, 0, 2, "unilib_glem_tree_mangrove_green_6")
    -- saplings

    -- glemr4_hot_humid_coastal
    -- trees
    add_schem({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 80, 0.01, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_jungle_exotic_1")
    add_schem({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 80, 0.01, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_jungle_exotic_2")
    add_schem({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 80, 0.01, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_jungle_1")
    add_schem({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 80, 0.01, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_jungle_2")
    add_schem({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 80, 0.01, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_plain_1")
    add_schem({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 80, 0.01, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_plain_2")
    add_schem({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 80, 0.01, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_1")
    add_schem({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 80, 0.01, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_3")
    add_schem({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 80, 0.01, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_5")
    add_schem({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 80, 0.01, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_exotic_7")
    add_schem({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 80, 0.01, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_exotic_9")
    -- saplings
    -- grasses
    add_node({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_jungle"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 0.03, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_rainforest_1"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_rainforest_2"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 0.03, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_rainforest_3"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_rainforest_4"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 0.03, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_rainforest_5"}, nil, nil, nil)
    -- ferns
    add_schem_no_rotate({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 80, 0.02, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_fern_giant_1")
    add_schem_no_rotate({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 80, 0.02, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_fern_yellow")
    add_node({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 0.02, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:tree_fern_giant_sapling"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 0.02, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:tree_fern_sapling"}, nil, nil, nil)
    -- flowers
    -- plants
    -- N.B. This schematic replaces the non-existent bush mentioned in the original code
    add_schem({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 80, 0.01, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_bush_ordinary")
    add_node({"unilib:dirt_silt_coarse_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:tree_young_jungle"}, nil, nil, nil)

    -- glemr4_hot_humid_lowland
    -- trees
    add_schem({"unilib:dirt_silt_fine_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_exotic_1")
    add_schem({"unilib:dirt_silt_fine_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_exotic_2")
    add_schem({"unilib:dirt_silt_fine_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_jungle_1")
    add_schem({"unilib:dirt_silt_fine_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_jungle_2")
    add_schem({"unilib:dirt_silt_fine_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_plain_1")
    add_schem({"unilib:dirt_silt_fine_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_plain_2")
    add_schem({"unilib:dirt_silt_fine_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_2")
    add_schem({"unilib:dirt_silt_fine_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_3")
    add_schem({"unilib:dirt_silt_fine_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_4")
    add_schem({"unilib:dirt_silt_fine_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_exotic_5")
    add_schem({"unilib:dirt_silt_fine_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_exotic_7")
    add_schem({"unilib:dirt_silt_fine_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_exotic_8")
    add_schem({"unilib:dirt_silt_fine_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_exotic_10")
    -- saplings
    -- grasses
    add_node({"unilib:dirt_silt_fine_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_jungle"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_1"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_2"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_3"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_4"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_5"}, nil, nil, nil)
    -- ferns
    add_schem_no_rotate({"unilib:dirt_silt_fine_with_litter_rainforest"}, 80, 0.003, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fern_giant_1")
    add_schem_no_rotate({"unilib:dirt_silt_fine_with_litter_rainforest"}, 80, 0.002, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fern_yellow")
    add_node({"unilib:dirt_silt_fine_with_litter_rainforest"}, 0.002, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:tree_fern_giant_sapling"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_litter_rainforest"}, 0.002, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:tree_fern_sapling"}, nil, nil, nil)
    -- flowers
    -- plants
    add_schem({"unilib:dirt_silt_fine_with_litter_rainforest"}, 80, 0.003, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_bush_ordinary")
    add_node({"unilib:dirt_silt_fine_with_litter_rainforest"}, 0.003, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:produce_pineapple_grow_8"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_litter_rainforest"}, 0.003, {"glemr4_hot_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:tree_young_jungle"}, nil, nil, nil)

    -- glemr4_hot_humid_shelf
    -- trees
    add_schem({"unilib:dirt_dark_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_plant_bamboo_small_1")
    add_schem({"unilib:dirt_dark_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_1")
    add_schem({"unilib:dirt_dark_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_2")
    add_schem({"unilib:dirt_dark_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_3")
    add_schem({"unilib:dirt_dark_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_exotic_1")
    add_schem({"unilib:dirt_dark_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_exotic_2")
    add_schem({"unilib:dirt_dark_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_exotic_3")
    add_schem({"unilib:dirt_dark_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_exotic_1")
    add_schem({"unilib:dirt_dark_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_exotic_2")
    add_schem({"unilib:dirt_dark_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_jungle_1")
    add_schem({"unilib:dirt_dark_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_jungle_2")
    add_schem({"unilib:dirt_dark_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_plain_1")
    add_schem({"unilib:dirt_dark_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_plain_2")
    add_schem({"unilib:dirt_dark_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_1")
    add_schem({"unilib:dirt_dark_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_3")
    add_schem({"unilib:dirt_dark_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_4")
    add_schem({"unilib:dirt_dark_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_exotic_6")
    add_schem({"unilib:dirt_dark_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_exotic_8")
    -- grasses
    add_node({"unilib:dirt_dark_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_jungle"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_bamboo"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_1"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_2"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_3"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_4"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_5"}, nil, nil, nil)
    -- ferns
    add_schem_no_rotate({"unilib:dirt_dark_with_litter_rainforest"}, 80, 0.003, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fern_giant_1")
    add_schem_no_rotate({"unilib:dirt_dark_with_litter_rainforest"}, 80, 0.002, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fern_yellow")
    add_node({"unilib:dirt_dark_with_litter_rainforest"}, 0.002, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:tree_fern_giant_sapling"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_litter_rainforest"}, 0.002, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:tree_fern_sapling"}, nil, nil, nil)
    -- flowers
    -- plants
    add_schem({"unilib:dirt_dark_with_litter_rainforest"}, 80, 0.003, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_bush_ordinary")
    add_node({"unilib:dirt_dark_with_litter_rainforest"}, 0.003, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:produce_pineapple_grow_8"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_litter_rainforest"}, 0.003, {"glemr4_hot_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:tree_young_jungle"}, nil, nil, nil)

    -- glemr4_hot_humid_highland
    -- trees
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_plant_bamboo_small_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_bamboo_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_bamboo_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_bamboo_3")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_bamboo_exotic_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_bamboo_exotic_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_bamboo_exotic_3")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_5")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_mature_5")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_exotic_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_exotic_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_palm_jungle_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_palm_jungle_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_palm_plain_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_palm_plain_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_palm_1")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_palm_2")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_palm_5")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_palm_exotic_7")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_palm_exotic_8")
    add_schem({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.005, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_palm_exotic_9")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_jungle"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_bamboo"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.01, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_5"}, nil, nil, nil)
    -- ferns
    add_schem_no_rotate({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.003, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fern_giant_1")
    add_schem_no_rotate({"unilib:dirt_ordinary_with_litter_rainforest"}, 80, 0.002, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fern_yellow")
    add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.002, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:tree_fern_giant_sapling"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.002, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:tree_fern_sapling"}, nil, nil, nil)
    -- flowers
    -- plants
    add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.003, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_aloe_vera"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_rainforest"}, 0.003, {"glemr4_hot_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:tree_young_jungle"}, nil, nil, nil)

    -- glemr4_hot_humid_mountain

end

local function add_decorations_hot_semihumid()

    -- glemr4_hot_semihumid_ocean

    -- glemr4_hot_semihumid_beach
    -- trees
    -- N.B. "glemr4_hot_semihumid_coastal" in original code - appears to be a mistake
    if unilib.pkg.biome_glemr4.optional_biome_flag then

        add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 80, 0.008, {"glemr4_hot_semihumid_beach"}, 0, 1, "unilib_glem_tree_mangrove_green_1")
        add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 80, 0.008, {"glemr4_hot_semihumid_beach"}, 0, 1, "unilib_glem_tree_mangrove_green_2")
        add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 80, 0.008, {"glemr4_hot_semihumid_beach"}, 0, 1, "unilib_glem_tree_mangrove_green_3")
        add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 80, 0.008, {"glemr4_hot_semihumid_beach"}, 0, 1, "unilib_glem_tree_mangrove_green_4")
        add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 80, 0.008, {"glemr4_hot_semihumid_beach"}, 0, 1, "unilib_glem_tree_mangrove_green_5")
        add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 80, 0.008, {"glemr4_hot_semihumid_beach"}, 0, 1, "unilib_glem_tree_mangrove_green_6")
        -- saplings

    end

    -- glemr4_hot_semihumid_coastal
    -- trees
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 80, 0.002, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_jungle_exotic_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 80, 0.002, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_jungle_exotic_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 80, 0.002, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_jungle_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 80, 0.002, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_jungle_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 80, 0.002, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_plain_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 80, 0.002, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_plain_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 80, 0.002, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 80, 0.002, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_4")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 80, 0.002, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_palm_7")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 80, 0.002, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_jungle_6")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 80, 0.002, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_jungle_mature_6")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 80, 0.002, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_jungle_ancient_6")
    -- saplings
    -- grasses
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 0.01, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_jungle"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 0.01, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_rainforest_1"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 0.01, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_rainforest_2"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 0.01, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_rainforest_3"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 0.01, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_rainforest_4"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 0.01, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_rainforest_5"}, nil, nil, nil)
    -- ferns
    add_schem_no_rotate({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 80, 0.003, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_fern_giant_1")
    add_schem_no_rotate({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 80, 0.003, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_fern_yellow")
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 0.002, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:tree_fern_giant_sapling"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 0.002, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:tree_fern_sapling"}, nil, nil, nil)
    -- flowers
    -- plants
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 0.003, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:plant_shrub_banana_large"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_4"}, 0.003, {"glemr4_hot_semihumid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:tree_young_jungle"}, nil, nil, nil)

    -- glemr4_hot_semihumid_lowland
    -- trees
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_exotic_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_exotic_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_jungle_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_jungle_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_plain_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_plain_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_4")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_5")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_6")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_7")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_8")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_mature_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_mature_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_mature_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_mature_4")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_mature_5")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_mature_6")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_mature_7")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_mature_8")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_ancient_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_ancient_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_ancient_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_ancient_4")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_ancient_5")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_ancient_6")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_ancient_7")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_ancient_8")
    -- grasses
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 0.01, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_jungle"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 0.01, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_1"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 0.01, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_2"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 0.01, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_3"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 0.01, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_4"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 0.01, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_rainforest_5"}, nil, nil, nil)
    -- ferns
    add_schem_no_rotate({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.003, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fern_giant_1")
    add_schem_no_rotate({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 80, 0.003, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fern_yellow")
    -- flowers
    -- plants
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 0.003, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_shrub_banana_large"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_3"}, 0.003, {"glemr4_hot_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:tree_young_jungle"}, nil, nil, nil)

    -- glemr4_hot_semihumid_shelf
    -- trees
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.005, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_plant_bamboo_small_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.005, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.005, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.005, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.005, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_exotic_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.005, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_exotic_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.005, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_bamboo_exotic_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.005, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_exotic_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.005, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_jungle_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.005, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.005, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_5")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.005, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_mature_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.005, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_mature_5")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.005, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_ancient_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.005, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_ancient_5")
    -- grasses
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_jungle"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_1"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_2"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_3"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_4"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_rainforest_5"}, nil, nil, nil)
    -- ferns
    add_schem_no_rotate({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.003, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fern_giant_1")
    add_schem_no_rotate({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.003, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fern_yellow")
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.004, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_dicksonia"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.001, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_lady"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.001, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_broad_leaf"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.003, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_boston"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.001, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_horsetail_young"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.001, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_horsetail_small"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.001, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_horsetail_medium"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.001, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_horsetail_large"}, nil, nil, nil)
    -- flowers
    -- plants
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.003, {"glemr4_hot_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:tree_young_jungle"}, nil, nil, nil)

    -- glemr4_hot_semihumid_highland
    -- trees
    add_schem({"unilib:dirt_coarse_with_turf_exotic_brown_1"}, 80, 0.005, {"glemr4_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_plant_bamboo_small_1")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_brown_1"}, 80, 0.005, {"glemr4_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_bamboo_2")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_brown_1"}, 80, 0.005, {"glemr4_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_bamboo_exotic_2")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_brown_1"}, 80, 0.005, {"glemr4_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_exotic_1")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_brown_1"}, 80, 0.005, {"glemr4_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_palm_jungle_1")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_brown_1"}, 80, 0.005, {"glemr4_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_7")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_brown_1"}, 80, 0.005, {"glemr4_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_8")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_brown_1"}, 80, 0.005, {"glemr4_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_mature_7")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_brown_1"}, 80, 0.005, {"glemr4_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_mature_8")
    -- grasses
    add_node({"unilib:dirt_coarse_with_turf_exotic_brown_1"}, 0.01, {"glemr4_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_1"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_brown_1"}, 0.01, {"glemr4_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_2"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_brown_1"}, 0.01, {"glemr4_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_3"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_brown_1"}, 0.01, {"glemr4_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_4"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_brown_1"}, 0.01, {"glemr4_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_rainforest_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_coarse_with_turf_exotic_brown_1"}, 0.003, {"glemr4_hot_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:tree_young_jungle"}, nil, nil, nil)

    -- glemr4_hot_semihumid_mountain

end

local function add_decorations_hot_temperate()

    -- glemr4_hot_temperate_ocean

    -- glemr4_hot_temperate_beach
    -- trees
    add_schem({"unilib:sand_volcanic_dust"}, 80, 0.002, {"glemr4_hot_temperate_beach"}, 1, 2, "unilib_glem_tree_palm_1")
    add_schem({"unilib:sand_volcanic_dust"}, 80, 0.002, {"glemr4_hot_temperate_beach"}, 1, 2, "unilib_glem_tree_palm_2")

    -- glemr4_hot_temperate_coastal
    -- trees
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.005, {"glemr4_hot_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_jungle_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.005, {"glemr4_hot_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_jungle_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.005, {"glemr4_hot_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_jungle_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.005, {"glemr4_hot_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_jungle_4")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.005, {"glemr4_hot_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_jungle_5")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.005, {"glemr4_hot_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_jungle_6")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.005, {"glemr4_hot_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_jungle_7")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.005, {"glemr4_hot_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_jungle_8")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.005, {"glemr4_hot_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_jungle_mature_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.005, {"glemr4_hot_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_jungle_ancient_1")
    -- grasses
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.01, {"glemr4_hot_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.01, {"glemr4_hot_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.01, {"glemr4_hot_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.01, {"glemr4_hot_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.01, {"glemr4_hot_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_5"}, nil, nil, nil)

    -- glemr4_hot_temperate_lowland
    -- trees
    add_schem({"unilib:dirt_dark_with_turf_exotic_2"}, 80, 0.004, {"glemr4_hot_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_2"}, 80, 0.004, {"glemr4_hot_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_mature_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_2"}, 80, 0.005, {"glemr4_hot_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_jungle_ancient_1")
    -- grasses
    add_node({"unilib:dirt_dark_with_turf_exotic_2"}, 0.01, {"glemr4_hot_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_2"}, 0.01, {"glemr4_hot_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_2"}, 0.01, {"glemr4_hot_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_2"}, 0.01, {"glemr4_hot_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_2"}, 0.01, {"glemr4_hot_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)

    -- glemr4_hot_temperate_shelf
    -- trees
    add_schem({"unilib:dirt_coarse_with_turf_exotic_3"}, 80, 0.004, {"glemr4_hot_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_1")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_3"}, 80, 0.004, {"glemr4_hot_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_mature_1")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_3"}, 80, 0.005, {"glemr4_hot_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_jungle_ancient_1")
    -- grasses
    add_node({"unilib:dirt_coarse_with_turf_exotic_3"}, 0.01, {"glemr4_hot_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_3"}, 0.01, {"glemr4_hot_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_3"}, 0.01, {"glemr4_hot_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_3"}, 0.01, {"glemr4_hot_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_3"}, 0.01, {"glemr4_hot_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_5"}, nil, nil, nil)

    -- glemr4_hot_temperate_highland
    -- trees
    add_schem({"unilib:clay_red_with_turf_exotic_4"}, 80, 0.005, {"glemr4_hot_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_1")
    add_schem({"unilib:clay_red_with_turf_exotic_4"}, 80, 0.005, {"glemr4_hot_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_mature_1")
    add_schem({"unilib:clay_red_with_turf_exotic_4"}, 80, 0.005, {"glemr4_hot_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_jungle_ancient_1")

    -- glemr4_hot_temperate_mountain

end

local function add_decorations_hot_semiarid()

    -- glemr4_hot_semiarid_ocean

    -- glemr4_hot_semiarid_beach

    -- glemr4_hot_semiarid_coastal
    -- trees
    add_schem({"unilib:dirt_dark_with_turf_exotic_dry_3"}, 80, 0.002, {"glemr4_hot_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_acacia_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_dry_3"}, 80, 0.002, {"glemr4_hot_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_acacia_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_dry_3"}, 80, 0.002, {"glemr4_hot_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_acacia_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_dry_3"}, 80, 0.002, {"glemr4_hot_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_acacia_log", "place_center_x, place_center_z")
    -- grasses
    add_node({"unilib:dirt_dark_with_turf_exotic_dry_3"}, 0.01, {"glemr4_hot_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_dry_3"}, 0.01, {"glemr4_hot_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_dry_3"}, 0.01, {"glemr4_hot_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_dry_3"}, 0.01, {"glemr4_hot_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_dry_3"}, 0.01, {"glemr4_hot_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_5"}, nil, nil, nil)

    -- glemr4_hot_semiarid_lowland
    -- trees
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_3"}, 80, 0.006, {"glemr4_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_acacia_2")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_3"}, 80, 0.006, {"glemr4_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_acacia_1")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_3"}, 80, 0.006, {"glemr4_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_acacia_3")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_3"}, 80, 0.006, {"glemr4_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_acacia_log", "place_center_x, place_center_z")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_3"}, 80, 0.006, {"glemr4_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_date_1")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_3"}, 80, 0.006, {"glemr4_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_date_2")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_3"}, 80, 0.006, {"glemr4_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_date_3")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_3"}, 80, 0.006, {"glemr4_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_date_4")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_3"}, 80, 0.006, {"glemr4_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_palm_date_5")
    -- saplings
    -- grasses
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_3"}, 0.01, {"glemr4_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_3"}, 0.01, {"glemr4_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_3"}, 0.01, {"glemr4_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_3"}, 0.01, {"glemr4_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_3"}, 0.01, {"glemr4_hot_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)

    -- glemr4_hot_semiarid_shelf
    -- trees
    add_schem({"unilib:clay_red_with_turf_exotic_dry_4"}, 80, 0.004, {"glemr4_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_acacia_2")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_4"}, 80, 0.004, {"glemr4_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_acacia_1")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_4"}, 80, 0.004, {"glemr4_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_acacia_3")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_4"}, 80, 0.004, {"glemr4_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_acacia_log", "place_center_x, place_center_z")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_4"}, 80, 0.004, {"glemr4_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_date_1")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_4"}, 80, 0.004, {"glemr4_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_date_2")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_4"}, 80, 0.004, {"glemr4_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_date_3")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_4"}, 80, 0.004, {"glemr4_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_date_4")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_4"}, 80, 0.004, {"glemr4_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_palm_date_5")
    -- saplings
    -- grasses
    add_node({"unilib:clay_red_with_turf_exotic_dry_4"}, 0.01, {"glemr4_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_dry_4"}, 0.01, {"glemr4_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_dry_4"}, 0.01, {"glemr4_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_dry_4"}, 0.01, {"glemr4_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_dry_4"}, 0.01, {"glemr4_hot_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_5"}, nil, nil, nil)

    -- glemr4_hot_semiarid_highland
    -- trees
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_4"}, 80, 0.003, {"glemr4_hot_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_acacia_2")
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_4"}, 80, 0.003, {"glemr4_hot_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_acacia_1")
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_4"}, 80, 0.003, {"glemr4_hot_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_acacia_3")
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_4"}, 80, 0.003, {"glemr4_hot_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_acacia_log", "place_center_x, place_center_z")
    -- grasses
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_4"}, 0.01, {"glemr4_hot_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_4"}, 0.01, {"glemr4_hot_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_4"}, 0.01, {"glemr4_hot_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_4"}, 0.01, {"glemr4_hot_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_4"}, 0.01, {"glemr4_hot_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)

    -- glemr4_hot_semiarid_mountain

end

local function add_decorations_hot_arid()

    -- glemr4_hot_arid_ocean

    -- glemr4_hot_arid_beach

    -- glemr4_hot_arid_coastal

    -- glemr4_hot_arid_lowland

    -- glemr4_hot_arid_shelf

    -- glemr4_hot_arid_highland

    -- glemr4_hot_arid_mountain

end

---------------------------------------------------------------------------------------------------
-- Warm biomes
---------------------------------------------------------------------------------------------------

local function add_decorations_warm_humid()

    -- glemr4_warm_humid_ocean

    -- glemr4_warm_humid_beach

    -- glemr4_warm_humid_coastal
    -- trees
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_brown_4"}, 80, 0.05, {"glemr4_warm_humid_coastal"}, 0, 1, "unilib_glem_tree_mangrove_green_1")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_brown_4"}, 80, 0.05, {"glemr4_warm_humid_coastal"}, 0, 1, "unilib_glem_tree_mangrove_green_2")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_brown_4"}, 80, 0.05, {"glemr4_warm_humid_coastal"}, 0, 1, "unilib_glem_tree_mangrove_green_3")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_brown_4"}, 80, 0.05, {"glemr4_warm_humid_coastal"}, 0, 1, "unilib_glem_tree_mangrove_green_4")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_brown_4"}, 80, 0.05, {"glemr4_warm_humid_coastal"}, 0, 1, "unilib_glem_tree_mangrove_green_5")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_brown_4"}, 80, 0.005, {"glemr4_warm_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_cypress_1")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_brown_4"}, 80, 0.005, {"glemr4_warm_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_cypress_2")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_brown_4"}, 80, 0.005, {"glemr4_warm_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_normal_1")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_brown_4"}, 80, 0.005, {"glemr4_warm_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_normal_2")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_brown_4"}, 80, 0.005, {"glemr4_warm_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_mature_2")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_brown_4"}, 80, 0.005, {"glemr4_warm_humid_coastal"}, 3, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_mature_4")
    -- saplings
    -- grasses
    add_node({"unilib:dirt_silt_coarse_with_turf_exotic_brown_4"}, 0.01, {"glemr4_warm_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_turf_exotic_brown_4"}, 0.01, {"glemr4_warm_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_swamp_1"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_turf_exotic_brown_4"}, 0.01, {"glemr4_warm_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_swamp_2"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_turf_exotic_brown_4"}, 0.01, {"glemr4_warm_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_swamp_3"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_turf_exotic_brown_4"}, 0.01, {"glemr4_warm_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_swamp_4"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_turf_exotic_brown_4"}, 0.01, {"glemr4_warm_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:grass_swamp_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_silt_coarse_with_turf_exotic_brown_4"}, 0.01, {"glemr4_warm_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:plant_juncus_white"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_turf_exotic_brown_4"}, 0.01, {"glemr4_warm_humid_coastal"}, 3, HEIGHT_COASTAL, {"unilib:fern_lady_small"}, nil, nil, nil)

    -- glemr4_warm_humid_lowland
    -- trees
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 80, 0.005, {"glemr4_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_cypress_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 80, 0.005, {"glemr4_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_cypress_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 80, 0.005, {"glemr4_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_normal_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 80, 0.005, {"glemr4_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_normal_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 80, 0.005, {"glemr4_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_mature_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 80, 0.005, {"glemr4_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_mature_4")
    -- grasses
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 0.01, {"glemr4_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 0.01, {"glemr4_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_1"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 0.01, {"glemr4_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_2"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 0.01, {"glemr4_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_3"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 0.01, {"glemr4_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_4"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 0.01, {"glemr4_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 0.01, {"glemr4_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_juncus_white"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 0.01, {"glemr4_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:fern_lady_small"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 0.01, {"glemr4_warm_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_palmetto_saw"}, nil, nil, nil)

    -- glemr4_warm_humid_shelf
    -- trees
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.005, {"glemr4_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_cypress_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.005, {"glemr4_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_cypress_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.005, {"glemr4_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_normal_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.005, {"glemr4_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_normal_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.005, {"glemr4_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_mature_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.005, {"glemr4_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_mature_4")
    -- grasses
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_1"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_2"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_3"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_4"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_juncus_white"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_lady_small"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_warm_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_palmetto_saw"}, nil, nil, nil)

    -- glemr4_warm_humid_highland

    -- glemr4_warm_humid_mountain

end

local function add_decorations_warm_semihumid()

    -- glemr4_warm_semihumid_ocean

    -- glemr4_warm_semihumid_beach

    -- glemr4_warm_semihumid_coastal
    -- trees
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_warm_semihumid_coastal"}, 8, HEIGHT_COASTAL, "unilib_glem_tree_eucalyptus_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_warm_semihumid_coastal"}, 8, HEIGHT_COASTAL, "unilib_glem_tree_eucalyptus_large_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_warm_semihumid_coastal"}, 6, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_normal_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_warm_semihumid_coastal"}, 6, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_normal_3")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_warm_semihumid_coastal"}, 6, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_mature_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 80, 0.002, {"glemr4_warm_semihumid_coastal"}, 6, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_mature_3")
    -- grasses
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 0.01, {"glemr4_warm_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 0.01, {"glemr4_warm_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_swamp_1"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 0.01, {"glemr4_warm_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_swamp_2"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 0.01, {"glemr4_warm_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_swamp_3"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 0.01, {"glemr4_warm_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_swamp_4"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 0.01, {"glemr4_warm_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_swamp_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 0.01, {"glemr4_warm_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:plant_juncus_white"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_brown_3"}, 0.01, {"glemr4_warm_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:plant_palmetto_saw"}, nil, nil, nil)

    -- glemr4_warm_semihumid_lowland
    -- trees
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.006, {"glemr4_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_eucalyptus_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.006, {"glemr4_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_eucalyptus_large_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.006, {"glemr4_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_normal_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.006, {"glemr4_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_normal_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.006, {"glemr4_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_mature_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.006, {"glemr4_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_mature_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.001, {"glemr4_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_rubber_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 80, 0.001, {"glemr4_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_rubber_3")
    -- grasses
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_1"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_2"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_3"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_4"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_juncus_white"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_shrub_banana_large"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_brown_2"}, 0.01, {"glemr4_warm_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_palmetto_saw"}, nil, nil, nil)

    -- glemr4_warm_semihumid_shelf
    -- trees
    add_schem({"unilib:dirt_coarse_with_turf_brown"}, 80, 0.004, {"glemr4_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_eucalyptus_1")
    add_schem({"unilib:dirt_coarse_with_turf_brown"}, 80, 0.004, {"glemr4_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_eucalyptus_large_1")
    add_schem({"unilib:dirt_coarse_with_turf_brown"}, 80, 0.004, {"glemr4_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_normal_2")
    add_schem({"unilib:dirt_coarse_with_turf_brown"}, 80, 0.004, {"glemr4_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_normal_3")
    add_schem({"unilib:dirt_coarse_with_turf_brown"}, 80, 0.004, {"glemr4_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_mature_1")
    add_schem({"unilib:dirt_coarse_with_turf_brown"}, 80, 0.004, {"glemr4_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_mature_3")
    add_schem({"unilib:dirt_coarse_with_turf_brown"}, 80, 0.001, {"glemr4_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_rubber_2")
    add_schem({"unilib:dirt_coarse_with_turf_brown"}, 80, 0.001, {"glemr4_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_rubber_4")
    -- grasses
    add_node({"unilib:dirt_coarse_with_turf_brown"}, 0.01, {"glemr4_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_brown"}, 0.01, {"glemr4_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_1"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_brown"}, 0.01, {"glemr4_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_2"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_brown"}, 0.01, {"glemr4_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_3"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_brown"}, 0.01, {"glemr4_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_4"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_brown"}, 0.01, {"glemr4_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_coarse_with_turf_brown"}, 0.01, {"glemr4_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_juncus_white"}, nil, nil, nil)
    -- N.B. Duplicate line in original code; replaced with brown juncus
--  add_node({"unilib:dirt_coarse_with_turf_brown"}, 0.01, {"glemr4_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_juncus_white"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_brown"}, 0.01, {"glemr4_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_juncus_brown"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_brown"}, 0.01, {"glemr4_warm_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_palmetto_saw"}, nil, nil, nil)

    -- glemr4_warm_semihumid_highland
    -- trees
    add_schem({"unilib:dirt_parched_with_turf_exotic_brown_1"}, 80, 0.004, {"glemr4_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_eucalyptus_1")
    add_schem({"unilib:dirt_parched_with_turf_exotic_brown_1"}, 80, 0.004, {"glemr4_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_eucalyptus_large_1")
    add_schem({"unilib:dirt_parched_with_turf_exotic_brown_1"}, 80, 0.004, {"glemr4_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_deciduous_normal_2")
    add_schem({"unilib:dirt_parched_with_turf_exotic_brown_1"}, 80, 0.004, {"glemr4_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_deciduous_normal_3")
    add_schem({"unilib:dirt_parched_with_turf_exotic_brown_1"}, 80, 0.004, {"glemr4_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_deciduous_mature_1")
    add_schem({"unilib:dirt_parched_with_turf_exotic_brown_1"}, 80, 0.004, {"glemr4_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_deciduous_mature_3")
    -- grasses
    add_node({"unilib:dirt_parched_with_turf_exotic_brown_1"}, 0.01, {"glemr4_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_parched_with_turf_exotic_brown_1"}, 0.01, {"glemr4_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_swamp_1"}, nil, nil, nil)
    add_node({"unilib:dirt_parched_with_turf_exotic_brown_1"}, 0.01, {"glemr4_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_swamp_2"}, nil, nil, nil)
    add_node({"unilib:dirt_parched_with_turf_exotic_brown_1"}, 0.01, {"glemr4_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_swamp_3"}, nil, nil, nil)
    add_node({"unilib:dirt_parched_with_turf_exotic_brown_1"}, 0.01, {"glemr4_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_swamp_4"}, nil, nil, nil)
    add_node({"unilib:dirt_parched_with_turf_exotic_brown_1"}, 0.01, {"glemr4_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_swamp_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_parched_with_turf_exotic_brown_1"}, 0.01, {"glemr4_warm_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_juncus_white"}, nil, nil, nil)

    -- glemr4_warm_semihumid_mountain

end

local function add_decorations_warm_temperate()

    -- glemr4_warm_temperate_ocean

    -- glemr4_warm_temperate_beach
    -- trees
    add_schem({"unilib:sand_ordinary"}, 80, 0.002, {"glemr4_warm_temperate_beach"}, 1, 2, "unilib_glem_tree_palm_1")
    add_schem({"unilib:sand_ordinary"}, 80, 0.002, {"glemr4_warm_temperate_beach"}, 1, 2, "unilib_glem_tree_palm_2")
    add_schem({"unilib:sand_ordinary"}, 80, 0.002, {"glemr4_warm_temperate_beach"}, 1, 2, "unilib_glem_tree_palm_3")

    -- glemr4_warm_temperate_coastal
    -- trees
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.006, {"glemr4_warm_temperate_coastal"}, 6, HEIGHT_COASTAL, "unilib_glem_tree_apple_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.002, {"glemr4_warm_temperate_coastal"}, 6, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_normal_tall_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.002, {"glemr4_warm_temperate_coastal"}, 8, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_mature_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.002, {"glemr4_warm_temperate_coastal"}, 8, HEIGHT_COASTAL, "unilib_glem_tree_deciduous_mature_3")
    -- grasses
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.09, {"glemr4_warm_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.08, {"glemr4_warm_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_swamp_1"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.08, {"glemr4_warm_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_swamp_2"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.08, {"glemr4_warm_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_swamp_3"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.08, {"glemr4_warm_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_swamp_4"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.08, {"glemr4_warm_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_swamp_5"}, nil, nil, nil)

    -- glemr4_warm_temperate_lowland
    -- trees
    if unilib.global.pkg_executed_table["tree_apple_mature"] ~= nil then
        add_schem({"unilib:dirt_dark_with_turf_exotic_2"}, 80, 0.015, {"glemr4_warm_temperate_lowland"}, 35, 42, "unilib_glem_tree_banana_1")
    end
    add_schem({"unilib:dirt_dark_with_turf_exotic_2"}, 80, 0.015, {"glemr4_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_apple_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_2"}, 80, 0.006, {"glemr4_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_mature_5")
    add_schem({"unilib:dirt_dark_with_turf_exotic_2"}, 80, 0.006, {"glemr4_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_normal_tall_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_2"}, 80, 0.008, {"glemr4_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_mature_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_2"}, 80, 0.008, {"glemr4_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_deciduous_mature_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_2"}, 80, 0.004, {"glemr4_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_ipe_yellow_1")
    -- saplings
    -- grasses
    add_node({"unilib:dirt_dark_with_turf_exotic_2"}, 0.12, {"glemr4_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_2"}, 0.06, {"glemr4_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_1"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_2"}, 0.06, {"glemr4_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_2"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_2"}, 0.06, {"glemr4_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_3"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_2"}, 0.06, {"glemr4_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_4"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_2"}, 0.06, {"glemr4_warm_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_swamp_5"}, nil, nil, nil)

    -- glemr4_warm_temperate_shelf
    -- trees
    add_schem({"unilib:dirt_coarse_with_turf_exotic_3"}, 80, 0.009, {"glemr4_warm_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_apple_1")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_3"}, 80, 0.003, {"glemr4_warm_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_normal_tall_1")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_3"}, 80, 0.012, {"glemr4_warm_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_mature_1")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_3"}, 80, 0.012, {"glemr4_warm_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_deciduous_mature_3")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_3"}, 80, 0.002, {"glemr4_warm_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_ipe_yellow_1")
    -- saplings
    -- grasses
    add_node({"unilib:dirt_coarse_with_turf_exotic_3"}, 0.08, {"glemr4_warm_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_3"}, 0.04, {"glemr4_warm_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_1"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_3"}, 0.04, {"glemr4_warm_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_2"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_3"}, 0.04, {"glemr4_warm_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_3"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_3"}, 0.04, {"glemr4_warm_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_4"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_3"}, 0.04, {"glemr4_warm_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_swamp_5"}, nil, nil, nil)

    -- glemr4_warm_temperate_highland
    add_schem({"unilib:clay_red_with_turf_exotic_3"}, 80, 0.004, {"glemr4_warm_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_apple_1")
    add_schem({"unilib:clay_red_with_turf_exotic_3"}, 80, 0.005, {"glemr4_warm_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_deciduous_normal_tall_1")
    add_schem({"unilib:clay_red_with_turf_exotic_3"}, 80, 0.022, {"glemr4_warm_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_deciduous_mature_1")
    add_schem({"unilib:clay_red_with_turf_exotic_3"}, 80, 0.022, {"glemr4_warm_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_deciduous_mature_3")
    -- saplings
    -- grasses
    add_node({"unilib:clay_red_with_turf_exotic_3"}, 0.04, {"glemr4_warm_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_tall"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_3"}, 0.02, {"glemr4_warm_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_3"}, 0.02, {"glemr4_warm_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_3"}, 0.02, {"glemr4_warm_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_3"}, 0.02, {"glemr4_warm_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_3"}, 0.02, {"glemr4_warm_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)

    -- glemr4_warm_temperate_mountain

end

local function add_decorations_warm_semiarid()

    -- glemr4_warm_semiarid_ocean

    -- glemr4_warm_semiarid_beach

    -- glemr4_warm_semiarid_coastal
    -- trees
    add_schem({"unilib:stone_sandstone_white"}, 80, 0.001, {"glemr4_warm_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_acacia_2")
    add_schem({"unilib:stone_sandstone_white"}, 80, 0.001, {"glemr4_warm_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_acacia_1")
    add_schem({"unilib:stone_sandstone_white"}, 80, 0.001, {"glemr4_warm_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_acacia_3")
    add_schem({"unilib:stone_sandstone_white"}, 80, 0.001, {"glemr4_warm_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_acacia_log", "place_center_x, place_center_z")
    -- grasses
    add_node({"unilib:stone_sandstone_white"}, 0.01, {"glemr4_warm_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:stone_sandstone_white"}, 0.01, {"glemr4_warm_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:stone_sandstone_white"}, 0.01, {"glemr4_warm_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:stone_sandstone_white"}, 0.01, {"glemr4_warm_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:stone_sandstone_white"}, 0.01, {"glemr4_warm_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_5"}, nil, nil, nil)

    -- glemr4_warm_semiarid_lowland
    -- trees
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_4"}, 80, 0.005, {"glemr4_warm_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_acacia_2")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_4"}, 80, 0.005, {"glemr4_warm_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_acacia_1")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_4"}, 80, 0.005, {"glemr4_warm_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_acacia_3")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_4"}, 80, 0.005, {"glemr4_warm_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_acacia_log", "place_center_x, place_center_z")
    -- grasses
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_4"}, 0.01, {"glemr4_warm_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_4"}, 0.01, {"glemr4_warm_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_4"}, 0.01, {"glemr4_warm_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_4"}, 0.01, {"glemr4_warm_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_4"}, 0.01, {"glemr4_warm_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)

    -- glemr4_warm_semiarid_shelf
    -- trees
    add_schem({"unilib:clay_red_with_turf_exotic_dry_5"}, 80, 0.002, {"glemr4_warm_semiarid_shelf"},HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_acacia_1")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_5"}, 80, 0.002, {"glemr4_warm_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_acacia_2")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_5"}, 80, 0.002, {"glemr4_warm_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_acacia_3")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_5"}, 80, 0.002, {"glemr4_warm_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_acacia_log", "place_center_x, place_center_z")
    -- grasses
    add_node({"unilib:clay_red_with_turf_exotic_dry_5"}, 0.01, {"glemr4_warm_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_dry_5"}, 0.01, {"glemr4_warm_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_dry_5"}, 0.01, {"glemr4_warm_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_dry_5"}, 0.01, {"glemr4_warm_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_dry_5"}, 0.01, {"glemr4_warm_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr4_warm_semiarid_highland
    -- trees
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_5"}, 80, 0.001, {"glemr4_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_acacia_1")
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_5"}, 80, 0.001, {"glemr4_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_acacia_2")
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_5"}, 80, 0.001, {"glemr4_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_acacia_3")
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_5"}, 80, 0.001, {"glemr4_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_acacia_log", "place_center_x, place_center_z")
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_5"}, 80, 0.001, {"glemr4_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_baobab_1")
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_5"}, 80, 0.001, {"glemr4_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_baobab_2")
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_5"}, 80, 0.001, {"glemr4_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_baobab_3")
    -- grasses
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_5"}, 0.01, {"glemr4_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_5"}, 0.01, {"glemr4_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_5"}, 0.01, {"glemr4_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_5"}, 0.01, {"glemr4_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_5"}, 0.01, {"glemr4_warm_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr4_warm_semiarid_mountain

end

local function add_decorations_warm_arid()

    -- glemr4_warm_arid_ocean

    -- glemr4_warm_arid_beach

    -- glemr4_warm_arid_coastal

    -- glemr4_warm_arid_lowland

    -- glemr4_warm_arid_shelf

    -- glemr4_warm_arid_highland

    -- glemr4_warm_arid_mountain

end

---------------------------------------------------------------------------------------------------
-- Temperate biomes
---------------------------------------------------------------------------------------------------

local function add_decorations_temperate_humid()

    -- glemr4_temperate_humid_ocean

    -- glemr4_temperate_humid_beach

    -- glemr4_temperate_humid_coastal
    -- trees
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_beech_mature_1")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_beech_mature_2")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_beech_mature_3")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_oak_1")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_oak_2")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_oak_3")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_poplar_1")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_poplar_2")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_poplar_3")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_willow_large_1")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_willow_large_2")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_willow_large_3")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_willow_ancient_1")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_willow_ancient_2")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_willow_ancient_3")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_willow_weeping_1")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_willow_weeping_2")
    add_schem({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_willow_weeping_3")
    -- grasses
    add_node({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_5"}, nil, nil, nil)
    --ferns
    add_node({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:fern_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:fern_ordinary_3"}, nil, nil, nil)

    -- glemr4_temperate_humid_lowland
    -- trees
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_beech_mature_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_beech_mature_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_beech_mature_3")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_oak_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_oak_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_oak_3")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_poplar_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_poplar_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_poplar_3")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_willow_large_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_willow_large_3")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_willow_ancient_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_willow_ancient_3")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_willow_weeping_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_willow_weeping_2")
    -- grasses
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)
    --ferns
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:fern_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:fern_ordinary_3"}, nil, nil, nil)

    -- glemr4_temperate_humid_shelf
    -- trees
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_beech_mature_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_beech_mature_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_oak_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_oak_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_oak_4")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_oak_5")
    -- grasses
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_5"}, nil, nil, nil)
    --ferns
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_ordinary_3"}, nil, nil, nil)

    -- glemr4_temperate_humid_highland
    -- trees
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.02, {"glemr4_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_ancient_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.02, {"glemr4_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.02, {"glemr4_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_exposed_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.01, {"glemr4_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_sequoia_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.01, {"glemr4_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_sequoia_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.01, {"glemr4_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_sequoia_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_sequoia_giant_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_sequoia_giant_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_sequoia_giant_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_sequoia_giant_4")
    -- saplings
    -- grasses
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)
    --ferns
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:fern_lady_small"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:fern_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:fern_ordinary_3"}, nil, nil, nil)

    -- glemr4_temperate_humid_mountain

end

local function add_decorations_temperate_semihumid()

    -- glemr4_temperate_semihumid_ocean

    -- glemr4_temperate_semihumid_beach

    -- glemr4_temperate_semihumid_coastal
    -- trees
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_beech_mature_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_beech_mature_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_beech_mature_3")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_chestnut_exotic_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_chestnut_exotic_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_oak_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_oak_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_oak_3")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_pine_ancient_1")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_pine_2")
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.001, {"glemr4_temperate_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_pine_exposed_3")
    -- saplings
    -- grasses
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_5"}, nil, nil, nil)
    -- plants
    add_schem({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 80, 0.01, {"glemr4_temperate_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_bush_ordinary")
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_turf_exotic_1"}, 0.01, {"glemr4_temperate_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:plant_shrub_forest_deciduous"}, nil, nil, nil)

    -- glemr4_temperate_semihumid_lowland
    -- trees
    add_schem({"unilib:dirt_dark_with_turf_exotic_2"}, 80, 0.001, {"glemr4_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_beech_mature_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_2"}, 80, 0.001, {"glemr4_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_beech_mature_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_2"}, 80, 0.001, {"glemr4_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_beech_mature_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_2"}, 80, 0.001, {"glemr4_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_chestnut_exotic_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_2"}, 80, 0.001, {"glemr4_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_chestnut_exotic_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_2"}, 80, 0.001, {"glemr4_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_oak_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_2"}, 80, 0.001, {"glemr4_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_oak_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_2"}, 80, 0.001, {"glemr4_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_oak_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_2"}, 80, 0.001, {"glemr4_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_pine_ancient_5")
    -- saplings
    -- grasses
    add_node({"unilib:dirt_dark_with_turf_exotic_2"}, 0.01, {"glemr4_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_2"}, 0.01, {"glemr4_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_2"}, 0.01, {"glemr4_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_2"}, 0.01, {"glemr4_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_2"}, 0.01, {"glemr4_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)
    -- plants
    add_schem({"unilib:dirt_dark_with_turf_exotic_2"}, 80, 0.01, {"glemr4_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_bush_ordinary")
    add_node({"unilib:dirt_dark_with_turf_exotic_2"}, 0.01, {"glemr4_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_2"}, 0.01, {"glemr4_temperate_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_shrub_forest_deciduous"}, nil, nil, nil)

    -- glemr4_temperate_semihumid_shelf
    -- trees
    add_schem({"unilib:dirt_ordinary_with_turf_exotic_2"}, 80, 0.001, {"glemr4_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_beech_mature_1")
    add_schem({"unilib:dirt_ordinary_with_turf_exotic_2"}, 80, 0.001, {"glemr4_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_beech_mature_2")
    add_schem({"unilib:dirt_ordinary_with_turf_exotic_2"}, 80, 0.001, {"glemr4_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_beech_mature_3")
    add_schem({"unilib:dirt_ordinary_with_turf_exotic_2"}, 80, 0.001, {"glemr4_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_chestnut_exotic_1")
    add_schem({"unilib:dirt_ordinary_with_turf_exotic_2"}, 80, 0.001, {"glemr4_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_chestnut_exotic_2")
    add_schem({"unilib:dirt_ordinary_with_turf_exotic_2"}, 80, 0.001, {"glemr4_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_oak_1")
    add_schem({"unilib:dirt_ordinary_with_turf_exotic_2"}, 80, 0.001, {"glemr4_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_oak_2")
    add_schem({"unilib:dirt_ordinary_with_turf_exotic_2"}, 80, 0.001, {"glemr4_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_oak_3")
    add_schem({"unilib:dirt_ordinary_with_turf_exotic_2"}, 80, 0.001, {"glemr4_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_pine_ancient_5")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_exotic_2"}, 0.01, {"glemr4_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_exotic_2"}, 0.01, {"glemr4_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_exotic_2"}, 0.01, {"glemr4_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_exotic_2"}, 0.01, {"glemr4_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_exotic_2"}, 0.01, {"glemr4_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_5"}, nil, nil, nil)
    -- plants
    add_schem({"unilib:dirt_ordinary_with_turf_exotic_2"}, 80, 0.01, {"glemr4_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_bush_ordinary")
    add_node({"unilib:dirt_ordinary_with_turf_exotic_2"}, 0.01, {"glemr4_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_exotic_2"}, 0.01, {"glemr4_temperate_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_shrub_forest_deciduous"}, nil, nil, nil)

    -- glemr4_temperate_semihumid_highland
    add_schem({"unilib:clay_red_with_turf_exotic_3"}, 80, 0.001, {"glemr4_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_oak_1")
    add_schem({"unilib:clay_red_with_turf_exotic_3"}, 80, 0.001, {"glemr4_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_oak_2")
    add_schem({"unilib:clay_red_with_turf_exotic_3"}, 80, 0.001, {"glemr4_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_oak_3")
    add_schem({"unilib:clay_red_with_turf_exotic_3"}, 80, 0.001, {"glemr4_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_ancient_5")
    -- grasses
    add_node({"unilib:clay_red_with_turf_exotic_3"}, 0.01, {"glemr4_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_3"}, 0.01, {"glemr4_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_3"}, 0.01, {"glemr4_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_3"}, 0.01, {"glemr4_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_3"}, 0.01, {"glemr4_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)
    -- plants
    add_schem({"unilib:clay_red_with_turf_exotic_3"}, 80, 0.01, {"glemr4_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_bush_ordinary")
    add_node({"unilib:clay_red_with_turf_exotic_3"}, 0.01, {"glemr4_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_3"}, 0.01, {"glemr4_temperate_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_shrub_forest_deciduous"}, nil, nil, nil)

    -- glemr4_temperate_semihumid_mountain

end

local function add_decorations_temperate_temperate()

    -- glemr4_temperate_temperate_ocean

    -- glemr4_temperate_temperate_beach

    -- glemr4_temperate_temperate_coastal
    -- trees
    add_schem({"unilib:dirt_dark_with_turf_exotic_dry_1"}, 80, 0.006, {"glemr4_temperate_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_beech_mature_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_dry_1"}, 80, 0.006, {"glemr4_temperate_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_beech_mature_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_dry_1"}, 80, 0.006, {"glemr4_temperate_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_beech_mature_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_dry_1"}, 80, 0.004, {"glemr4_temperate_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_oak_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_dry_1"}, 80, 0.004, {"glemr4_temperate_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_oak_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_dry_1"}, 80, 0.004, {"glemr4_temperate_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_oak_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_dry_1"}, 80, 0.002, {"glemr4_temperate_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_pine_ancient_5")
    -- grasses
    add_node({"unilib:dirt_dark_with_turf_exotic_dry_1"}, 0.01, {"glemr4_temperate_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_dry_1"}, 0.01, {"glemr4_temperate_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_dry_1"}, 0.04, {"glemr4_temperate_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_dry_1"}, 0.04, {"glemr4_temperate_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_dry_1"}, 0.04, {"glemr4_temperate_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_5"}, nil, nil, nil)
    -- plants
    add_schem({"unilib:dirt_dark_with_turf_exotic_dry_1"}, 80, 0.01, {"glemr4_temperate_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_bush_ordinary")
    add_node({"unilib:dirt_dark_with_turf_exotic_dry_1"}, 0.01, {"glemr4_temperate_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_dry_1"}, 0.01, {"glemr4_temperate_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:plant_shrub_forest_deciduous"}, nil, nil, nil)

    -- glemr4_temperate_temperate_lowland
    -- trees
    add_schem({"unilib:dirt_dark_with_turf_exotic_dry_2"}, 80, 0.005, {"glemr4_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_ash_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_dry_2"}, 80, 0.008, {"glemr4_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_beech_mature_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_dry_2"}, 80, 0.006, {"glemr4_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_beech_mature_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_dry_2"}, 80, 0.007, {"glemr4_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_beech_mature_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_dry_2"}, 80, 0.005, {"glemr4_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_oak_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_dry_2"}, 80, 0.005, {"glemr4_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_oak_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_dry_2"}, 80, 0.005, {"glemr4_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_oak_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_dry_2"}, 80, 0.002, {"glemr4_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_pine_ancient_5")
    -- grasses
    add_node({"unilib:dirt_dark_with_turf_exotic_dry_2"}, 0.03, {"glemr4_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_dry_2"}, 0.03, {"glemr4_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_dry_2"}, 0.03, {"glemr4_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_dry_2"}, 0.03, {"glemr4_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_dry_2"}, 0.03, {"glemr4_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)
    -- plants
    add_schem({"unilib:dirt_dark_with_turf_exotic_dry_2"}, 80, 0.03, {"glemr4_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_bush_ordinary")
    add_node({"unilib:dirt_dark_with_turf_exotic_dry_2"}, 0.03, {"glemr4_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_dry_2"}, 0.03, {"glemr4_temperate_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_shrub_forest_deciduous"}, nil, nil, nil)

    -- glemr4_temperate_temperate_shelf
    -- trees
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 80, 0.001, {"glemr4_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_ash_1")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 80, 0.001, {"glemr4_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_beech_mature_1")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 80, 0.001, {"glemr4_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_beech_mature_2")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 80, 0.001, {"glemr4_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_beech_mature_3")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 80, 0.001, {"glemr4_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_oak_1")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 80, 0.001, {"glemr4_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_oak_2")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 80, 0.001, {"glemr4_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_oak_3")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 80, 0.001, {"glemr4_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_pine_ancient_5")
    -- grasses
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 0.02, {"glemr4_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 0.02, {"glemr4_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 0.02, {"glemr4_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 0.02, {"glemr4_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 0.02, {"glemr4_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_ordinary_5"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 0.02, {"glemr4_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_tall"}, nil, nil, nil)
    -- plants
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 80, 0.01, {"glemr4_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_bush_ordinary")
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 0.02, {"glemr4_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 0.02, {"glemr4_temperate_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_shrub_forest_deciduous"}, nil, nil, nil)

    -- glemr4_temperate_temperate_highland
    -- trees
    add_schem({"unilib:clay_red_with_turf_exotic_dry_3"}, 80, 0.001, {"glemr4_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_cedar_1")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_3"}, 80, 0.001, {"glemr4_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_cherry_blossom_1")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_3"}, 80, 0.001, {"glemr4_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_cherry_blossom_2")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_3"}, 80, 0.001, {"glemr4_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_cherry_blossom_3")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_3"}, 80, 0.001, {"glemr4_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_exposed_1")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_3"}, 80, 0.001, {"glemr4_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_exposed_2")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_3"}, 80, 0.001, {"glemr4_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_exposed_8")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_3"}, 80, 0.001, {"glemr4_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_exposed_9")
    -- grasses
    add_node({"unilib:clay_red_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)
    -- plants
    add_schem({"unilib:clay_red_with_turf_exotic_dry_3"}, 80, 0.01, {"glemr4_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_bush_ordinary")
    add_node({"unilib:clay_red_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_shrub_forest_deciduous"}, nil, nil, nil)

    -- glemr4_temperate_temperate_mountain

end

local function add_decorations_temperate_semiarid()

    -- glemr4_temperate_semiarid_ocean

    -- glemr4_temperate_semiarid_beach

    -- glemr4_temperate_semiarid_coastal
    -- trees
    add_schem({"unilib:dirt_ordinary_with_turf_exotic_dry_2"}, 80, 0.001, {"glemr4_temperate_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_cedar_1")
    add_schem({"unilib:dirt_ordinary_with_turf_exotic_dry_2"}, 80, 0.001, {"glemr4_temperate_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_pine_5")
    add_schem({"unilib:dirt_ordinary_with_turf_exotic_dry_2"}, 80, 0.001, {"glemr4_temperate_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_pine_6")
    add_schem({"unilib:dirt_ordinary_with_turf_exotic_dry_2"}, 80, 0.001, {"glemr4_temperate_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_pine_exposed_1")
    add_schem({"unilib:dirt_ordinary_with_turf_exotic_dry_2"}, 80, 0.001, {"glemr4_temperate_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_pine_exposed_2")
    add_schem({"unilib:dirt_ordinary_with_turf_exotic_dry_2"}, 80, 0.001, {"glemr4_temperate_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_pine_exposed_3")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_turf_exotic_dry_2"}, 0.01, {"glemr4_temperate_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_exotic_dry_2"}, 0.01, {"glemr4_temperate_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_exotic_dry_2"}, 0.01, {"glemr4_temperate_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_exotic_dry_2"}, 0.01, {"glemr4_temperate_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_exotic_dry_2"}, 0.01, {"glemr4_temperate_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_ordinary_with_turf_exotic_dry_2"}, 0.01, {"glemr4_temperate_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:plant_cactus_purple_small"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_exotic_dry_2"}, 0.01, {"glemr4_temperate_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:plant_cactus_small"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_exotic_dry_2"}, 0.01, {"glemr4_temperate_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:plant_cactus_small_flowering"}, nil, nil, nil)

    -- glemr4_temperate_semiarid_lowland
    -- trees
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 80, 0.001, {"glemr4_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_cedar_1")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 80, 0.001, {"glemr4_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_pine_5")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 80, 0.001, {"glemr4_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_pine_6")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 80, 0.001, {"glemr4_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_pine_exposed_1")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 80, 0.001, {"glemr4_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_pine_exposed_2")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 80, 0.001, {"glemr4_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_pine_exposed_3")
    -- grasses
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 0.001, {"glemr4_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_1"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 0.001, {"glemr4_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_2"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 0.001, {"glemr4_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_3"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 0.001, {"glemr4_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_4"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 0.001, {"glemr4_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_ordinary_5"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 0.01, {"glemr4_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 0.01, {"glemr4_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 0.01, {"glemr4_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 0.01, {"glemr4_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 0.01, {"glemr4_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 0.001, {"glemr4_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_cactus_purple_small"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 0.001, {"glemr4_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_cactus_small"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 0.001, {"glemr4_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_cactus_small_flowering"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_2"}, 0.001, {"glemr4_temperate_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:tree_young_palm_desert"}, nil, nil, nil)

    -- glemr4_temperate_semiarid_shelf
    -- trees
    add_schem({"unilib:clay_red_with_turf_exotic_dry_3"}, 80, 0.001, {"glemr4_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_cedar_1")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_3"}, 80, 0.001, {"glemr4_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_pine_5")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_3"}, 80, 0.001, {"glemr4_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_pine_6")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_3"}, 80, 0.001, {"glemr4_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_pine_exposed_1")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_3"}, 80, 0.001, {"glemr4_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_pine_exposed_2")
    add_schem({"unilib:clay_red_with_turf_exotic_dry_3"}, 80, 0.001, {"glemr4_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_pine_exposed_3")
    -- grasses
    add_node({"unilib:clay_red_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:clay_red_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_cactus_thorny"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_cactus_purple_small"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_cactus_small"}, nil, nil, nil)
    add_node({"unilib:clay_red_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_cactus_small_flowering"}, nil, nil, nil)

    -- glemr4_temperate_semiarid_highland
    -- trees
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_3"}, 80, 0.001, {"glemr4_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_cedar_1")
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_3"}, 80, 0.001, {"glemr4_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_5")
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_3"}, 80, 0.001, {"glemr4_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_6")
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_3"}, 80, 0.001, {"glemr4_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_exposed_1")
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_3"}, 80, 0.001, {"glemr4_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_exposed_2")
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_3"}, 80, 0.001, {"glemr4_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_exposed_3")
    -- grasses
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_5"}, nil, nil, nil)
    -- plants
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_cactus_thorny"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_3"}, 0.01, {"glemr4_temperate_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_cactus_small"}, nil, nil, nil)

    -- glemr4_temperate_semiarid_mountain

end

local function add_decorations_temperate_arid()

    -- glemr4_temperate_arid_ocean

    -- glemr4_temperate_arid_beach

    -- glemr4_temperate_arid_coastal

    -- glemr4_temperate_arid_lowland

    -- glemr4_temperate_arid_shelf

    -- glemr4_temperate_arid_highland

    -- glemr4_temperate_arid_mountain

end

---------------------------------------------------------------------------------------------------
-- Cool biomes
---------------------------------------------------------------------------------------------------

local function add_decorations_cool_humid()

    -- glemr4_cool_humid_ocean

    -- glemr4_cool_humid_beach

    -- glemr4_cool_humid_coastal
    -- trees
    add_schem({"unilib:dirt_silt_coarse_with_litter_coniferous"}, 80, 0.005, {"glemr4_cool_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_silt_coarse_with_litter_coniferous"}, 80, 0.005, {"glemr4_cool_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_fir_douglas_coast_2")
    add_schem({"unilib:dirt_silt_coarse_with_litter_coniferous"}, 80, 0.005, {"glemr4_cool_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_fir_douglas_coast_3")
    add_schem({"unilib:dirt_silt_coarse_with_litter_coniferous"}, 80, 0.005, {"glemr4_cool_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_fir_douglas_coast_14")
    add_schem({"unilib:dirt_silt_coarse_with_litter_coniferous"}, 80, 0.005, {"glemr4_cool_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_fir_douglas_coast_15")
    add_schem({"unilib:dirt_silt_coarse_with_litter_coniferous"}, 80, 0.005, {"glemr4_cool_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_fir_douglas_coast_16")
    -- plants
    add_node({"unilib:dirt_silt_coarse_with_litter_coniferous"}, 0.01, {"glemr4_cool_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:fern_broad_leaf"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_litter_coniferous"}, 0.01, {"glemr4_cool_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:fern_lady"}, nil, nil, nil)
    -- N.B. Duplicate line in original code
--  add_node({"unilib:dirt_silt_coarse_with_litter_coniferous"}, 0.01, {"glemr4_cool_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:fern_broad_leaf"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_litter_coniferous"}, 0.01, {"glemr4_cool_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)

    -- glemr4_cool_humid_lowland
    -- trees
    add_schem({"unilib:dirt_silt_fine_with_litter_coniferous"}, 80, 0.004, {"glemr4_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_silt_fine_with_litter_coniferous"}, 80, 0.004, {"glemr4_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fir_douglas_coast_2")
    add_schem({"unilib:dirt_silt_fine_with_litter_coniferous"}, 80, 0.004, {"glemr4_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fir_douglas_coast_3")
    add_schem({"unilib:dirt_silt_fine_with_litter_coniferous"}, 80, 0.004, {"glemr4_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fir_douglas_coast_14")
    add_schem({"unilib:dirt_silt_fine_with_litter_coniferous"}, 80, 0.004, {"glemr4_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fir_douglas_coast_15")
    add_schem({"unilib:dirt_silt_fine_with_litter_coniferous"}, 80, 0.004, {"glemr4_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fir_douglas_coast_16")
    -- plants
    add_node({"unilib:dirt_silt_fine_with_litter_coniferous"}, 0.01, {"glemr4_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:fern_broad_leaf"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_litter_coniferous"}, 0.01, {"glemr4_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:fern_lady"}, nil, nil, nil)
    -- N.B. Duplicate line in original code
--  add_node({"unilib:dirt_silt_fine_with_litter_coniferous"}, 0.01, {"glemr4_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:fern_broad_leaf"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_litter_coniferous"}, 0.01, {"glemr4_cool_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)

    -- glemr4_cool_humid_shelf
    -- trees
    add_schem({"unilib:dirt_dark_with_litter_coniferous"}, 80, 0.007, {"glemr4_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_dark_with_litter_coniferous"}, 80, 0.006, {"glemr4_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_douglas_coast_2")
    add_schem({"unilib:dirt_dark_with_litter_coniferous"}, 80, 0.006, {"glemr4_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_douglas_coast_3")
    add_schem({"unilib:dirt_dark_with_litter_coniferous"}, 80, 0.005, {"glemr4_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_douglas_coast_14")
    add_schem({"unilib:dirt_dark_with_litter_coniferous"}, 80, 0.005, {"glemr4_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_douglas_coast_15")
    add_schem({"unilib:dirt_dark_with_litter_coniferous"}, 80, 0.005, {"glemr4_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_douglas_coast_16")
    -- plants
    add_node({"unilib:dirt_dark_with_litter_coniferous"}, 0.01, {"glemr4_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_broad_leaf"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_litter_coniferous"}, 0.01, {"glemr4_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_lady"}, nil, nil, nil)
    -- N.B. Duplicate line in original code
--  add_node({"unilib:dirt_dark_with_litter_coniferous"}, 0.01, {"glemr4_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:fern_broad_leaf"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_litter_coniferous"}, 0.01, {"glemr4_cool_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)

    -- glemr4_cool_humid_highland
    -- trees
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.01, {"glemr4_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.008, {"glemr4_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_douglas_coast_2")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.008, {"glemr4_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_douglas_coast_3")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.006, {"glemr4_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_douglas_coast_14")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.006, {"glemr4_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_douglas_coast_15")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.006, {"glemr4_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_douglas_coast_16")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.001, {"glemr4_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_redwood_1")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.001, {"glemr4_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_redwood_2")
    add_schem({"unilib:dirt_ordinary_with_litter_coniferous"}, 80, 0.001, {"glemr4_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_redwood_3")
    -- plants
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr4_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:fern_broad_leaf"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr4_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:fern_lady"}, nil, nil, nil)
    -- N.B. Duplicate line in original code
--  add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr4_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:fern_broad_leaf"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_litter_coniferous"}, 0.01, {"glemr4_cool_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:plant_shrub_hog_peanut"}, nil, nil, nil)

    -- glemr4_cool_humid_mountain

end

local function add_decorations_cool_semihumid()

    -- glemr4_cool_semihumid_ocean

    -- glemr4_cool_semihumid_beach

    -- glemr4_cool_semihumid_coastal
    -- trees
    add_schem({"unilib:dirt_silt_fine_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_birch_1")
    add_schem({"unilib:dirt_silt_fine_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_birch_small_1")
    add_schem({"unilib:dirt_silt_fine_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_birch_small_2")
    add_schem({"unilib:dirt_silt_fine_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_birch_small_3")
    add_schem({"unilib:dirt_silt_fine_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_birch_large_1")
    add_schem({"unilib:dirt_silt_fine_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_birch_large_2")
    add_schem({"unilib:dirt_silt_fine_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_birch_large_3")
    add_schem({"unilib:dirt_silt_fine_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_fir_2")
    add_schem({"unilib:dirt_silt_fine_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_fir_3")
    --grass
    add_node({"unilib:dirt_silt_fine_with_litter_coniferous"}, 0.05, {"glemr4_cool_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_2", "unilib:grass_ordinary_3", "unilib:grass_ordinary_4", "unilib:grass_ordinary_5"}, nil, nil, nil)

    -- glemr4_cool_semihumid_lowland
    -- trees
    add_schem({"unilib:dirt_dark_with_turf_exotic_5"}, 80, 0.002, {"glemr4_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_5"}, 80, 0.002, {"glemr4_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_small_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_5"}, 80, 0.002, {"glemr4_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_small_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_5"}, 80, 0.002, {"glemr4_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_small_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_5"}, 80, 0.002, {"glemr4_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_large_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_5"}, 80, 0.002, {"glemr4_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_large_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_5"}, 80, 0.002, {"glemr4_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_large_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_5"}, 80, 0.002, {"glemr4_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_maple_sugar_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_5"}, 80, 0.002, {"glemr4_cool_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_maple_sugar_large_1")

    -- glemr4_cool_semihumid_shelf
    -- trees
    add_schem({"unilib:dirt_dark_with_turf_exotic_6"}, 80, 0.002, {"glemr4_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_6"}, 80, 0.002, {"glemr4_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_small_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_6"}, 80, 0.002, {"glemr4_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_small_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_6"}, 80, 0.002, {"glemr4_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_small_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_6"}, 80, 0.002, {"glemr4_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_large_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_6"}, 80, 0.002, {"glemr4_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_large_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_6"}, 80, 0.002, {"glemr4_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_large_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_6"}, 80, 0.002, {"glemr4_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_maple_sugar_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_6"}, 80, 0.002, {"glemr4_cool_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_maple_sugar_large_1")
    -- saplings

    -- glemr4_cool_semihumid_highland
    -- trees
    add_schem({"unilib:clay_red_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_1")
    add_schem({"unilib:clay_red_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_small_1")
    add_schem({"unilib:clay_red_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_small_2")
    add_schem({"unilib:clay_red_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_small_3")
    add_schem({"unilib:clay_red_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_large_1")
    add_schem({"unilib:clay_red_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_large_2")
    add_schem({"unilib:clay_red_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_large_3")
    add_schem({"unilib:clay_red_with_litter_coniferous"}, 80, 0.005, {"glemr4_cool_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_1")
    add_schem({"unilib:clay_red_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_maple_sugar_1")
    add_schem({"unilib:clay_red_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_maple_sugar_large_1")
    -- saplings

    -- glemr4_cool_semihumid_mountain

end

local function add_decorations_cool_temperate()

    -- glemr4_cool_temperate_ocean

    -- glemr4_cool_temperate_beach

    -- glemr4_cool_temperate_coastal
    -- trees
    add_schem({"unilib:dirt_dark_with_turf_exotic_5"}, 80, 0.002, {"glemr4_cool_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_birch_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_5"}, 80, 0.002, {"glemr4_cool_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_birch_small_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_5"}, 80, 0.002, {"glemr4_cool_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_birch_small_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_5"}, 80, 0.002, {"glemr4_cool_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_birch_small_3")

    add_node({"unilib:dirt_dark_with_turf_exotic_5"}, 0.05, {"glemr4_cool_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_ordinary_2", "unilib:grass_ordinary_3", "unilib:grass_ordinary_4", "unilib:grass_ordinary_5"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_turf_exotic_5"}, 0.2, {"glemr4_cool_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:plant_arrow_arum"}, nil, nil, nil)

    -- glemr4_cool_temperate_lowland
    -- trees
    add_schem({"unilib:dirt_dark_with_turf_exotic_6"}, 80, 0.002, {"glemr4_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_6"}, 80, 0.002, {"glemr4_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_small_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_6"}, 80, 0.002, {"glemr4_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_small_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_6"}, 80, 0.002, {"glemr4_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_small_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_6"}, 80, 0.002, {"glemr4_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_large_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_6"}, 80, 0.002, {"glemr4_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_large_2")
    add_schem({"unilib:dirt_dark_with_turf_exotic_6"}, 80, 0.002, {"glemr4_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_birch_large_3")
    add_schem({"unilib:dirt_dark_with_turf_exotic_6"}, 80, 0.002, {"glemr4_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_maple_sugar_1")
    add_schem({"unilib:dirt_dark_with_turf_exotic_6"}, 80, 0.002, {"glemr4_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_maple_sugar_large_1")
    -- plants
    add_node({"unilib:dirt_dark_with_turf_exotic_6"}, 0.01, {"glemr4_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:flower_lily_calla"}, nil, nil, nil)
    add_schem({"unilib:dirt_dark_with_turf_exotic_6"}, 80, 0.2, {"glemr4_cool_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_bush_ordinary")

    -- glemr4_cool_temperate_shelf
    -- trees
    add_schem({"unilib:dirt_coarse_with_turf_exotic_7"}, 80, 0.0005, {"glemr4_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_aspen_1")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_7"}, 80, 0.0005, {"glemr4_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_aspen_2")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_7"}, 80, 0.0005, {"glemr4_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_aspen_3")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_7"}, 80, 0.0005, {"glemr4_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_aspen_4")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_7"}, 80, 0.0005, {"glemr4_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_aspen_5")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_7"}, 80, 0.0005, {"glemr4_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_aspen_6")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_7"}, 80, 0.0005, {"glemr4_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_aspen_log", "place_center_x")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_7"}, 80, 0.002, {"glemr4_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_1")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_7"}, 80, 0.002, {"glemr4_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_small_1")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_7"}, 80, 0.002, {"glemr4_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_small_2")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_7"}, 80, 0.002, {"glemr4_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_small_3")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_7"}, 80, 0.002, {"glemr4_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_large_1")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_7"}, 80, 0.002, {"glemr4_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_large_2")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_7"}, 80, 0.002, {"glemr4_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_birch_large_3")
    add_schem({"unilib:dirt_coarse_with_turf_exotic_7"}, 80, 0.005, {"glemr4_cool_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_1")

    -- glemr4_cool_temperate_highland
    -- trees
    add_schem({"unilib:clay_red_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_1")
    add_schem({"unilib:clay_red_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_small_1")
    add_schem({"unilib:clay_red_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_small_2")
    add_schem({"unilib:clay_red_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_small_3")
    add_schem({"unilib:clay_red_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_large_1")
    add_schem({"unilib:clay_red_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_large_2")
    add_schem({"unilib:clay_red_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_birch_large_3")
    add_schem({"unilib:clay_red_with_litter_coniferous"}, 80, 0.005, {"glemr4_cool_temperate_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_1")
    -- plants
    add_schem({"unilib:clay_red_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_temperate_highland"}, HEIGHT_HIGHLAND, HEIGHT_HIGHLAND, "unilib_bush_ordinary")

    -- glemr4_cool_temperate_mountain

end

local function add_decorations_cool_semiarid()

    -- glemr4_cool_semiarid_ocean

    -- glemr4_cool_semiarid_beach

    -- glemr4_cool_semiarid_coastal
    -- trees
    -- grasses
    add_node({"unilib:dirt_sandy_with_litter_coniferous"}, 0.01, {"glemr4_cool_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_sandy_with_litter_coniferous"}, 0.05, {"glemr4_cool_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_sandy_with_litter_coniferous"}, 0.1, {"glemr4_cool_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_sandy_with_litter_coniferous"}, 0.1, {"glemr4_cool_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_sandy_with_litter_coniferous"}, 0.2, {"glemr4_cool_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr4_cool_semiarid_lowland
    -- trees
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_4"}, 80, 0.002, {"glemr4_cool_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_pine_ancient_3")
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_4"}, 80, 0.002, {"glemr4_cool_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_pine_ancient_5")
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_4"}, 80, 0.002, {"glemr4_cool_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_pine_ancient_6")
    -- -- grasses
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_4"}, 0.01, {"glemr4_cool_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_4"}, 0.05, {"glemr4_cool_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_4"}, 0.05, {"glemr4_cool_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_4"}, 0.1, {"glemr4_cool_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_4"}, 0.1, {"glemr4_cool_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr4_cool_semiarid_shelf
    -- trees
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_8"}, 80, 0.002, {"glemr4_cool_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_pine_ancient_7")
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_8"}, 80, 0.002, {"glemr4_cool_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_pine_ancient_8")
    add_schem({"unilib:dirt_clayey_with_turf_exotic_dry_8"}, 80, 0.002, {"glemr4_cool_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_pine_ancient_9")
    -- grasses
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_8"}, 0.01, {"glemr4_cool_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_8"}, 0.05, {"glemr4_cool_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_8"}, 0.05, {"glemr4_cool_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_8"}, 0.05, {"glemr4_cool_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_turf_exotic_dry_8"}, 0.1, {"glemr4_cool_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr4_cool_semiarid_highland
    -- trees
    add_schem({"unilib:dirt_clayey_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_ancient_1")
    add_schem({"unilib:dirt_clayey_with_litter_coniferous"}, 80, 0.002, {"glemr4_cool_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_pine_ancient_2")
    -- grasses
    add_node({"unilib:dirt_clayey_with_litter_coniferous"}, 0.01, {"glemr4_cool_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_1"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_litter_coniferous"}, 0.01, {"glemr4_cool_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_2"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_litter_coniferous"}, 0.05, {"glemr4_cool_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_3"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_litter_coniferous"}, 0.05, {"glemr4_cool_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_4"}, nil, nil, nil)
    add_node({"unilib:dirt_clayey_with_litter_coniferous"}, 0.1, {"glemr4_cool_semiarid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr4_cool_semiarid_mountain

end

local function add_decorations_cool_arid()

    -- glemr4_cool_arid_ocean

    -- glemr4_cool_arid_beach

    -- glemr4_cool_arid_coastal

    -- glemr4_cool_arid_lowland

    -- glemr4_cool_arid_shelf

    -- glemr4_cool_arid_highland

    -- glemr4_cool_arid_mountain

end

---------------------------------------------------------------------------------------------------
-- Cold biomes
---------------------------------------------------------------------------------------------------

local function add_decorations_cold_humid()

    -- glemr4_cold_humid_ocean

    -- glemr4_cold_humid_beach

    -- glemr4_cold_humid_coastal
    -- trees
    add_schem({"unilib:dirt_silt_coarse_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_silt_coarse_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_spruce_2")
    add_schem({"unilib:dirt_silt_coarse_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_spruce_3")
    add_schem({"unilib:dirt_silt_coarse_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_spruce_4")
    add_schem({"unilib:dirt_silt_coarse_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_spruce_5")
    add_schem({"unilib:dirt_silt_coarse_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_spruce_6")
    add_schem({"unilib:dirt_silt_coarse_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_spruce_7")
    add_schem({"unilib:dirt_silt_coarse_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_fir_1")
    -- grasses
    -- N.B. unilib:grass_dry_1 etc in the original code, but that is surely a mistake
    add_node({"unilib:dirt_silt_coarse_with_cover_snow"}, 0.01, {"glemr4_cold_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_frozen_1"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_cover_snow"}, 0.001, {"glemr4_cold_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_frozen_2"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_cover_snow"}, 0.01, {"glemr4_cold_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_frozen_3"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_cover_snow"}, 0.001, {"glemr4_cold_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_frozen_4"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_coarse_with_cover_snow"}, 0.01, {"glemr4_cold_humid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_frozen_5"}, nil, nil, nil)
    -- saplings

    -- glemr4_cold_humid_lowland
    -- trees
    add_schem({"unilib:dirt_silt_fine_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_silt_fine_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_spruce_2")
    add_schem({"unilib:dirt_silt_fine_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_spruce_3")
    add_schem({"unilib:dirt_silt_fine_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_spruce_4")
    add_schem({"unilib:dirt_silt_fine_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_spruce_5")
    add_schem({"unilib:dirt_silt_fine_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_spruce_6")
    add_schem({"unilib:dirt_silt_fine_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_spruce_7")
    add_schem({"unilib:dirt_silt_fine_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_silt_fine_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_pine_1")
    -- grasses
    add_node({"unilib:dirt_silt_fine_with_cover_snow"}, 0.01, {"glemr4_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_1"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_cover_snow"}, 0.001, {"glemr4_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_2"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_cover_snow"}, 0.01, {"glemr4_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_3"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_cover_snow"}, 0.001, {"glemr4_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_4"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_cover_snow"}, 0.01, {"glemr4_cold_humid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_5"}, nil, nil, nil)
    -- saplings

    -- glemr4_cold_humid_shelf
    -- trees
    add_schem({"unilib:dirt_dark_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_dark_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_spruce_2")
    add_schem({"unilib:dirt_dark_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_spruce_3")
    add_schem({"unilib:dirt_dark_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_spruce_4")
    add_schem({"unilib:dirt_dark_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_spruce_5")
    add_schem({"unilib:dirt_dark_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_spruce_6")
    add_schem({"unilib:dirt_dark_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_spruce_7")
    add_schem({"unilib:dirt_dark_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_dark_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_pine_1")
    -- grasses
    add_node({"unilib:dirt_dark_with_cover_snow"}, 0.01, {"glemr4_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_frozen_1"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_cover_snow"}, 0.001, {"glemr4_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_frozen_2"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_cover_snow"}, 0.01, {"glemr4_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_frozen_3"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_cover_snow"}, 0.001, {"glemr4_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_frozen_4"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_cover_snow"}, 0.01, {"glemr4_cold_humid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_frozen_5"}, nil, nil, nil)
    -- saplings

    -- glemr4_cold_humid_highland
    -- trees
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_2")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_3")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_4")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_5")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_6")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_7")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_3")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_douglas_coast_5")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_douglas_coast_6")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_douglas_coast_14")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr4_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_douglas_coast_15")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.001, {"glemr4_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_mature_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.001, {"glemr4_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_mature_2")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.001, {"glemr4_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_mature_3")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr4_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_frozen_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.001, {"glemr4_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_frozen_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr4_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_frozen_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.001, {"glemr4_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_frozen_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr4_cold_humid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_frozen_5"}, nil, nil, nil)
    -- saplings

    -- glemr4_cold_humid_mountain

end

local function add_decorations_cold_semihumid()

    -- glemr4_cold_semihumid_ocean

    -- glemr4_cold_semihumid_beach

    -- glemr4_cold_semihumid_coastal
    -- trees
    add_schem({"unilib:dirt_silt_fine_with_cover_snow"}, 80, 0.005, {"glemr4_cold_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_silt_fine_with_cover_snow"}, 80, 0.005, {"glemr4_cold_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_silt_fine_with_cover_snow"}, 80, 0.005, {"glemr4_cold_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_fir_douglas_coast_14")
    -- grasses
    add_node({"unilib:dirt_silt_fine_with_cover_snow"}, 0.01, {"glemr4_cold_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_frozen_1"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_cover_snow"}, 0.001, {"glemr4_cold_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_frozen_2"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_cover_snow"}, 0.01, {"glemr4_cold_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_frozen_3"}, nil, nil, nil)
    add_node({"unilib:dirt_silt_fine_with_cover_snow"}, 0.001, {"glemr4_cold_semihumid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_frozen_4"}, nil, nil, nil)
    -- saplings

    -- glemr4_cold_semihumid_lowland
    -- trees
    add_schem({"unilib:dirt_dark_with_cover_snow"}, 80, 0.005, {"glemr4_cold_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_dark_with_cover_snow"}, 80, 0.005, {"glemr4_cold_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_dark_with_cover_snow"}, 80, 0.005, {"glemr4_cold_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fir_douglas_coast_14")
    -- grasses
    add_node({"unilib:dirt_dark_with_cover_snow"}, 0.01, {"glemr4_cold_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_1"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_cover_snow"}, 0.001, {"glemr4_cold_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_2"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_cover_snow"}, 0.01, {"glemr4_cold_semihumid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_3"}, nil, nil, nil)
    add_node({"unilib:dirt_dark_with_cover_snow"}, 0.001, {"glemr4_cold_semihumid_lowland"}, 30, 45, {"unilib:grass_frozen_4"}, nil, nil, nil)
    -- saplings

    -- glemr4_cold_semihumid_shelf
    -- trees
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr4_cold_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr4_cold_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr4_cold_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_douglas_coast_14")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr4_cold_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_frozen_1"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.001, {"glemr4_cold_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_frozen_2"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.01, {"glemr4_cold_semihumid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_frozen_3"}, nil, nil, nil)
    -- saplings

    -- glemr4_cold_semihumid_highland
    -- trees
    add_schem({"unilib:dirt_coarse_with_cover_snow"}, 80, 0.005, {"glemr4_cold_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_coarse_with_cover_snow"}, 80, 0.005, {"glemr4_cold_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_1")
    add_schem({"unilib:dirt_coarse_with_cover_snow"}, 80, 0.005, {"glemr4_cold_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, "unilib_glem_tree_fir_douglas_coast_14")
    -- grasses
    add_node({"unilib:dirt_coarse_with_cover_snow"}, 0.01, {"glemr4_cold_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_frozen_1"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_cover_snow"}, 0.001, {"glemr4_cold_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_frozen_2"}, nil, nil, nil)
    add_node({"unilib:dirt_coarse_with_cover_snow"}, 0.01, {"glemr4_cold_semihumid_highland"}, HEIGHT_SHELF, HEIGHT_HIGHLAND, {"unilib:grass_frozen_3"}, nil, nil, nil)
    -- saplings

    -- glemr4_cold_semihumid_mountain

end

local function add_decorations_cold_temperate()

    -- glemr4_cold_temperate_ocean

    -- glemr4_cold_temperate_beach

    -- glemr4_cold_temperate_coastal
    -- trees
    add_schem({"unilib:dirt_dark_with_cover_snow"}, 80, 0.005, {"glemr4_cold_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_dark_with_cover_snow"}, 80, 0.005, {"glemr4_cold_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, "unilib_glem_tree_fir_1")
    -- grasses
    add_node({"unilib:dirt_dark_with_cover_snow"}, 0.005, {"glemr4_cold_temperate_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_frozen_1", "unilib:grass_frozen_2", "unilib:grass_frozen_3", "unilib:grass_frozen_4", "unilib:grass_frozen_5"}, nil, nil, nil)
    -- saplings

    -- glemr4_cold_temperate_lowland
    -- trees
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr4_cold_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.005, {"glemr4_cold_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, "unilib_glem_tree_fir_1")
    -- grasses
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.005, {"glemr4_cold_temperate_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_1", "unilib:grass_frozen_2", "unilib:grass_frozen_3", "unilib:grass_frozen_4", "unilib:grass_frozen_5"}, nil, nil, nil)
    -- saplings

    -- glemr4_cold_temperate_shelf
    -- trees
    add_schem({"unilib:dirt_coarse_with_cover_snow"}, 80, 0.005, {"glemr4_cold_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_spruce_1")
    add_schem({"unilib:dirt_coarse_with_cover_snow"}, 80, 0.005, {"glemr4_cold_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, "unilib_glem_tree_fir_1")
    -- grasses
    add_node({"unilib:dirt_coarse_with_cover_snow"}, 0.005, {"glemr4_cold_temperate_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_frozen_1", "unilib:grass_frozen_2", "unilib:grass_frozen_3", "unilib:grass_frozen_4", "unilib:grass_frozen_5"}, nil, nil, nil)
    -- saplings

    -- glemr4_cold_temperate_highland

    -- glemr4_cold_temperate_mountain

end

local function add_decorations_cold_semiarid()

    -- glemr4_cold_semiarid_ocean

    -- glemr4_cold_semiarid_beach
    add_node({"unilib:sand_ordinary"}, 0.005, {"glemr4_cold_semiarid_beach"}, 1, 4, {"unilib:grass_frozen_1", "unilib:grass_frozen_2", "unilib:grass_frozen_3", "unilib:grass_frozen_4", "unilib:grass_frozen_5"}, nil, nil, nil)

    -- glemr4_cold_semiarid_coastal
    add_node({"unilib:dirt_dark_with_turf_exotic_dry_8"}, 0.00125, {"glemr4_cold_semiarid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_frozen_1", "unilib:grass_frozen_2", "unilib:grass_frozen_3", "unilib:grass_frozen_4", "unilib:grass_frozen_5"}, nil, nil, nil)

    -- glemr4_cold_semiarid_lowland
    add_node({"unilib:dirt_coarse_with_turf_exotic_dry_8"}, 0.001, {"glemr4_cold_semiarid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_1", "unilib:grass_frozen_2", "unilib:grass_frozen_3", "unilib:grass_frozen_4", "unilib:grass_frozen_5"}, nil, nil, nil)

    -- glemr4_cold_semiarid_shelf
    add_node({"unilib:clay_red_with_turf_exotic_dry_8"}, 0.0075, {"glemr4_cold_semiarid_shelf"}, HEIGHT_LOWLAND, HEIGHT_SHELF, {"unilib:grass_frozen_1", "unilib:grass_frozen_2", "unilib:grass_frozen_3", "unilib:grass_frozen_4", "unilib:grass_frozen_5"}, nil, nil, nil)

    -- glemr4_cold_semiarid_highland

    -- glemr4_cold_semiarid_mountain

end

local function add_decorations_cold_arid()

    -- glem4_cold_arid_ocean

    -- glem4_cold_arid_beach
    add_node({"unilib:sand_silver"}, 0.005, {"glemr4_cold_arid_beach"}, 1, 4, {"unilib:grass_frozen_1", "unilib:grass_frozen_2", "unilib:grass_frozen_3", "unilib:grass_frozen_4", "unilib:grass_frozen_5"}, nil, nil, nil)

    -- glem4_cold_arid_coastal
    -- N.B. In original code, biome was glemr4_cold_semihumid_lowland, presumably a mistake
    add_node({"unilib:dirt_coarse"}, 0.01, {"glemr4_cold_arid_coastal"}, HEIGHT_BEACH, HEIGHT_COASTAL, {"unilib:grass_frozen_1", "unilib:grass_frozen_2", "unilib:grass_frozen_3", "unilib:grass_frozen_4", "unilib:grass_frozen_5"}, nil, nil, nil)

    -- glem4_cold_arid_lowland
    -- N.B. In original code, biome was glemr4_cold_semihumid_lowland, presumably a mistake
    add_node({"unilib:dirt_clayey"}, 0.0075, {"glemr4_cold_arid_lowland"}, HEIGHT_COASTAL, HEIGHT_LOWLAND, {"unilib:grass_frozen_1", "unilib:grass_frozen_2", "unilib:grass_frozen_3", "unilib:grass_frozen_4", "unilib:grass_frozen_5"}, nil, nil, nil)

    -- glem4_cold_arid_shelf

    -- glem4_cold_arid_highland

    -- glem4_cold_arid_mountain

end

---------------------------------------------------------------------------------------------------
-- Generic biomes
---------------------------------------------------------------------------------------------------

local function add_decorations_generic()

    if unilib.pkg.biome_glemr4.optional_biome_flag then

        -- glemr4_generic_volcanic
        add_node({"unilib:dirt_ordinary_with_turf_grey"}, 0.006, {"glemr4_generic_volcanic"}, 145, unilib.constant.y_max, {"unilib:tree_scorched_trunk"}, 6, nil, nil)

        -- glemr4_generic_burned
        add_node({"unilib:dirt_ordinary_with_turf_grey"}, 0.006, {"glemr4_generic_burned"}, 130, 145, {"unilib:tree_scorched_trunk"}, 6, nil, nil)

        -- glemr4_generic_mushroom
        -- N.B. These schematics are not used in the original code, even though the blotchy
        --      mushroom itself does
        -- These lines have been imported from the equivalent function in GLEMr6
        add_schem({"unilib:dirt_ordinary_with_cover_fungi"}, 80, 0.003, {"glemr4_generic_mushroom"}, 30, 50, "unilib_glem_mushroom_blotchy", "place_center_x, place_center_z")
        add_schem({"unilib:dirt_ordinary_with_cover_fungi"}, 80, 0.003, {"glemr4_generic_mushroom"}, 30, 50, "unilib_glem_mushroom_blotchy_large", "place_center_x, place_center_z")

    end

end

---------------------------------------------------------------------------------------------------
-- valleys_c biomes
---------------------------------------------------------------------------------------------------

local function add_decorations_valleys()

    -- glemr4_valleys_deciduous_forest_swamp
    -- trees
    add_schem({"unilib:dirt_silt_fine_with_litter_coniferous"}, 80, 0.0025, {"glemr4_valleys_deciduous_forest_swamp"}, 1, 100, "unilib_glem_tree_willow_large_1")
    -- plants
    add_schem({"unilib:dirt_mud_swamp"}, 80, 0.15, {"glemr4_valleys_deciduous_forest_swamp"}, 1, 2, "unilib_glem_plant_bulrush_1")
    add_schem({"unilib:dirt_mud_swamp"}, 80, 0.02, {"glemr4_valleys_deciduous_forest_swamp"}, 1, 2, "unilib_glem_plant_bulrush_2")
    add_schem({"unilib:liquid_water_ordinary_source"}, 80, 0.05, {"glemr4_valleys_deciduous_forest_swamp"}, -2, 2, "unilib_glem_flower_waterlily_exotic_pink")
    add_schem({"unilib:liquid_water_ordinary_source"}, 80, 0.05, {"glemr4_valleys_deciduous_forest_swamp"}, -2, 2, "unilib_glem_flower_waterlily_exotic_yellow")
    add_node({"unilib:dirt_mud_swamp"}, 0.2, {"glemr4_valleys_deciduous_forest_swamp"}, -1, 2, {"unilib:plant_papyrus_ordinary"}, 4, "unilib:liquid_water_ordinary_source", 1)
    add_node({"unilib:liquid_water_ordinary_source"}, 0.08, {"glemr4_valleys_deciduous_forest_swamp"}, -1, 2, {"unilib:plant_papyrus_ordinary"}, 3, "unilib:dirt_mud_swamp", 1)
    add_node({"unilib:dirt_mud_swamp"}, 0.2, {"glemr4_valleys_deciduous_forest_swamp"}, 1, 2, {"unilib:plant_cattail_normal"}, 1, nil, nil)
    add_node({"unilib:dirt_mud_swamp"}, 0.1, {"glemr4_valleys_deciduous_forest_swamp"}, 2, 4, {"unilib:misc_patch_grass"}, 1, nil, nil)
    add_node({"unilib:dirt_mud_swamp"}, 0.1, {"glemr4_valleys_deciduous_forest_swamp"}, 2, 4, {"unilib:grass_giant"}, 1, nil, nil)
    add_node({"unilib:liquid_water_ordinary_source"}, 0.05, {"glemr4_valleys_deciduous_forest_swamp"}, -2, 2, {"unilib:flower_waterlily_exotic_pink"}, 1, "unilib:dirt_mud_swamp", 3)
    add_node({"unilib:liquid_water_ordinary_source"}, 0.05, {"glemr4_valleys_deciduous_forest_swamp"}, -2, 2, {"unilib:flower_waterlily_exotic_yellow"}, 1, "unilib:dirt_mud_swamp", 4)

end

---------------------------------------------------------------------------------------------------
-- ethereal-ng biomes
---------------------------------------------------------------------------------------------------

local function add_decorations_ethereal()

    -- glemr4_ethereal_alpine
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.01, {"glemr4_ethereal_alpine"}, 120, 140, "unilib_glem_tree_healing_1")
    add_schem({"unilib:dirt_ordinary_with_cover_snow"}, 80, 0.01, {"glemr4_ethereal_alpine"}, 40, 140, "unilib_glem_tree_pine_ancient_2")
    add_node({"unilib:dirt_ordinary_with_cover_snow"}, 0.8, {"glemr4_ethereal_alpine"}, 40, 140, {"unilib:snow_ordinary"}, nil, nil, nil)

    -- glemr4_ethereal_desert
    add_node({"unilib:sand_desert"}, 0.015, {"glemr4_ethereal_desert"}, 1, 100, {"unilib:plant_shrub_dry"}, nil, nil, nil)
    add_node({"unilib:sand_desert"}, 0.005, {"glemr4_ethereal_desert"}, 1, 100, {"unilib:plant_cactus_ordinary"}, 4, nil, nil)
    unilib.register_decoration_simple({
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_plant_cactus_ordinary_large.mts",

        biomes = {"glemr4_ethereal_desert"},
        flags = "place_center_x",
        noise_params = {
            octaves = 3,
            offset = -0.0005,
            persist = 0.6,
            scale = 0.0015,
            seed = 230,
            spread = {x = 200, y = 200, z = 200},
        },
        place_on = {"unilib:sand_desert"},
        rotation = "random",
        sidelen = 80,
        y_max = unilib.constant.y_max,
        y_min = 5,
    })

    -- glemr4_ethereal_fiery
    -- N.B. Assuming that fiery grass should have fiery shrubs, not unilib:plant_shrub_dry, as in the original code
    add_node({"unilib:dirt_ordinary_with_turf_fiery"}, 0.10, {"glemr4_ethereal_fiery"}, 1, 100, {"unilib:plant_shrub_dry_fiery"}, nil, nil, nil)

    -- glemr4_ethereal_frost
    add_schem({"unilib:dirt_ordinary_with_turf_crystal"}, 80, 0.01, {"glemr4_ethereal_frost"}, 1, 100, "unilib_glem_tree_frost_1")
    add_node({"unilib:dirt_ordinary_with_turf_crystal"}, 0.02, {"glemr4_ethereal_frost"}, 1, 100, {"unilib:mineral_crystallite_spike",  "unilib:plant_shrub_crystal"}, nil, nil, nil)

    -- glemr4_ethereal_junglee
    add_schem({"unilib:dirt_ordinary_with_turf_rainforest"}, 80, 0.002, {"glemr4_ethereal_junglee"}, 1, 100, "unilib_glem_tree_jungle_6")
    add_node({"unilib:dirt_ordinary_with_turf_rainforest"}, 0.10, {"glemr4_ethereal_junglee"}, 1, 100, {"unilib:grass_jungle"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_rainforest"}, 0.35, {"glemr4_ethereal_junglee"}, 1, 100, {"unilib:grass_ordinary_2", "unilib:grass_ordinary_3", "unilib:grass_ordinary_4", "unilib:grass_ordinary_5"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_rainforest"}, 0.1, {"glemr4_ethereal_junglee"}, 1, 1, {"unilib:plant_papyrus_ordinary"}, 4, "unilib:liquid_water_ordinary_source", 1)
    add_node({"unilib:dirt_ordinary_with_turf_rainforest"}, 0.035, {"glemr4_ethereal_junglee"}, 1, 100, {"unilib:produce_potato_normal_grow_3"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_rainforest"}, 0.015, {"glemr4_ethereal_junglee"}, 1, 1, {"unilib:produce_melon_grow_8", "unilib:produce_pumpkin_yellow_grow_8"}, nil, "unilib:liquid_water_ordinary_source", 1)

    -- glemr4_ethereal_plains
    add_node({"unilib:dirt_parched"}, 0.015, {"glemr4_ethereal_plains"}, 1, 100, {"unilib:plant_shrub_dry"}, nil, nil, nil)

    -- glemr4_ethereal_prairie
    add_schem({"unilib:dirt_ordinary_with_turf_prairie"}, 80, 0.001, {"glemr4_ethereal_prairie"}, 1, 100, "unilib_glem_tree_orange_1")
    add_node({"unilib:dirt_ordinary_with_turf_prairie"}, 0.035, {"glemr4_ethereal_prairie"}, 1, 100, {"unilib:flower_dandelion_white"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_prairie"}, 0.035, {"glemr4_ethereal_prairie"}, 1, 100, {"unilib:flower_dandelion_yellow"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_prairie"}, 0.035, {"glemr4_ethereal_prairie"}, 1, 100, {"unilib:flower_geranium_blue"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_prairie"}, 0.035, {"glemr4_ethereal_prairie"}, 1, 100, {"unilib:flower_rose_red"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_prairie"}, 0.035, {"glemr4_ethereal_prairie"}, 1, 100, {"unilib:flower_tulip_orange"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_prairie"}, 0.035, {"glemr4_ethereal_prairie"}, 1, 100, {"unilib:flower_viola_purple"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_prairie"}, 0.035, {"glemr4_ethereal_prairie"}, 1, 100, {"unilib:produce_strawberry_normal_grow_7"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_prairie"}, 0.035, {"glemr4_ethereal_prairie"}, 1, 100, {"unilib:produce_strawberry_normal_grow_7"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_prairie"}, 0.35, {"glemr4_ethereal_prairie"}, 1, 100, {"unilib:grass_ordinary_2", "unilib:grass_ordinary_3", "unilib:grass_ordinary_4", "unilib:grass_ordinary_5"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_prairie"}, 0.25, {"glemr4_ethereal_prairie"}, 1, 100, {"unilib:produce_onion_wild_grow_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_prairie"}, 0.05, {"glemr4_ethereal_prairie"}, 1, 100, {"unilib:produce_carrot_normal_grow_7", "unilib:produce_cucumber_normal_grow_4", "unilib:produce_potato_normal_grow_3", "unilib:produce_tomato_salad_grow_7", "unilib:produce_corn_normal_grow_8", "unilib:produce_coffee_grow_5", "unilib:produce_raspberry_grow_4", "unilib:produce_rhubarb_grow_3", "unilib:produce_blueberry_highbush_grow_4"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_prairie"}, 0.025, {"glemr4_ethereal_prairie"}, 1, 100, {"unilib:produce_grape_wild"}, nil, nil, nil)

    -- glemr4_ethereal_sandclay
    add_node({"unilib:sand_ordinary"}, 0.25, {"glemr4_ethereal_sandclay"}, 3, 4, {"unilib:grass_ordinary_2", "unilib:grass_ordinary_3"}, nil, nil, nil)

    -- glemr4_ethereal_sandstone
    add_node({"unilib:stone_sandstone_ordinary"}, 0.015, {"glemr4_ethereal_sandstone"}, 1, 100, {"unilib:plant_shrub_dry"}, nil, nil, nil)
    add_node({"unilib:stone_sandstone_ordinary"}, 0.0025, {"glemr4_ethereal_sandstone"}, 1, 100, {"unilib:plant_cactus_ordinary"}, 3, nil, nil)

    -- glemr4_ethereal_savanna
    add_schem({"unilib:dirt_ordinary_with_turf_dry"}, 80, 0.004, {"glemr4_ethereal_savanna"}, 1, 100, "unilib_glem_tree_acacia_1")
    add_node({"unilib:dirt_ordinary_with_turf_dry"}, 0.25, {"glemr4_ethereal_savanna"}, 1, 100, {"unilib:grass_dry_2", "unilib:grass_dry_3", "unilib:grass_dry_4", "unilib:grass_dry_5"}, nil, nil, nil)

    -- glemr4_ethereal_snowy
    add_schem({"unilib:dirt_ordinary_with_turf_cold"}, 80, 0.01, {"glemr4_ethereal_snowy"}, 10, 40, "unilib_glem_tree_pine_ancient_1")
    add_node({"unilib:dirt_ordinary_with_turf_cold"}, 0.05, {"glemr4_ethereal_snowy"}, 1, 100, {"unilib:plant_shrub_snowy"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf"}, 0.25, {"glemr4_ethereal_snowy"}, 1, 100, {"unilib:grass_jungle"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf"}, 0.1, {"glemr4_ethereal_snowy"}, 1, 100, {"unilib:fern_boston"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf_cold"}, 0.8, {"glemr4_ethereal_snowy"}, 4, 40, {"unilib:snow_ordinary"}, nil, nil, nil)
    add_node({"unilib:dirt_ordinary_with_turf"}, 0.1, {"glemr4_ethereal_snowy"}, 1, 1, {"unilib:plant_papyrus_ordinary"}, 4, "unilib:liquid_water_ordinary_source", 1)

    -- glemr4_ethereal_swamp

    if unilib.pkg.biome_glemr4.optional_biome_flag then

        -- glemr4_ethereal_bamboo
        add_node({"unilib:dirt_ordinary_with_turf_bamboo"}, 0.35, {"glemr4_ethereal_bamboo"}, 1, 100, {"unilib:grass_ordinary_2", "unilib:grass_ordinary_3", "unilib:grass_ordinary_4", "unilib:grass_ordinary_5"}, nil, nil, nil)

        -- glemr4_ethereal_caves

        -- glemr4_ethereal_clearing
        add_node({"unilib:dirt_ordinary_with_turf"}, 0.35, {"glemr4_ethereal_clearing", "glemr4_ethereal_snowy"}, 1, 100, {"unilib:grass_ordinary_3",  "unilib:grass_ordinary_4"}, nil, nil, nil, 1)

        -- glemr4_ethereal_grassy
        add_node({"unilib:dirt_ordinary_with_turf"}, 0.025, {"glemr4_ethereal_grassy"}, 1, 100, {"unilib:flower_dandelion_white", "unilib:flower_dandelion_yellow", "unilib:flower_geranium_blue", "unilib:flower_rose_red", "unilib:flower_tulip_orange", "unilib:flower_viola_purple", "unilib:produce_strawberry_normal_grow_7"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_turf"}, 0.35, {"glemr4_ethereal_grassy"}, 1, 100, {"unilib:grass_ordinary_2", "unilib:grass_ordinary_3", "unilib:grass_ordinary_4", "unilib:grass_ordinary_5"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_turf"}, 0.25, {"glemr4_ethereal_grassy"}, 1, 100, {"unilib:produce_onion_wild_grow_4"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_turf"}, 0.1, {"glemr4_ethereal_grassy"}, 1, 1, {"unilib:plant_papyrus_ordinary"}, 4, "unilib:liquid_water_ordinary_source", 1)
        add_node({"unilib:dirt_ordinary_with_turf"}, 0.05, {"glemr4_ethereal_grassy"}, 1, 100, {"unilib:produce_carrot_normal_grow_7", "unilib:produce_cucumber_normal_grow_4", "unilib:produce_potato_normal_grow_3", "unilib:produce_tomato_salad_grow_7", "unilib:produce_corn_normal_grow_8", "unilib:produce_coffee_grow_5", "unilib:produce_raspberry_grow_4", "unilib:produce_rhubarb_grow_3", "unilib:produce_blueberry_highbush_grow_4"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_turf"}, 0.015, {"glemr4_ethereal_grassy"}, 1, 1, {"unilib:produce_melon_grow_8", "unilib:produce_pumpkin_yellow_grow_8"}, nil, "unilib:liquid_water_ordinary_source", 1)
        add_node({"unilib:dirt_ordinary_with_turf"}, 0.025, {"glemr4_ethereal_grassy"}, 1, 100, {"unilib:produce_grape_wild"}, nil, nil, nil)

        -- glemr4_ethereal_grayness
        add_node({"unilib:dirt_ordinary_with_turf_grey"}, 0.006, {"glemr4_ethereal_grayness"}, 1, 100, {"unilib:tree_scorched_trunk"}, 6, nil, nil)
        add_node({"unilib:dirt_ordinary_with_turf_grey"}, 0.05, {"glemr4_ethereal_grayness"}, 1, 100, {"unilib:plant_shrub_snowy"}, nil, nil, nil)

        -- glemr4_ethereal_grayness2
        add_node({"unilib:dirt_ordinary_with_turf_grey"}, 0.006, {"glemr4_ethereal_grayness2"}, 40, 50, {"unilib:tree_scorched_trunk"}, 6, nil, nil)

        -- glemr4_ethereal_grassytwo
        add_node({"unilib:dirt_ordinary_with_turf"}, 0.025, {"glemr4_ethereal_grassytwo"}, 1, 100, {"unilib:flower_dandelion_white", "unilib:flower_dandelion_yellow", "unilib:flower_geranium_blue", "unilib:flower_rose_red", "unilib:flower_tulip_orange", "unilib:flower_viola_purple", "unilib:produce_strawberry_normal_grow_7"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_turf"}, 0.35, {"glemr4_ethereal_grassytwo"}, 1, 100, {"unilib:grass_ordinary_2", "unilib:grass_ordinary_3", "unilib:grass_ordinary_4", "unilib:grass_ordinary_5"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_turf"}, 0.25, {"glemr4_ethereal_grassytwo"}, 1, 100, {"unilib:produce_onion_wild_grow_4"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_turf"}, 0.05, {"glemr4_ethereal_grassytwo"}, 1, 100, {"unilib:produce_carrot_normal_grow_7", "unilib:produce_cucumber_normal_grow_4", "unilib:produce_potato_normal_grow_3", "unilib:produce_tomato_salad_grow_7", "unilib:produce_corn_normal_grow_8", "unilib:produce_coffee_grow_5", "unilib:produce_raspberry_grow_4", "unilib:produce_rhubarb_grow_3", "unilib:produce_blueberry_highbush_grow_4"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_turf"}, 0.015, {"glemr4_ethereal_grassytwo"}, 1, 1, {"unilib:produce_melon_grow_8", "unilib:produce_pumpkin_yellow_grow_8"}, nil, "unilib:liquid_water_ordinary_source", 1)
        add_node({"unilib:dirt_ordinary_with_turf"}, 0.035, {"glemr4_ethereal_grassytwo"}, 1, 100, {"unilib:produce_bean_green_wild"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_turf"}, 0.025, {"glemr4_ethereal_grassytwo"}, 1, 100, {"unilib:produce_grape_wild"}, nil, nil, nil)

        -- glemr4_ethereal_grove
        if unilib.global.pkg_executed_table["tree_apple_mature"] ~= nil then
            add_schem({"unilib:dirt_ordinary_with_turf_grove"}, 80, 0.015, {"glemr4_ethereal_grove"}, 1, 100, "unilib_glem_tree_banana_1")
        end
        add_node({"unilib:dirt_ordinary_with_turf_grove"}, 0.35, {"glemr4_ethereal_grove"}, 1, 100, {"unilib:grass_ordinary_2", "unilib:grass_ordinary_3", "unilib:grass_ordinary_4", "unilib:grass_ordinary_5"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_turf_grove"}, 0.2, {"glemr4_ethereal_grove"}, 1, 100, {"unilib:fern_boston"}, nil, nil, nil)

        -- glemr4_ethereal_jumble
        add_node({"unilib:dirt_ordinary_with_turf"}, 0.15, {"glemr4_ethereal_jumble"}, 1, 100, {"unilib:grass_jungle"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_turf"}, 0.35, {"glemr4_ethereal_jumble"}, 1, 100, {"unilib:grass_ordinary_2", "unilib:grass_ordinary_3", "unilib:grass_ordinary_4", "unilib:grass_ordinary_5"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_turf"}, 0.25, {"glemr4_ethereal_jumble"}, 1, 100, {"unilib:produce_onion_wild_grow_4"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_turf"}, 0.05, {"glemr4_ethereal_jumble"}, 1, 100, {"unilib:produce_carrot_normal_grow_7", "unilib:produce_cucumber_normal_grow_4", "unilib:produce_potato_normal_grow_3", "unilib:produce_tomato_salad_grow_7", "unilib:produce_corn_normal_grow_8", "unilib:produce_coffee_grow_5", "unilib:produce_raspberry_grow_4", "unilib:produce_rhubarb_grow_3", "unilib:produce_blueberry_highbush_grow_4"}, nil, nil, nil)
        add_node({"unilib:dirt_ordinary_with_turf"}, 0.015, {"glemr4_ethereal_jumble"}, 1, 1, {"unilib:produce_melon_grow_8", "unilib:produce_pumpkin_yellow_grow_8"}, nil, "unilib:liquid_water_ordinary_source", 1)

    end

    local list = {
        {"glemr4_ethereal_junglee", "unilib:dirt_ordinary_with_turf_rainforest"},
        {"glemr4_ethereal_grassy", "unilib:dirt_ordinary_with_turf"},
        {"glemr4_ethereal_grassytwo", "unilib:dirt_ordinary_with_turf"},
        {"glemr4_ethereal_prairie", "unilib:dirt_ordinary_with_turf_prairie"},
        {"glemr4_ethereal_snowy", "unilib:dirt_ordinary_with_turf"},
    }
    for _, mini_list in pairs(list) do

        unilib.register_decoration_simple({
            deco_type = "simple",
            decoration = {"unilib:mushroom_brown", "unilib:mushroom_red"},

            biomes = {mini_list[1]},
            noise_params = {
                octaves = 3,
                offset = 0,
                persist = 0.66,
                scale = 0.009,
                seed = 2,
                spread = {x = 200, y = 200, z = 200},
            },
            place_on = {mini_list[2]},
            sidelen = 16,
            y_max = 120,
            y_min = 1,
        })

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

        biomes = {"glemr4_cool_temperate_lowland"},
        fill_ratio = 0.01,
        height = 1,
        place_on = {"unilib:dirt_coarse_with_turf"},
        sidelen = 6,
    })

    -- Large cactus
    unilib.register_decoration_simple({
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_plant_cactus_ordinary_large.mts",

        biomes = {"glemr4_warm_arid_lowland", "glem4_temperate_arid_lowland"},
        fill_ratio = 0.002,
        flags = "place_center_x",
        place_on = {"unilib:dirt_parched_with_turf_dry", "unilib:sand_ordinary"},
        rotation = "random",
        sidelen = 16,
        y_max = unilib.constant.y_max,
        y_min = 5,
    })

    -- Cactus
    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = "unilib:plant_cactus_ordinary",

        biomes = {
            "glemr4_hot_arid_lowland",
            "glemr4_warm_arid_lowland",
            "glemr4_temperate_arid_lowland",
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
        y_max = unilib.constant.y_max,
        y_min = 5,
    })

    -- Papyrus
    unilib.register_decoration_simple({
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_plant_papyrus_ordinary_farlands.mts",

        biomes = {
            "glemr4_hot_humid_coastal",
            "glemr4_hot_semihumid_coastal",
            "glemr4_warm_humid_coastal",
            "glemr4_warm_temperate_coastal",
        },
        fill_ratio = 0.002,
        height = 2,
        height_max = 5,
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

local function add_decorations_waterlily()

    -- place waterlily in beach areas
    local biome_list = {
        "glemr4_ethereal_desert",
        "glemr4_ethereal_plains",
        "glemr4_ethereal_sandclay",
        "glemr4_ethereal_sandstone",
    }

    if unilib.pkg.biome_glemr4.optional_biome_flag then

        table.insert(biome_list, "glemr4_ethereal_grove")
        table.insert(biome_list, "glemr4_ethereal_grassy")

    end

    for _, biome_name in pairs(biome_list) do

        -- (The "flower_waterlily_ordinary_alt" package removes the node
        --      "unilib:flower_waterlily_ordinary", making this schematic unusable)
        if unilib.global.pkg_executed_table["flower_waterlily_ordinary_alt"] == nil then

            unilib.register_decoration_simple({
                deco_type = "schematic",
                schematic = unilib.core.path_mod .. "/mts/unilib_flower_waterlily_ordinary_ethereal.mts",

                biomes = {biome_name},
                noise_params = {
                    octaves = 3,
                    offset = -0.12,
                    persist = 0.7,
                    scale = 0.3,
                    seed = 33,
                    spread = {x = 200, y = 200, z = 200},
                },
                place_on = {"unilib:sand_ordinary"},
                rotation = "random",
                sidelen = 16,
                y_max = 0,
                y_min = 0,
            })

        end

        unilib.register_decoration_simple({
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_flower_waterlily_exotic_pink.mts",

            biomes = {biome_name},
            noise_params = {
                octaves = 3,
                offset = -0.12,
                persist = 0.7,
                scale = 0.3,
                seed = 33,
                spread = {x = 200, y = 200, z = 200},
            },
            place_on = {"unilib:sand_ordinary"},
            rotation = "random",
            sidelen = 16,
            y_max = 0,
            y_min = 0,
        })

        unilib.register_decoration_simple({
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_flower_waterlily_exotic_yellow.mts",

            biomes = {biome_name},
            noise_params = {
                octaves = 3,
                offset = -0.12,
                persist = 0.7,
                scale = 0.3,
                seed = 33,
                spread = {x = 200, y = 200, z = 200},
            },
            place_on = {"unilib:sand_ordinary"},
            rotation = "random",
            sidelen = 16,
            y_max = 0,
            y_min = 0,
        })

    end

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
        decoration = "unilib:grass_reed_mannagrass",

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

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_glemr4.init()

    return {
        description = "Decorations from GLEMr4",
        notes = "This package should be used with the corresponding remix, as it assumes that" ..
                " packages specified by the remix have been loaded",
        depends = "biome_glemr4",
        -- The mature apple tree package fails if the replace_mode for minetest_game mods is
        --      "defer", therefore we have to check it was executed, before we use schematics
        --      containing its leaves (confusingly, the schematic in question is
        --      "unilib_glem_tree_banana_1")
        optional = "tree_apple_mature",
    }

end

function unilib.pkg.deco_glemr4.post()

    if unilib.pkg.biome_glemr4.generic_biome_flag then
        add_decorations_generic()
    end

    if unilib.pkg.biome_glemr4.glem_biome_flag then

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

    if unilib.pkg.biome_glemr4.valleys_biome_flag then
        add_decorations_valleys()
    end

    if unilib.pkg.biome_glemr4.ethereal_biome_flag then
        add_decorations_ethereal()
    end

    if misc_flag then

        add_decorations_mixed()
        add_decorations_waterlily()
        add_decorations_bakedclay()

    end

end
