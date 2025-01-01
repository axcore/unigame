---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mapgen_hades = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------
-- Standard variables
---------------------

-- The VoxelManip object works by switching nodes, comparing their Minetest IDs
local id_table = {}
-- Table used to replace ordinary stone nodes with the base stone for each pseudo-biome
local ending_list = {"", "_cobble", "_cobble_mossy", "_cobble_stair_simple"}

-- Tables of ores to be placed in each pseudo-biome, compiled by calls to distribute_single_ore(),
--      distribute_blob() and distribute_scatter() below
-- The format of each table is
--      table[item_name] = mini_list
-- ...where "item_name" is, for example, "stone_breccia" (each pseudo-biome is characterised by a
--      single stone type), and "list" is a list of distribution tables, one for each ore to be
--      placed in that pseudo-biome. For the format of each distribution table, see the comments in
--      those functions
local single_ore_table = {}
local blob_table = {}
local scatter_table = {}
-- Ore probability table, used to balance the number of ores available in each pseudo-biome
-- Table in the form
--      table[item_name] = combined_probability_of_alL_ores
-- ...where "item_name" is, for example, "stone_breccia", and "combined_probability_of_all_ores"
--      represents the probability that a particular basic stone node will be replaced by any
--      ore
-- Note that these statistics are not very accurate; they don't take account of ores placed via
--      calls to distribute_blob() and distribute_scatter(), and they don't take account of
--      maximum/minimum heights for each ore
local ore_chance_table = {}
-- Adjusted ore probability table, in the form
--      table[item_name] = factor
-- ...where "factor" is multiplied against an ore's basic probability. If the value is 1.2, ores in
--      the pseudo-biome are less frequent than the average, so their numbers are increased; if the
--      value is 0.8, ores in the pseudo-biome are less frequent than average, so their numbers are
--      descreased; if the value is 1, ores in the pseudo-biome exactly match the average
local ore_factor_table = {}
-- Table of of ore probability adjustments, according to height. Table in the form
--      table[height_multiple] = factor
-- ...where "height_multiple" is a value between 310 and -310, representing the Mineteset height
--      range of y = 31000 to y = -31000 (such that ores at y=-20 and y=-80 will have exactly the
--      same probability adjustment), and "factor" is multiplied against an ore's basic probability
-- The factors depend on customisable values that can be set below. For example, the factor at
--      y=-100 might be 0.2 (fewer ores), but at y=-30100 it might be 1.5 (more ores)
-- The adjustments apply equally to single ores, scatters and blobs
local height_adjust_table = {}

-- Table identical to the one used in ../lib/shared/stone/stone_smooth.lua, converting a PFAA
--      hardness (in the range 1-5) into a Minetest cracky group
local smooth_cracky_table = {3, 2, 1, 1, 1}

-- When placing ore distributions in place_blob() and place_scatter(), introduce randomness
-- (Use our own values for our own functions, rather than using the ../lib/shared/jbiomes/
--      equivalents)
local x_off = math.random()
local y_off = math.random()
local z_off = math.random()

-- List of all basic stones not in ugbc_list (below). This list is populated only if needed
local non_ugbc_list = {}

-- Base value for the seeds used in calls to create_simple_blobs(); every time a blob is generated,
--      this value is increased by 1
local base_seed = unilib.utils.get_mod_attribute("storage_random_seed_offset")

---------------------------------
-- Customisable variables - stone
---------------------------------

-- List of pseudo-biomes. This list must  contain at least one pseudo-biome, and any number up to
--      the upper limit specified by unilib.constant.underch_max_biomes (currently 62)
-- Each pseudo-biome is characterised by a basic stone (e.g. "unilib:stone_breccia"). A specific set
--      of ores is placed randomly throughout each basic stone
local basic_stone_list = {

    -- Basic stones used for whole sections of minerals (in populate_ore_tables() below); these
    --      should be closest to the surface

    -- 1  stone_carbonatite|pfaa|extrusive
    "carbonatite",
    -- 2  stone_diorite_dark|pfaa|intrusive
    "diorite_dark",
    -- 3  stone_laterite|pfaa|clay_dirt
    "laterite",
    -- 4  stone_limestone_beige|ugbc|sedimentary
    "limestone_beige",
    -- 5  stone_limestone_red|pfaa|sedimentary
    "limestone_red",
    -- 6  stone_pegmatite_white|pfaa|intrusive
    "pegmatite_white",
    -- 7  stone_rhyolite_pale|pfaa|extrusive
    "rhyolite_pale",
    -- 8  stone_serpentinite_dark|pfaa|metamorphic
    "serpentinite_dark",
    -- 9  stone_serpentinite_pale|decoblocks|metamorphic
    "serpentinite_pale",

    -- Basic stones used for smaller groups of minerals

    -- 10 stone_andesite_pale|pfaa|intrusive
    "andesite_pale",
    -- 11 stone_basalt_red|pfaa|extrusive
    "basalt_red",
    -- 12 stone_basalt_dark|darkage|extrusive
    "basalt_dark",
    -- 13 stone_basalt_pale|ugbc|extrusive
    "basalt_pale",
    -- 14 stone_conglomerate_rough|pfaa|sedimentary
    "conglomerate_rough",
    -- 15 stone_dolostone_dark|ugbc|sedimentary
    "dolostone_dark",
    -- 16 stone_gabbro_grey|ugbc|intrusive
    "gabbro_grey",
    -- 17 stone_gabbro_red|pfaa|intrusive
    "gabbro_red",
    -- 18 stone_granite_ebony|ugbc|intrusive
    "granite_ebony",
    -- 19 stone_granite_orange|ugbc|intrusive
    "granite_orange",
    -- 20 stone_granite_pale|pfaa|intrusive
    "granite_pale",
    -- 21 stone_peridotite_pale|pfaa|intrusive
    "peridotite_pale",
    -- 22 stone_sandstone_pink|pfaa|sedimentary
    "sandstone_pink",
    -- 23 stone_slate_black|pfaa|metamorphic
    "slate_black",
    -- 24 stone_slate_grey|darkage|metamorphic
    "slate_grey",
    -- 25 stone_marble_silver|pfaa|metamorphic
    "marble_silver",
    -- 26 stone_skarn|pfaa|metamorphic
    "skarn",

    -- All other basic stones, sorted by type

    -- 27 stone_breccia|pfaa|sedimentary
    "breccia",
    -- 28 stone_brownstone_pale|decoblocks|sedimentary
    "brownstone_pale",
    -- 29 stone_chalk_pink|ugbc|sedimentary
    "chalk_pink",
    -- 30 stone_chalk_yellow|pfaa|sedimentary
    "chalk_yellow",
    -- 31 stone_chert|ugbc|sedimentary
    "chert",
    -- 32 stone_claystone_red|pfaa|sedimentary
    "claystone_red",
    -- 33 stone_greywacke_pale|ugbc|sedimentary
    "greywacke_pale",
    -- 34 stone_lignite|ugbc|sedimentary
    "lignite",
    -- 35 stone_mudstone|pfaa|sedimentary
    "mudstone",
    -- 36 stone_sandstone_red|pfaa|sedimentary
    "sandstone_red",
    -- 37 stone_sandstone_old_red|darkage|sedimentary
    "sandstone_old_red",
    -- 38 stone_sandstone_beige|decoblocks|sedimentary
    "sandstone_beige",
    -- 39 stone_savanna|farlands|sedimentary
    "savanna",
    -- 40 stone_shale_white|ugbc|sedimentary
    "shale_white",
    -- 41 stone_siltstone_pale|ugbc|sedimentary
    "siltstone_pale",
    -- 42 stone_travertine|decoblocks|sedimentary
    "travertine",
    -- 43 stone_andesite_white|ugbc|extrusive
    "andesite_white",
    -- 44 stone_dacite|ugbc|extrusive
    "dacite",
    -- 45 stone_rhyolite_dark|ugbc|extrusive
    "rhyolite_dark",
    -- 46 stone_tuff|darkage|extrusive
    "tuff",
    -- 47 stone_tuff_rhyolitic|darkage|extrusive
    "tuff_rhyolitic",
    -- 48 stone_eclogite|ugbc|metamorphic
    "eclogite",
    -- 49 stone_gneiss_brown|pfaa|metamorphic
    "gneiss_brown",
    -- 50 stone_gneiss_grey|ugbc|metamorphic
    "gneiss_grey",
    -- 51 stone_gneiss_white|darkage|metamorphic
    "gneiss_white",
    -- 52 stone_hornfels|pfaa|metamorphic
    "hornfels",
    -- 53 stone_komatiite|ugbc|metamorphic
    "komatiite",
    -- 54 stone_marble_cream|ugbc|metamorphic
    "marble_cream",
    -- 55 stone_quartzite_white|pfaa|metamorphic
    "quartzite_white",
    -- 56 stone_quartzite_red|ugbc|metamorphic
    "quartzite_red",
    -- 57 stone_schist_blue|ugbc|metamorphic
    "schist_blue",
    -- 58 stone_schist_green_dark|pfaa|metamorphic
    "schist_green_dark",
    -- 59 stone_schist_green_pale|ugbc|metamorphic
    "schist_green_pale",
    -- 60 stone_schist_brown|pfaa|metamorphic
    "schist_brown",
    -- 61 stone_soapstone|ugbc|metamorphic
    "soapstone",

    -- The final basic stone replaces underch's obscurite, at the deepest possible level
    -- 62 stone_migmatite|ugbc|metamorphic
    "migmatite",
}
-- Lists of related basic stones, used when required
local basalt_list = {"basalt_red", "basalt_dark", "basalt_pale"}
local gabbro_list = {"gabbro_grey", "gabbro_red"}
local granite_list = {"granite_ebony", "granite_orange", "granite_pale"}
local limestone_list = {"limestone_beige", "limestone_red"}
local sandstone_list = {"sandstone_beige", "sandstone_pink", "sandstone_old_red", "sandstone_red"}
local serpentinite_list = {"serpentinite_dark", "serpentinite_pale"}
local slate_list = {"slate_black", "slate_grey"}

-- List of UGBC stones which have clay, gravel, sand and sandstone equivalents, which can be
--      placed as blob/scatter ores
local ugbc_list = {
    "andesite_white", "basalt_pale", "chalk_pink", "chert", "dacite", "dolostone_dark", "eclogite",
    "gabbro_grey", "gneiss_grey", "granite_ebony", "granite_orange", "greywacke_pale", "komatiite",
    "lignite", "limestone_beige", "marble_cream", "migmatite", "quartzite_red", "rhyolite_dark",
    "schist_blue", "schist_green_pale", "shale_white", "siltstone_pale", "soapstone",
}

------------------------------------
-- Customisable variables - minerals
------------------------------------

-- N.B. THESE FLAGS, WHEN SET TO true, PLACE NODES NOT LOADED BY THE REMIX, BY DEFAULT
-- Before setting any of the flags below to true, you should edit the "hades" remix to uncomment the
--      necessary packages (i.e. by removing the # character at the beginning of each line)

-- Flag set to true if extra native metal ores should be placed (even though they are not mentioned
--      in PFAA documentation, for the most part). For example, a Minetest player probably wants
--      a source of silver, but none of the minerals created by default here provide it; so we can
--      place native silver
local add_native_flag = true
-- Flag set to true if additional minerals providing metals, which are not provided by other
--      non-optional minerals, should be added (sparsely, and in random biomes)
local add_more_metals_flag = false
-- Flag set to true if additional minerals from the AATO mod should be added (sparsely, and in
--      random biomes)
local add_aato_flag = false
-- Flag set to true if additional minerals from the real_minerals mod should be added (sparsely,
--      and in random biomes)
local add_real_minerals_flag = false
-- Packages like "mineral_gold_native" creates minerals whose lump can be smelted into the
--      real_minerals variant of the gold ingot, if available, or the ordinary gold ingot, if not
-- Flag set to true if some extra ores should be created to make sure that both the ordinary and
--      variant gold ingots are obtainable in the game. Ignored if add_real_minerals_flag is false
local add_real_minerals_extra_flag = false
-- Flag set to true if additional minerals from the custom list should be added. The custom list,
--      below, is empty, ready for you to add new minerals
local add_custom_flag = true

-- Flag set to true, if UGBC clay/gravel/sand/sandstones should be placed as ores inside their
--      corresponding basic stones
local ugbc_extra_ore_flag = false
-- Flag set to true, if ordinary clay/gravel/sand should be place as ores inside non-UGBC stones
local non_ugbc_extra_ore_flag = false

-- Flags set to true, if common nodes/ores from the default, moreores, technic, underch and
--      xtraores mods should be made available, as well as the "realistic" ores generated by this
--      package
-- If you use this package together with the "gaia" remix, these values should all be false, since
--      the same ores are provided by "gaia". However, if you were to use this package together
--      with remixes that don't provide the same ores, you can set one or more of them to true
-- N.B. Most of the metals/minerals provided when these flags are set to true, are also
--      obtainable from other non-optional minerals. See the comments in the .post() function below
local blob_default_flag = false
local scatter_default_flag = false
local scatter_moreores_flag = false
local scatter_technic_flag = false
local scatter_xtraores_flag = false

------------------------------------------
-- Customisable variables - optimised mode
------------------------------------------

-- Optimisation flag. If disabled, this package uses code that's very similar to the
--      "mapgen_hades_jit" package; however, this comes with a high computational cost, as ores are
--      calculated for all underground nodes during map generation, not just those that are exposed
--      to air. The flag should be disabled only on high-end machines
-- If enabled, the code is simplified so that the computational cost is greatly reduced so that it's
--      comparable to the non-JIT "underch" mod (and the corresponding "mapgen_underch" package)
local optimised_flag = true

-- Tables used to partially pre-calculate the positions of single ores
-- Table in the form
--      single_ore_max_chance_table[item_name] = maximum_probability_for_any_ore_in_this_basic_stone
local single_ore_max_chance_table = {}
-- Table in the form
--      single_ore_total_chance_table[item_name] = number_of_ores_in_this_basic_stone
local single_ore_total_chance_table = {}

-- Tables used to (quickly) convert a basic stone into the Minetest ID for an ore
-- Tables in the form
--      convert_table[item_name] = list_of_minetest_content_IDs_for_ores
local blob_convert_table = {}
local scatter_convert_table = {}
-- Table used to convert Hades matrix nodes into an index, matching the index used in
--      list_of_minetest_content_IDs_for_ores
-- Tables in the form
--      matrix_id_table[matrix_id] = index
local blob_matrix_id_table = {}
local scatter_matrix_id_table = {}

-- Reduce the number of blobs per material, relative to original underch_hit code (which had fewer
--      materials). Applies only to optimised code in create_simple_blobs()
local special_blob_scarcity_factor = 10

---------------------------------
-- Customisable variables - other
---------------------------------

-- Override all pseudo-biomes with a single pseudo-biome for testing purposes
-- If set, should be an index in the range 1-62, matching one of the items in basic_stone_list
local force_biome = nil

-- Flag set to true if we should attempt the balance the number of ores in each pseudo-biome, so
--      that no pseudo-biome has more or fewer ores than another
local ore_balance_flag = true
-- Factor multiplied against each single ore's probability; set to 2 to double the number of ores
--      globally, or 0.5 to halve the number of ors globally, or any other sensible value
-- Blob and scatter ores, placed via calls to place_blob() and place_scatter(), are not affected
local ore_global_factor = 1

-- Flag set to true if the number of ores should depend on height, such that there are fewer ores
--      near the surface, and more ores at greater depths
-- Blob and scatter ores, placed via calls to place_blob() and place_scatter(), are not affected
local ore_height_adjust_flag = true
-- Flag set to true if ores at all positive heights (y=0 and higher) should have the same height
--      adjustment, meaning that ores are just as common at y=1 and y=30000. If false, the height
--      adjustment applies over the full y = -31000 to y = 31000 range. Ignored if
--      ore_height_adjust_flag is false
local ore_height_adjust_below_flag = true
-- The lowest adjustment, applied at the height at which ores are most sparse (either 31000 or 0,
--      depending on the value of the flag above). This is a factor multiplied against an ore's
--      basic probability. Ignored if ore_height_adjust_flag is false
local ore_height_adjust_min_factor = 0.1
-- The highest adjustment, applied at the height at which ores are most common (-31000). Ignored if
--      ore_height_adjust_flag is false
local ore_height_adjust_max_factor = 1.1

-- Flag set to true if calls to distribute_single_ore() are allowed to place the "alternative" ore,
--      when one is specified by the calling code. When specified, the "alternative" ore is usually
--      a rock-mineral (e.g. "unilib:mineral_cinnabar_rock", matching the stone/mineral ore
--      "stone_basalt_red_with_cinnabar")
local use_alt_ores_flag = true
-- The number of "alternative" ores placed for every for every stone/mineral ore. The rock-mineral
--      ores usually produce multiple lumps/chunks, so this value should be less than one
local alt_ore_factor = 0.2

-- Flag set to true if original ores (created in calls to add_ore() ) should use lump textures,
--      rather than the usual mineral overlay textures. The effect is somewhat cartoonish, but fun
local lump_texture_flag = false
-- Flag set to true if original ores (created in calls to add_ore() ) should be visible in the
--      creative inventory, false if not. (By default, this package generates a great number of
--      ores, so hiding them is probably beneficial)
local show_ores_in_inventory_flag = false

--------------
-- Debug flags
--------------

-- Make the basic stone types glow a little, so we can clearly see what's happening in caves
local debug_glow_flag = false

-- Before placing ores/blobs/scatters, check the node actually exists
local debug_ore_flag = false
-- Show list of basic stones that have no ores
local debug_no_ore_flag = false
-- Show a warning when the code tries to create the same ore more than once
local debug_duplicate_ore_flag = false

-- Disable single ores, blobs and/or scatters (for testing purposes)
local debug_disable_single_flag = false
local debug_disable_blob_flag = false
local debug_disable_scatter_flag = false

---------------------------------------------------------------------------------------------------
-- Notes
---------------------------------------------------------------------------------------------------

-- As in the original mod, code in this file is inadequately documented

---------------------------------------------------------------------------------------------------
-- Local functions (original to unilib)
---------------------------------------------------------------------------------------------------

local function get_seed()

    -- Original to unilib
    -- Called by create_simple_blobs() to produce a unique seed for each blob, that is consistent
    --      across sessions (because it is based on the "storage_random_seed_offset" attribute)

    base_seed = base_seed + 1
    return base_seed

end

local function balance_ores(basic_stone_count)

    -- Original to unilib
    -- If permitted, attemps to balance the number of ores placed in each pseudo-biome, by compiling
    --      the contents of ore_factor_table
    -- This process is subject to some limitations (see the comments at the top of the file)

    if not ore_balance_flag then

        -- Don't balance ores; just set the multiplication factor to 1 for all pseudo-biomes
        for item_name, _ in pairs(ore_chance_table) do
            ore_factor_table[item_name] = 1
        end

    else

        local total_chance = 0
        for _, chance in pairs (ore_chance_table) do
            total_chance = total_chance + chance
        end

        local average_chance = total_chance / basic_stone_count

        -- (Round the factor to 2 decimal places; that should reduce computation times a little)
        for item_name, chance in pairs (ore_chance_table) do
            ore_factor_table[item_name] = unilib.utils.round_up((average_chance / chance), 2)
        end

    end

end

local function illuminate_nodes()

    -- Original to unilib
    -- If the debug flag is set, make basic stone nodes glow a little

    if debug_glow_flag then

        for _, part_name in ipairs(basic_stone_list) do

            unilib.override_item("unilib:stone_" .. part_name, {
                light_source = 7,
            })

        end

    end

end

local function prepare_height_adjust()

    -- Original to unilib
    -- If permitted, prepare a height adjustment, so that ores are more common, the deeper one goes
    -- Pre-calculate the adjustment at various heights (using multiples of 100)

    if not ore_height_adjust_flag then

        -- Ores are equally common at all heights
        for i = -310, 310 do
            height_adjust_table[i] = 1
        end

    elseif ore_height_adjust_below_flag then

        -- Ores are equally (un)common above y=0, but increasinly less common below that
        for i = 0, 310 do
            height_adjust_table[i] = ore_height_adjust_min_factor
        end

        local increment = (ore_height_adjust_max_factor - ore_height_adjust_min_factor) / 310
        for i = -1, -310, -1 do

            -- (We definitely don't need more than 3 decimal places)
            height_adjust_table[i] = unilib.utils.round_up(
                ore_height_adjust_min_factor + (increment * i * -1),
                3
            )

        end

    else

        -- Ores become increasingly more common between the full range of heights from 31000 to
        --  -31000
        local increment = (ore_height_adjust_max_factor - ore_height_adjust_min_factor) / 620
        for i = 0, 621 do

            height_adjust_table[310 - i] = unilib.utils.round_up(
                ore_height_adjust_min_factor + (increment * i),
                3
            )

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (generate ores)
---------------------------------------------------------------------------------------------------

local function add_ore(data_table)

    -- Original to unilib
    -- Creates a brand new ore, using a stone and a mineral/metal
    --
    -- data_table compulsory fields:
    --      wherein (str): e.g. "stone_ordinary" (an item_name)
    --      output (str): e.g. "metal_gold_lump", "mineral_cinnabar_lump" (an item_name)
    --
    -- data_table optional fields:
    --      description (str): e.g. "Cinnabar Ore (Ordinary Stone)"
    --      metal (str): e.g. "gold"
    --      mineral (str): e.g. "mineral". Either .metal or .mineral must be specified
    --      level (int): A value in the range 1 (weak) to 3 (strong), corresponding to PFAA stone
    --          hardness values. The hardness of the new ore stone is the hardness of its mineral/
    --          metal

    local wherein = data_table.wherein
    local output = data_table.output

    local description = data_table.description or S("Ore")
    local level = data_table.level or 1
    local metal = data_table.metal or nil
    local mineral = data_table.mineral or nil

    local img = core.registered_nodes["unilib:" .. wherein].tiles[1]
    local inv_hide = nil
    if not show_ores_in_inventory_flag then
        inv_hide = 1
    end

    local item_name
    if metal ~= nil then

        item_name = wherein .. "_with_" .. metal
        -- (Checking that the lump craftitem exists is more reliable than checking
        --      unilib.global.metal_table, at least at the time of writing)
        if lump_texture_flag == true and
                core.registered_craftitems["unilib:metal_" .. metal .. "_lump"] ~= nil then
            img = img .. "^unilib_metal_" .. metal .. "_lump.png"
        else
            img = img .. "^unilib_metal_" .. metal .. ".png"
        end

    elseif mineral ~= nil then

        item_name = wherein .. "_with_" .. mineral
        -- (Checking that the lump craftitem exists is more reliable than checking
        --      unilib.global.mineral_table, at least at the time of writing)
        if lump_texture_flag == true and
                core.registered_craftitems["unilib:mineral_" .. mineral .. "_lump"] ~= nil then
            img = img .. "^unilib_mineral_" .. mineral .. "_lump.png"
        else
            img = img .. "^unilib_mineral_" .. mineral .. ".png"
        end

    else

        unilib.utils.show_warning("mapgen_hades package, add_ore(): Invalid arguments")
        return

    end

    -- Don't create the same new ore twice, e.g. the skarn ores created by the rocks mod will have
    --      the same name as some nodes created by this package
    local full_name = "unilib:" .. item_name
    if core.registered_nodes[full_name] ~= nil then

        if debug_duplicate_ore_flag then

            unilib.utils.show_warning(
                "mapgen_hades package, add_ore(): Ore already exists", full_name
            )

        end

        return

    end

    unilib.register_node(full_name, nil, mode, {
        -- Original to unilib
        description = description,
        tiles = {img},
        groups = {
            cracky = smooth_cracky_table[level],
            level = level,
            not_in_creative_inventory = inv_hide,
            ore = 1,
        },
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:" .. output .. " 2"}, rarity = 2},
                {items = {"unilib:" .. output}},
            },
        },
    })

    id_table[item_name] = core.get_content_id(full_name)

