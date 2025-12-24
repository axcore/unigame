---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    badlands
-- Code:    LGPL-3.0
-- Media:   LGPL-3.0
--
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
--
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
--
-- From:    moreores
-- Code:    zlib
-- Media:   CC BY-SA 3.0
--
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
--
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
--
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_gaia = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- For ore seeds we use a base value which is incremented, whenever an ore distribution is generated
local base_seed = unilib.utils.get_mod_attribute("storage_random_seed_offset")

-- For minerals that appear in stones, a list of all stones used as each biome's .node_stone
local stone_list = {
    "stone_andesite_grey",      -- extrusive
    "stone_basalt_brown",       -- extrusive
    "stone_basalt_dark",        -- extrusive
    "stone_bluestone",          -- other
    "stone_brownstone_dark",    -- sedimentary
    "stone_brownstone_pale",    -- sedimentary
    "stone_desert",             -- other
    "stone_diorite_dark",       -- intrusive
    "stone_gabbro_red",         -- intrusive
    "stone_gneiss_brown",       -- metamorphic
    "stone_granite_dark",       -- intrusive
    "stone_granite_orange",     -- intrusive
    "stone_granite_pink",       -- intrusive
    "stone_granite_white",      -- intrusive
    "stone_greenstone",         -- metamorphic
    "stone_limestone_beige",    -- sedimentary
    "stone_limestone_red",      -- sedimentary
    "stone_limestone_white",    -- sedimentary
    "stone_ordinary",           -- other
    "stone_quartzite_brown",    -- metamorphic
    "stone_quartzite_red",      -- metamorphic
    "stone_sandstone_barren",   -- sedimentary
    "stone_sandstone_beige",    -- sedimentary
    "stone_sandstone_brown",    -- sedimentary
    "stone_sandstone_desert",   -- sedimentary
    "stone_sandstone_ordinary", -- sedimentary
    "stone_sandstone_pink",     -- sedimentary
    "stone_sandstone_silver",   -- sedimentary
    "stone_sandstone_white",    -- sedimentary
    "stone_schist_grey",        -- metamorphic
    "stone_serpentinite_dark",  -- metamorphic
    "stone_serpentinite_pale",  -- metamorphic
    "stone_travertine",         -- sedimentary
}
-- The same collection of stones, sorted by type. Three stones in the "other" category have been
--      added to the metamorphic list for balance
local extrusive_intrusive_list = {
    "stone_andesite_grey",
    "stone_basalt_brown",
    "stone_basalt_dark",
    "stone_diorite_dark",
    "stone_gabbro_red",
    "stone_granite_dark",
    "stone_granite_orange",
    "stone_granite_pink",
    "stone_granite_white",
}
local metamorphic_list = {
    "stone_bluestone",
    "stone_desert",
    "stone_gneiss_brown",
    "stone_greenstone",
    "stone_ordinary",
    "stone_quartzite_brown",
    "stone_quartzite_red",
    "stone_schist_grey",
    "stone_serpentinite_dark",
    "stone_serpentinite_pale",
}
local sedimentary_list = {
    "stone_brownstone_dark",
    "stone_brownstone_pale",
    "stone_limestone_beige",
    "stone_limestone_red",
    "stone_limestone_white",
    "stone_sandstone_barren",
    "stone_sandstone_beige",
    "stone_sandstone_brown",
    "stone_sandstone_desert",
    "stone_sandstone_ordinary",
    "stone_sandstone_pink",
    "stone_sandstone_silver",
    "stone_sandstone_white",
    "stone_travertine",
}

-- Lowest level at which these ores apply (may be overriden by the code below)
local y_min = unilib.constant.y_min
-- Don't place ores where hades/underch remixes are already placing ores (set in the .post()
--      function)
local underworld_y_max = nil

-- Table identical to the one used in ../lib/shared/stone/stone_smooth.lua, converting a PFAA
--      hardness (in the range 1-5) into a Minetest cracky group
local smooth_cracky_table = {3, 2, 1, 1, 1}

-- Flag set to true if original ores (created in calls to register_ore_special() ) should be visible
--      in the creative inventory, false if not. (By default, this package generates a great number
--      of ores, so hiding them is probably beneficial)
local show_ores_in_inventory_flag = false
-- Flag set to true if new stone-with-ore nodes should be created (e.g. red gabbro with coal) so
--      that the nodes match the surrounding non-ore nodes; false if the code should use pre-
--      existing ore nodes (e.g. ordinary stone with coal) so that the ores usually don't match
--      their surroundings
local create_new_ores_flag = true

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_seed()

    -- Original to unilib
    -- Called when each ore is generated to produce a unique seed for it, that is consistent across
    --      sessions (because it is based on the "storage_random_seed_offset" attribute)

    base_seed = base_seed + 1
    return base_seed

end