end

local function distribute_single_ore(data_table)

    -- Original to unilib
    -- Sets up an ore distribution consisting of single nodes to be placed randomly throughout a
    --      specified pseudo-biome in a call to place_single_ore()
    --
    -- data_table compulsory fields:
    --      wherein (str): e.g. "stone_ordinary" (an item_name), or "all" if the ore can be placed
    --          in any pseudo-biome
    --      ore (str): e.g. "stone_ordinary_with_mineral_cinnabar" (an item_name)
    --
    -- data_table optional fields:
    --      alt_ore (str): An "alternative" ore, e.g. "mineral_cinnabar_rock" (an item name)
    --      chance (float): Probability of placing the ore node in a pseudo-biome. A value of 1/100
    --          means that in the pseudo-biome, one out of every hundred standard stone nodes are
    --          replaced by the ore node
    --      y_max, y_min (int): Maximum/minimum y-coordinates inside which the ore can be placed

    local wherein = data_table.wherein
    local ore = data_table.ore

    local alt_ore = data_table.alt_ore or nil
    local chance = data_table.chance or 1/1000
    local y_max = data_table.y_max or unilib.constant.y_max
    local y_min = data_table.y_min or unilib.constant.y_min

    -- (Checks are required, because non-existent nodes can cause a crash)
    if (wherein ~= "all" and core.registered_nodes["unilib:" .. wherein] == nil) or
            (core.registered_nodes["unilib:" .. ore] == nil) then

        unilib.utils.show_warning(
            "mapgen_hades package, distribute_single_ore(): Unrecognised node(s)",
            "unilib:" .. wherein,
            "unilib:" .. ore
        )

        return

    end

    local distrib_table = {}

    distrib_table["ore"] = ore
    distrib_table["chance"] = chance * ore_global_factor
    distrib_table["y_min"] = y_min
    distrib_table["y_max"] = y_max

    if single_ore_table[wherein] == nil then
        single_ore_table[wherein] = {}
    end

    table.insert(single_ore_table[wherein], distrib_table)

    if ore_chance_table[wherein] == nil then
        ore_chance_table[wherein] = chance
    else
        ore_chance_table[wherein] = ore_chance_table[wherein] + chance
    end

    -- (Also add the "alternative" ore, if specified)
    if alt_ore ~= nil then

        if core.registered_nodes["unilib:" .. alt_ore] == nil then

            unilib.utils.show_warning(
                "mapgen_hades package, distribute_single_ore(): Unrecognised node(s)",
                "unilib:" .. wherein,
                "unilib:" .. alt_ore
            )

            return

        end

        local alt_distrib_table = {}

        alt_distrib_table["ore"] = alt_ore
        alt_distrib_table["chance"] = chance * ore_global_factor * alt_ore_factor
        alt_distrib_table["y_min"] = y_min
        alt_distrib_table["y_max"] = y_max

        table.insert(single_ore_table[wherein], alt_distrib_table)
        ore_chance_table[wherein] = ore_chance_table[wherein] + (chance * alt_ore_factor)

    end

    -- (Make sure that the ID table contains both ores)
    id_table[ore] = core.get_content_id("unilib:" .. ore)
    if alt_ore ~= nil then
        id_table[alt_ore] = core.get_content_id("unilib:" .. alt_ore)
    end

end

local function distribute_blob(data_table)

    -- Original to unilib
    -- Sets up an ore distribution consisting of Minetest blobs to be placed randomly throughout a
    --      specified pseudo-biome in a call to place_blob()
    --
    -- data_table compulsory fields:
    --      wherein (str): e.g. "stone_ordinary" (an item_name), or "all" if the ore can be placed
    --          in any pseudo-biome
    --      ore (str): e.g. "mineral_cinnabar_rock", "stone_ordinary_with_mineral_cinnabar"
    --          (an item_name)
    --
    -- data_table optional fields:
    --      period, period2, period3 (int): Values used in the place_blob() algorithm, which
    --          determine where each blob is placed. The original underch code used values in the
    --          range 17-19 for stone inside stone, and 18-25 for other things inside stone
    --      size (int): Value used in the place_blob() algorithm. The original underch code used
    --          values in the range 0.2-0.7 for stone inside stone, and 0.09 for other things inside
    --          stone
    --      y_max, y_min (int): Maximum/minimum y-coordinates inside which the ore can be placed

    local wherein = data_table.wherein
    local ore = data_table.ore

    local period = data_table.period or 21
    local period2 = data_table.period2 or 22
    local period3 = data_table.period3 or 23
    local size = data_table.size or 0.09
    local y_max = data_table.y_max or unilib.constant.y_max
    local y_min = data_table.y_min or unilib.constant.y_min

    -- (Checks are required, because non-existent nodes can cause a crash)
    if (wherein ~= "all" and core.registered_nodes["unilib:" .. wherein] == nil) or
            (core.registered_nodes["unilib:" .. ore] == nil) then

        unilib.utils.show_warning(
            "mapgen_hades package, distribute_blob(): Unrecognised node(s)",
            "unilib:" .. wherein,
            "unilib:" .. ore
        )

        return

    end

    local distrib_table = {}

    distrib_table["ore"] = ore
    distrib_table["period"] = period
    distrib_table["period2"] = period2
    distrib_table["period3"] = period3
    distrib_table["size"] = size
    distrib_table["y_max"] = y_max
    distrib_table["y_min"] = y_min

    if blob_table[wherein] == nil then
        blob_table[wherein] = {}
    end

    table.insert(blob_table[wherein], distrib_table)

    -- (Make sure that the ID table contains this ore)
    id_table[ore] = core.get_content_id("unilib:" .. ore)

end

local function distribute_scatter(data_table)

    -- Original to unilib
    -- Sets up an ore distribution consisting of Minetest scatters to be placed randomly throughout
    --      a specified pseudo-biome in a call to place_scatter()
    --
    -- data_table compulsory fields:
    --      wherein (str): e.g. "stone_ordinary" (an item_name), or "all" if the ore can be placed
    --          in any pseudo-biome
    --      ore (str): e.g. "mineral_cinnabar_rock", "stone_ordinary_with_mineral_cinnabar"
    --          (an item_name)
    --
    -- data_table optional fields:
    --      period, period2, period3 (int):  Values used in the place_scatter() algorithm. The
    --          original underch code used values in the range 27-37
    --      scarcity (int): Values used in the place_scatter() algorithm. The original underch code
    --          used values in the range 150-220
    --      y_max, y_min (int): Maximum/minimum y-coordinates inside which the ore can be placed

    local wherein = data_table.wherein
    local ore = data_table.ore

    local period = data_table.period or 29
    local period2 = data_table.period2 or 31
    local period3 = data_table.period3 or 33
    local scarcity = data_table.size or 150
    local y_max = data_table.y_max or unilib.constant.y_max
    local y_min = data_table.y_min or unilib.constant.y_min

    -- (Checks are required, because non-existent nodes can cause a crash)
    if (wherein ~= "all" and core.registered_nodes["unilib:" .. wherein] == nil) or
            (core.registered_nodes["unilib:" .. ore] == nil) then

        unilib.utils.show_warning(
            "mapgen_hades package, distribute_scatter(): Unrecognised node(s)",
            "unilib:" .. wherein,
            "unilib:" .. ore
        )

        return

    end

    local distrib_table = {}

    distrib_table["ore"] = ore
    distrib_table["period"] = period
    distrib_table["period2"] = period2
    distrib_table["period3"] = period3
    distrib_table["scarcity"] = scarcity
    distrib_table["y_max"] = y_max
    distrib_table["y_min"] = y_min

    if scatter_table[wherein] == nil then
        scatter_table[wherein] = {}
    end

    table.insert(scatter_table[wherein], distrib_table)

    -- (Make sure that the ID table contains this ore)
    id_table[ore] = core.get_content_id("unilib:" .. ore)

end

local function place_blob(vi, data, distrib_table, x, y, z)

    -- Adapted from unilib.jbiomes.blob() in ../lib/shared/jbiomes/jbiomes_base.lua
    -- As described above, here we assume that the values in "distrib_table" are correct

    local full_name = "unilib:" .. distrib_table.ore
    if debug_ore_flag and core.registered_nodes[full_name] == nil then

        unilib.utils.show_warning("mapgen_hades package, place_blob(): Undefined blob", full_name)
        return false

    end

    if y < distrib_table.y_min or y > distrib_table.y_max then
        return false
    end

    local xx = math.abs(x + x_off * distrib_table.period3)
    local yy = math.abs(y + y_off * distrib_table.period)
    local zz = math.abs(z + z_off * distrib_table.period2)
    local xn = math.fmod(math.floor(xx / distrib_table.period2) * 0.56432123 + x_off, 1)
    local yn = math.fmod(math.floor(yy / distrib_table.period2) * 0.23478634 + y_off, 1)
    local zn = math.fmod(math.floor(zz / distrib_table.period2) * 0.35487542 + z_off, 1)
    local xr = math.fmod(math.floor(xx / distrib_table.period3) * 0.76845311, 2) + 1
    local yr = math.fmod(math.floor(yy / distrib_table.period3) * 0.35735452, 2) + 1
    local zr = math.fmod(math.floor(zz / distrib_table.period3) * 0.75343545, 2) + 1
    local x_ = (xx % distrib_table.period) / distrib_table.period * xr - yn * zn
    local y_ = (yy % distrib_table.period) / distrib_table.period * yr - xn * zn
    local z_ = (zz % distrib_table.period) / distrib_table.period * zr - zn * yn
    local t1 = x_ * x_ + y_ * y_ + z_ * z_

    if t1 < distrib_table.size then

        data[vi] = id_table[distrib_table.ore]
        return true

    else

        return false

    end

end

local function place_scatter(vi, data, distrib_table, x, y, z)

    -- Adapted from unilib.jbiomes.scatter() in ../lib/shared/jbiomes/jbiomes_base.lua
    -- As described above, here we assume that the values in "distrib_table" are correct

    local full_name = "unilib:" .. distrib_table.ore

    if debug_ore_flag and core.registered_nodes[full_name] == nil then

        unilib.utils.show_warning(
            "mapgen_hades package, place_scatter(): Undefined scatter", full_name
        )

        return false

    end

    if y < distrib_table.y_min or y > distrib_table.y_max then
        return false
    end

    local xx = math.abs(x + x_off * distrib_table.period2)
    local yy = math.abs(y + y_off * distrib_table.period3)
    local zz = math.abs(z + z_off * distrib_table.period)

    local x_ = (xx % distrib_table.period) / distrib_table.period +
            (yy % distrib_table.period2) / distrib_table.period2 +
            (zz % distrib_table.period3) / distrib_table.period3 +
            x_off / 10
    local y_ = (yy % distrib_table.period) / distrib_table.period +
            (zz % distrib_table.period2) / distrib_table.period2 +
            (xx % distrib_table.period3) / distrib_table.period3 +
            y_off / 10
    local z_ = (zz % distrib_table.period) / distrib_table.period +
            (xx % distrib_table.period2) / distrib_table.period2 +
            (yy % distrib_table.period3) / distrib_table.period3 +
            z_off / 10

    local a = math.tan(math.atan(x_ * y_))
    local b = math.tan(math.atan(x_ * z_))
    local c = math.tan(math.atan(y_ * z_))

    local t = math.sqrt(a * b / c) + math.sqrt(a * c / b) + math.sqrt(b * c / a) -
            math.abs(x_) - math.abs(y_) - math.abs(z_)

    if math.abs(t * 1E17) > distrib_table.scarcity then

        data[vi] = id_table[distrib_table.ore]
        return true

    else

        return false

    end

end

local function populate_ore_tables()

    -- Original to unilib
    -- The PFAA documentation describes a set of ore distributions, which are represented by code
    --      in this package (in a very crude way, using just single-node ores and Minetest blobs/
    --      scatters)
    -- Each ore distribution is placed in a single pseudo-biome, represented by a single standard
    --      stone. The pseudo-biomes and their standard stones are listed below in
    --      unilib.pkg.mapgen_hades.exec()
    --
    -- N.B. This function is identical to the one in the "mapgen_hades_jit" package, but moving them
    --      to a shared package is not practical (especially considering that the two packages are
    --      mutually exclusive)

    -----------------------------------------------------------------------------------------------
    -- Misc igneous veins
    -----------------------------------------------------------------------------------------------

    -- Based on https://pfaa.fandom.com/wiki/Igneous_Veins
    -- Igneous veins are generally formed through hydrothermal (hot water) action. They can occur in
    --      any type of igneous rock, although specific ores only appear in specific rock types.
    --      Note that this page excludes special types of igneous veins, like serpentine and
    --      pegmatite.
    --
    --  Cassiterite     Granite                         5% gold, 5% scheelite
    --  Chalcopyrite    Granite                         10% gold
    --  Chromite        Diorite                         2x ocean, volcanic
    --  Cinnabar        Basalt                          Only ocean
    --  Magnetite       Granite
    --  Stibnite        Granite
    --  Alunite         Andesite, rhyolite
    --  Perlite         Peridotite, diorite, gabbro     Only volcanic
    --  Quartz          Granite
    --  Realgar         Granite                         Continental

    -- In pale andesite
    add_ore({
        wherein = "stone_andesite_pale",
        mineral = "alunite",
        output = "mineral_alunite_lump",

        description = unilib.utils.brackets(S("Alunite Ore"), S("Pale Andesite")),
        level = 2,
    })
    distribute_single_ore({
        wherein = "stone_andesite_pale",
        ore = "stone_andesite_pale_with_alunite",

        alt_ore = "mineral_alunite_rock",
        chance = 1 / 100,
    })

    -- In basalts
    for _, part_name in pairs(basalt_list) do

        local item_name = "stone_" .. part_name
        local data_table = unilib.global.stone_table[part_name]
        local wherein_description = data_table.description

        add_ore({
            wherein = item_name,
            mineral = "cinnabar",
            output = "mineral_cinnabar_lump",

            description = unilib.utils.brackets(S("Cinnabar Ore"), wherein_description),
            level = 1,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_cinnabar",

            alt_ore = "mineral_cinnabar_rock",
            chance = 1 / 100,
        })

    end

    -- In dark diorite
    add_ore({
        wherein = "stone_diorite_dark",
        mineral = "chromite",
        output = "mineral_chromite_lump",

        description = unilib.utils.brackets(S("Chromite Ore"), S("Dark Diorite")),
        level = 3,
    })
    distribute_single_ore({
        wherein = "stone_diorite_dark",
        ore = "stone_diorite_dark_with_chromite",

        alt_ore = "mineral_chromite_rock",
        chance = 1 / 100,
    })

    add_ore({
        wherein = "stone_diorite_dark",
        mineral = "perlite",
        output = "mineral_perlite_lump",

        description = unilib.utils.brackets(S("Perlite Ore"), S("Dark Diorite")),
        level = 3,
    })
    distribute_single_ore({
        wherein = "stone_diorite_dark",
        ore = "stone_diorite_dark_with_perlite",

        alt_ore = "mineral_perlite_rock",
        chance = 1 / 100,
    })

    -- In gabbros
    for _, part_name in pairs(gabbro_list) do

        local item_name = "stone_" .. part_name
        local data_table = unilib.global.stone_table[part_name]
        local wherein_description = data_table.description

        add_ore({
            wherein = item_name,
            mineral = "perlite",
            output = "mineral_perlite_lump",

            description = unilib.utils.brackets(S("Perlite Ore"), wherein_description),
            level = 3,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_perlite",

            alt_ore = "mineral_perlite_rock",
            chance = 1 / 100,
        })

    end

    -- In granites
    for _, part_name in pairs(granite_list) do

        local item_name = "stone_" .. part_name
        local data_table = unilib.global.stone_table[part_name]
        local wherein_description = data_table.description

        add_ore({
            wherein = item_name,
            mineral = "cassiterite",
            output = "mineral_cassiterite_lump",

            description = unilib.utils.brackets(S("Cassiterite Ore"), wherein_description),
            level = 3,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_cassiterite",

            alt_ore = "mineral_cassiterite_rock",
            chance = 1 / 100,
        })

        if add_native_flag then

            add_ore({
                wherein = item_name,
                mineral = "tin_native",
                output = "mineral_tin_native_lump",

                description = unilib.utils.brackets(S("Native Tin Ore"), wherein_description),
                level = 1,
            })
            distribute_single_ore({
                wherein = item_name,
                ore = item_name .. "_with_tin_native",

                alt_ore = "mineral_tin_native_rock",
                chance = 0.1 / 100,
            })

        end

        -- (Gold and scheelite can be 10% of the volume of the cassiterite, not 5% as described
        --      above. We don't want it to be too rare)
        add_ore({
            wherein = item_name,
            mineral = "gold_native",
            output = "mineral_gold_native_lump",

            description = unilib.utils.brackets(S("Native Gold Ore"), wherein_description),
            level = 3,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_gold_native",

            alt_ore = "mineral_gold_native_rock",
            chance = 0.1 / 100,
        })

        if add_native_flag then

            add_ore({
                wherein = item_name,
                mineral = "silver_native",
                output = "mineral_silver_native_lump",

                description = unilib.utils.brackets(S("Native Silver Ore"), wherein_description),
                level = 3,
            })
            distribute_single_ore({
                wherein = item_name,
                ore = item_name .. "_with_silver_native",

                alt_ore = "mineral_silver_native_rock",
                chance = 0.1 / 100,
            })

        end

        add_ore({
            wherein = item_name,
            mineral = "scheelite",
            output = "mineral_scheelite_lump",

            description = unilib.utils.brackets(S("Scheelite Ore"), wherein_description),
            level = 2,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_scheelite",

            alt_ore = "mineral_scheelite_rock",
            chance = 0.1 / 100,
        })

        add_ore({
            wherein = item_name,
            mineral = "chalcopyrite",
            output = "mineral_chalcopyrite_lump",

            description = unilib.utils.brackets(S("Chalcopyrite Ore"), wherein_description),
            level = 2,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_chalcopyrite",

            alt_ore = "mineral_chalcopyrite_rock",
            chance = 1 / 100,
        })

        add_ore({
            wherein = item_name,
            mineral = "magnetite",
            output = "mineral_magnetite_lump",

            description = unilib.utils.brackets(S("Magnetite Ore"), wherein_description),
            level = 3,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_magnetite",

            alt_ore = "mineral_magnetite_rock",
            chance = 1 / 100,
        })

        add_ore({
            wherein = item_name,
            mineral = "stibnite",
            output = "mineral_stibnite_lump",

            description = unilib.utils.brackets(S("Stibnite Ore"), wherein_description),
            level = 1,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_stibnite",

            alt_ore = "mineral_stibnite_rock",
            chance = 1 / 100,
        })

        add_ore({
            wherein = item_name,
            mineral = "quartz_brown",
            output = "mineral_quartz_brown_lump",

            description = unilib.utils.brackets(S("Brown Quartz Ore"), wherein_description),
            level = 3,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_quartz_brown",

            alt_ore = "mineral_quartz_brown_rock",
            chance = 1 / 100,
        })

        add_ore({
            wherein = item_name,
            mineral = "realgar",
            output = "mineral_realgar_lump",

            description = unilib.utils.brackets(S("Realgar Ore"), wherein_description),
            level = 1,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_realgar",

            alt_ore = "mineral_realgar_rock",
            chance = 1 / 100,
        })

        -- (Not in PFAA documentation, but a PFAA ore)
        add_ore({
            wherein = item_name,
            mineral = "fluorite",
            output = "mineral_fluorite_lump",

            description = unilib.utils.brackets(S("Fluorite Ore"), wherein_description),
            level = 1,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_fluorite",

            alt_ore = "mineral_fluorite_rock",
            chance = 1 / 100,
        })

        -- (Not in PFAA, but required for bismuth)
        if add_native_flag then

            add_ore({
                wherein = item_name,
                mineral = "bismuth_native",
                output = "mineral_bismuth_native_lump",

                description = unilib.utils.brackets(S("Native Bismuth Ore"), wherein_description),
                level = 1,
            })
            distribute_single_ore({
                wherein = item_name,
                ore = item_name .. "_with_bismuth_native",

                alt_ore = "mineral_bismuth_native_rock",
                chance = 0.1 / 100,
            })

        end

    end

    -- In pale peridotite
    add_ore({
        wherein = "stone_peridotite_pale",
        mineral = "perlite",
        output = "mineral_perlite_lump",

        description = unilib.utils.brackets(S("Perlite Ore"), S("Pale Peridotite")),
        level = 3,
    })
    distribute_single_ore({
        wherein = "stone_peridotite_pale",
        ore = "stone_peridotite_pale_with_perlite",

        alt_ore = "mineral_perlite_rock",
        chance = 1 / 100,
    })

    -- In pale rhyolite
    add_ore({
        wherein = "stone_rhyolite_pale",
        mineral = "alunite",
        output = "mineral_alunite_lump",

        description = unilib.utils.brackets(S("Alunite Ore"), S("Pale Rhyolite")),
        level = 2,
    })
    distribute_single_ore({
        wherein = "stone_rhyolite_pale",
        ore = "stone_rhyolite_pale_with_alunite",

        alt_ore = "mineral_alunite_rock",
        chance = 1 / 100,
    })

    -----------------------------------------------------------------------------------------------
    -- Misc sedimentary beds
    -----------------------------------------------------------------------------------------------

    -- Based on https://pfaa.fandom.com/wiki/Sedimentary_Bed
    -- Sedimentary rocks and ores formed through the transformation of sediment that accumulated at
    --      the bottom of ancient seas, lakes, and rivers. Occassionally, the sedimentation process
    --      served to separate and concentrate specific minerals, hence generating economically
    --      exploitable deposits. A sedimentary deposit is typically formed as a localized layer, or
    --      stratum, or bed, in the upper crust. We list the ores/minerals and location for each
    --      deposit in Geologica below. These deposits are typically quite large; establishing
    --      mining infrastructure is encouraged.
    --
    --  Coal            Ocean, inland                   2x swamp
    --  Pyrolusite      Swamp
    --  Diatomite       Volcanic, desert
    --  Glauconite      Ocean                           20% sandstone
    --  Apatite         Any                             Metamorphic depth
    --  Zeolite         Volcanic
    --  Fuller's Earth  Desert
    --  Kaolinite       Tropics

    for part_name, data_table in pairs(unilib.global.stone_table) do

        if not data_table.no_smooth_flag and data_table.category == "sedimentary" then

            local item_name = "stone_" .. part_name
            local wherein_description = data_table.description

            add_ore({
                wherein = item_name,
                mineral = "anthracite",
                output = "mineral_anthracite_lump",

                description = unilib.utils.brackets(S("Anthracite Ore"), wherein_description),
                level = 3,
            })
            distribute_single_ore({
                wherein = item_name,
                ore = item_name .. "_with_anthracite",

                alt_ore = "mineral_anthracite_rock",
                chance = 1 / 100,
            })

            add_ore({
                wherein = item_name,
                mineral = "coal_bituminous",
                output = "mineral_coal_bituminous_lump",

                description = unilib.utils.brackets(S("Bituminous Coal Ore"), wherein_description),
                level = 1,
            })
            distribute_single_ore({
                wherein = item_name,
                ore = item_name .. "_with_coal_bituminous",

                alt_ore = "mineral_coal_bituminous_rock",
                chance = 1 / 100,
            })

            add_ore({
                wherein = item_name,
                mineral = "lignite",
                output = "mineral_lignite_lump",

                description = unilib.utils.brackets(S("Lignite Ore"), wherein_description),
                level = 1,
            })
            distribute_single_ore({
                wherein = item_name,
                ore = item_name .. "_with_lignite",

                alt_ore = "mineral_lignite_rock",
                chance = 1 / 100,
            })

            add_ore({
                wherein = item_name,
                mineral = "coke_natural",
                output = "mineral_coke_natural_lump",

                description = unilib.utils.brackets(S("Natural Coke Ore"), wherein_description),
                level = 3,
            })
            distribute_single_ore({
                wherein = item_name,
                ore = item_name .. "_with_coke_natural",

                alt_ore = "mineral_coke_natural_rock",
                chance = 1 / 100,
            })

            distribute_single_ore({
                wherein = item_name,
                ore = "dirt_peat_with_oil_crude",

                chance = 1 / 100,
            })

            distribute_single_ore({
                wherein = item_name,
                ore = "dirt_peat_with_shale",

                chance = 1 / 100,
            })

            distribute_single_ore({
                wherein = item_name,
                ore = "sand_ordinary_with_oil_crude",

                chance = 1 / 100,
            })

            add_ore({
                wherein = item_name,
                mineral = "pyrolusite",
                output = "mineral_pyrolusite_lump",

                description = unilib.utils.brackets(S("Pyrolusite Ore"), wherein_description),
                level = 1,
            })
            distribute_single_ore({
                wherein = item_name,
                ore = item_name .. "_with_pyrolusite",

                alt_ore = "mineral_pyrolusite_rock",
                chance = 1 / 100,
            })

            add_ore({
                wherein = item_name,
                mineral = "apatite",
                output = "mineral_apatite_lump",

                description = unilib.utils.brackets(S("Apatite Ore"), wherein_description),
                level = 3,
            })
            distribute_single_ore({
                wherein = item_name,
                ore = item_name .. "_with_apatite",

                alt_ore = "mineral_apatite_rock",
                chance = 1 / 100,
            })

            distribute_single_ore({
                wherein = item_name,
                ore = "sand_diatomite",

                chance = 1 / 100,
            })

            -- (20% sandstone, as decribed above)
            distribute_single_ore({
                wherein = item_name,
                ore = "sand_glauconite",

                chance = 0.8 / 100,
            })

            distribute_single_ore({
                wherein = item_name,
                ore = "stone_sandstone_ordinary",

                chance = 0.2 / 100,
            })

            -- (On this occasion, do use the mineral-rock variant, not the mineral-ore variant)
            distribute_single_ore({
                wherein = item_name,
                ore = "mineral_zeolite_rock",

                chance = 1 / 100,
            })

            distribute_single_ore({
                wherein = item_name,
                ore = "clay_attapulgite",

                chance = 1 / 100,
            })

            distribute_single_ore({
                wherein = item_name,
                ore = "clay_kaolinite",

                chance = 1 / 100,
            })

            -- (The following are not mentioned by PFAA documentation, but this is as good a place
            --      as any to add them)
            distribute_single_ore({
                wherein = item_name,
                ore = "sand_quartz",

                chance = 1 / 100,
            })

            distribute_single_ore({
                wherein = item_name,
                ore = "sand_sulphur",

                chance = 1 / 100,
            })

            -- (Not in PFAA, but required for platinum)
            if add_native_flag then

                add_ore({
                    wherein = item_name,
                    mineral = "platinum_native",
                    output = "mineral_platinum_native_lump",

                    description =
                            unilib.utils.brackets(S("Native Platinum Ore"), wherein_description),
                    level = 3,
                })
                distribute_single_ore({
                    wherein = item_name,
                    ore = item_name .. "_with_platinum_native",

                    alt_ore = "mineral_platinum_native_rock",
                    chance = 0.1 / 100,
                })

            end

        end

    end

    -----------------------------------------------------------------------------------------------
    -- Serpentinite
    -----------------------------------------------------------------------------------------------

    -- Based on https://pfaa.fandom.com/wiki/Serpentine
    -- Serpentine is a class of rock forming minerals resulting from hydrothermal metamorphosis of
    --      ultra-mafic rock. In Geologica, these formations consist of serpentinite (an aggregate
    --      of serpentine minerals), intermixed with specific ore and mineral blocks at specific
    --      frequencies, representing the mineral heterogeneity found in economic deposits.
    --      Serpentine deposits occur in all domains, and are twice as frequent in volcanic regions
    --      and the ocean. Below, we list each type of ore/mineral, along with its frequency. The
    --      remaining composition is general serpentinite, as well as some peridotite that has been
    --      spared from metamorphosis.
    --
    --  Ore/Mineral         Frequency
    --  Soapstone (talc)    10%     [in unilib code, implemented as steatite]
    --  Magnesite           1%
    --  Chrysotile          0.9%
    --  Pentlandite         0.5%

    -- In serpentinites
    for _, part_name in pairs(serpentinite_list) do

        local item_name = "stone_" .. part_name
        local data_table = unilib.global.stone_table[part_name]
        local wherein_description = data_table.description

        add_ore({
            wherein = item_name,
            mineral = "steatite",
            output = "mineral_steatite_lump",

            description = unilib.utils.brackets(S("Steatite Ore"), wherein_description),
            level = 1,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_steatite",

            alt_ore = "mineral_steatite_rock",
            chance = 10 / 100,
        })

        add_ore({
            wherein = item_name,
            mineral = "magnesite",
            output = "mineral_magnesite_lump",

            description = unilib.utils.brackets(S("Magnesite Ore"), wherein_description),
            level = 2,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_magnesite",

            alt_ore = "mineral_magnesite_rock",
            chance = 1 / 100,
        })

        add_ore({
            wherein = item_name,
            mineral = "chrysotile",
            output = "mineral_chrysotile_lump",

            description = unilib.utils.brackets(S("Chrysotile Ore"), wherein_description),
            level = 1,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_chrysotile",

            alt_ore = "mineral_chrysotile_rock",
            chance = 0.9 / 100,
        })

        add_ore({
            wherein = item_name,
            mineral = "pentlandite",
            output = "mineral_pentlandite_lump",

            description = unilib.utils.brackets(S("Pentlandite Ore"), wherein_description),
            level = 2,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_pentlandite",

            alt_ore = "mineral_pentlandite_rock",
            chance = 0.5 / 100,
        })

        -- Pale peridotite stone as ore
        distribute_single_ore({
            wherein = item_name,
            ore = "stone_peridotite_pale",

            chance = 1 / 100,
        })

    end

    -----------------------------------------------------------------------------------------------
    -- Marine evaporite
    -----------------------------------------------------------------------------------------------

    -- Based on https://pfaa.fandom.com/wiki/Marine_Evaporite
    -- When ancient seas dried up, they deposited their mineral contents as sedimentary deposits.
    --      Geologica restricts the occurrence of these to plains, deserts and wastelands. There are
    --      three layers in every deposit. From bottom up, these are: limestone, gypsum and rock
    --      salt (see pictures below). The limestone formed the original sea floor, and the gypsum
    --      and rock salt crystallized on top of it. About 5% of the gypsum is concentrated
    --      celestine.

    -- In limestones
    -- The description above is implemented as large deposits of gypsum/rock salt in limestone,
    --      with smaller deposits of celestine
    for _, part_name in pairs(limestone_list) do

        local item_name = "stone_" .. part_name
        local data_table = unilib.global.stone_table[part_name]
        local wherein_description = data_table.description

        add_ore({
            wherein = item_name,
            mineral = "gypsum",
            output = "mineral_gypsum_lump",

            description = unilib.utils.brackets(S("Gypsum Ore"), wherein_description),
            level = 1,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_gypsum",

            alt_ore = "mineral_gypsum_rock",
            chance = 5 / 100,
        })

        add_ore({
            wherein = item_name,
            mineral = "halite",
            output = "mineral_halite_lump",

            description = unilib.utils.brackets(S("Halite Ore"), wherein_description),
            level = 1,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_halite",

            alt_ore = "mineral_halite_rock",
            chance = 10 / 100,
        })

        add_ore({
            wherein = item_name,
            mineral = "celestine",
            output = "mineral_celestine_lump",

            description = unilib.utils.brackets(S("Celestine Ore"), wherein_description),
            level = 3,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_celestine",

            alt_ore = "mineral_celestine_rock",
            chance = 0.25 / 100,
        })

    end

    -----------------------------------------------------------------------------------------------
    -- Lake evaporite
    -----------------------------------------------------------------------------------------------

    -- Based on https://pfaa.fandom.com/wiki/Lake_Evaporite
    -- Seasonal lakes fill during the wet season, and dry up during the dry season. Each time the
    --      water dries up, the minerals it has carried from afar are deposited at the bottom of the
    --      lake. Over the centuries, this cycle accumulates significant mineral deposits on the
    --      lake bed. Geologica assumes that the lakes have since completely disappeared in deserts
    --      and wastelands, where the evaporite deposits persist, ready for exploitation. Like
    --      marine evaporites, lake evaporite deposits generally consist of gypsum and rock salt, as
    --      well as some minerals specific to lake evaporites: trona, mirabilite and borax, which
    --      occur in these proportions:
    --
    --  Mineral             Percent
    --  Trona (soda ash)    70%
    --  Mirabilite          15%
    --  Borax               15%

    -- Sedimentary rocks in general already have a lot of ores, so this is implemented as deposits
    --      in sandstones
    for _, part_name in pairs(sandstone_list) do

        local item_name = "stone_" .. part_name
        local data_table = unilib.global.stone_table[part_name]
        local wherein_description = data_table.description

        add_ore({
            wherein = item_name,
            mineral = "gypsum",
            output = "mineral_gypsum_lump",

            description = unilib.utils.brackets(S("Gypsum Ore"), wherein_description),
            level = 1,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_gypsum",

            chance = 5 / 100,
            alt_ore = "mineral_gypsum_rock",
        })

        distribute_single_ore({
            wherein = item_name,
            ore = "mineral_salt_block",

            chance = 4 / 100,
        })

        distribute_single_ore({
            wherein = item_name,
            ore = "mineral_salt_pure_block",

            chance = 1 / 100,
        })

        add_ore({
            wherein = item_name,
            mineral = "trona",
            output = "mineral_trona_lump",

            description = unilib.utils.brackets(S("Trona Ore"), wherein_description),
            level = 1,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_trona",

            alt_ore = "mineral_trona_rock",
            chance = 0.7 / 100,
        })

        add_ore({
            wherein = item_name,
            mineral = "mirabilite",
            output = "mineral_mirabilite_lump",

            description = unilib.utils.brackets(S("Mirabilite Ore"), wherein_description),
            level = 1,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_mirabilite",

            alt_ore = "mineral_mirabilite_rock",
            chance = 0.15 / 100,
        })

        add_ore({
            wherein = item_name,
            mineral = "borax",
            output = "mineral_borax_lump",

            description = unilib.utils.brackets(S("Borax Ore"), wherein_description),
            level = 1,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_borax",

            alt_ore = "mineral_borax_rock",
            chance = 0.15 / 100,
        })

    end

    -----------------------------------------------------------------------------------------------
    -- Pegmatite
    -----------------------------------------------------------------------------------------------

    -- Based on https://pfaa.fandom.com/wiki/Pegmatite
    -- Pegmatites are highly crystallized veins in granite. Their overall chemical composition is
    --      essentially equivalent to the surrounding granite, but they are enriched for many
    --      valuable minerals, sometimes in gem quality. Geologica generates pegmatites fairly deep
    --      underground whereever there is granite, and pegmatites are found twice as frequently in
    --      felsic volcanic domains (e.g., Extreme Hills). The majority of a pegmatite vein consists
    --      of generalized pegmatite stone. The remaining mineral/ore distribution is as follows:
    --
    --  Ore/Mineral         Percent
    --  Spodumene           7%
    --  Muscovite (mica)    7%
    --  Kyanite             5%
    --  Lepidolite          2.5%
    --  Tantalite           2%
    --  Cassiterite         1.5%
    --  Wolframite          1%
    --  Pollucite           0.1%

    -- In pale pegmatite
    add_ore({
        wherein = "stone_pegmatite_white",
        mineral = "spodumene",
        output = "mineral_spodumene_lump",

        description = unilib.utils.brackets(S("Spodumene Ore"), S("Pale Pegmatite")),
        level = 3,
    })
    distribute_single_ore({
        wherein = "stone_pegmatite_white",
        ore = "stone_pegmatite_white_with_spodumene",

        alt_ore = "mineral_spodumene_rock",
        chance = 7 / 100,
    })

    add_ore({
        wherein = "stone_pegmatite_white",
        mineral = "mica",
        output = "mineral_mica_lump",

        description = unilib.utils.brackets(S("Mica Ore"), S("Pale Pegmatite")),
        level = 1,
    })
    distribute_single_ore({
        wherein = "stone_pegmatite_white",
        ore = "stone_pegmatite_white_with_mica",

        alt_ore = "mineral_mica_rock",
        chance = 7 / 100,
    })

    add_ore({
        wherein = "stone_pegmatite_white",
        mineral = "kyanite",
        output = "mineral_kyanite_lump",

        description = unilib.utils.brackets(S("Kyanite Ore"), S("Pale Pegmatite")),
        level = 3,
    })
    distribute_single_ore({
        wherein = "stone_pegmatite_white",
        ore = "stone_pegmatite_white_with_kyanite",

        alt_ore = "mineral_kyanite_rock",
        chance = 5 / 100,
    })

    add_ore({
        wherein = "stone_pegmatite_white",
        mineral = "lepidolite",
        output = "mineral_lepidolite_lump",

        description = unilib.utils.brackets(S("Lepidolite Ore"), S("Pale Pegmatite")),
        level = 2,
    })
    distribute_single_ore({
        wherein = "stone_pegmatite_white",
        ore = "stone_pegmatite_white_with_lepidolite",

        alt_ore = "mineral_lepidolite_rock",
        chance = 2.5 / 100,
    })

    add_ore({
        wherein = "stone_pegmatite_white",
        mineral = "tantalite",
        output = "mineral_tantalite_lump",

        description = unilib.utils.brackets(S("Tantalite Ore"), S("Pale Pegmatite")),
        level = 3,
    })
    distribute_single_ore({
        wherein = "stone_pegmatite_white",
        ore = "stone_pegmatite_white_with_tantalite",

        alt_ore = "mineral_tantalite_rock",
        chance = 2 / 100,
    })

    add_ore({
        wherein = "stone_pegmatite_white",
        mineral = "cassiterite",
        output = "mineral_cassiterite_lump",

        description = unilib.utils.brackets(S("Cassiterite Ore"), S("Pale Pegmatite")),
        level = 3,
    })
    distribute_single_ore({
        wherein = "stone_pegmatite_white",
        ore = "stone_pegmatite_white_with_cassiterite",

        alt_ore = "mineral_cassiterite_rock",
        chance = 1.5 / 100,
    })

    add_ore({
        wherein = "stone_pegmatite_white",
        mineral = "wolframite",
        output = "mineral_wolframite_lump",

        description = unilib.utils.brackets(S("Wolframite Ore"), S("Pale Pegmatite")),
        level = 2,
    })
    distribute_single_ore({
        wherein = "stone_pegmatite_white",
        ore = "stone_pegmatite_white_with_wolframite",

        alt_ore = "mineral_wolframite_rock",
        chance = 1 / 100,
    })

    add_ore({
        wherein = "stone_pegmatite_white",
        mineral = "pollucite",
        output = "mineral_pollucite_lump",

        description = unilib.utils.brackets(S("Pollucite Ore"), S("Pale Pegmatite")),
        level = 3,
    })
    distribute_single_ore({
        wherein = "stone_pegmatite_white",
        ore = "stone_pegmatite_white_with_pollucite",

        chance = 0.1 / 100,
        alt_ore = "mineral_pollucite_rock",
    })

    -----------------------------------------------------------------------------------------------
    -- Carbonatite
    -----------------------------------------------------------------------------------------------

    -- Based on https://pfaa.fandom.com/wiki/Carbonatite
    -- Consisting largely of carbonate minerals, carbonatite is essentially an igneous limestone.
    --      They form short, vertical veins (volcanic plugs) in igneous rock. Like pegmatites,
    --      carbonatite veins are enriched for valuable minerals, in particular rare earths and
    --      niobium minerals. Besides carbonatite itself, the veins have the following composition:
    --
    --  Ore/Mineral     Percent
    --  Bastnasite      5%
    --  Apatite         5%
    --  Vermiculite     4%
    --  Chalcopyrite    2.5%
    --  Barite          2.5%

    -- In carbonatite
    add_ore({
        wherein = "stone_carbonatite",
        mineral = "bastnasite",
        output = "mineral_bastnasite_lump",

        description = unilib.utils.brackets(S("Bastnasite Ore"), S("Carbonatite")),
        level = 2,
    })
    distribute_single_ore({
        wherein = "stone_carbonatite",
        ore = "stone_carbonatite_with_bastnasite",

        alt_ore = "mineral_bastnasite_rock",
        chance = 5 / 100,
    })

    add_ore({
        wherein = "stone_carbonatite",
        mineral = "apatite",
        output = "mineral_apatite_lump",

        description = unilib.utils.brackets(S("Apatite Ore"), S("Carbonatite")),
        level = 3,
    })
    distribute_single_ore({
        wherein = "stone_carbonatite",
        ore = "stone_carbonatite_with_apatite",

        alt_ore = "mineral_apatite_rock",
        chance = 5 / 100,
    })

    distribute_single_ore({
        wherein = "stone_carbonatite",
        ore = "clay_vermiculite",

        chance = 4 / 100,
    })

    add_ore({
        wherein = "stone_carbonatite",
        mineral = "chalcopyrite",
        output = "mineral_chalcopyrite_lump",

        description = unilib.utils.brackets(S("Chalcopyrite Ore"), S("Carbonatite")),
        level = 2,
    })
    distribute_single_ore({
        wherein = "stone_carbonatite",
        ore = "stone_carbonatite_with_chalcopyrite",

        alt_ore = "mineral_chalcopyrite_rock",
        chance = 2.5 / 100,
    })

    add_ore({
        wherein = "stone_carbonatite",
        mineral = "barite",
        output = "mineral_barite_lump",

        description = unilib.utils.brackets(S("Barite Ore"), S("Carbonatite")),
        level = 2,
    })
    distribute_single_ore({
        wherein = "stone_carbonatite",
        ore = "stone_carbonatite_with_barite",

        alt_ore = "mineral_barite_rock",
        chance = 2.5 / 100,
    })

    -----------------------------------------------------------------------------------------------
    -- Uraninite
    -----------------------------------------------------------------------------------------------

    -- Based on https://pfaa.fandom.com/wiki/Uraninite_Deposit
    -- Geologica generates uraninite in several unique deposit types, in addition to the appearance
    --      of uraninite in carbonatite deposits. The most significant deposits are called
    --      "unconformities", because they do not conform with the pattern of the surrounding
    --      strata. These are usually hosted by sandstone (sometimes in combination with slate), and
    --      less often conglomerate. Uraninite may also be found as veins in the continental crust.

    -- In carbonatite
    add_ore({
        wherein = "stone_carbonatite",
        mineral = "uraninite",
        output = "mineral_uraninite_lump",

        description = unilib.utils.brackets(S("Uraninite Ore"), S("Carbonatite")),
        level = 3,
    })
    distribute_single_ore({
        wherein = "stone_carbonatite",
        ore = "stone_carbonatite_with_uraninite",

        alt_ore = "mineral_uraninite_rock",
        chance = 1 / 100,
    })

    -- In sandstones
    for _, part_name in pairs(sandstone_list) do

        local item_name = "stone_" .. part_name
        local data_table = unilib.global.stone_table[part_name]
        local wherein_description = data_table.description

        add_ore({
            wherein = item_name,
            mineral = "uraninite",
            output = "mineral_uraninite_lump",

            description = unilib.utils.brackets(S("Uraninite Ore"), wherein_description),
            level = 3,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_uraninite",

            alt_ore = "mineral_uraninite_rock",
            chance = 1 / 100,
        })

    end

    -- In slates
    for _, part_name in pairs(slate_list) do

        local item_name = "stone_" .. part_name
        local data_table = unilib.global.stone_table[part_name]
        local wherein_description = data_table.description

        add_ore({
            wherein = item_name,
            mineral = "uraninite",
            output = "mineral_uraninite_lump",

            description = unilib.utils.brackets(S("Uraninite Ore"), wherein_description),
            level = 3,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_uraninite",

            alt_ore = "mineral_uraninite_rock",
            chance = 0.5 / 100,
        })

    end

    -- In rough conglomerate
    add_ore({
        wherein = "stone_conglomerate_rough",
        mineral = "uraninite",
        output = "mineral_uraninite_lump",

        description = unilib.utils.brackets(S("Uraninite Ore"), S("Rough Conglomerate")),
        level = 3,
    })
    distribute_single_ore({
        wherein = "stone_conglomerate_rough",
        ore = "stone_conglomerate_rough_with_uraninite",

        alt_ore = "mineral_uraninite_rock",
        chance = 0.2 / 100,
    })

    -----------------------------------------------------------------------------------------------
    -- SEDEX
    -----------------------------------------------------------------------------------------------

    -- Based on https://pfaa.fandom.com/wiki/SEDEX
    -- SEDEX stands for SEDimentary EXhalative. As the name suggests, these deposits form by
    --      minerals being exhaled (through igneous action) from the crust and then concentrated in
    --      the same manner as other sedimentary deposits. This process usually occurs in the ocean,
    --      and due to the dynamics of geology, SEDEX deposits can be found in the continents, as
    --      well. Geologica generates them everywhere, except for volcanic domains. Due to the
    --      solubility of sulphur compounds in magma, these deposits are enriched for sulphur-
    --      containing minerals, especially sphalerite, galena and barite, but also chalcopyrite.
    --      The tungstate mineral scheelite is also found in economic concentrations.
    --
    -- Chalcopyrite, sphalerite, galena, scheelite, barite

    for part_name, data_table in pairs(unilib.global.stone_table) do

        if not data_table.no_smooth_flag and
                (data_table.category == "intrusive" or data_table.category == "extrusive") then

            local item_name = "stone_" .. part_name
            local wherein_description = data_table.description

            add_ore({
                wherein = item_name,
                mineral = "chalcopyrite",
                output = "mineral_chalcopyrite_lump",

                description = unilib.utils.brackets(S("Chalcopyrite Ore"), wherein_description),
                level = 2,
            })
            distribute_single_ore({
                wherein = item_name,
                ore = item_name .. "_with_chalcopyrite",

                alt_ore = "mineral_chalcopyrite_rock",
                chance = 1 / 100,
            })

            add_ore({
                wherein = item_name,
                mineral = "sphalerite",
                output = "mineral_sphalerite_lump",

                description = unilib.utils.brackets(S("Sphalerite Ore"), wherein_description),
                level = 2,
            })
            distribute_single_ore({
                wherein = item_name,
                ore = item_name .. "_with_sphalerite",

                alt_ore = "mineral_sphalerite_rock",
                chance = 1 / 100,
            })

            add_ore({
                wherein = item_name,
                mineral = "galena",
                output = "mineral_galena_lump",

                description = unilib.utils.brackets(S("Galena Ore"), wherein_description),
                level = 1,
            })
            distribute_single_ore({
                wherein = item_name,
                ore = item_name .. "_with_galena",

                alt_ore = "mineral_galena_rock",
                chance = 1 / 100,
            })

            add_ore({
                wherein = item_name,
                mineral = "scheelite",
                output = "mineral_scheelite_lump",

                description = unilib.utils.brackets(S("Scheelite Ore"), wherein_description),
                level = 2,
            })
            distribute_single_ore({
                wherein = item_name,
                ore = item_name .. "_with_scheelite",

                alt_ore = "mineral_scheelite_rock",
                chance = 1 / 100,
            })

            add_ore({
                wherein = item_name,
                mineral = "barite",
                output = "mineral_barite_lump",

                description = unilib.utils.brackets(S("Barite Ore"), wherein_description),
                level = 2,
            })
            distribute_single_ore({
                wherein = item_name,
                ore = item_name .. "_with_barite",

                alt_ore = "mineral_barite_rock",
                chance = 1 / 100,
            })

        end

    end

    -----------------------------------------------------------------------------------------------
    -- Skarn
    -----------------------------------------------------------------------------------------------

    -- Based on https://pfaa.fandom.com/wiki/Skarn_Deposit
    -- Skarns are the result of contact metamorphosis of carbonate rock, such as limestone and
    --      dolostone. Skarns consist of skarn stone, other metamorphic carbonate rocks (marble and
    --      hornfels), as well as unchanged limestone. Geologica generates skarns anywhere outside
    --      of volcanic regions. Some skarn deposits are enriched for a particular ore or mineral.
    --      These include: sphalerite/galena, magnesite/vermiculite, magnetite, chalcopyrite/
    --      malachite, scheelite and wollastonite. There is also a chance of isolated lapis
    --      crystals.
    --
    --  Sphalerite galena, 50/50 magnesite vermiculite, magnetite, chalcopyrite (30% malachite),
    --      wollastonite, scheelite, lapis

    local skarn_list = {
        "dolostone_dark",
        "hornfels",
        "limestone_red",
        "marble_silver",
        "skarn",
    }

    for _, part_name in pairs(skarn_list) do

        local item_name = "stone_" .. part_name
        local data_table = unilib.global.stone_table[part_name]
        local wherein_description = data_table.description

        -- Everything is twice as common in actual skarn
        local factor = 1
        if part_name == "skarn" then
            factor = 2
        end

        add_ore({
            wherein = item_name,
            mineral = "sphalerite",
            output = "mineral_sphalerite_lump",

            description = unilib.utils.brackets(S("Sphalerite Ore"), wherein_description),
            level = 2,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_sphalerite",

            alt_ore = "mineral_sphalerite_rock",
            chance = (factor * 0.5) / 200,
        })

        add_ore({
            wherein = item_name,
            mineral = "galena",
            output = "mineral_galena_lump",

            description = unilib.utils.brackets(S("Galena Ore"), wherein_description),
            level = 1,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_galena",

            alt_ore = "mineral_galena_rock",
            chance = (factor * 0.5) / 200,
        })

        add_ore({
            wherein = item_name,
            mineral = "magnesite",
            output = "mineral_magnesite_lump",

            description = unilib.utils.brackets(S("Magnesite Ore"), wherein_description),
            level = 2,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_magnesite",

            alt_ore = "mineral_magnesite_rock",
            chance = (factor * 0.5) / 200,
        })

        distribute_single_ore({
            wherein = item_name,
            ore = "clay_vermiculite",

            chance = (factor * 0.5) / 200,
        })

        add_ore({
            wherein = item_name,
            mineral = "magnetite",
            output = "mineral_magnetite_lump",

            description = unilib.utils.brackets(S("Magnetite Ore"), wherein_description),
            level = 3,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_magnetite",

            alt_ore = "mineral_magnetite_rock",
            chance = (factor * 1) / 200,
        })

        add_ore({
            wherein = item_name,
            mineral = "chalcopyrite",
            output = "mineral_chalcopyrite_lump",

            description = unilib.utils.brackets(S("Chalcopyrite Ore"), wherein_description),
            level = 2,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_chalcopyrite",

            alt_ore = "mineral_chalcopyrite_rock",
            chance = (factor * 0.7) / 200,
        })

        add_ore({
            wherein = item_name,
            mineral = "malachite",
            output = "mineral_malachite_lump",

            description = unilib.utils.brackets(S("Malachite Ore"), wherein_description),
            level = 2,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_malachite",

            alt_ore = "mineral_malachite_rock",
            chance = (factor * 0.3) / 200,
        })

        add_ore({
            wherein = item_name,
            mineral = "wollastonite",
            output = "mineral_wollastonite_lump",

            description = unilib.utils.brackets(S("Wollastonite Ore"), wherein_description),
            level = 2,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_wollastonite",

            alt_ore = "mineral_wollastonite_rock",
            chance = (factor * 1) / 200,
        })

        add_ore({
            wherein = item_name,
            mineral = "scheelite",
            output = "mineral_scheelite_lump",

            description = unilib.utils.brackets(S("Scheelite Ore"), wherein_description),
            level = 2,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_scheelite",

            alt_ore = "mineral_scheelite_rock",
            chance = (factor * 1) / 200,
        })

        -- (The documentation above suggests that lapis lazuli is quite rare)
        add_ore({
            wherein = item_name,
            mineral = "lapis_lazuli",
            output = "mineral_lapis_lazuli_lump",

            description = unilib.utils.brackets(S("Lapis Lazuli Ore"), wherein_description),
            level = 2,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_lapis_lazuli",

            chance = (factor * 0.01) / 200,
        })

    end

    -----------------------------------------------------------------------------------------------
    -- Carbonate
    -----------------------------------------------------------------------------------------------

    -- From https://pfaa.fandom.com/wiki/Carbonate
    -- Carbonate rocks often host economic ore deposits. The host rock is either limestone or
    --      dolostone (consisting of dolomite). Geologica generates these anywhere outside of
    --      volcanic regions. Limestone hosts combined sphalerite/galena/barite veins, while
    --      dolostone hosts calcium and magnesium minerals like magnesite, soapstone, and
    --      wollastonite.
    --
    -- Magnesite, soapstone [implemented as steatite], wollastonite, sphalerite/galena/barite

    -- In limestones
    for _, part_name in pairs(limestone_list) do

        local item_name = "stone_" .. part_name
        local data_table = unilib.global.stone_table[part_name]
        local wherein_description = data_table.description

        add_ore({
            wherein = item_name,
            mineral = "sphalerite",
            output = "mineral_sphalerite_lump",

            description = unilib.utils.brackets(S("Sphalerite Ore"), wherein_description),
            level = 2,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_sphalerite",

            alt_ore = "mineral_sphalerite_rock",
            chance = 0.33 / 100,
        })

        add_ore({
            wherein = item_name,
            mineral = "galena",
            output = "mineral_galena_lump",

            description = unilib.utils.brackets(S("Galena Ore"), wherein_description),
            level = 1,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_galena",

            alt_ore = "mineral_galena_rock",
            chance = 0.33 / 100,
        })

        add_ore({
            wherein = item_name,
            mineral = "barite",
            output = "mineral_barite_lump",

            description = unilib.utils.brackets(S("Barite Ore"), wherein_description),
            level = 2,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_barite",

            alt_ore = "mineral_barite_rock",
            chance = 0.33 / 100,
        })

    end

    -- In dark dolostone
    add_ore({
        wherein = "stone_dolostone_dark",
        mineral = "dolomite",
        output = "mineral_dolomite_lump",

        description = unilib.utils.brackets(S("Dolomite Ore"), ("Dark Dolostone")),
        level = 1,
    })
    distribute_single_ore({
        wherein = "stone_dolostone_dark",
        ore = "stone_dolostone_dark_with_dolomite",

        alt_ore = "mineral_dolomite_rock",
        chance = 5 / 100,
    })

    add_ore({
        wherein = "stone_dolostone_dark",
        mineral = "magnesite",
        output = "mineral_magnesite_lump",

        description = unilib.utils.brackets(S("Magnesite Ore"), ("Dark Dolostone")),
        level = 2,
    })
    distribute_single_ore({
        wherein = "stone_dolostone_dark",
        ore = "stone_dolostone_dark_with_magnesite",

        alt_ore = "mineral_magnesite_rock",
        chance = 0.33 / 100,
    })

    add_ore({
        wherein = "stone_dolostone_dark",
        mineral = "steatite",
        output = "mineral_steatite_lump",

        description = unilib.utils.brackets(S("Steatite Ore"), ("Dark Dolostone")),
        level = 1,
    })
    distribute_single_ore({
        wherein = "stone_dolostone_dark",
        ore = "stone_dolostone_dark_with_steatite",

        alt_ore = "mineral_steatite_rock",
        chance = 0.33 / 100,
    })

    add_ore({
        wherein = "stone_dolostone_dark",
        mineral = "wollastonite",
        output = "mineral_wollastonite_lump",

        description = unilib.utils.brackets(S("Wollastonite Ore"), S("Dark Dolostone")),
        level = 2,
    })
    distribute_single_ore({
        wherein = "stone_dolostone_dark",
        ore = "stone_dolostone_dark_with_wollastonite",

        alt_ore = "mineral_wollastonite_rock",
        chance = 0.33 / 100,
    })

    -----------------------------------------------------------------------------------------------
    -- Layered intrusion
    -----------------------------------------------------------------------------------------------

    -- From https://pfaa.fandom.com/wiki/Layered_Intrusion
    -- Layered intrusions consist of several layers of igneous rock that has intruded into the
    --      upper-reaches of the crust. The separation of the layers is due to differences in
    --      melting point that depend on the silica content of the rock. Higher silica rocks have a
    --      lower melting point and thus rise higher towards the surface. Geologica generates three
    --      layers: peridotite (ultra-mafic), gabbro (mafic) and diorite (intermediate). Many types
    --      of ore deposits are generated in layered intrusions. Peridotite contains magnesite,
    --      ferrovanadium ore, and pentlandite deposits, as well as serpentine veins. Diorite
    --      contains ilmenite, chromite and vermiculite. Both types of deposits will extend into the
    --      intervening gabbro.
    --
    -- Chromite, ilmenite, pentlandite, magnetite (w/ vanadium), vermiculite

    -- In pale peridotite
    add_ore({
        wherein = "stone_peridotite_pale",
        mineral = "magnesite",
        output = "mineral_magnesite_lump",

        description = unilib.utils.brackets(S("Magnesite Ore"), ("Pale Peridotite")),
        level = 2,
    })
    distribute_single_ore({
        wherein = "stone_peridotite_pale",
        ore = "stone_peridotite_pale_with_magnesite",

        alt_ore = "mineral_magnesite_rock",
        chance = 1 / 100,
    })

    -- (In PFAA, ferrovanadium ore seems to correspond to vanadium magnetite)
    add_ore({
        wherein = "stone_peridotite_pale",
        mineral = "magnetite_vanadium",
        output = "mineral_magnetite_vanadium_lump",

        description = unilib.utils.brackets(S("Vanadium Magnetite Ore"), ("Pale Peridotite")),
        level = 3,
    })
    distribute_single_ore({
        wherein = "stone_peridotite_pale",
        ore = "stone_peridotite_pale_with_magnetite_vanadium",

        alt_ore = "mineral_magnetite_vanadium_rock",
        chance = 1 / 100,
    })

    add_ore({
        wherein = "stone_peridotite_pale",
        mineral = "pentlandite",
        output = "mineral_pentlandite_lump",

        description = unilib.utils.brackets(S("Pentlandite Ore"), ("Pale Peridotite")),
        level = 2,
    })
    distribute_single_ore({
        wherein = "stone_peridotite_pale",
        ore = "stone_peridotite_pale_with_pentlandite",

        alt_ore = "mineral_pentlandite_rock",
        chance = 1 / 100,
    })

    add_ore({
        wherein = "stone_peridotite_pale",
        mineral = "serpentinite",
        output = "mineral_serpentinite_lump",

        description = unilib.utils.brackets(S("Serpentinite Ore"), ("Pale Peridotite")),
        level = 1,
    })
    distribute_single_ore({
        wherein = "stone_peridotite_pale",
        ore = "stone_peridotite_pale_with_serpentinite",

        alt_ore = "mineral_serpentinite_rock",
        chance = 10 / 100,
    })

    -- In dark diorite
    add_ore({
        wherein = "stone_diorite_dark",
        mineral = "ilmenite",
        output = "mineral_ilmenite_lump",

        description = unilib.utils.brackets(S("Ilmenite Ore"), ("Dark Diorite")),
        level = 3,
    })
    distribute_single_ore({
        wherein = "stone_diorite_dark",
        ore = "stone_diorite_dark_with_ilmenite",

        alt_ore = "mineral_ilmenite_rock",
        chance = 1 / 100,
    })

    add_ore({
        wherein = "stone_diorite_dark",
        mineral = "chromite",
        output = "mineral_chromite_lump",

        description = unilib.utils.brackets(S("Chromite Ore"), ("Dark Diorite")),
        level = 3,
    })
    distribute_single_ore({
        wherein = "stone_diorite_dark",
        ore = "stone_diorite_dark_with_chromite",

        alt_ore = "mineral_chromite_rock",
        chance = 1 / 100,
    })

    distribute_single_ore({
        wherein = "stone_diorite_dark",
        ore = "clay_vermiculite",

        chance = 1 / 100,
    })

    -- In gabbros. The PFAA documentation mentions the minerals "extending into the intervening
    --      gabbro", which is implemented by doubling the scarcity
    for _, part_name in pairs(gabbro_list) do

        local item_name = "stone_" .. part_name
        local data_table = unilib.global.stone_table[part_name]
        local wherein_description = data_table.description

        add_ore({
            wherein = item_name,
            mineral = "magnesite",
            output = "mineral_magnesite_lump",

            description = unilib.utils.brackets(S("Magnesite Ore"), wherein_description),
            level = 2,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_magnesite",

            alt_ore = "mineral_magnesite_rock",
            chance = 0.5 / 100,
        })

        add_ore({
            wherein = item_name,
            mineral = "magnetite_vanadium",
            output = "mineral_magnetite_vanadium_lump",

            description = unilib.utils.brackets(S("Vanadium Magnetite Ore"), wherein_description),
            level = 3,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_magnetite_vanadium",

            alt_ore = "mineral_magnetite_vanadium_rock",
            chance = 0.5 / 100,
        })

        add_ore({
            wherein = item_name,
            mineral = "pentlandite",
            output = "mineral_pentlandite_lump",

            description = unilib.utils.brackets(S("Pentlandite Ore"), wherein_description),
            level = 2,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_pentlandite",

            alt_ore = "mineral_pentlandite_rock",
            chance = 0.5 / 100,
        })

        add_ore({
            wherein = item_name,
            mineral = "serpentinite",
            output = "mineral_serpentinite_lump",

            description = unilib.utils.brackets(S("Serpentinite Ore"), wherein_description),
            level = 2,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_serpentinite",

            alt_ore = "mineral_serpentinite_rock",
            chance = 5 / 100,
        })

        add_ore({
            wherein = item_name,
            mineral = "ilmenite",
            output = "mineral_ilmenite_lump",

            description = unilib.utils.brackets(S("Ilmenite Ore"), wherein_description),
            level = 3,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_ilmenite",

            alt_ore = "mineral_ilmenite_rock",
            chance = 0.5 / 100,
        })

        add_ore({
            wherein = item_name,
            mineral = "chromite",
            output = "mineral_chromite_lump",

            description = unilib.utils.brackets(S("Chromite Ore"), wherein_description),
            level = 3,
        })
        distribute_single_ore({
            wherein = item_name,
            ore = item_name .. "_with_chromite",

            alt_ore = "mineral_chromite_rock",
            chance = 0.5 / 100,
        })

        distribute_single_ore({
            wherein = item_name,
            ore = "clay_vermiculite",

            chance = 0.5 / 100,
        })

    end

    -----------------------------------------------------------------------------------------------
    -- VMS
    -----------------------------------------------------------------------------------------------

    -- Based on https://pfaa.fandom.com/wiki/VMS
    -- A Volcanogenic Massive Sulfide (VMS) deposit results from volcanic action, usually on the sea
    --      floor, that concentrates sulfide ores. The lava is typically of felsic (high silica)
    --      composition and thus forms rhyolite. Ores include chalcopyrite, sphalerite/galena, and
    --      even some native gold, in order of decreasing depth. These usually occur in the ocean,
    --      but sometimes also in folded mountain ranges, where tectonic forces have brought the
    --      ancient sea floor into the upper reaches of the crust.
    --
    -- Chalcopyrite, sphalerite, galena, gold

    -- In pale rhyolite
    add_ore({
        wherein = "stone_rhyolite_pale",
        mineral = "chalcopyrite",
        output = "mineral_chalcopyrite_lump",

        description = unilib.utils.brackets(S("Chalcopyrite Ore"), ("Pale Rhyolite")),
        level = 2,
    })
    distribute_single_ore({
        wherein = "stone_rhyolite_pale",
        ore = "stone_rhyolite_pale_with_chalcopyrite",

        alt_ore = "mineral_chalcopyrite_rock",
        chance = 2 / 100,
    })

    add_ore({
        wherein = "stone_rhyolite_pale",
        mineral = "sphalerite",
        output = "mineral_sphalerite_lump",

        description = unilib.utils.brackets(S("Sphalerite Ore"), ("Pale Rhyolite")),
        level = 2,
    })
    distribute_single_ore({
        wherein = "stone_rhyolite_pale",
        ore = "stone_rhyolite_pale_with_sphalerite",

        alt_ore = "mineral_sphalerite_rock",
        chance = 1 / 100,
    })

    add_ore({
        wherein = "stone_rhyolite_pale",
        mineral = "galena",
        output = "mineral_galena_lump",

        description = unilib.utils.brackets(S("Galena Ore"), ("Pale Rhyolite")),
        level = 1,
    })
    distribute_single_ore({
        wherein = "stone_rhyolite_pale",
        ore = "stone_rhyolite_pale_with_galena",

        alt_ore = "mineral_galena_rock",
        chance = 1 / 100,
    })

    add_ore({
        wherein = "stone_rhyolite_pale",
        mineral = "gold_native",
        output = "mineral_gold_native_lump",

        description = unilib.utils.brackets(S("Native Gold Ore"), ("Pale Rhyolite")),
        level = 3,
    })
    distribute_single_ore({
        wherein = "stone_rhyolite_pale",
        ore = "stone_rhyolite_pale_with_gold_native",

        alt_ore = "mineral_gold_native_rock",
        chance = 0.25 / 100,
    })

    if add_native_flag then

        add_ore({
            wherein = "stone_rhyolite_pale",
            mineral = "silver_native",
            output = "mineral_silver_native_lump",

            description = unilib.utils.brackets(S("Native Silver Ore"), ("Pale Rhyolite")),
            level = 3,
        })
        distribute_single_ore({
            wherein = "stone_rhyolite_pale",
            ore = "stone_rhyolite_pale_with_silver_native",

            alt_ore = "mineral_silver_native_rock",
            chance = 0.25 / 100,
        })

    end

    -- (N.B. According to https://pfaa.fandom.com/wiki/Ore, pyrite is a minor component in sulfide
    --      ore deposits)
    add_ore({
        wherein = "stone_rhyolite_pale",
        mineral = "pyrite",
        output = "mineral_pyrite_lump",

        description = unilib.utils.brackets(S("Pyrite Ore"), ("Pale Rhyolite")),
        level = 3,
    })
    distribute_single_ore({
        wherein = "stone_rhyolite_pale",
        ore = "stone_rhyolite_pale_with_pyrite",

        alt_ore = "mineral_pyrite_rock",
        chance = 0.5 / 100,
    })

    -----------------------------------------------------------------------------------------------
    -- BIF
    -----------------------------------------------------------------------------------------------

    -- Based on https://pfaa.fandom.com/wiki/BIF
    -- A Banded Iron Formation (BIF) is a mainly mixture of two iron oxide minerals: haematite and
    --      magnetite. It forms in layers near the surface through sedimentary processes. BIFs are
    --      common outside of volcanic regions, and are twice as frequent in frozen and ocean
    --      biomes.
    --
    -- Haematite, often chalcopyrite and gold beneath

    for part_name, data_table in pairs(unilib.global.stone_table) do

        if not data_table.no_smooth_flag and data_table.category == "sedimentary" then

            local item_name = "stone_" .. part_name
            local wherein_description = data_table.description

            add_ore({
                wherein = item_name,
                mineral = "haematite",
                output = "mineral_haematite_lump",

                description = unilib.utils.brackets(S("Haematite Ore"), wherein_description),
                level = 3,
            })
            distribute_single_ore({
                wherein = item_name,
                ore = item_name .. "_with_haematite",

                alt_ore = "mineral_haematite_rock",
                chance = 0.5 / 100,
            })

            add_ore({
                wherein = item_name,
                mineral = "chalcopyrite",
                output = "mineral_chalcopyrite_lump",

                description = unilib.utils.brackets(S("Chalcopyrite Ore"), wherein_description),
                level = 3,
            })
            distribute_single_ore({
                wherein = item_name,
                ore = item_name .. "_with_chalcopyrite",

                alt_ore = "mineral_chalcopyrite_rock",
                chance = 0.25 / 100,
            })

            add_ore({
                wherein = item_name,
                mineral = "gold_native",
                output = "mineral_gold_native_lump",

                description = unilib.utils.brackets(S("Native Gold Ore"), wherein_description),
                level = 3,
            })
            distribute_single_ore({
                wherein = item_name,
                ore = item_name .. "_with_gold_native",

                alt_ore = "mineral_gold_native_rock",
                chance = 0.25 / 100,
            })

            if add_native_flag then

                add_ore({
                    wherein = item_name,
                    mineral = "silver_native",
                    output = "mineral_silver_native_lump",

                    description =
                            unilib.utils.brackets(S("Native Silver Ore"), wherein_description),
                    level = 3,
                })
                distribute_single_ore({
                    wherein = item_name,
                    ore = item_name .. "_with_silver_native",

                    alt_ore = "mineral_silver_native_rock",
                    chance = 0.25 / 100,
                })

            end

        end

    end

    -----------------------------------------------------------------------------------------------
    -- Porphyry
    -----------------------------------------------------------------------------------------------

    -- Based on https://pfaa.fandom.com/wiki/Porphyry
    -- A porphyry formation consists of a mixture of large and small igneous crystals. Geologica
    --      models this as a vein of breccia in diorite, with intermixed chalcopyrite (20%) and
    --      molybdenite (10%).
    --
    -- Breccia w/ chalcopyrite (20%), molybdenite (10%)

    -- In dark diorite
    distribute_single_ore({
        wherein = "stone_diorite_dark",
        ore = "stone_breccia",

        chance = 7 / 100,
    })

    add_ore({
        wherein = "stone_breccia",
        mineral = "chalcopyrite",
        output = "mineral_chalcopyrite_lump",

        description = unilib.utils.brackets(S("Chalcopyrite Ore"), ("Breccia")),
        level = 2,
    })
    distribute_single_ore({
        wherein = "stone_diorite_dark",
        ore = "stone_breccia_with_chalcopyrite",

        alt_ore = "mineral_chalcopyrite_rock",
        chance = 2 / 100,
    })

    add_ore({
        wherein = "stone_breccia",
        mineral = "molybdenite",
        output = "mineral_molybdenite_lump",

        description = unilib.utils.brackets(S("Molybdenite Ore"), ("Breccia")),
        level = 1,
    })
    distribute_single_ore({
        wherein = "stone_diorite_dark",
        ore = "stone_breccia_with_molybdenite",

        alt_ore = "mineral_molybdenite_rock",
        chance = 1 / 100,
    })

    -----------------------------------------------------------------------------------------------
    -- Volcanic ash
    -----------------------------------------------------------------------------------------------

    -- Based on https://pfaa.fandom.com/wiki/Volcanic_Ash
    -- Volcanic ash deposits occur near the surface in volcanic regions. Geologica generates similar
    --      deposits for two types of minerals: pumice (essentially the hardened bubbles of lava
    --      spewed into the air by the volcano) and bentonite (a weathering product of ash).

    -- In all
    distribute_blob({
        wherein = "all",
        ore = "sand_volcanic_ash",

        period = 15,
        period2 = 16,
        period3 = 17,
        size = 0.05,
        y_max = 5,
        y_min = -50,
    })

    distribute_blob({
        wherein = "all",
        ore = "mineral_pumice_rock",

        period = 16,
        period2 = 17,
        period3 = 15,
        size = 0.05,
        y_max = 5,
        y_min = -50,
    })

    distribute_blob({
        wherein = "all",
        ore = "clay_bentonite_calcium",

        period = 17,
        period2 = 15,
        period3 = 16,
        size = 0.05,
        y_max = 5,
        y_min = -50,
    })

    distribute_blob({
        wherein = "all",
        ore = "clay_bentonite_sodium",

        period = 17,
        period2 = 16,
        period3 = 15,
        size = 0.05,
        y_max = 5,
        y_min = -50,
    })

    -----------------------------------------------------------------------------------------------
    -- Placer
    -----------------------------------------------------------------------------------------------

    -- Based on https://pfaa.fandom.com/wiki/Placer
    -- Placer deposits are placed by streams and rivers. Rocks enriched for heavier minerals settle
    --      to the bottom in regions of slower current, such as eddies. Geologica models placer
    --      deposits as sand and generates them on the beaches and the sides of rivers. There is
    --      cassiterite sand, granitic and basaltic mineral sand, and garnet sand. The general
    --      "mineral" sands consist largely of iron oxides and can be smelted to iron. With more
    --      complex processing, additional minerals can be isolated, depending on whether the host
    --      rock was granitic (felsic) or basaltic (mafic).
    --
    -- Cassiterite sand, basaltic/granitic mineral sands, garnet sand

    -- In all
    distribute_blob({
        wherein = "all",
        ore = "sand_cassiterite",

        period = 16,
        period2 = 17,
        period3 = 18,
        size = 0.05,
        y_max = 5,
        y_min = -20,
    })

    distribute_blob({
        wherein = "all",
        ore = "sand_garnet",

        period = 17,
        period2 = 18,
        period3 = 16,
        size = 0.05,
        y_max = 5,
        y_min = -20,
    })

    distribute_blob({
        wherein = "all",
        ore = "sand_mineral_basaltic",

        period = 18,
        period2 = 16,
        period3 = 17,
        size = 0.05,
        y_max = 5,
        y_min = -20,
    })

    distribute_blob({
        wherein = "all",
        ore = "sand_mineral_granitic",

        period = 18,
        period2 = 17,
        period3 = 16,
        size = 0.05,
        y_max = 5,
        y_min = -20,
    })

    -----------------------------------------------------------------------------------------------
    -- Laterite
    -----------------------------------------------------------------------------------------------

    -- Based on https://pfaa.fandom.com/wiki/Laterite
    -- Laterites are mineral deposits rich in iron and aluminum and are formed through tropical
    --      weathering of rock. In Geologica, laterite soil and ores are in the form of clay. In the
    --      tropics (any biome with sufficiently high temperature and rainfall), there are two types
    --      of laterite deposits: limonite and bauxite. Swamps also host limonite. Geologica divides
    --      limonite ore into two types: yellow and brown. There is no functional difference between
    --      the two, yet.
    -- Beneath some laterite deposits, one will encounter veins of serpentinite that are enriched
    --      for garnierite, an ore of nickel.
    --
    -- Bauxite, limonite (often serpentine w/ garnierite beneath)

    -- In laterite
    add_ore({
        wherein = "stone_laterite",
        mineral = "bauxite",
        output = "mineral_bauxite_lump",

        description = unilib.utils.brackets(S("Bauxite Ore"), ("Laterite")),
        level = 1,
    })
    distribute_single_ore({
        wherein = "stone_laterite",
        ore = "stone_laterite_with_bauxite",

        alt_ore = "mineral_bauxite_rock",
        chance = 1 / 100,
    })

    add_ore({
        wherein = "stone_laterite",
        mineral = "limonite_brown",
        output = "mineral_limonite_brown_lump",

        description = unilib.utils.brackets(S("Brown Limonite Ore"), ("Laterite")),
        level = 1,
    })
    distribute_single_ore({
        wherein = "stone_laterite",
        ore = "stone_laterite_with_limonite_brown",

        alt_ore = "mineral_limonite_rock",
        chance = 0.5 / 100,
    })

    add_ore({
        wherein = "stone_laterite",
        mineral = "limonite_yellow",
        output = "mineral_limonite_yellow_lump",

        description = unilib.utils.brackets(S("Yellow Limonite Ore"), ("Laterite")),
        level = 1,
    })
    distribute_single_ore({
        wherein = "stone_laterite",
        ore = "stone_laterite_with_limonite_yellow",

        alt_ore = "mineral_limonite_rock",
        chance = 0.5 / 100,
    })

    add_ore({
        wherein = "stone_serpentinite_dark",
        mineral = "garnierite",
        output = "mineral_garnierite_lump",

        description = unilib.utils.brackets(S("Garnierite Ore"), ("Dark Serpentinite")),
        level = 2,
    })
    distribute_single_ore({
        wherein = "stone_serpentinite_dark",
        ore = "stone_serpentinite_dark_with_garnierite",

        alt_ore = "mineral_garnierite_rock",
        chance = 0.5 / 100,
    })

    -----------------------------------------------------------------------------------------------
    -- Kimberlite pipes
    -----------------------------------------------------------------------------------------------

    -- Based on https://pfaa.fandom.com/wiki/Kimberlite_Pipes
    -- Kimberlite pipes are lava-filled vertical veins/dikes that are walled with xenolithic
    --      peridotite, often with embedded diamonds. They are found anywhere in the world.
    --
    -- Diamonds

    -- (Can't place pipes in the world, but we can place kimberlite in serpentinite)
    add_ore({
        wherein = "stone_serpentinite_dark",
        mineral = "kimberlite",
        output = "mineral_kimberlite_lump",

        description = unilib.utils.brackets(S("Kimberlite Ore"), S("Serpentinite")),
        level = 3,
    })
    distribute_single_ore({
        wherein = "stone_serpentinite_dark",
        ore = "stone_serpentinite_dark_with_kimberlite",

        alt_ore = "mineral_kimberlite_rock",
        chance = 0.5 / 100,
    })

    add_ore({
        wherein = "stone_serpentinite_dark",
        mineral = "diamond",
        output = "mineral_diamond_gem",

        description = unilib.utils.brackets(S("Diamond Ore"), ("Serpentinite")),
        level = 3,
    })
    distribute_single_ore({
        wherein = "stone_serpentinite_dark",
        ore = "stone_serpentinite_dark_with_diamond",

        chance = 0.1 / 100,
    })

    -----------------------------------------------------------------------------------------------
    -- Cuprite pipes
    -----------------------------------------------------------------------------------------------

    -- Cuprite pipes are vertical veins that are enriched for the copper ores cuprite (80%) and
    --      chalcopyrite (20%). Cuprite is considered the equivalent of redstone.
    --
    -- Redstone/cuprite(80%), chalcopyrite (20%)

    -- Implement this as a cuprite/chalcopyrite/mese mix (with mese standing in for redstone). Also,
    --      adjust the relative quantities so that cuprite does not dominate. The mix occurs in all
    --      metamorphic stones (which otherwise don't have many ores)

    for part_name, data_table in pairs(unilib.global.stone_table) do

        if not data_table.no_smooth_flag and data_table.category == "metamorphic" then

            local item_name = "stone_" .. part_name
            local wherein_description = data_table.description

            add_ore({
                wherein = item_name,
                mineral = "cuprite",
                output = "mineral_cuprite_lump",

                description = unilib.utils.brackets(S("Cuprite Ore"), wherein_description),
                level = 2,
            })
            distribute_single_ore({
                wherein = item_name,
                ore = item_name .. "_with_cuprite",

                alt_ore = "mineral_cuprite_rock",
                chance = 2 / 100,
            })

            add_ore({
                wherein = item_name,
                mineral = "chalcopyrite",
                output = "mineral_chalcopyrite_lump",

                description = unilib.utils.brackets(S("Chalcopyrite Ore"), wherein_description),
                level = 2,
            })
            distribute_single_ore({
                wherein = item_name,
                ore = item_name .. "_with_chalcopyrite",

                alt_ore = "mineral_chalcopyrite_rock",
                chance = 1 / 100,
            })

            add_ore({
                wherein = item_name,
                mineral = "mese",
                output = "mineral_mese_crystal",

                description = unilib.utils.brackets(S("Mese Ore"), wherein_description),
                level = 3,
            })
            distribute_single_ore({
                wherein = item_name,
                ore = item_name .. "_with_mese",

                chance = 1 / 100,
            })

            if add_native_flag then

                add_ore({
                    wherein = item_name,
                    mineral = "copper_native",
                    output = "mineral_copper_native_lump",

                    description =
                            unilib.utils.brackets(S("Native Copper Ore"), wherein_description),
                    level = 3,
                })
                distribute_single_ore({
                    wherein = item_name,
                    ore = item_name .. "_with_cuprite",

                    alt_ore = "mineral_copper_native_rock",
                    chance = 0.1 / 100,
                })

            end

        end

    end

    -----------------------------------------------------------------------------------------------
    -- Fumaroles
    -----------------------------------------------------------------------------------------------

    -- From https://en.wikipedia.org/wiki/Fumarole
    -- A fumarole (or fumerole – the word ultimately comes from the Latin fumus, "smoke") is an
    --      opening in a planet's crust which emits steam and gases such as carbon dioxide, sulphur
    --      dioxide, hydrogen chloride, and hydrogen sulfide.
    -- Fumaroles emitting sulphurous vapors form surface deposits of sulphur-rich minerals and of
    --      fumarole minerals.
    --
    -- Based on https://pfaa.fandom.com/wiki/Deposit
    -- Gypsum (60%), rock salt (30%), realgar (10%)

    -- In all
    distribute_blob({
        wherein = "all",
        ore = "mineral_gypsum_rock",

        period = 14,
        period2 = 16,
        period3 = 18,
        size = 0.05,
        y_max = 5,
        y_min = -100,
    })

    distribute_blob({
        wherein = "all",
        ore = "mineral_salt_block",

        period = 16,
        period2 = 18,
        period3 = 14,
        size = 0.05,
        y_max = 5,
        y_min = -100,
    })

    distribute_blob({
        wherein = "all",
        ore = "mineral_salt_pure_block",

        period = 18,
        period2 = 14,
        period3 = 16,
        size = 0.05,
        y_max = 5,
        y_min = -100,
    })

    distribute_blob({
        wherein = "all",
        ore = "mineral_realgar_rock",

        period = 18,
        period2 = 16,
        period3 = 14,
        size = 0.05,
        y_max = 5,
        y_min = -100,
    })

    -----------------------------------------------------------------------------------------------
    -- Place clays, gravels, sands and sandstones as ores
    -----------------------------------------------------------------------------------------------

    if ugbc_extra_ore_flag then

        -- Basic stones from UGBC have clay, gravel, sand and sandstone equivalents, which we will
        --      use as blob/scatter ores
        for _, part_name in pairs(ugbc_list) do

            distribute_blob({
                wherein = "stone_" .. part_name,
                ore = "clay_" .. part_name,

                size = 0.2,
            })

            distribute_blob({
                wherein = "stone_" .. part_name,
                ore = "gravel_" .. part_name,

                size = 0.2,
            })

            distribute_blob({
                wherein = "stone_" .. part_name,
                ore = "sand_" .. part_name,

                size = 0.2,
            })

            distribute_scatter({
                wherein = "stone_" .. part_name,
                ore = "stone_sandstone_" .. part_name,

                size = 0.2,
            })

        end

    end

    if non_ugbc_extra_ore_flag then

        -- Compile a list of non-UGBC basic stones, so we can place ordinary clays, gravels and
        --      sands in them
        local check_table = {}
        for _, part_name in pairs(ugbc_list) do
            check_table[part_name] = true
        end

        for _, part_name in pairs(basic_stone_list) do

            if check_table[part_name] == nil then
                table.insert(non_ugbc_list, part_name)
            end

        end

        for _, part_name in pairs(non_ugbc_list) do

            distribute_blob({
                wherein = "stone_" .. part_name,
                ore = "clay_ordinary",

                size = 0.2,
            })

            distribute_blob({
                wherein = "stone_" .. part_name,
                ore = "gravel_ordinary",

                size = 0.2,
            })

            distribute_blob({
                wherein = "stone_" .. part_name,
                ore = "sand_ordinary",

                size = 0.2,
            })

        end

    end

    -----------------------------------------------------------------------------------------------
    -- Additional ore section
    -----------------------------------------------------------------------------------------------

    -- Any ores not already handled by the code above, can be placed in this list, from which they
    --      will be added to the world. This package must be used in a remix which provides the
    --      packages of the additional ores
    -- For reach ore, if no pseudo-biome is specified, one is assigned randomly. Thus, any
    --      particular will be hard to find (and some will be harder to find than others)

    local pbiome_count = #basic_stone_list

    -- List of mini-lists, each in the form
    --      [ ore-part-name, alternative-ore-item-name, chance, wherein-part-name ]
    -- ... in which all four arguments are optional. "wherein-part-name" should be one of the items
    --      in basic_stone_list
    local additional_list = {}

    -- Additional ores that provide metals, not provided by any of the ores listed above
    if add_more_metals_flag then

        local more_metals_list = {
            {"borax",           "mineral_borax_rock",           0.1,          nil}, -- boron
            {"carnotite",       "mineral_carnotite_rock",       0.2,          nil}, -- uranium
            {"chromite",        "mineral_chromite_rock",        0.5,          nil}, -- chromium
            {"cobaltite",       "mineral_cobaltite_rock",       0.2,          nil}, -- cobalt
            {"columbite",       "mineral_columbite_rock",       0.1,          nil}, -- niobium
            {"germanite",       "mineral_germanite_rock",       0.1,          nil}, -- germanium
            {"greenockite",     "mineral_greenockite_rock",     0.1,          nil}, -- cadmium
            {"monazite",        "mineral_monazite_rock",        0.1,          nil}, -- ceriuim
            {"samarskite",      "mineral_samarskite_rock",      0.1,          nil}, -- yttrium
            {"sylvite",         "mineral_sylvite_rock",         0.1,          nil}, -- potassium
            {"thorite",         "mineral_thorite_rock",         0.1,          nil}, -- thorium
            {"thortveitite",    "mineral_thortveitite_rock",    0.1,          nil}, -- scandium
            {"torbernite",      "mineral_torbernite_rock",      0.2,          nil}, -- uranium
            {"vanadinite",      "mineral_vanadinite_rock",      0.1,          nil}, -- vanadium
            {"zircon",          "mineral_zircon_rock",          0.1,          nil}, -- zirconium
        }

        for _, mini_list in ipairs(more_metals_list) do
            table.insert(additional_list, mini_list)
        end

    end

    -- Additional ores from AATO
    if add_aato_flag then

        local aato_list = {
            {"acanthite",       "mineral_acanthite_rock",       0.1,          nil}, -- silver
            {"agate",           "mineral_agate_rock",           0.1,          nil},
            {"alabandite",      "mineral_alabandite_rock",      0.1,          nil},
            {"almandine",       "mineral_almandine_rock",       0.1,          nil},
            {"amazonite",       "mineral_amazonite_rock",       0.1,          nil},
            {"amethyst_dark",   "mineral_amethyst_dark_rock",   0.1,          nil},
            {"anatase",         "mineral_anatase_rock",         0.1,          nil}, -- titanium
            {"andradite",       "mineral_andradite_rock",       0.1,          nil},
            {"anglesite",       "mineral_anglesite_rock",       0.1,          nil}, -- lead
            {"anhydrite",       "mineral_anhydrite_rock",       0.1,          nil}, -- calcium
            {"argutite",        "mineral_argutite_rock",        0.1,          nil}, -- germanium
            {"arsenopyrite",    "mineral_arsenopyrite_rock",    0.1,          nil}, -- arsenic
            {"azurite",         "mineral_azurite_rock",         0.1,          nil}, -- copper
            {"bismite",         "mineral_bismite_rock",         0.1,          nil}, -- bismuth
            {"bornite",         "mineral_bornite_rock",         0.1,          nil}, -- copper
            {"boulangerite",    "mineral_boulangerite_rock",    0.1,          nil}, -- lead
            {"brookite",        "mineral_brookite_rock",        0.1,          nil}, -- titanium
            {"brucite",         "mineral_brucite_rock",         0.1,          nil}, -- magnesium
            {"calcite",         "mineral_calcite_rock",         0.1,          nil}, -- calcium
            {"carnallite",      "mineral_carnallite_rock",      0.1,          nil}, -- potassium
            {"carnelian",       "mineral_carnelian_rock",       0.1,          nil},
            {"carnotite",       "mineral_carnotite_rock",       0.1,          nil}, -- uranium
            {"carrollite",      "mineral_carrollite_rock",      0.1,          nil}, -- cobalt
            {"cerussite",       "mineral_cerussite_rock",       0.1,          nil}, -- lead
            {"chalcocite",      "mineral_chalcocite_rock",      0.1,          nil}, -- copper
            {"chrysocolla",     "mineral_chrysocolla_rock",     0.1,          nil},
            {"chrysoprase",     "mineral_chrysoprase_rock",     0.1,          nil},
            {"clausthalite",    "mineral_clausthalite_rock",    0.1,          nil}, -- selenium
            {"cobaltite",       "mineral_cobaltite_rock",       0.1,          nil}, -- cobalt
            {"columbite",       "mineral_columbite_rock",       0.1,          nil}, -- niobium
            {"covellite",       "mineral_covellite_rock",       0.1,          nil}, -- copper
            {"descloizite",     "mineral_descloizite_rock",     0.1,          nil}, -- vanadium
            {"enargite",        "mineral_enargite_rock",        0.1,          nil}, -- copper
            {"ferberite",       "mineral_ferberite_rock",       0.1,          nil}, -- tungsten
            {"franklinite",     "mineral_franklinite_rock",     0.1,          nil}, -- zinc
            {"freibergite",     "mineral_freibergite_rock",     0.1,          nil}, -- silver
            {"germanite",       "mineral_germanite_rock",       0.1,          nil}, -- germanium
            {"gersdorffite",    "mineral_gersdorffite_rock",    0.1,          nil}, -- nickel
            {"greenockite",     "mineral_greenockite_rock",     0.1,          nil}, -- cadmium
            {"hausmannite",     "mineral_hausmannite_rock",     0.1,          nil}, -- manganese
            {"hauyne",          "mineral_hauyne_rock",          0.1,          nil},
            {"heliotrope",      "mineral_heliotrope_rock",      0.1,          nil},
            {"hemimorphite",    "mineral_hemimorphite_rock",    0.1,          nil}, -- zinc
            {"hollandite",      "mineral_hollandite_rock",      0.1,          nil}, -- manganese
            {"hubnerite",       "mineral_hubnerite_rock",       0.1,          nil}, -- tungsten
            {"hydrozincite",    "mineral_hydrozincite_rock",    0.1,          nil}, -- zinc
            {"iron_telluric",   "mineral_iron_telluric_rock",   0.1,          nil}, -- pig iron
            {"jade",            "mineral_jade_rock",            0.1,          nil},
            {"jet_dark",        "mineral_jet_dark_rock",        0.1,          nil},
            {"kainite",         "mineral_kainite_rock",         0.1,          nil}, -- potassium
            {"kesterite",       "mineral_kesterite_rock",       0.1,          nil}, -- tin
            {"kieserite",       "mineral_kieserite_rock",       0.1,          nil}, -- magnesium
            {"lamproite",       "mineral_lamproite_rock",       0.1,          nil}, -- magnesium
            {"langbeinite",     "mineral_langbeinite_rock",     0.1,          nil}, -- potassium
            {"leucite",         "mineral_leucite_rock",         0.1,          nil}, -- aluminium
            {"loellingite",     "mineral_loellingite_rock",     0.1,          nil}, -- arsenic
            {"manganite",       "mineral_manganite_rock",       0.1,          nil}, -- manganese
            {"millerite",       "mineral_millerite_rock",       0.1,          nil}, -- nickel
            {"monazite",        "mineral_monazite_rock",        0.1,          nil}, -- cerium
            {"moonstone",       "mineral_moonstone_rock",       0.1,          nil},
            {"nepheline",       "mineral_nepheline_rock",       0.1,          nil}, -- aluminium
            {"nepouite",        "mineral_nepouite_rock",        0.1,          nil}, -- nickel
            {"nickeline",       "mineral_nickeline_rock",       0.1,          nil}, -- nickel
            {"nitratine",       "mineral_nitratine_rock",       0.1,          nil}, -- sodium
            {"onyx",            "mineral_onyx_rock",            0.1,          nil},
            {"opal",            "mineral_opal_rock",            0.1,          nil},
            {"orpiment",        "mineral_orpiment_rock",        0.1,          nil}, -- arsenic
            {"otavite",         "mineral_otavite_rock",         0.1,          nil}, -- cadmium
            {"peridot",         "mineral_peridot_rock",         0.1,          nil},
            {"petalite",        "mineral_petalite_rock",        0.1,          nil}, -- lithium
            {"phosphorite",     "mineral_phosphorite_rock",     0.1,          nil}, -- phosphorus
            {"polyhalite",      "mineral_polyhalite_rock",      0.1,          nil}, -- potassium
            {"polylithionite",  "mineral_polylithionite_rock",  0.1,          nil}, -- lithium
            {"proustite",       "mineral_proustite_rock",       0.1,          nil}, -- silver
            {"pyromorphite",    "mineral_pyromorphite_rock",    0.1,          nil}, -- lead
            {"pyrope",          "mineral_pyrope_rock",          0.1,          nil},
            {"rhodochrosite",   "mineral_rhodochrosite_rock",   0.1,          nil}, -- manganese
            {"rhodonite",       "mineral_rhodonite_rock",       0.1,          nil}, -- manganese
            {"ruby_dark",       "mineral_ruby_dark_rock",       0.1,          nil},
            {"rutile",          "mineral_rutile_rock",          0.1,          nil}, -- titanium
            {"samarskite",      "mineral_samarskite_rock",      0.1,          nil}, -- yttrium
            {"sapphire_dark",   "mineral_sapphire_dark_rock",   0.1,          nil},
            {"siderite",        "mineral_siderite_rock",        0.1,          nil}, -- pig iron
            {"skutterudite",    "mineral_skutterudite_rock",    0.1,          nil}, -- cobalt
            {"smithsonite",     "mineral_smithsonite_rock",     0.1,          nil}, -- zinc
            {"spessartine",     "mineral_spessartine_rock",     0.1,          nil},
            {"spinel",          "mineral_spinel_rock",          0.1,          nil},
            {"stannite",        "mineral_stannite_rock",        0.1,          nil}, -- tin
            {"stephanite",      "mineral_stephanite_rock",      0.1,          nil}, -- silver
            {"strontianite",    "mineral_strontianite_rock",    0.1,          nil}, -- strontium
            {"sugilite",        "mineral_sugilite_rock",        0.1,          nil},
            {"tanzanite",       "mineral_tanzanite_rock",       0.1,          nil},
            {"teallite",        "mineral_teallite_rock",        0.1,          nil}, -- tin
            {"tennantite",      "mineral_tennantite_rock",      0.1,          nil}, -- copper
            {"thorite",         "mineral_thorite_rock",         0.1,          nil}, -- thorium
            {"thortveitite",    "mineral_thortveitite_rock",    0.1,          nil}, -- scandium
            {"titanite",        "mineral_titanite_rock",        0.1,          nil}, -- titanium
            {"topaz",           "mineral_topaz_rock",           0.1,          nil},
            {"torbernite",      "mineral_torbernite_rock",      0.1,          nil}, -- uranium
            {"tourmaline",      "mineral_tourmaline_rock",      0.1,          nil},
            {"tsavorite",       "mineral_tsavorite_rock",       0.1,          nil},
            {"turquoise",       "mineral_turquoise_rock",       0.1,          nil},
            {"unakite",         "mineral_unakite_rock",         0.1,          nil},
            {"vanadinite",      "mineral_vanadinite_rock",      0.1,          nil}, -- vanadium
            {"wulfenite",       "mineral_wulfenite_rock",       0.1,          nil}, -- molybdenum
            {"zincite",         "mineral_zincite_rock",         0.1,          nil}, -- zinc
            {"zircon",          "mineral_zircon_rock",          0.1,          nil}, -- zirconium
        }

        for _, mini_list in ipairs(aato_list) do
            table.insert(additional_list, mini_list)
        end

    end

    -- Additional ores from real_minerals
    if add_real_minerals_flag then

        local real_minerals_list = {
            {nil,               "dirt_peat",                    0.1,          nil},
            {"bismuthinite",    "mineral_bismuthinite_rock",    0.1,          nil}, -- bismuth
            {
                "charcoal_natural",
                "mineral_charcoal_natural_rock",
                0.1,
                nil,
            },
            {"cryolite",        "mineral_cryolite_rock",        0.1,          nil},
            {"flux",            "mineral_flux_rock",            0.1,          nil},
            {"graphite",        "mineral_graphite_rock",        0.1,          nil},
            {"jet",             "mineral_jet_rock",             0.1,          nil},
            {"kaolinite",       "mineral_kaolinite_rock",       0.1,          nil},
            {"lazurite",        "mineral_lazurite_rock",        0.1,          nil},
            {"limonite",        "mineral_limonite_rock",        0.1,          nil}, -- pig iron
            {"olivine",         "mineral_olivine_rock",         0.1,          nil},
            {"pitchblende",     "mineral_pitchblende_rock",     0.1,          nil},
            {"saltpetre",       "mineral_saltpetre_rock",       0.1,          nil},
            {"satinspar",       "mineral_satinspar_rock",       0.1,          nil},
            {"selenite",        "mineral_selenite_rock",        0.1,          nil},
            {"sulphur_rare",    "mineral_sulphur_rare_rock",    0.1,          nil},
            {"sylvite",         "mineral_sylvite_rock",         0.1,          nil}, -- potassium
            {"tenorite",        "mineral_tenorite_rock",        0.1,          nil},
            {"tetrahedrite",    "mineral_tetrahedrite_rock",    0.1,          nil}, -- rare copper
            {"wood_petrified",  nil,                            0.1,          nil},
        }

        for _, mini_list in ipairs(real_minerals_list) do
            table.insert(additional_list, mini_list)
        end

    end

    -- Additional ores, to be added by you, the user
    if add_custom_flag then

        local custom_list = {
--          {"bismuthinite",    "mineral_bismuthinite_rock",    0.1,          nil},
        }

        for _, mini_list in ipairs(custom_list) do
            table.insert(additional_list, mini_list)
        end

    end

    -- Create the additional ores
    for _, mini_list in ipairs(additional_list) do

        local ore = mini_list[1]
        local alt_ore = mini_list[2]
        local chance = mini_list[3] or 0.1
        local wherein = mini_list[4] or basic_stone_list[math.random(1, pbiome_count)]

        local stone_name = "stone_" .. wherein
        local stone_data_table = unilib.global.stone_table[wherein]

        if ore ~= nil and unilib.global.mineral_table[ore] ~= nil then

            local mineral_data_table = unilib.global.mineral_table[ore]

            add_ore({
                wherein = stone_name,
                mineral = ore,
                output = "mineral_" .. ore .. "_lump",

                description = unilib.utils.brackets(
                    S("@1 Ore", mineral_data_table.description),
                    stone_data_table.description
                ),
                level = mineral_data_table.hardness,
            })
            distribute_single_ore({
                wherein = stone_name,
                ore = stone_name .. "_with_" .. ore,

                alt_ore = alt_ore,
                chance = chance / 100,
            })

        elseif alt_ore ~= nil then

            distribute_single_ore({
                wherein = stone_name,
                ore = alt_ore,

                chance = chance / 100,
            })

        end

    end

end

local function populate_optional_ore_tables()

    -- Original to unilib
    -- In addition to the ores placed in the call to populate_ore_tables(), there are two
    --      further ore-generation tables used to place common nodes, and common ores in ordinary
    --      stone. This ensures that items that are important for crafting can be commonly available
    --      to players, even though they might be rare in the ores generated by
    --      populate_ore_tables()
    -- These ores can be enabled or disabled, as required, using the flags

    -- The first one specifies calls to unilib.jbiomes.blob()
    local blob_table = {}
    if blob_default_flag then

        table.insert(
            blob_table,
            {unilib.constant.y_min, unilib.constant.y_max, "sand_silver", 0.09, 21, 22, 23}
        )
        table.insert(
            blob_table,
            {-31, unilib.constant.y_max, "dirt_ordinary", 0.09, 19, 22, 23}
        )
        table.insert(
            blob_table,
            {unilib.constant.y_min, unilib.constant.y_max, "gravel_ordinary", 0.09, 21, 19, 24}
        )
        table.insert(
            blob_table,
            {-93, unilib.constant.y_max, "clay_brown", 0.09, 19, 24, 25}
        )
        table.insert(
            blob_table,
            {-1301, unilib.constant.y_max, "gravel_mossy", 0.09, 18, 19, 23}
        )
        table.insert(
            blob_table,
            {
                unilib.constant.y_min, unilib.constant.y_max, "stone_ordinary_cobble",
                0.09, 20, 21, 19,
            }
        )

    end

    -- The second one specifies calls to unilib.jbiomes.scatter()
    local scatter_table = {}
    if scatter_default_flag then

        -- N.B. All of these metals/minerals are obtainable from the other non-optional minerals
        --      specified by the populate_ore_tables() function

        -- (From default)
        table.insert(
            scatter_table,
            {unilib.constant.y_min, 64, "stone_ordinary_with_coal", 150, 29, 32, 33}
        )
        table.insert(
            scatter_table,
            {unilib.constant.y_min, -20, "stone_ordinary_with_tin", 165, 30, 29, 31}
        )
        table.insert(
            scatter_table,
            {unilib.constant.y_min, -20, "stone_ordinary_with_copper", 163, 27, 28, 31}
        )
        table.insert(
            scatter_table,
            {unilib.constant.y_min, -40, "stone_ordinary_with_iron", 170, 29, 27, 31}
        )
        table.insert(
            scatter_table,
            {unilib.constant.y_min, -250, "stone_ordinary_with_gold", 173, 32, 29, 27}
        )
        table.insert(
            scatter_table,
            {unilib.constant.y_min, -500, "stone_ordinary_with_mese", 175, 29, 31, 28}
        )
        table.insert(
            scatter_table,
            {unilib.constant.y_min, -500, "stone_ordinary_with_diamond", 180, 32, 31, 29}
        )
        table.insert(
            scatter_table,
            {unilib.constant.y_min, -1000, "mineral_mese_block", 200, 29, 32, 35}
        )

    elseif add_real_minerals_flag and add_real_minerals_extra_flag then

        -- When real_minerals packages enabled, make sure that both metal varieties are obtainable

        table.insert(
            scatter_table,
            {unilib.constant.y_min, -20, "stone_ordinary_with_tin", 165, 30, 29, 31}
        )

        table.insert(
            scatter_table,
            {unilib.constant.y_min, -20, "stone_ordinary_with_copper", 163, 27, 28, 31}
        )

        table.insert(
            scatter_table,
            {unilib.constant.y_min, -250, "stone_ordinary_with_gold", 173, 32, 29, 27}
        )

    end

    if scatter_moreores_flag then

        -- N.B. Silver (but not mithril) is obtainable from the other non-optional minerals
        --      specified by the populate_ore_tables() function

        -- (From moreores)
        table.insert(
            scatter_table,
            {unilib.constant.y_min, -2, "stone_ordinary_with_silver", 173, 30, 31, 37}
        )
        table.insert(
            scatter_table,
            {unilib.constant.y_min, -512, "stone_ordinary_with_mithril", 185, 33, 28, 29}
        )

    elseif add_real_minerals_flag and add_real_minerals_extra_flag then

        -- When real_minerals packages enabled, make sure that both metal varieties are obtainable

        table.insert(
            scatter_table,
            {unilib.constant.y_min, -2, "stone_ordinary_with_silver", 173, 30, 31, 37}
        )

    end

    if scatter_technic_flag then

        -- N.B. All of these metals/minerals are obtainable from the other non-optional minerals
        --      specified by the populate_ore_tables() function

        -- (From technic)
        table.insert(
            scatter_table,
            {unilib.constant.y_min, -80, "stone_ordinary_with_chromium", 170, 28, 31, 33}
        )
        table.insert(
            scatter_table,
            {unilib.constant.y_min, -80, "stone_ordinary_with_lead", 170, 28, 35, 33}
        )
        table.insert(
            scatter_table,
            {-300, -80, "stone_ordinary_with_uranium", 170, 30, 31, 28}
        )
        table.insert(
            scatter_table,
            {unilib.constant.y_min, -80, "stone_ordinary_with_zinc", 170, 28, 37, 30}
        )

    end

    if scatter_xtraores_flag then

        -- N.B. None of these metals are obtainable from the other non-optional minerals specified
        --      by the populate_ore_tables() function

        -- (From xtraores)
        table.insert(
            scatter_table,
            {unilib.constant.y_min, -100, "stone_ordinary_with_planexium", 180, 35, 29, 28}
        )
        table.insert(
            scatter_table,
            {unilib.constant.y_min, -1000, "stone_ordinary_with_sybilline", 190, 29, 33, 34}
        )
        table.insert(
            scatter_table,
            {unilib.constant.y_min, -2000, "stone_ordinary_with_ozymandium", 195, 28, 30, 32}
        )
        table.insert(
            scatter_table,
            {unilib.constant.y_min, -5000, "stone_ordinary_with_adamantite", 200, 31, 32, 33}
        )
        table.insert(
            scatter_table,
            {unilib.constant.y_min, -10000, "stone_ordinary_with_rarium", 205, 30, 34, 37}
        )
        table.insert(
            scatter_table,
            {unilib.constant.y_min, -15000, "stone_ordinary_with_unobtainium", 210, 29, 37, 34}
        )
        table.insert(
            scatter_table,
            {unilib.constant.y_min, -20000, "stone_ordinary_with_tritonium", 215, 32, 29, 37}
        )
        table.insert(
            scatter_table,
            {unilib.constant.y_min, -25000, "stone_ordinary_with_geminitium", 220, 32, 33, 35}
        )

    end

    -- Now set up those ores
    for _, data_list in ipairs(blob_table) do

        distribute_blob({
            wherein = "all",
            ore = data_list[3],

            period = data_list[5],
            period2 = data_list[6],
            period3 = data_list[7],
            size = data_list[4],
            y_max = data_list[2],
            y_min = data_list[1],
        })

    end

    for _, data_list in ipairs(scatter_table) do

        distribute_scatter({
            wherein = "all",
            ore = data_list[3],

            period = data_list[5],
            period2 = data_list[6],
            period3 = data_list[7],
            scarcity = data_list[4],
            y_max = data_list[2],
            y_min = data_list[1],
        })

    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (optimised mode only)
---------------------------------------------------------------------------------------------------

local function pre_calculate_single_ores()

    -- Called by unilib.pkg.mapgen_hades.post() when "optimised_flag" is true
    -- Perform some pre-calculations on the probabilities for ores in each basic stone, reducing
    --      the amount of work that switch_stone_fast() has to do
    -- For a longer explanation, see the comments in switch_stone_fast()

    for stone_type, distrib_list in pairs(single_ore_table) do

        single_ore_total_chance_table[stone_type] = #distrib_list

        local max_chance = 0
        for _, distrib_table in pairs(distrib_list) do

            if max_chance < distrib_table.chance then
                max_chance = distrib_table.chance
            end

        end

        -- This value is multiplied by a height adjustment, and then tested against a random number
        single_ore_max_chance_table[stone_type] = max_chance * ore_factor_table[stone_type]

    end

end

local function create_simple_blobs()

    -- Called by unilib.pkg.mapgen_hades.post() when "optimised_flag" is true
    -- Create standard Minetest ore distributions for "blob" ores, which is much, much quicker than
    --      using the code in place_blob(); however, the blobs are equally common for all values of
    --      y

    -- Ore distributions that exist in all pseudo-biomes can be created immediately as ordinary
    --      Minetest ores
    -- For ore distributions that exist in specific pseudo-biomes, work out the maximum number per
    --      pseudo-biome, so that they can be distributed evenly
    local max_ores = 0
    for stone_type, distrib_list in pairs(blob_table) do

        local ore_count = 0
        for _, distrib_table in ipairs(distrib_list) do

            if stone_type == "all" then

                -- (Based loosely on the underch/init.lua distribution for clay)
                unilib.register_ore({
                    ore_type        = "blob",
                    ore             = distrib_table.ore,
                    wherein         = "unilib:stone_ordinary",

                    clust_scarcity  = distrib_table.period * distrib_table.period2 *
                                            distrib_table.period3 * special_blob_scarcity_factor,
                    clust_size      = 5,
                    noise_threshold = 0.0,
                    noise_params    = {
                        octaves = 1,
                        offset = 0.5,
                        persist = 0.0,
                        scale = 0.2,
                        seed = get_seed(),
                        spread = {x = 5, y = 5, z = 5},
                    },
                    y_max           = distrib_table.y_max,
                    y_min           = distrib_table.y_min,
                })

            else

                ore_count = ore_count + 1

            end

        end

        if max_ores < ore_count then
            max_ores = ore_count
        end

    end

    -- For ore distributions that exist in specific pseudo-biomes, generate some matrix nodes
    -- For pseudo-biomes that have the maximum number of ores, each matrix node will correspond to
    --      a single ore. For pseudo-biomes that have fewer than the maximum number of ores, we'll
    --      distribute the matrix nodes as evenly as we can
    if max_ores > 0 then

        for i = 1, max_ores do

            -- Create a matrix node, e.g. "unilib:misc_matrix_hades_blob_1"
            local full_name = unilib.pkg.misc_matrix_hades.do_blob_matrix(i)

            -- switch_stone_fast() uses IDs, not node names
            blob_matrix_id_table[core.get_content_id(full_name)] = i

            -- Create the ore distribution for that matrix node
            unilib.register_ore({
                ore_type        = "blob",
                ore             = full_name,
                wherein         = "unilib:stone_ordinary",

                clust_scarcity  = 16 * 16 * 16 * special_blob_scarcity_factor,
                clust_size      = 5,
                noise_threshold = 0.0,
                noise_params    = {
                    octaves = 1,
                    offset = 0.5,
                    persist = 0.0,
                    scale = 0.2,
                    seed = get_seed(),
                    spread = {x = 5, y = 5, z = 5},
                },
                y_max           = unilib.constant.y_max,
                y_min           = unilib.constant.y_min,
            })

        end

    end

    -- Generate a table, linking each stone_type/pseudo-biome to each of the matrix nodes, so we
    --      can quickly and easily switch them for the actual ore stone in the later call to
    --      switch_stone_fast()
    for stone_type, distrib_list in pairs(blob_table) do

        if stone_type ~= "all" then

            blob_convert_table[stone_type] = {}

            local ore_count = 0
            local index = 0

            while max_ores > ore_count do

                ore_count = ore_count + 1
                index = index + 1
                if index > #distrib_list then
                    index = 1
                end

                local distrib_table = distrib_list[index]
                table.insert(
                    blob_convert_table[stone_type], core.get_content_id(distrib_table.ore)
                )

            end

        end

    end

end

local function create_simple_scatters()

    -- Called by unilib.pkg.mapgen_hades.post() when "optimised_flag" is true
    -- Create standard Minetest ore distributions for "scatter" ores, which is much, much quicker
    --      than using the code in place_scatter()

    -- Ore distributions that exist in all pseudo-biomes can be created immediately as ordinary
    --      Minetest ores
    -- For ore distributions that exist in specific pseudo-biomes, work out the maximum number per
    --      pseudo-biome, so that they can be distributed evenly
    local max_ores = 0
    for stone_type, distrib_list in pairs(scatter_table) do

        local ore_count = 0
        for _, distrib_table in ipairs(distrib_list) do

            if stone_type == "all" then

                -- (Based loosely on the minetest_game/default distribution for coal ore)
                unilib.register_ore({
                    ore_type        = "scatter",
                    ore             = distrib_table.ore,
                    wherein         = "unilib:stone_ordinary",

                    clust_num_ores  = 27,
                    clust_scarcity  = 24 * 24 * 24,
                    clust_size      = 6,
                    y_max           = distrib_table.y_max,
                    y_min           = distrib_table.y_min,
                })

            else

                ore_count = ore_count + 1

            end

        end

        if max_ores < ore_count then
            max_ores = ore_count
        end

    end

    -- For ore distributions that exist in specific pseudo-biomes, generate some matrix nodes
    -- For pseudo-biomes that have the maximum number of ores, each matrix node will correspond to
    --      a single ore. For pseudo-biomes that have fewer than the maximum number of ores, we'll
    --      distribute the matrix nodes as evenly as we can
    if max_ores > 0 then

        for i = 1, max_ores do

            -- Create a matrix node, e.g. "unilib:misc_matrix_hades_scatter_1"
            local full_name = unilib.pkg.misc_matrix_hades.do_scatter_matrix(i)

            -- switch_stone_fast() uses IDs, not node names
            scatter_matrix_id_table[core.get_content_id(full_name)] = i

            -- Create the ore distribution for that matrix node
            unilib.register_ore({
                ore_type        = "scatter",
                ore             = full_name,
                wherein         = "unilib:stone_ordinary",

                clust_num_ores  = 27,
                clust_scarcity  = 24 * 24 * 24,
                clust_size      = 6,
                y_max           = unilib.constant.y_max,
                y_min           = unilib.constant.y_min,
            })

        end

    end

    -- Generate a table, linking each stone_type/pseudo-biome to each of the matrix nodes, so we
    --      can quickly and easily switch them for the actual ore stone in the later call to
    --      switch_stone_fast()
    for stone_type, distrib_list in pairs(scatter_table) do

        if stone_type ~= "all" then

            scatter_convert_table[stone_type] = {}

            local ore_count = 0
            local index = 0

            while max_ores > ore_count do

                ore_count = ore_count + 1
                index = index + 1
                if index > #distrib_list then
                    index = 1
                end

                local distrib_table = distrib_list[index]
                table.insert(
                    scatter_convert_table[stone_type], core.get_content_id(distrib_table.ore)
                )

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (adapted from underch)
---------------------------------------------------------------------------------------------------

local function populate_id_table()

    -- Copied from the same function in the "mapgen_underch_jit" package
    -- Before calling unilib.setup_biomes(), prepare a table containing Minetest IDs for every node
    --      referenced by this package

    -- Add the basic stone set
    for _, part_name in ipairs(basic_stone_list) do

        for _, ending in ipairs(ending_list) do

            local full_name = "unilib:stone_" .. part_name .. ending

            if core.registered_nodes[full_name] ~= nil then
                id_table["stone_" .. part_name .. ending] = core.get_content_id(full_name)
            end

        end

        -- "ending_list" doesn't contain the "_rubble" variant, because there is no such node as
        --      "unilib:stone_ordinary_rubble", but we still recognise rubbles in other stone types
        local full_name = "unilib:stone_" .. part_name .. "_rubble"
        if core.registered_nodes[full_name] ~= nil then
            id_table["stone_" .. part_name .. "_rubble"] = core.get_content_id(full_name)
        end

    end

    -- Add ordinary stone variants, which are replaced by stones from the basic stone set
    -- N.B. Minetest also creates dungeons from ordinary sandstone bricks/blocks and desert stone,
    --      but we don't handle them separatel; it's not worth the computational expense for such
    --      rare structures
    for _, ending in ipairs(ending_list) do

        local full_name = "unilib:stone_ordinary" .. ending

        if core.registered_nodes[full_name] ~= nil then
            id_table["stone_ordinary" .. ending] = core.get_content_id(full_name)
        end

    end

    -- Add other common nodes (commented-out lines are not actually used any more)
    for _, item_name in ipairs({
        -- Ordinary nodes                   -- Original shortcut / parent package
        "dirt_ordinary",                    -- c_dirt / dirt_ordinary
--      "liquid_lava_ordinary_source",      -- c_lava / liquid_lava_ordinary
--      "liquid_water_ordinary_source",     -- c_water / liquid_water_ordinary
    }) do
        id_table[item_name] = core.get_content_id("unilib:" .. item_name)
    end

end

local function switch_stone_slow(vi, data, item_name, x, y, z)

    -- Adapted from underch/worldgen.lua, underch.use_stone()
    -- Replaces ordinary stone nodes with the base stone for the current pseudo-biome
    -- Called by the tables generated by unilib.pkg.mapgen_hades.post(), only when
    --      optimised_flag is false

    local height_adjust = height_adjust_table[math.floor(y / 100)]

    if data[vi] == id_table["stone_ordinary"] then

        -- Create ore distributions for the specified pseudo-biome
        if not debug_disable_single_flag and single_ore_table[item_name] ~= nil then

            for _, distrib_table in ipairs(single_ore_table[item_name]) do

                if y <= distrib_table.y_max and
                        y >= distrib_table.y_min and
                        math.random() <
                            distrib_table.chance * ore_factor_table[item_name] * height_adjust then

                    -- (Replaces a call to unilib.pbiomes.ore(), which doesn't return a true/false
                    --      result, enabling us to return here)
                    data[vi] = id_table[distrib_table.ore]
                    return

                end

            end

        end

        if not debug_disable_blob_flag and blob_table[item_name] ~= nil then

            for _, distrib_table in ipairs(blob_table[item_name]) do

                if place_blob(vi, data, distrib_table, x, y, z) then
                    return
                end

            end

        end

        if not debug_disable_scatter_flag and scatter_table[item_name] ~= nil then

            for _, distrib_table in ipairs(scatter_table[item_name]) do

                if place_scatter(vi, data, distrib_table, x, y, z) then
                    return
                end

            end

        end

        -- Create ore distributions for all biomes
        if not debug_disable_single_flag and single_ore_table["all"] ~= nil then

            for _, distrib_table in ipairs(single_ore_table["all"]) do

                if y <= distrib_table.y_max and
                        y >= distrib_table.y_min and
                        math.random() <
                            distrib_table.chance * ore_factor_table["all"] * height_adjust then

                    -- (Replaces a call to unilib.pbiomes.ore(), which doesn't return a true/false
                    --      result, enabling us to return here)
                    data[vi] = id_table[distrib_table.ore]
                    return

                end

            end

        end

        if not debug_disable_blob_flag and blob_table["all"] ~= nil then

            for _, distrib_table in ipairs(blob_table["all"]) do

                if place_blob(vi, data, distrib_table, x, y, z) then
                    return
                end

            end

        end

        if not debug_disable_scatter_flag and scatter_table["all"] ~= nil then

            for _, distrib_table in ipairs(scatter_table["all"]) do

                if place_scatter(vi, data, distrib_table, x, y, z) then
                    return
                end

            end

        end

    end

    -- No ore placed, so place the characteristic stone for this pseudo-biome
    for _, ending in ipairs(ending_list) do

        --[[
        unilib.pbiomes.replace(
            vi,
            data,
            id_table["stone_ordinary" .. ending],
            id_table[item_name .. ending]
        )
        ]]--
        --[[
        if data[vi] == id_table["stone_ordinary" .. ending] then

            data[vi] = id_table[item_name .. ending]
            return

        end
        ]]--
        if data[vi] == id_table["stone_ordinary" .. ending] then

            if id_table[item_name .. ending] ~= nil then

                data[vi] = id_table[item_name .. ending]
                return

            elseif ending == "_cobble" and id_table[item_name .. "_rubble"] ~= nil then

                -- There is no unilib:stone_ordinary_rubble, but when other basic stones provide
                --      rubble instead of cobble, we can switch cobble for rubble
                data[vi] = id_table[item_name .. "_rubble"]
                return

            end

        end

    end

end

local function switch_stone_fast(vi, data, item_name, x, y, z)

    -- Adapted from underch/worldgen.lua, underch.use_stone()
    -- Replaces ordinary stone nodes with the base stone for the current pseudo-biome
    -- Called by the tables generated by unilib.pkg.mapgen_hades.post(), only when
    --      "optimised_flag" is true

    local height_adjust = height_adjust_table[math.floor(y / 100)]

    if not debug_disable_single_flag and data[vi] == id_table["stone_ordinary"] then

        -- When producing single ores (not including blobs and scatters, which are handled below),
        --      the non-optimised code in switch_stone_slow() works like this (ignoring adjustments
        --      for height, balanced ore distributions, and so on):
        --
        -- In "stone_X", fifty different ores can spawn. So
        --      single_ore_table["stone_X"] = list_of_tables
        -- ...in which each table represents a single ore
        --
        -- Each ore has (for example) a 0.001 chance of spawning. We test a random number against
        --      each ore, so in total there's a 0.001 * 50 = 0.05 chance of at least one ore
        --      spawning
        -- BUT, ores are always tested in the same order, so the last ore in the list would only
        --      spawn in the other 49 tests failed; this means that the list ore in the list
        --      spawns slightly less often than it would do, if it were the only ore in the list
        -- Also, testing 50 different ores for every stone node is computationally expensive
        --
        -- The optimised code in switch_stone_fast() works like this:
        --
        -- In "stone_x", we have already worked out which of the 50 ores has the highest chance of
        --      spawning. We generate a single random number, divide it by 50 (so the probability is
        --      the same as testing 50 different random numbers), then test that probability
        --      against the ore with the highest chance
        -- If the test succeeds, we then test the original random number (not multiplied by 50)
        --      against each of the 50 ores, starting at a random position in the list
        --
        -- N.B. In exchange for a tiny increase in execution speed, the two code blocks below have
        --      not been combined into a single function

        -- Create ore distributions for the specified pseudo-biome
        if single_ore_table[item_name] ~= nil then

            local ore_count = single_ore_total_chance_table[item_name]
            -- N.B. Dividing by half of 50, rather than by 50 as described above, produces results
            --      that are closer to the non-optimised code
--          local this_random = math.random() / ore_count
            local this_random = math.random() / (ore_count / 2)

            -- Test the random number against the ore with the highest probability
            if this_random < single_ore_max_chance_table[item_name] * height_adjust then

                -- Test passed; one of the ores in this basic stone will be spawned. Start searching
                --      for one at a random position in the list
                local start = math.random(1, ore_count)
                local index = start

                while true do

                    local distrib_table = single_ore_table[item_name][index]
                    if y <= distrib_table.y_max and
                            y >= distrib_table.y_min and
                            this_random < distrib_table.chance * ore_factor_table[item_name] *
                                    height_adjust then

                        -- (Replaces a call to unilib.pbiomes.ore(), which doesn't return a true/
                        --      false result, enabling us to return here)
                        data[vi] = id_table[distrib_table.ore]
                        return

                    end

                    index = index + 1
                    if index > ore_count then
                        index = 1
                    end

                    if index == start then
                        break
                    end

                end

            end

        end

        -- Create ore distributions for all biomes
        if single_ore_table["all"] ~= nil then

            local this_random = math.random()
            local ore_count = single_ore_total_chance_table["all"]

            -- Test the random number against the ore with the highest probability
            if this_random / ore_count < single_ore_max_chance_table["all"] * height_adjust then

                -- Test passed; one of the ores in this basic stone will be spawned. Start searching
                --      for one at a random position in the list
                local start = math.random(1, ore_count)
                local index = start

                while true do

                    index = index + 1
                    if index > ore_count then
                        index = 1
                    elseif index == start then
                        break
                    end

                    local distrib_table = single_ore_table["all"][index]
                    if y <= distrib_table.y_max and
                            y >= distrib_table.y_min and
                            this_random < distrib_table.chance * ore_factor_table["all"] *
                                    height_adjust then

                        -- (Replaces a call to unilib.pbiomes.ore(), which doesn't return a true/
                        --      false result, enabling us to return here)
                        data[vi] = id_table[distrib_table.ore]
                        return

                    end

                end

            end

        end

    elseif blob_matrix_id_table[data[vi]] ~= nil then

        if blob_convert_table[item_name] ~= nil then

--          local index = blob_matrix_id_table[data[vi]]
--          data[vi] = blob_convert_table[item_name][index]
            data[vi] = blob_convert_table[item_name][blob_matrix_id_table[data[vi]]]

        else

            -- (No value corresponding to the key "item_name" in "blob_convert_table", if there are
            --      no blobs for this specific pseudo-biome, so just replace the matrix node with
            --      the basic stone)
            unilib.pbiomes.replace(
                vi,
                data,
                data[vi],
                id_table[item_name]
            )

        end

        return

    elseif scatter_matrix_id_table[data[vi]] ~= nil then

        if scatter_convert_table[item_name] ~= nil then

--          local index = scatter_matrix_id_table[data[vi]]
--          data[vi] = scatter_convert_table[item_name][index]
            data[vi] = scatter_convert_table[item_name][scatter_matrix_id_table[data[vi]]]

        else

            -- (No value corresponding to the key "item_name" in "scatter_convert_table", if there
            --      are no scatters for this specific pseudo-biome, so just replace the matrix node
            --      with the basic stone)
            unilib.pbiomes.replace(
                vi,
                data,
                data[vi],
                id_table[item_name]
            )

        end

        return

    end

    -- No ore placed, so place the characteristic stone for this pseudo-biome
    for _, ending in ipairs(ending_list) do

        --[[
        unilib.pbiomes.replace(
            vi,
            data,
            id_table["stone_ordinary" .. ending],
            id_table[item_name .. ending]
        )
        ]]--
        --[[
        if data[vi] == id_table["stone_ordinary" .. ending] then

            data[vi] = id_table[item_name .. ending]
            return

        end
        ]]--
        if data[vi] == id_table["stone_ordinary" .. ending] then

            if id_table[item_name .. ending] ~= nil then

                data[vi] = id_table[item_name .. ending]
                return

            elseif ending == "_cobble" and id_table[item_name .. "_rubble"] ~= nil then

                -- There is no unilib:stone_ordinary_rubble, but when other basic stones provide
                --      rubble instead of cobble, we can switch cobble for rubble
                data[vi] = id_table[item_name .. "_rubble"]
                return

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mapgen_hades.init()

    return {
        description = "Pseudo-biomes for the \"hades\" remix",
        notes = "A simplistic implementation of PFAA Geologica's geology system, partly based" ..
                " on the underground challenge (underch) mod, but with a completely new set" ..
                " of stones and ores, which are placed in a semi-realistic way, but making no" ..
                " effort to reproduce strata, pipes or other real-world geological formations" ..
                " (as PFAA tried to do). As in underch, each underground biome (pseudo-biome)" ..
                " has a characteristic basic stone, each with a characteristic set of ores." ..
                " This package assumes that all packages listed in the \"hades\" remix have been" ..
                " executed (rather than listing them all here as dependencies)",
        excludes = {"mapgen_hades_jit", "mapgen_underch", "mapgen_underch_jit"},
        depends = {"misc_matrix_hades", "stone_ordinary"},
    }

end

function unilib.pkg.mapgen_hades.post()

    -- Load files in ../lib/shared/pbiomes/
    unilib.pbiomes.load()

    -- Basic check: if a suitable remix has not been loaded, the stones may not exist
    for _, part_name in pairs(basic_stone_list) do

        if core.registered_nodes["unilib:stone_" .. part_name] == nil then

            unilib.utils.show_warning(
                "mapgen_hades package, post(): Aborting because of a non-existent node" ..
                        " (\"unilib:stone_" .. part_name .. "\"); this package requires the" ..
                        " \"hades\" remix, or a suitable replacement providing the same" ..
                        " selection of packages"
            )

            return

        end

    end

    local basic_stone_count = #basic_stone_list

    -- If the debug flag is set, make basic stone nodes glow a little
    illuminate_nodes()

    -- The VoxelManip object works by switching nodes, comparing their Minetest IDs
    populate_id_table()

    -- Set up ore distribution tables
    populate_ore_tables()
    populate_optional_ore_tables()

    -- If permitted, balance the number of ores in each pseudo-biome, compiling "ore_factor_table"
    balance_ores(basic_stone_count)
    -- If permitted, apply a height adjustment, so that ores are more common, the deeper one goes
    prepare_height_adjust()

    -- Set up pseudo-biomes
    local pbiome_table = {}
    if not optimised_flag then

        for i = 1, #basic_stone_list do

            if force_biome == nil then

                pbiome_table[i] = function(x, y, z, vi, data, p2data, area, lastlayer)
                    switch_stone_slow(vi, data, "stone_" .. basic_stone_list[i], x, y, z)
                end

            else

                pbiome_table[i] = function(x, y, z, vi, data, p2data, area, lastlayer)
                    switch_stone_slow(vi, data, "stone_" .. basic_stone_list[force_biome], x, y, z)
                end

            end

        end

    else

        for i = 1, #basic_stone_list do

            if force_biome == nil then

                pbiome_table[i] = function(x, y, z, vi, data, p2data, area, lastlayer)
                    switch_stone_fast(vi, data, "stone_" .. basic_stone_list[i], x, y, z)
                end

            else

                pbiome_table[i] = function(x, y, z, vi, data, p2data, area, lastlayer)
                    switch_stone_fast(vi, data, "stone_" .. basic_stone_list[force_biome], x, y, z)
                end

            end

        end

    end

    unilib.pbiomes.setup(pbiome_table)

    if optimised_flag then

        -- In optimised mode, set up ore distributions for the contents of "blob_table" and
        --      "scatter_table"
        if not debug_disable_blob_flag then
            create_simple_blobs()
        end

        if not debug_disable_scatter_flag then
            create_simple_scatters()
        end

        -- We also do some pre-calculations for "single_ore_table", see the comments in
        --      switch_stone_fast()
        if not debug_disable_single_flag then
            pre_calculate_single_ores()
        end

    end

    -- Show a list of basic stones that have no ores, if required
    if debug_no_ore_flag then

        for i = 1, basic_stone_count do

            local part_name = basic_stone_list[i]

            if single_ore_table["stone_" .. part_name] == nil and
                    blob_table["stone_" .. part_name] == nil and
                    scatter_table["stone_" .. part_name] == nil then
                unilib.utils.show_msg("mapgen_hades package: basic stone has no ores", part_name)
            end

        end

    end

end