local function register_ore(def_table)

    -- Don't place ores where hades/underch remixes are already placing ores
    if underworld_y_max ~= nil then

        if def_table.y_max < underworld_y_max then
            return
        elseif def_table.y_min < underworld_y_max then
            def_table.y_min = underworld_y_max
        end

    end

    unilib.register_ore(def_table)

end

local function register_ore_special(data_table, def_table)

    -- Special function so that stone-with-ore nodes match their surrounding stone nodes (instead
    --      of placing ordinary-stone-with-ore nodes everywhere)

    if not create_new_ores_flag then

        -- Do, in fact, place ordinary-stone-with-ore nodes everywhere

        local wherein_list = {}
        for _, item_name in ipairs(def_table.wherein) do
            table.insert(wherein_list, "unilib:" .. item_name)
        end

        def_table.wherein = wherein_list
        return register_ore(def_table)

    end

    -- Create new nodes for each stone-metal/mineral combination (but don't create duplicates)
    for _, item_name in ipairs(def_table.wherein) do

        local stone_name = "unilib:" .. item_name
        local ore_name
        local img = core.registered_nodes[stone_name].tiles[1]
        -- The hardness of the new ore stone is the hardness of its mineral/metal
        local level = 2

        if data_table.metal ~= nil then

            ore_name = stone_name .. "_with_" .. data_table.metal
            img = img .. "^unilib_metal_" .. data_table.metal .. ".png"
            if unilib.global.metal_table[data_table.metal] ~= nil then
                level = unilib.global.metal_table[data_table.metal].hardness
            end

        elseif data_table.mineral ~= nil then

            ore_name = stone_name .. "_with_" .. data_table.mineral
            img = img .. "^unilib_mineral_" .. data_table.mineral .. ".png"
            if unilib.global.mineral_table[data_table.mineral] ~= nil then
                level = unilib.global.mineral_table[data_table.mineral].hardness
            end

        else

            unilib.utils.show_warning("ore_gaia package, register_ore_special(): Invalid arguments")
            return

        end

        -- Don't register duplicate ore nodes
        if core.registered_nodes[ore_name] == nil then

            local inv_hide = nil
            if not show_ores_in_inventory_flag then
                inv_hide = 1
            end

            -- Create the ore node
            unilib.register_node(ore_name, nil, mode, {
                -- Original to unilib
                description = unilib.utils.brackets(
                    core.registered_nodes[stone_name].description, data_table.description
                ),
                tiles = {img},
                groups = {
                    cracky = smooth_cracky_table[level],
                    -- N.B. level group removed to allow basic ores (like iron) to be dug with
                    --      basic tools (like stone picks). Compare the equivalent code in the
                    --      "mapgen_hades" (etc) package, in which the level group is NOT removed
--                  level = level,
                    not_in_creative_inventory = inv_hide,
                    ore = 1,
                },
                sounds = unilib.global.sound_table.stone,

                drop = {
                    max_items = 1,
                    items = {
                        -- N.B. rarity = 3, more rare than the equivalent "hades" code, rarity = 2
                        {items = {data_table.output .. " 2"}, rarity = 3},
                        {items = {data_table.output}},
                    },
                },
            })

        end

        -- After creating a unique table for each ore, register the ore distribution
        local adj_def_table = table.copy(def_table)
        adj_def_table.ore = ore_name
        adj_def_table.wherein = stone_name

        register_ore(adj_def_table)

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_gaia.init()

    return {
        description = "Ores for \"gaia\"-compatible remixes",
        notes = "Ore distributions are mostly as they are in original mods, except that here they"
                .. " occur in a wider range of stones. Very common ores (like iron) occur in all"
                .. " stones in the selection; less common ones (such as silver from moreores)"
                .. " occur in a sub-selection of stones",
        depends = {
            -- Wherein stones
            "clay_baked_basic",
            "stone_andesite_grey",
            "stone_basalt_dark",
            "stone_bluestone",
            "stone_brownstone_dark",
            "stone_desert",
            "stone_limestone_white",
            "stone_gabbro_red",
            "stone_gneiss_brown",
            "stone_granite_dark",
            "stone_granite_white",
            "stone_limestone_red",
            "stone_ordinary",
            "stone_sandstone_barren",
            "stone_sandstone_brown",
            "stone_sandstone_golden",
            "stone_sandstone_ordinary",
            "stone_sandstone_pink",
            "stone_sandstone_silver",
            "stone_sandstone_white",
            "stone_schist_grey",
            -- Ore stones/sands/clays/minerals
            "clay_brown",
            "clay_ordinary",
            "clay_red",
            "dirt_black",
            "dirt_brown",
            "dirt_clayey",
            "dirt_coarse",
            "dirt_dark",
            "dirt_ordinary",
            "dirt_peat_with_oil_crude",
            "dirt_peat_with_shale",
            "dirt_sandy",
            "dirt_silt_coarse",
            "dirt_silt_fine",
            "gravel_ordinary",
            "gravel_mossy",
            "mineral_mese",
            "sand_desert",
            "sand_ordinary",
            "sand_ordinary_with_oil_crude",
            "sand_quicksand",
            "sand_silver",
            "stone_chalk_white",
            "stone_granite_dark",
            "stone_marble_brown",
            "stone_ordinary_with_chromium",
            "stone_ordinary_with_coal",
            "stone_ordinary_with_copper",
            "stone_ordinary_with_diamond",
            "stone_ordinary_with_gold",
            "stone_ordinary_with_iron",
            "stone_ordinary_with_lead",
            "stone_ordinary_with_mese",
            "stone_ordinary_with_mithril",
            "stone_ordinary_with_silver",
            "stone_ordinary_with_sulphur",
            "stone_ordinary_with_tin",
            "stone_ordinary_with_uranium",
            "stone_ordinary_with_zinc",
            "stone_sandstone_old_red",
            "stone_tuff",
            "stone_tuff_rhyolitic",
            -- Other dependencies
            "liquid_lava_ordinary",
        },
        -- The "gaia" remix is compatible with the following underworld pseudo-biome remixes, and
        --      if any of them are loaded, it won't generate ores in the space they occupy
        optional = {"mapgen_hades", "mapgen_hades_jit", "mapgen_underch", "mapgen_underch_jit"},
    }

end

function unilib.pkg.ore_gaia.post()

    -- Don't place ores where hades/underch remixes are already placing ores
    if unilib.global.pkg_executed_table["mapgen_hades"] ~= nil or
            unilib.global.pkg_executed_table["mapgen_hades_jit"] ~= nil or
            unilib.global.pkg_executed_table["mapgen_underch"] ~= nil or
            unilib.global.pkg_executed_table["mapgen_underch_jit"] ~= nil then

        underworld_y_max = tonumber(unilib.pkg.biome_gaia.constant_table["OCEAN"])
        -- Code below won't work if OCEAN has been set to 0, for some reason; guard against that
        --      remote possibility
        if underworld_y_max == 0 then
            underworld_y_max = 1
        end

    end

    -- Mineral distributions from minetest_game

    -- Coal
    local coal_table = {
        mineral = "coal",
        description = S("Coal"),
        output = "unilib:mineral_coal_lump",
    }

    register_ore_special(coal_table, {
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_coal",
        wherein                 = stone_list,

        clust_num_ores          = 9,
        clust_scarcity          = 8 * 8 * 8,
        clust_size              = 3,
        y_max                   = unilib.constant.y_max,
        y_min                   = 1025,
    })

    register_ore_special(coal_table, {
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_coal",
        wherein                 = stone_list,

        clust_num_ores          = 8,
        clust_scarcity          = 8 * 8 * 8,
        clust_size              = 3,
        y_max                   = 64,
        y_min                   = -127,
    })

    register_ore_special(coal_table, {
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_coal",
        wherein                 = stone_list,

        clust_num_ores          = 30,
        clust_scarcity          = 12 * 12 * 12,
        clust_size              = 5,
        y_max                   = -128,
        y_min                   = y_min,
    })

    -- Copper
    local copper_table = {
        metal = "copper",
        description = S("Copper"),
        output = "unilib:metal_copper_lump",
    }

    register_ore_special(copper_table, {
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_copper",
        wherein                 = stone_list,

        clust_num_ores          = 5,
        clust_scarcity          = 9 * 9 * 9,
        clust_size              = 3,
        y_max                   = unilib.constant.y_max,
        y_min                   = 1025,
    })

    register_ore_special(copper_table, {
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_copper",
        wherein                 = stone_list,

        clust_num_ores          = 4,
        clust_scarcity          = 12 * 12 * 12,
        clust_size              = 3,
        y_max                   = -64,
        y_min                   = -127,
    })

    register_ore_special(copper_table, {
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_copper",
        wherein                 = stone_list,

        clust_num_ores          = 5,
        clust_scarcity          = 9 * 9 * 9,
        clust_size              = 3,
        y_max                   = -128,
        y_min                   = y_min,
    })

    -- Diamond
    local diamond_table = {
        mineral = "diamond",
        description = S("Diamond"),
        output = "unilib:mineral_diamond_gem",
    }

    register_ore_special(diamond_table, {
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_diamond",
        wherein                 = stone_list,

        clust_num_ores          = 4,
        clust_scarcity          = 15 * 15 * 15,
        clust_size              = 3,
        y_max                   = unilib.constant.y_max,
        y_min                   = 1025,
    })

    register_ore_special(diamond_table, {
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_diamond",
        wherein                 = stone_list,

        clust_num_ores          = 4,
        clust_scarcity          = 17 * 17 * 17,
        clust_size              = 3,
        y_max                   = -1024,
        y_min                   = -2047,
    })

    register_ore_special(diamond_table, {
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_diamond",
        wherein                 = stone_list,

        clust_num_ores          = 4,
        clust_scarcity          = 15 * 15 * 15,
        clust_size              = 3,
        y_max                   = -2048,
        y_min                   = y_min,
    })

    -- Gold
    local gold_table = {
        metal = "gold",
        description = S("Gold"),
        output = "unilib:metal_gold_lump",
    }

    register_ore_special(gold_table, {
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_gold",
        wherein                 = stone_list,

        clust_num_ores          = 5,
        clust_scarcity          = 13 * 13 * 13,
        clust_size              = 3,
        y_max                   = unilib.constant.y_max,
        y_min                   = 1025,
    })

    register_ore_special(gold_table, {
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_gold",
        wherein                 = stone_list,

        clust_num_ores          = 3,
        clust_scarcity          = 15 * 15 * 15,
        clust_size              = 2,
        y_max                   = -256,
        y_min                   = -511,
    })

    register_ore_special(gold_table, {
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_gold",
        wherein                 = stone_list,

        clust_num_ores          = 5,
        clust_scarcity          = 13 * 13 * 13,
        clust_size              = 3,
        y_max                   = -512,
        y_min                   = y_min,
    })

    -- Iron
    local iron_table = {
        metal = "iron",
        description = S("Iron"),
        output = "unilib:metal_iron_lump",
    }

    register_ore_special(iron_table, {
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_iron",
        wherein                 = stone_list,

        clust_num_ores          = 12,
        clust_scarcity          = 9 * 9 * 9,
        clust_size              = 3,
        y_max                   = unilib.constant.y_max,
        y_min                   = 1025,
    })

    register_ore_special(iron_table, {
        -- Original to unilib (mtgame has no iron at this range, unless the v6 mapgen is being used;
        --      this is a compromise between the two)
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_iron",
        wherein                 = stone_list,

        clust_num_ores          = 5,
        clust_scarcity          = 11 * 11 * 11,
        clust_size              = 3,
        y_max                   = -16,
        y_min                   = -127,
    })

    register_ore_special(iron_table, {
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_iron",
        wherein                 = stone_list,

        clust_num_ores          = 5,
        clust_scarcity          = 7 * 7 * 7,
        clust_size              = 3,
        y_max                   = -128,
        y_min                   = -255,
    })

    register_ore_special(iron_table, {
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_iron",
        wherein                 = stone_list,

        clust_num_ores          = 29,
        clust_scarcity          = 12 * 12 * 12,
        clust_size              = 5,
        y_max                   = -256,
        y_min                   = y_min,
    })

    -- Mese crystal
    local mese_table = {
        mineral = "mese",
        description = S("Mese"),
        output = "unilib:mineral_mese_crystal",
    }

    register_ore_special(mese_table, {
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_mese",
        wherein                 = stone_list,

        clust_num_ores          = 5,
        clust_scarcity          = 14 * 14 * 14,
        clust_size              = 3,
        y_max                   = unilib.constant.y_max,
        y_min                   = 1025,
    })

    register_ore_special(mese_table, {
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_mese",
        wherein                 = stone_list,

        clust_num_ores          = 3,
        clust_scarcity          = 18 * 18 * 18,
        clust_size              = 2,
        y_max                   = -512,
        y_min                   = -1023,
    })

    register_ore_special(mese_table, {
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_mese",
        wherein                 = stone_list,

        clust_num_ores          = 5,
        clust_scarcity          = 14 * 14 * 14,
        clust_size              = 3,
        y_max                   = -1024,
        y_min                   = y_min,
    })

    -- Mese block
    register_ore({
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:mineral_mese_block",
        wherein                 = stone_list,

        clust_num_ores          = 3,
        clust_scarcity          = 36 * 36 * 36,
        clust_size              = 2,
        y_max                   = unilib.constant.y_max,
        y_min                   = 1025,
    })

    register_ore({
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:mineral_mese_block",
        wherein                 = stone_list,

        clust_num_ores          = 3,
        clust_scarcity          = 36 * 36 * 36,
        clust_size              = 2,
        y_max                   = -2048,
        y_min                   = -4095,
    })

    register_ore({
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:mineral_mese_block",
        wherein                 = stone_list,

        clust_num_ores          = 5,
        clust_scarcity          = 28 * 28 * 28,
        clust_size              = 3,
        y_max                   = -4096,
        y_min                   = y_min,
    })

    -- Tin
    local tin_table = {
        metal = "tin",
        description = S("Tin"),
        output = "unilib:metal_tin_lump",
    }

    register_ore_special(tin_table, {
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_tin",
        wherein                 = stone_list,

        clust_num_ores          = 5,
        clust_scarcity          = 10 * 10 * 10,
        clust_size              = 3,
        y_max                   = unilib.constant.y_max,
        y_min                   = 1025,
    })

    register_ore_special(tin_table, {
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_tin",
        wherein                 = stone_list,

        clust_num_ores          = 4,
        clust_scarcity          = 13 * 13 * 13,
        clust_size              = 3,
        y_max                   = -64,
        y_min                   = -127,
    })

    register_ore_special(tin_table, {
        -- From default/mapgen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_tin",
        wherein                 = stone_list,

        clust_num_ores          = 5,
        clust_scarcity          = 10 * 10 * 10,
        clust_size              = 3,
        y_max                   = -128,
        y_min                   = y_min,
    })

    -- Stone ore distributions from minetest_game

    -- Ordinary clay
    register_ore({
        -- From default/mapgen.lua
        ore_type                = "blob",
        ore                     = "unilib:clay_ordinary",
        wherein                 = "unilib:sand_ordinary",

--      clust_scarcity          = 16 * 16 * 16,
        clust_scarcity          = 18 * 18 * 18,
        clust_size              = 5,
        noise_params            = {
            octaves = 1,
            offset = 0.5,
            persist = 0.0,
            scale = 0.2,
            seed = get_seed(),
            spread = {x = 5, y = 5, z = 5},
        },
        noise_threshold         = 0.0,
        y_max                   = 0,
        y_min                   = -15,
    })

    -- Various dirts (including clays used as a basic dirt type in the "gaia" remix)
    -- In the original minetest_game code, only default dirt was used, and it appeared only in
    --      biomes that had default dirt on the surface; here a selection of common "gaia" remix
    --      dirts can appear in any biome (but only below the surface)
    for _, full_name in pairs({
        "unilib:clay_red",
        "unilib:dirt_black",
        "unilib:dirt_brown",
        "unilib:dirt_clayey",
        "unilib:dirt_coarse",
        "unilib:dirt_dark",
        "unilib:dirt_ordinary",
        "unilib:dirt_peat_with_oil_crude",
        "unilib:dirt_peat_with_shale",
        "unilib:dirt_sandy",
        "unilib:dirt_silt_coarse",
        "unilib:dirt_silt_fine",
    }) do

        register_ore({
            -- Adapted from default/mapgen.lua
            ore_type                = "blob",
            ore                     = full_name,
            wherein                 = stone_list,

--          clust_scarcity          = 16 * 16 * 16,
            clust_scarcity          = 24 * 24 * 24,
            clust_size              = 5,
            noise_params            = {
                octaves = 1,
                offset = 0.5,
                persist = 0.0,
                scale = 0.2,
                seed = get_seed(),
                spread = {x = 5, y = 5, z = 5},
            },
            noise_threshold         = 0.0,
            y_max                   = -2,
            y_min                   = y_min,
        })

    end

    -- Ordinary gravel
    register_ore({
        -- From default/mapgen.lua
        ore_type                = "blob",
        ore                     = "unilib:gravel_ordinary",
        wherein                 = stone_list,

--      clust_scarcity          = 16 * 16 * 16,
        clust_scarcity          = 18 * 18 * 18,
        clust_size              = 5,
        noise_params            = {
            octaves = 1,
            offset = 0.5,
            persist = 0.0,
            scale = 0.2,
            seed = get_seed(),
            spread = {x = 5, y = 5, z = 5},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.constant.y_max,
        y_min                   = y_min,
    })

    -- Ordinary, desert and silver sand (based on an original distribution providing only desert
    --      sand)
    for i, full_name in pairs({
        "unilib:sand_desert",
        "unilib:sand_ordinary",
        "unilib:sand_ordinary_with_oil_crude",
        "unilib:sand_silver",
    }) do

        register_ore({
            -- From default/mapgen.lua
            ore_type                = "blob",
            ore                     = full_name,
            wherein                 = stone_list,

--          clust_scarcity          = 16 * 16 * 16,
            clust_scarcity          = 20 * 20 * 20,
            clust_size              = 5,
            noise_params            = {
                octaves = 1,
                offset = 0.5,
                persist = 0.0,
                scale = 0.2,
                seed = get_seed(),
                spread = {x = 5, y = 5, z = 5},
            },
            noise_threshold         = 0.0,
            y_max                   = unilib.constant.y_max,
            y_min                   = y_min,
        })

    end

    -- Mineral distributions from badlands (here, provides extra gold in hot humid and mild humid
    --      biomes)
    register_ore_special(gold_table, {
        -- From badlands/init.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_gold",
        wherein                 = {
            "clay_baked_orange",
            "stone_sandstone_golden",
        },

        biomes                  = {
            "gaia_hot_arid_lowland",
            "gaia_hot_arid_shelf",
            "gaia_hot_arid_highland",
            "gaia_mild_arid_lowland",
            "gaia_mild_arid_shelf",
            "gaia_mild_arid_highland",
        },
        clust_num_ores          = 8,
        clust_scarcity          = 9 * 9 * 9,
        clust_size              = 4,
        y_max                   = -10,
        y_min                   = -64,
    })

    -- Stone ore distributions from darkage (here, found in extrusive/intrusive stone only; desert
    --      stone with iron has been omitted)

    -- White chalk
    register_ore({
        -- From darkage/mapgen.lua
        ore_type                = "sheet",
        ore                     = "unilib:stone_chalk_white",
        wherein                 = extrusive_intrusive_list,

        column_height_max       = 30,
        column_height_min       = 20,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persistence = 0.6,
            scale = 0.2,
            spread = {x = 30, y = 30, z = 30},
        },
        noise_threshold         = 0.45,
        y_max                   = 50,
        y_min                   = -20,
    })

    -- Old red sandstone
    register_ore({
        -- From darkage/mapgen.lua
        ore_type                = "sheet",
        ore                     = "unilib:stone_sandstone_old_red",
        wherein                 = extrusive_intrusive_list,


        column_height_max       = 8,
        column_height_min       = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.28,
            persistence = 0.6,
            scale = 0.3,
            seed = get_seed(),
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.49,
        y_max                   = 500,
        y_min                   = -200,
    })

    -- Tuff
    register_ore({
        -- From darkage/mapgen.lua
        ore_type                = "sheet",
        ore                     = "unilib:stone_tuff",
        wherein                 = extrusive_intrusive_list,


        column_height_max       = 20,
        column_height_min       = 15,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persistence = 0.6,
            scale = 0.19,
            seed = get_seed(),
            spread = {x = 45, y = 45, z = 45},
        },
        noise_threshold         = 0.5,
        y_max                   = 200,
        y_min                   = -200,
    })

    -- Rhyolitic tuff
    register_ore({
        -- From darkage/mapgen.lua
        ore_type                = "sheet",
        ore                     = "unilib:stone_tuff_rhyolitic",
        wherein                 = extrusive_intrusive_list,

        column_height_max       = 20,
        column_height_min       = 15,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persistence = 0.6,
            scale = 0.2,
            seed = get_seed(),
            spread = {x = 100, y = 100, z = 100},
        },
        noise_threshold         = 0.53,
        y_max                   = 200,
        y_min                   = -2000,
    })

    -- Sand distributions from GLEMr4
    -- Tweaked the original distribution because there was far too much quicksand (but, strangely,
    --      none at all in beaches)
    --[[
    register_ore({
        -- From GLEMr4
        ore_type                = "blob",
        ore                     = "unilib:sand_quicksand",
        wherein                 = "unilib:sand_ordinary",

        clust_num_ores          = 8,
        clust_scarcity          = 4 * 4 * 4,
        clust_size              = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.5,
            scale = 0.2,
            seed = get_seed(),
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = 30,
        y_min                   = 4,
    })
    ]]--
    register_ore({
        -- From GLEMr4
        ore_type                = "blob",
        ore                     = "unilib:sand_quicksand",
        wherein                 = "unilib:sand_ordinary",

        clust_num_ores          = 8,
        clust_scarcity          = 10 * 10 * 10,
        clust_size              = 6,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persist = 0.5,
            scale = 0.2,
            seed = get_seed(),
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = 8,
        y_min                   = 1,
    })

    -- Metal/mineral distributions from moreores (here, found in metamorphic stone only)

    -- Mithril
    local mithril_table = {
        metal = "mithril",
        description = S("Mithril"),
        output = "unilib:metal_mithril_lump",
    }

    register_ore_special(mithril_table, {
        -- From moreores/init.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_mithril",
        wherein                 = metamorphic_list,

        clust_num_ores          = 1,
        clust_scarcity          = 1331,
        clust_size              = 11,
        y_max                   = -512,
        y_min                   = y_min,
    })

    -- Silver
    local silver_table = {
        metal = "silver",
        description = S("Silver"),
        output = "unilib:metal_silver_lump",
    }

    register_ore_special(silver_table, {
        -- From moreores/init.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_silver",
        wherein                 = metamorphic_list,

        clust_num_ores          = 4,
        clust_scarcity          = 1331,
        clust_size              = 11,
        y_max                   = -2,
        y_min                   = y_min,
    })

    -- Metal/mineral distributions from technic (here, found in sedimentary stone only)

    -- Chromium
    local chromium_table = {
        metal = "chromium",
        description = S("Chromium"),
        output = "unilib:metal_chromium_lump",
    }

    register_ore_special(chromium_table, {
        -- From technic/technic_worldgen/oregen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_chromium",
        wherein                 = sedimentary_list,

        clust_num_ores          = 2,
        clust_scarcity          = 8 * 8 * 8,
        clust_size              = 3,
        noise_params            = {
            octaves = 3,
            offset = 0,
            persist = 0.7,
            scale = 1,
            seed = get_seed(),
            spread = {x = 100, y = 100, z = 100},
        },
        noise_threshold         = 0.55,
        y_max                   = -100,
        y_min                   = -200,
    })

    register_ore_special(chromium_table, {
        -- From technic/technic_worldgen/oregen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_chromium",
        wherein                 = sedimentary_list,

        clust_num_ores          = 2,
        clust_scarcity          = 6 * 6 * 6,
        clust_size              = 3,
        flags                   = "absheight",
        noise_params            = {
            octaves = 3,
            offset = 0,
            persist = 0.7,
            scale = 1,
            seed = get_seed(),
            spread = {x = 100, y = 100, z = 100},
        },
        noise_threshold         = 0.55,
        y_max                   = -200,
        y_min                   = y_min,
    })

    -- Lead
    local lead_table = {
        metal = "lead",
        description = S("Lead"),
        output = "unilib:metal_lead_lump",
    }

    register_ore_special(lead_table, {
        -- From technic/technic_worldgen/oregen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_lead",
        wherein                 = sedimentary_list,

        clust_num_ores          = 5,
        clust_scarcity          = 9 * 9 * 9,
        clust_size              = 3,
        noise_params            = {
            octaves = 3,
            offset = 0,
            persist = 0.7,
            scale = 1,
            seed = get_seed(),
            spread = {x = 100, y = 100, z = 100},
        },
        noise_threshold         = 0.3,
        y_max                   = 16,
        y_min                   = -16,
    })

    register_ore_special(lead_table, {
        -- From technic/technic_worldgen/oregen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_lead",
        wherein                 = sedimentary_list,

        clust_num_ores          = 5,
        clust_scarcity          = 8 * 8 * 8,
        clust_size              = 3,
        noise_params            = {
            octaves = 3,
            offset = 0,
            persist = 0.7,
            scale = 1,
            seed = get_seed(),
            spread = {x = 100, y = 100, z = 100},
        },
        noise_threshold         = 0.3,
        y_max                   = -16,
        y_min                   = -128,
    })

    register_ore_special(lead_table, {
        -- From technic/technic_worldgen/oregen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_lead",
        wherein                 = sedimentary_list,

        clust_num_ores          = 5,
        clust_scarcity          = 6 * 6 * 6,
        clust_size              = 3,
        flags                   = "absheight",
        noise_params            = {
            octaves = 3,
            offset = 0,
            persist = 0.7,
            scale = 1,
            seed = get_seed(),
            spread = {x = 100, y = 100, z = 100},
        },
        noise_threshold         = 0.3,
        y_max                   = -128,
        y_min                   = y_min,
    })

    -- Sulphur (see code in the core.register_on_generated() function at the bottom)

    -- Uranium
    local uranium_table = {
        metal = "uranium",
        description = S("Uranium"),
        output = "unilib:metal_uranium_lump",
    }

    register_ore_special(uranium_table, {
        -- From technic/technic_worldgen/oregen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_uranium",
        wherein                 = sedimentary_list,

        clust_num_ores          = 4,
        clust_scarcity          = 8 * 8 * 8,
        clust_size              = 3,
        noise_params            = {
            octaves = 3,
            offset = 0,
            persist = 0.7,
            scale = 1,
            seed = get_seed(),
            spread = {x = 100, y = 100, z = 100},
        },
        noise_threshold         = 0.55,
        y_max                   = -80,
        y_min                   = -300,
    })

    -- Zinc
    local zinc_table = {
        metal = "zinc",
        description = S("Zinc"),
        output = "unilib:metal_zinc_lump",
    }

    register_ore_special(zinc_table, {
        -- From technic/technic_worldgen/oregen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_zinc",
        wherein                 = sedimentary_list,

        clust_num_ores          = 5,
        clust_scarcity          = 8 * 8 * 8,
        clust_size              = 7,
        noise_params            = {
            octaves = 3,
            offset = 0,
            persist = 0.7,
            scale = 1,
            seed = get_seed(),
            spread = {x = 100, y = 100, z = 100},
        },
        noise_threshold         = 0.5,
        y_max                   = 2,
        y_min                   = -32,
    })

    register_ore_special(zinc_table, {
        -- From technic/technic_worldgen/oregen.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_ordinary_with_zinc",
        wherein                 = sedimentary_list,

        clust_num_ores          = 4,
        clust_scarcity          = 6 * 6 * 6,
        clust_size              = 3,
        flags                   = "absheight",
        noise_params            = {
            octaves = 3,
            offset = 0,
            persist = 0.7,
            scale = 1,
            seed = get_seed(),
            spread = {x = 100, y = 100, z = 100},
        },
        noise_threshold         = 0.5,
        y_max                   = -32,
        y_min                   = y_min,
    })

    -- Stone ore distributions from technic

    -- Brown marble
    register_ore({
        -- From technic/technic_worldgen/oregen.lua
        ore_type                = "sheet",
        ore                     = "unilib:stone_marble_brown",
        wherein                 = sedimentary_list,

        clust_num_ores          = 1,
        clust_scarcity          = 1,
        clust_size              = 3,
        noise_params            = {
            octaves = 3,
            offset = 0,
            persist = 0.70,
            scale = 15,
            seed = get_seed(),
            spread = {x = 150, y = 150, z = 150},
        },
        noise_threshold         = 0.4,
        y_max                   = -50,
        y_min                   = y_min,
    })

    -- Dark granite
    register_ore({
        -- From technic/technic_worldgen/oregen.lua
        ore_type                = "sheet",
        ore                     = "unilib:stone_granite_dark",
        wherein                 = sedimentary_list,

        clust_num_ores          = 1,
        clust_scarcity          = 1,
        clust_size              = 4,
        noise_params            = {
            octaves = 3,
            offset = 0,
            persist = 0.70,
            scale = 15,
            seed = get_seed(),
            spread = {x = 130, y = 130, z = 130},
        },
        noise_threshold         = 0.4,
        y_max                   = -150,
        y_min                   = y_min,
    })

    -- Stone ore distributions from underch

    -- Brown clay
    register_ore({
        -- From underch/init.lua
        ore_type                = "blob",
        ore                     = "unilib:clay_brown",
        wherein                 = stone_list,

--      clust_scarcity          = 16 * 16 * 16,
        clust_scarcity          = 20 * 20 * 20,
        clust_size              = 5,
        noise_params            = {
            octaves = 1,
            offset = 0.5,
            persist = 0.0,
            scale = 0.2,
            seed = get_seed(),
            spread = {x = 5, y = 5, z = 5},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.constant.y_max,
        y_min                   = -93,
    })

    -- Mossy gravel
    register_ore({
        -- From underch/init.lua
        ore_type                = "blob",
        ore                     = "unilib:gravel_mossy",
        wherein                 = stone_list,

--      clust_scarcity          = 16 * 16 * 16,
        clust_scarcity          = 20 * 20 * 20,
        clust_size              = 5,
        noise_params            = {
            octaves = 1,
            offset = 0.5,
            persist = 0.0,
            scale = 0.2,
            seed = get_seed(),
            spread = {x = 5, y = 5, z = 5},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.constant.y_max,
        y_min                   = -1301,
    })

    -- Ordinary cobble. Here, it acts as a source of ordinary stone, in case it's not easily
    --      available above the surface
    register_ore({
        -- From underch/init.lua
        ore_type                = "blob",
        ore                     = "unilib:stone_ordinary_cobble",
        wherein                 = stone_list,

--      clust_scarcity          = 16 * 16 * 16,
        clust_scarcity          = 18 * 18 * 18,
        clust_size              = 5,
        noise_params            = {
            octaves = 1,
            offset = 0.5,
            persist = 0.0,
            scale = 0.2,
            seed = get_seed(),
            spread = {x = 5, y = 5, z = 5},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.constant.y_max,
        y_min                   = y_min,
    })

    -- Mineral distributions from technic (here, found in ordinary stone only)

    local sulphur_buf = {}
    local sulphur_noise

    core.register_on_generated(function(minp, maxp)

        local vm, emin, emax = core.get_mapgen_object("voxelmanip")
        local a = VoxelArea:new({MinEdge = emin, MaxEdge = emax})
        local data = vm:get_data(sulphur_buf)
        local pr = PseudoRandom(17 * minp.x + 42 * minp.y + 101 * minp.z)
        sulphur_noise = sulphur_noise or core.get_perlin(9876, 3, 0.5, 100)

        local c_lava = core.get_content_id("unilib:liquid_lava_ordinary_source")
        local c_lava_flowing = core.get_content_id("unilib:liquid_lava_ordinary_flowing")
        local c_stone = core.get_content_id("unilib:stone_ordinary")
        local c_sulphur = core.get_content_id("unilib:stone_ordinary_with_sulphur")

        local grid_size = 5
        for x = minp.x + math.floor(grid_size / 2), maxp.x, grid_size do

            for y = minp.y + math.floor(grid_size / 2), maxp.y, grid_size do

                for z = minp.z + math.floor(grid_size / 2), maxp.z, grid_size do

                    local c = data[a:index(x, y, z)]
                    if (c == c_lava or c == c_lava_flowing)
                            and sulphur_noise:get_3d({x = x, y = z, z = z}) >= 0.4 then

                        for i in a:iter(
                            math.max(minp.x, x - grid_size),
                            math.max(minp.y, y - grid_size),
                            math.max(minp.z, z - grid_size),
                            math.min(maxp.x, x + grid_size),
                            math.min(maxp.y, y + grid_size),
                            math.min(maxp.z, z + grid_size)
                        ) do

                            if data[i] == c_stone and pr:next(1, 10) <= 7 then
                                data[i] = c_sulphur
                            end

                        end

                    end

                end

            end

        end

        vm:set_data(data)
        vm:write_to_map(data)

    end)

end
