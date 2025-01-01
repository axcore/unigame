---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mapgen_underch_jit = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

-- The VoxelManip object works by switching nodes, comparing their Minetest IDs
local id_table = {}
-- Table used to replace ordinary stone nodes with the base stone for each pseudo-biome
local ending_list = {"", "_cobble", "_cobble_mossy", "_cobble_stair_simple"}

---------------------------------------------------------------------------------------------------
-- Notes
---------------------------------------------------------------------------------------------------

-- This package creates underground biomes from the "experimental" version of the underch mod, using
--      just-in-time ore generation. For code from the "regular" version of the mod, see the
--      "mapgen_underch" package
-- As in the original mod, code in this file is inadequately documented

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function add_jit_property(full_name)

    -- Adapted from underch/jit.lua, add_jit_property()

    -- (The if-condition is simpler than checking the parent package has been executed. It also
    --      catches the some underch stones, like afualite, which don't have a mossy cobble variant)
    if core.registered_nodes[full_name] ~= nil then

        local g = core.registered_nodes[full_name].groups
        g.jit_shadow = 1
        unilib.override_item(full_name, {
            groups = g,
            after_dig_node = unilib.jbiomes.dig_shadow,
        })

    end

end

local function override_nodes()

    -- Adapted from underch/nodes.lua, etc
    -- Overrides various nodes to make them compatible with JIT

    -- (From underch/dense_ores.lua)
    for _, full_name in ipairs({
        "unilib:metal_copper_block",
        "unilib:metal_gold_block",
        "unilib:metal_steel_block",
        "unilib:mineral_coal_block",
    }) do
        add_jit_property(full_name)
    end

    -- (From underch/gems.lua)
    for _, gem_type in ipairs({
        "amethyst", "aquamarine", "emerald", "quartz", "ruby", "sapphire",
    }) do
        add_jit_property("unilib:mineral_" .. gem_type .. "_block")
    end

    -- (From underch/nodes.lua)
    for _, full_name in ipairs({
        "unilib:dirt_mossy",
        "unilib:light_block_sichamine",
        "unilib:misc_stone_burner",
        "unilib:mineral_coal_block_with_diamond",
        "unilib:stone_vindesite_white_with_quartz_white",
        "unilib:stone_malachite",
        "unilib:stone_obscurite",
        "unilib:stone_shinestone",
        "unilib:stone_sichamine_dark",
        "unilib:stone_sichamine_weedy",
    }) do
        add_jit_property(full_name)
    end

    unilib.override_item("unilib:stone_omphyrite_crack_lava", {
        groups = {cracky = 3, jit_shadow = 1},

        after_dig_node = function(pos, oldnode, oldmetadata, digger)

            core.place_node(pos, {name = "unilib:liquid_lava_ordinary_source"}, digger)
            unilib.jbiomes.dig_shadow(pos, oldnode, oldmetadata, digger)

        end,
    })

    -- (From underch/slime.lua)
    for _, slime_type in ipairs({"black", "green", "purple", "red"}) do

        add_jit_property("unilib:stone_slimestone_" .. slime_type .. "_brick_slimy")
        add_jit_property("unilib:stone_slimestone_" .. slime_type .. "_with_eye")

    end

    -- (From underch/stone.lua)
    for _, stone_type in ipairs({
        "afualite", "amphibolite", "andesite_dark", "aplite", "basalt_blue", "diorite_pale",
        "dolostone_pale", "emutite", "gabbro_brown", "gneiss_black", "granite_salmon", "hektorite",
        "limestone_grey", "marble_carrara", "omphyrite", "pegmatite_red", "peridotite_dark",
        "phonolite", "phyllite", "quartzite_brown", "schist_red", "sichamine", "slate_red",
        "slimestone_green", "slimestone_purple", "slimestone_red", "vindesite_blue",
        "vindesite_white",
    }) do
        add_jit_property("unilib:stone_" .. stone_type)
        add_jit_property("unilib:stone_" .. stone_type .. "_cobble")
        add_jit_property("unilib:stone_" .. stone_type .. "_cobble_mossy")
    end

    -- (From default)
    for _, full_name in ipairs({
        "unilib:dirt_ordinary",
        "unilib:stone_desert",
        "unilib:stone_desert_cobble",
        "unilib:stone_ordinary",
        "unilib:stone_ordinary_cobble",
        "unilib:stone_ordinary_with_coal",
        "unilib:stone_ordinary_with_copper",
        "unilib:stone_ordinary_with_diamond",
        "unilib:stone_ordinary_with_gold",
        "unilib:stone_ordinary_with_iron",
        "unilib:stone_ordinary_with_mese",
        "unilib:stone_ordinary_with_tin",
        "unilib:stone_sandstone_desert",
        "unilib:stone_sandstone_ordinary",
        "unilib:stone_sandstone_silver",
    }) do
        add_jit_property(full_name)
    end

    -- (From moreores)
    for _, full_name in ipairs({
        "unilib:stone_ordinary_with_mithril",
        "unilib:stone_ordinary_with_silver",
    }) do
        add_jit_property(full_name)
    end

    -- (From technic)
    for _, full_name in ipairs({
        "unilib:stone_ordinary_with_chromium",
        "unilib:stone_ordinary_with_lead",
        "unilib:stone_ordinary_with_uranium",
        "unilib:stone_ordinary_with_zinc",
    }) do
        add_jit_property(full_name)
    end

    -- (From xtraores)
    -- N.B. In the original code, osmium a.k.a. ozymandium is missing from this list
    for _, full_name in ipairs({
        "unilib:stone_ordinary_with_adamantite",
        "unilib:stone_ordinary_with_geminitium",
        "unilib:stone_ordinary_with_ozymandium",
        "unilib:stone_ordinary_with_planexium",
        "unilib:stone_ordinary_with_rarium",
        "unilib:stone_ordinary_with_sybilline",
        "unilib:stone_ordinary_with_tritonium",
        "unilib:stone_ordinary_with_unobtainium",
    }) do
        add_jit_property(full_name)
    end

end

local function create_dynamic_nodes()

    -- Adapted from underch/dynamic.lua and slime.lua
    -- Before calling unilib.setup_biomes(), set up dynamic nodes
    -- Dynamic nodes present in the original code, but not actually used in the biomegen tables
    --      below, are commented out

    -- Extenders
    unilib.dynamic.register_extender({
        label = "plant_bush_underground",
        orig_name = "underch:dynamic_underground_bush",
        wherein = "air",
        output = "unilib:plant_bush_underground",
        replace_mode = mode,
        sides = {
            {x = 1, y = 0, z = 0},
            {x = -1, y = 0, z = 0},
            {x = 0, y = 0, z = -1},
            {x = 0, y = 0, z = -1},
            {x = 0, y = 1, z = 0},
            {x = 0, y = 1, z = 0},
            {x = 0, y = 1, z = 0},
            {x = 0, y = 1, z = 0},
        },
        chance = 1 / 10,
    })

    unilib.dynamic.register_extender({
        label = "stone_basalt_blue",
        orig_name = "underch:dynamic_basalt",
        wherein = "air",
        output = "unilib:stone_basalt_blue",
        replace_mode = mode,
        sides = {
            {x = 1, y = 2, z = 0},
            {x = -1, y = 2, z = 0},
            {x = 0, y = 2, z = 1},
            {x = 0, y = 2, z = -1},
            {x = 1, y = -2, z = 0},
            {x = -1, y = -2, z = 0},
            {x = 0, y = -2, z = 1},
            {x = 0, y = -2, z = -1},
            {x = 0, y = -1, z = 0},
            {x = 0, y = 1, z = 0},
            {x = 0, y = -2, z = 0},
            {x = 0, y = 2, z = 0},
            {x = 0, y = -1, z = 0},
            {x = 0, y = 1, z = 0},
            {x = 0, y = -2, z = 0},
            {x = 0, y = 2, z = 0},
            {x = 0, y = -1, z = 0},
            {x = 0, y = 1, z = 0},
            {x = 0, y = -2, z = 0},
            {x = 0, y = 2, z = 0},
        },
        chance = 1 / 17,
    })

    unilib.dynamic.register_extender({
        label = "stone_obsidian",
        orig_name = "underch:dynamic_obsidian",
        wherein = "unilib:stone_afualite",
        output = "unilib:stone_obsidian",
        replace_mode = mode,
        sides = {
            {x = 1, y = -1, z = 1},
            {x = -1, y = -1, z = 1},
            {x = 1, y = -1, z = -1},
            {x = -1, y = -1, z = -1},
        },
        chance = 7 / 24,
    })

    --[[
    unilib.dynamic.register_extender({
        label = "stone_omphyrite_crack_lava",
        orig_name = "underch:dynamic_lava_crack",
        wherein = "unilib:stone_omphyrite",
        output = "unilib:stone_omphyrite_crack_lava",
        replace_mode = mode,
        sides = "corners",
        chance = 1 / 7,
    })
    ]]--

    unilib.dynamic.register_extender({
        label = "stone_shinestone",
        orig_name = "underch:dynamic_shinestone",
        wherein = "air",
        output = "unilib:stone_shinestone",
        replace_mode = mode,
        sides = {
            {x = 1, y = 0, z = 0},
            {x = -1, y = 0, z = 0},
            {x = 0, y = -1, z = 0},
            {x = 0, y = 0, z = -1},
            {x = 0, y = 0, z = 1},
        },
        chance = 1 / 5,
    })

    -- Flooders
    unilib.dynamic.register_flooder_jit({
        label = "dirt_ordinary_in_andesite_dark",
        orig_name = "underch:dynamic_jungle",
        wherein = "unilib:stone_andesite_dark",
        output = "unilib:dirt_ordinary",
        replace_mode = mode,
        sides = "sides",
        size = 100,
        ore_table = {
            {block = "unilib:dirt_mossy", chance = 2 / 3},
        },
        top_table = {
            {block = "unilib:dynamic_plant_bush_underground", chance = 1 / 5},
        },
        jit_flag = true,
    })

    unilib.dynamic.register_flooder_jit({
        label = "dirt_ordinary_in_basalt_blue",
        orig_name = "underch:dynamic_sticks",
        wherein = "unilib:stone_basalt_blue",
        output = "unilib:dirt_ordinary",
        replace_mode = mode,
        sides = "sides",
        size = 100,
        ore_table = {
            {block = "unilib:dirt_mossy", chance = 2 / 3},
        },
        top_table = {
            {block = "unilib:plant_bush_underground_dead", chance = 1 / 9},
        },
        jit_flag = true,
    })

    --[[
    unilib.dynamic.register_flooder_jit({
        label = "dirt_ordinary_in_gabbro_brown",
        orig_name = "underch:dynamic_jungleg",
        wherein = "unilib:stone_gabbro_brown",
        output = "unilib:dirt_ordinary",
        replace_mode = mode,
        sides = "sides",
        size = 100,
        ore_table = {
            {block = "unilib:dirt_mossy", chance = 2 / 3},
        },
        top_table = {
            {block = "unilib:dynamic_plant_bush_underground", chance = 1 / 5},
        },
        jit_flag = true,
    })
    ]]--

    --[[
    unilib.dynamic.register_flooder_jit({
        label = "dirt_ordinary_in_granite_salmon",
        orig_name = "underch:dynamic_mossy_dirt",
        wherein = "unilib:stone_granite_salmon",
        output = "unilib:dirt_ordinary",
        replace_mode = mode,
        sides = "sides",
        size = 100,
        ore_table = {
            {block = "unilib:dirt_mossy", chance = 2 / 3},
        },
        jit_flag = true,
    })
    ]]--

    unilib.dynamic.register_flooder_jit({
        label = "misc_granules_fiery_in_andesite_dark",
        orig_name = "underch:dynamic_fa",
        wherein = "unilib:stone_andesite_dark",
        output = "unilib:misc_granules_fiery_block",
        replace_mode = mode,
        sides = "sides",
        size = 30,
        jit_flag = true,
    })

    unilib.dynamic.register_flooder_jit({
        label = "misc_granules_fiery_in_omphyrite",
        orig_name = "underch:dynamic_fo",
        wherein = "unilib:stone_omphyrite",
        output = "unilib:misc_granules_fiery_block",
        replace_mode = mode,
        sides = "sides",
        size = 30,
        jit_flag = true,
    })

    unilib.dynamic.register_flooder_jit({
        label = "misc_granules_fiery_in_pegmatite_red",
        orig_name = "underch:dynamic_fp",
        wherein = "unilib:stone_pegmatite_red",
        output = "unilib:misc_granules_fiery_block",
        replace_mode = mode,
        sides = "sides",
        size = 30,
        jit_flag = true,
    })

    unilib.dynamic.register_flooder_jit({
        label = "misc_granules_fiery_in_phonolite",
        orig_name = "underch:dynamic_fire",
        wherein = "unilib:stone_phonolite",
        output = "unilib:misc_granules_fiery_block",
        replace_mode = mode,
        sidse = "sides",
        size = 30,
        top_table = {
            {block = "unilib:fire_permanent", chance = 2 / 3},
        },
        jit_flag = true,
    })

    unilib.dynamic.register_flooder_jit({
        label = "misc_granules_fiery_in_schist_red",
        orig_name = "underch:dynamic_fs",
        wherein = "unilib:stone_schist_red",
        output = "unilib:misc_granules_fiery_block",
        replace_mode = mode,
        sides = "sides",
        size = 30,
        jit_flag = true,
    })

    --[[
    unilib.dynamic.register_flooder_jit({
        label = "stone_malachite",
        orig_name = "underch:dynamic_malachite",
        wherein = "unilib:stone_peridotite_dark",
        output = "unilib:stone_malachite",
        replace_mode = mode,
        sides = "sides",
        size = 30,
        jit_flag = true,
    })
    ]]--

    --[[
    unilib.dynamic.register_flooder_jit({
        label = "stone_vindesite_white",
        orig_name = "underch:dynamic_vindesite",
        wherein = "unilib:stone_afualite",
        output = "unilib:stone_vindesite_white",
        replace_mode = mode,
        sides = "sides",
        size = 100,
        jit_flag = true,
    })
    ]]--

    --[[
    unilib.dynamic.register_flooder_jit({
        label = "stone_vindesite_blue",
        orig_name = "underch:dynamic_dark_vindesite",
        wherein = "unilib:stone_afualite",
        output = "unilib:stone_vindesite_blue",
        replace_mode = mode,
        sides = "sides",
        size = 100,
        jit_flag = true,
    })
    ]]--

    -- Flooders (slimestone)

    local slime_table = {
        black = "unilib:stone_slate_red",
        green = "unilib:stone_slimestone_green",
        purple = "unilib:stone_slimestone_purple",
        red = "unilib:stone_slimestone_red",
    }

    for part_name, wherein in pairs(slime_table) do

        unilib.dynamic.register_flooder_jit({
            label = "liquid_slime_" .. part_name .. "_source",
            orig_name = "underch:dynamic_" .. part_name .. "_slime",
            wherein = wherein,
            output = "unilib:liquid_slime_" .. part_name .. "_source",
            replace_mode = mode,
            sides = "sides",
            size = 100,
            jit_flag = true,
        })

        --[[
        unilib.dynamic.register_flooder_jit({
            label = "stone_slimestone_" .. part_name .. "_block_slimy",
            orig_name = "underch:dynamic_" .. part_name .. "_slimy_block",
            wherein = wherein,
            output = "unilib:stone_slimestone_" .. part_name .. "_block_slimy",
            replace_mode = mode,
            sides = "sides",
            size = 100,
            ore_table = {
                {block = "unilib:stone_slimestone_" .. part_name .. "_with_eye", chance = 1 / 10},
            },
            jit_flag = true,
        })
        ]]--

    end

end

local function populate_id_table()

    -- Adapted from underch/worldgen.lua
    -- Before calling unilib.setup_biomes(), prepare a table containing Minetest IDs for every node
    --      referenced by this package

    -- Add underch (smooth) stones
    for _, part_name in ipairs({
        -- This...
        "ordinary",
        -- ...is replaced by these...
        "afualite", "amphibolite", "andesite_dark", "aplite", "basalt_blue", "diorite_pale",
        "dolostone_pale", "emutite", "gabbro_brown", "gneiss_black", "granite_salmon", "hektorite",
        "limestone_grey", "marble_carrara", "omphyrite", "pegmatite_red", "peridotite_dark",
        "phonolite", "phyllite", "quartzite_brown", "schist_red", "sichamine", "slate_red",
        "slimestone_green", "slimestone_purple", "slimestone_red", "vindesite_blue",
        "vindesite_white",
    }) do

        for _, ending in ipairs(ending_list) do

            local full_name = "unilib:stone_" .. part_name .. ending

            if core.registered_nodes[full_name] ~= nil then
                id_table["stone_" .. part_name .. ending] = core.get_content_id(full_name)
            end

        end

    end

    -- Add other underch nodes (commented-out lines are not actually used any more)
    for _, item_name in ipairs({
        -- Ordinary nodes                   -- Original shortcut / parent package
        "dirt_ordinary",                    -- c_dirt / dirt_ordinary
--      "dirt_mossy",                       -- c_mossy_dirt / dirt_mossy
--      "fire_permanent",                   -- c_fire / fire_permanent
--      "light_block_sichamine",            -- c_sichamine_lamp / light_block_sichamine
        "liquid_lava_ordinary_source",      -- c_lava / liquid_lava_ordinary
        "liquid_water_ordinary_source",     -- c_water / liquid_water_ordinary
--      "mineral_amethyst_block",           -- c_amethyst_block / mineral_amethyst
        "mineral_amethyst_crystal_large",   -- c_amethyst_crystal / mineral_amethyst
--      "mineral_aquamarine_block",         -- c_aquamarine_block / mineral_aquamarine
        "mineral_aquamarine_crystal_large", -- c_aquamarine_crystal / mineral_aquamarine
--      "mineral_coal_block",               -- c_coalblock / mineral_coal
--      "mineral_coal_block_with_diamond",  -- c_coal_diamond / mineral_coal_block_with_diamond
        "mineral_emerald_crystal_large",    -- c_emerald_crystal / mineral_emerald
        "mineral_mese_crystal_large",       -- c_mese_crystal / mineral_mese_crystal_large
        "mineral_ruby_crystal_large",       -- c_ruby_crystal / mineral_ruby
--      "mineral_quartz_white_block",       -- c_quartz_block / mineral_quartz_white
        "mineral_quartz_white_crystal_large",
                                            -- c_quartz_crystal / mineral_quartz_white
        "mineral_sapphire_crystal_large",   -- c_saphire_crystal / mineral_sapphire
        "misc_granules_coal_block",         -- c_coal_dust / misc_granules_coal
        "misc_granules_ruby_block",         -- c_ruby_dust / misc_granules_ruby
--      "misc_granules_normal_block",       -- c_dust / misc_granules_normal
--      "misc_granules_fiery_block",        -- c_fiery_dust / misc_granules_fiery
--      "misc_stone_burner",                -- c_burner / misc_stone_burner
        "moss_underground",                 -- c_moss / moss_underground
        "moss_underground_dry",             -- c_dry_moss / moss_underground_dry
        "mushroom_black",                   -- c_black_mushroom / mushroom_black
        "mushroom_burning",                 -- c_burning_mushroom / mushroom_burning
        "mushroom_brown",                   -- c_brown_mushroom / mushroom_brown
        "mushroom_green",                   -- c_green_mushroom / mushroom_green
        "mushroom_orange",                  -- c_orange_mushroom / mushroom_orange
        "mushroom_red",                     -- c_red_mushroom / mushroom_red
--      "plant_bush_underground",           -- c_underground_bush / plant_bush_underground
--      "plant_bush_underground_dead",      -- c_dead_bush / plant_bush_underground_dead
        "plant_mould_underground",          -- c_mould / plant_mould_underground
        "plant_torchberry",                 -- c_torchberries / plant_torchberry
        "plant_tuber_dark",                 -- c_dark_tuber / plant_tuber_dark
--      "stone_malachite",                  -- c_malachite / stone_malachite
--      "stone_obscurite",                  -- c_obscurite / stone_obscurite
--      "stone_obsidian",                   -- c_obsidian / stone_obsidian
--      "stone_omphyrite_crack_lava",       -- c_lava_crack / stone_omphyrite_extra
--      "stone_ordinary_with_amethyst",     -- c_amethyst_ore / stone_ordinary_with_amethyst
--      "stone_ordinary_with_aquamarine",   -- c_aquamarine_ore / stone_ordinary_with_aquamarine
--      "stone_ordinary_with_coal_dense",   -- c_coal_dense_ore / stone_ordinary_with_coal_dense
--      "stone_ordinary_with_copper_dense", -- c_copper_dense_ore / stone_ordinary_with_copper_dense
--      "stone_ordinary_with_emerald",      -- c_emerald_ore / stone_ordinary_with_emerald
--      "stone_ordinary_with_gold_dense",   -- c_gold_dense_ore / stone_ordinary_with_gold_dense
--      "stone_ordinary_with_iron_dense",   -- c_iron_dense_ore / stone_ordinary_with_iron_dense
--      "stone_ordinary_with_quartz_white", -- c_quartz_ore / stone_ordinary_with_quartz_white
--      "stone_ordinary_with_ruby",         -- c_ruby_ore / stone_ordinary_with_ruby
--      "stone_ordinary_with_sapphire",     -- c_saphire_ore / stone_ordinary_with_sapphire
--      "stone_shinestone",                 -- c_shinestone / stone_shinestone
--      "stone_sichamine_dark",             -- c_dark_sichamine / stone_sichamine_extra
--      "stone_sichamine_weedy",            -- c_weedy_sichamine / stone_sichamine_extra
--      "stone_vindesite_white_with_quartz_white",
                                            -- c_vindesite_quartz_ore /
                                            --      stone_vindesite_white_with_quartz_white
        "vine_fiery",                       -- c_fiery_vine / vine_fiery
        "vine_underground",                 -- c_underground_vine / vine_underground

        -- Dynamic nodes                                    -- Original shortcut
        "dynamic_dirt_ordinary_in_andesite_dark",           -- c_dynamic_jungle
        "dynamic_dirt_ordinary_in_basalt_blue",             -- c_dynamic_sticks
--      "dynamic_dirt_ordinary_in_gabbro_brown",            -- c_dynamic_jungleg
--      "dynamic_dirt_ordinary_in_granite_salmon",          -- c_dynamic_mossy_dirt
        "dynamic_misc_granules_fiery_in_andesite_dark",     -- c_dynamic_fa
        "dynamic_misc_granules_fiery_in_pegmatite_red",     -- c_dynamic_fp
        "dynamic_misc_granules_fiery_in_omphyrite",         -- c_dynamic_fo
        "dynamic_misc_granules_fiery_in_phonolite",         -- c_dynamic_fire
        "dynamic_misc_granules_fiery_in_schist_red",        -- c_dynamic_fs
--      "dynamic_plant_bush_underground",                   -- c_dynamic_underground_bush
        "dynamic_stone_basalt_blue",                        -- c_dynamic_basalt
--      "dynamic_stone_malachite",                          -- c_dynamic_malachite
        "dynamic_stone_obsidian",                           -- c_dynamic_obsidian
--      "dynamic_stone_omphyrite_crack_lava",               -- c_dynamic_lava_crack
        "dynamic_stone_shinestone",                         -- c_dynamic_shinestone
--      "dynamic_stone_vindesite_white",                    -- c_dynamic_vindesite
--      "dynamic_stone_vindesite_blue",                     -- c_dynamic_dark_vindesite

        -- Dynamic nodes (slime)                            -- Original shortcut
        "dynamic_liquid_slime_black_source",                -- c_black_slime
--      "dynamic_stone_slimestone_black_block_slimy",       -- c_black_slimy_block
        "dynamic_liquid_slime_green_source",                -- c_green_slime
--      "dynamic_stone_slimestone_green_block_slimy",       -- c_green_slimy_block
        "dynamic_liquid_slime_red_source",                  -- c_red_slime
--      "dynamic_stone_slimestone_red_block_slimy",         -- c_red_slimy_block
        "dynamic_liquid_slime_purple_source",               -- c_purple_slime
--      "dynamic_stone_slimestone_purple_block_slimy",      -- c_purple_slimy_block
    }) do
        id_table[item_name] = core.get_content_id("unilib:" .. item_name)
    end

end

local function switch_stone(pos, stone_type)

    -- Adapted from underch/jit.lua, underch.jit.use_stone()

    local name = core.get_node(pos).name
    if name == "unilib:misc_matrix_bulk" or name == "unilib:misc_matrix_crust" then
        core.set_node(pos, {name = "unilib:stone_" .. stone_type})
    elseif name == "unilib:stone_ordinary_cobble" then
        core.set_node(pos, {name = "unilib:stone_" .. stone_type .. "_cobble"})
    end

end

local function setup_lbm()

    -- Adapted from underch/jit.lua

    unilib.register_lbm{
        label = "Replace crust with bulk [mapgen_underch_jit]",
        name = "unilib:lbm_mapgen_underch_jit",
        nodenames = {"unilib:misc_matrix_crust"},

        run_at_every_load = true,

        action = function(pos, node)

            if not unilib.jbiomes.reveal(pos, false, true) then
                core.set_node(pos, {name = "unilib:misc_matrix_bulk"})
            end

        end,
    }

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mapgen_underch_jit.init()

    return {
        description = "Pseudo-biomes for the \"underch_jit\" remix",
        notes = "This package assumes that all packages listed in the \"underch_jit\" remix" ..
                " have been executed (rather than listing them all here as dependencies)",
        excludes = {"mapgen_hades", "mapgen_hades_jit", "mapgen_underch"},
        depends = "stone_ordinary",
    }

end

function unilib.pkg.mapgen_underch_jit.post()

    -- Load files in ../lib/shared/
    unilib.pbiomes.load()
    unilib.jbiomes.load()
    unilib.dynamic.load()

    -- Override various nodes to make them compatible with JIT
    override_nodes()

    -- Create pseudo-nodes (see the comments in ../lib/shared/dynamic/dynamic_base.lua)
    create_dynamic_nodes()

    -- The VoxelManip object works by switching nodes, comparing their Minetest IDs
    populate_id_table()

    -- Set up the LBM which converts matrix crust to matrix bulk nodes
    setup_lbm()

    -- Some quick lookups
    local c_air = core.get_content_id("air")
    local c_stone = id_table["stone_ordinary"]
    local c_water = id_table["liquid_water_ordinary_source"]
    local c_lava = id_table["liquid_lava_ordinary_source"]

    -- There are two biome generation tables
    -- The first is adapted from underch/worldgen.lua,originally called "underch.biomegen"
    -- It is used in the call to core.register_on_generated(). During map generation, ordinary stone
    --      nodes (unilib:stone_ordinary) are converted to matrix nodes. Some other items, such as
    --      mushrooms, can be placed at this stage. Those other items are specified by this table,
    --      and are placed in an appropriate pseudo-biome
    local matrix_table = {
        -- 1. Basic pale dolostone. When these functions are empty, there are no items like
        --      mushrooms to be placed
        [1] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 2. Basic grey limestone
        [2] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 3. Basic red schist
        [3] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 4. Basic dark andesite
        [4] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 5. Basic phyllite
        [5] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 6. Basic brown quartzite
        [6] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 7. Basic amphibolite
        [7] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 8. Basic red slate
        [8] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 9. Basic black gneiss
        [9] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 10. Basic phonolite
        [10] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 11. Basic aplite
        [11] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 12. Basic blue basalt
        [12] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 13. Basic pale diorite
        [13] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 14. Basic red pegmatite
        [14] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 15. Basic salmon granite
        [15] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 16. Basic brown gabbro
        [16] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 17. Pale dolostone cave
        [17] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 18. Grey limestone with dust
        [18] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 19. Amphibolite with coal and dust
        [19] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.in_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["misc_granules_coal_block"], 1 / 9
            )
        end,
        -- 20. White vindesite with quartz ore and black mushrooms
        [20] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                id_table["stone_vindesite_white"], c_air, id_table["mushroom_black"], 1 / 18
            )
        end,
        -- 21. Phyllite with red/brown mushrooms and moss
        [21] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["mushroom_brown"], 1 / 18
            )
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["mushroom_red"], 1 / 18
            )
            unilib.jbiomes.on_wall_w(x, y, z, vi, area, data, p2data,
                c_stone, c_air, id_table["plant_mould_underground"], 1 / 9, lastlayer
            )
        end,
        -- 22. Phonolite with torchberries and brown mushrooms
        [22] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.on_roof(x, y, z, vi, area, data,
                c_stone, c_air, id_table["plant_torchberry"], 1 / 30, lastlayer
            )
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["mushroom_brown"], 1 / 18
            )
        end,
        -- 23. Red schist with tubers and black mushrooms
        [23] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["mushroom_black"], 1 / 18
            )
            unilib.pbiomes.on_floor_rr(x, y, z, vi, area, data, p2data,
                c_stone, c_air, id_table["plant_tuber_dark"], 1 / 50
            )
        end,
        -- 24. Red slate with black slime
        [24] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.in_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["dynamic_liquid_slime_black_source"], 1 / 300
            )
        end,
        -- 25. Pale diorite with white quartz crystals
        [25] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.jbiomes.on_wall_f(x, y, z, vi, area, data, p2data,
                c_stone, c_air, id_table["mineral_quartz_white_crystal_large"], 1 / 50, lastlayer
            )
        end,
        -- 26. Phonolite with emerald crystals
        [26] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.jbiomes.on_wall_f(x, y, z, vi, area, data, p2data,
                c_stone, c_air, id_table["mineral_emerald_crystal_large"], 1 / 201, lastlayer
            )
        end,
        -- 27. Blue basalt with moss and brown mushrooms
        [27] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.jbiomes.on_wall_w(x, y, z, vi, area, data, p2data,
                c_stone, c_air, id_table["moss_underground"], 1 / 3, lastlayer
            )
            unilib.jbiomes.on_wall_w(x, y, z, vi, area, data, p2data,
                id_table["dirt_ordinary"], c_air, id_table["moss_underground"], 1 / 3, lastlayer
            )
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["mushroom_brown"], 1 / 18
            )
        end,
        -- 28. Green slimestone
        [28] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.in_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["dynamic_liquid_slime_green_source"], 1 / 300
            )
        end,
        -- 29. Sichamine with light blocks
        [29] = function(x, y, z, vi, data, p2data, area, lastlayer)
            if y < 0 then
                unilib.jbiomes.replace_in_matrix(vi, data, c_air, c_water)
            end
        end,
        -- 30. Sichamine with dark stones
        [30] = function(x, y, z, vi, data, p2data, area, lastlayer)
            if y < 0 then
                unilib.jbiomes.replace_in_matrix(vi, data, c_air, c_water)
            end
        end,
        -- 31. Salmon granite with torchberries
        [31] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.on_roof(x, y, z, vi, area, data,
                c_stone, c_air, id_table["plant_torchberry"], 1 / 30, lastlayer
            )
        end,
        -- 32. Dark andesite with dirt, mould and vines
        [32] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.in_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["dynamic_dirt_ordinary_in_andesite_dark"], 1 / 50
            )
            unilib.jbiomes.on_wall_w(x, y, z, vi, area, data, p2data,
                c_stone, c_air, id_table["plant_mould_underground"], 1 / 9, lastlayer
            )
            unilib.jbiomes.on_wall_w(x, y, z, vi, area, data, p2data,
                c_stone, c_air, id_table["vine_underground"], 1 / 15, lastlayer
            )
        end,
        -- 33. Marble with lava springs
        [33] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 34. Phonolite with fiery dust
        [34] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.in_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["dynamic_misc_granules_fiery_in_phonolite"],
                1 / 300
            )
        end,
        -- 35. Red schist with fiery dust and fiery vines
        [35] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.in_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["dynamic_misc_granules_fiery_in_schist_red"],
                1 / 300
            )
            unilib.pbiomes.in_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["misc_granules_coal_block"], 1 / 9
            )
            unilib.jbiomes.on_wall_w(x, y, z, vi, area, data, p2data,
                c_stone, c_air, id_table["vine_fiery"], 1 / 15, lastlayer
            )
        end,
        -- 36. Blue vindesite with burner stones
        [36] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                id_table["stone_vindesite_blue"], c_air, id_table["mushroom_black"], 1 / 18
            )
        end,
        -- 37. Phyllite with mushrooms and mould
        [37] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["mushroom_brown"], 1 / 40
            )
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["mushroom_red"], 1 / 40
            )
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["mushroom_black"], 1 / 20
            )
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["mushroom_green"], 1 / 20
            )
            unilib.jbiomes.on_wall_w(x, y, z, vi, area, data, p2data,
                c_stone, c_air, id_table["plant_mould_underground"], 1 / 9, lastlayer
            )
        end,
        -- 38. Omphyrite with fiery dust and burning mushrooms
        [38] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.in_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["dynamic_misc_granules_fiery_in_omphyrite"],
                1 / 300
            )
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["mushroom_burning"], 1 / 18
            )
        end,
        -- 39. Red pegmatite with fiery dust/vines and burning/orange mushrooms
        [39] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.in_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["dynamic_misc_granules_fiery_in_pegmatite_red"],
                1 / 300
            )
            unilib.jbiomes.on_wall_w(x, y, z, vi, area, data, p2data,
                c_stone, c_air, id_table["vine_fiery"], 1 / 15, lastlayer
            )
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["mushroom_burning"], 1 / 18
            )
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["mushroom_orange"], 1 / 18
            )
        end,
        -- 40. Purple slimestone
        [40] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.in_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["dynamic_liquid_slime_purple_source"], 1 / 300
            )
        end,
        -- 41. Black gneiss with mese and sapphire crystals
        [41] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["mushroom_green"], 1 / 18
            )
            unilib.jbiomes.on_wall_f(x, y, z, vi, area, data, p2data,
                c_stone, c_air, id_table["mineral_sapphire_crystal_large"], 1 / 201, lastlayer
            )
            unilib.jbiomes.on_wall_f(x, y, z, vi, area, data, p2data,
                c_stone, c_air, id_table["mineral_mese_crystal_large"], 1 / 201, lastlayer
            )
            unilib.jbiomes.on_wall_w(x, y, z, vi, area, data, p2data,
                c_stone, c_air, id_table["vine_underground"], 1 / 15, lastlayer
            )
        end,
        -- 42. Salmon granite with ruby crystals
        [42] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["mushroom_orange"], 1 / 18
            )
            unilib.pbiomes.in_floor(x, y, z, vi, area, data,
                c_air, c_stone, id_table["misc_granules_ruby_block"], 1 / 450
            )
            unilib.jbiomes.on_wall_f(x, y, z, vi, area, data, p2data,
                c_stone, c_air, id_table["mineral_ruby_crystal_large"], 1 / 201, lastlayer
            )
        end,
        -- 43. Blue basalt with moss
        [43] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.jbiomes.on_wall_w(x, y, z, vi, area, data, p2data,
                c_stone, c_air, id_table["moss_underground_dry"], 1 / 3, lastlayer
            )
            unilib.jbiomes.on_wall_w(x, y, z, vi, area, data, p2data,
                id_table["dirt_ordinary"], c_air, id_table["moss_underground_dry"], 1 / 3, lastlayer
            )
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["mushroom_orange"], 1 / 18
            )
            unilib.pbiomes.in_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["dynamic_dirt_ordinary_in_basalt_blue"], 1 / 100
            )
        end,
        -- 44. Red slimestone
        [44] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.in_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["dynamic_liquid_slime_red_source"], 1 / 300
            )
        end,
        -- 45. Sichamine with lava
        [45] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.jbiomes.replace_in_matrix(vi, data, c_air, c_water)
        end,
        -- 46. Pale diorite with aquamarine and amethyst
        [46] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.jbiomes.on_wall_f(x, y, z, vi, area, data, p2data,
                c_stone, c_air, id_table["mineral_aquamarine_crystal_large"], 1 / 50, lastlayer
            )
            unilib.jbiomes.on_wall_f(x, y, z, vi, area, data, p2data,
                c_stone, c_air, id_table["mineral_amethyst_crystal_large"], 1 / 50, lastlayer
            )
        end,
        -- 47. Dark andesite with vines and mushrooms
        [47] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.in_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["dynamic_dirt_ordinary_in_andesite_dark"], 1 / 50
            )
            unilib.pbiomes.in_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["dynamic_misc_granules_fiery_in_andesite_dark"],
                1 / 300
            )
            unilib.jbiomes.on_wall_w(x, y, z, vi, area, data, p2data,
                c_stone, c_air, id_table["vine_fiery"], 1 / 15, lastlayer
            )
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["mushroom_red"], 1 / 27
            )
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["mushroom_brown"], 1 / 27
            )
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["mushroom_orange"], 1 / 27
            )
        end,
        -- 48. Brown gabbro with vines and mushrooms
        [48] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.in_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["dynamic_dirt_ordinary_in_andesite_dark"], 1 / 50
            )
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["mushroom_burning"], 1 / 18
            )
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["mushroom_orange"], 1 / 18
            )
            unilib.jbiomes.on_wall_w(x, y, z, vi, area, data, p2data,
                c_stone, c_air, id_table["vine_underground"], 1 / 15, lastlayer
            )
        end,
        -- 49. Omphyrite with lava
        [49] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 50. Afualite with coal and diamonds
        [50] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 51. Afualite with vindesites and lava
        [51] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 52. Black gneiss with copper
        [52] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 53. Hektorite with lava
        [53] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 54. Blue basalt with gold
        [54] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 55. Sichamine with amethyst/aquamarine blocks
        [55] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.jbiomes.replace_in_matrix(vi, data, c_air, c_water)
        end,
        -- 56. Salmon granite with iron
        [56] = function(x, y, z, vi, data, p2data, area, lastlayer)
        end,
        -- 57. Dark peridotite with malachite and burning mushrooms
        [57] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.on_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["mushroom_burning"], 1 / 18
            )
        end,
        -- 58. Hektorite with shinestone
        [58] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.on_roof(x, y, z, vi, area, data,
                c_stone, c_air, id_table["dynamic_stone_shinestone"], 1 / 50, lastlayer
            )
        end,
        -- 59. Afualite with obsidian
        [59] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.in_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["dynamic_stone_obsidian"], 1 / 20
            )
        end,
        -- 60. Emutite with lava
        [60] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.jbiomes.replace_in_matrix(vi, data, c_air, c_lava)
        end,
        -- 61. Dark peridotite with blue basalt
        [61] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.pbiomes.in_floor(x, y, z, vi, area, data,
                c_stone, c_air, id_table["dynamic_stone_basalt_blue"], 1 / 200
            )
        end,
        -- 62. Obscurite
        [62] = function(x, y, z, vi, data, p2data, area, lastlayer)
            unilib.jbiomes.replace_in_matrix(vi, data, c_air, c_lava)
        end,
    }

    -- The second is adapted from underch/jit.lua, originally called "underch.jit.biomegen"
    -- It is used in calls to unilib.jbiomes.reveal(). When matrix nodes are exposed to air, they
    --      are converted to pseudo-biome appropriate items, using this table
    local converted_table = {
        -- 1. Basic pale dolostone
        [1] = function(pos)
            switch_stone(pos, "dolostone_pale")
        end,
        -- 2. Basic grey limestone
        [2] = function(pos)
            switch_stone(pos, "limestone_grey")
        end,
        -- 3. Basic red schist
        [3] = function(pos)
            switch_stone(pos, "schist_red")
        end,
        -- 4. Basic dark andesite
        [4] = function(pos)
            switch_stone(pos, "andesite_dark")
        end,
        -- 5. Basic phyllite
        [5] = function(pos)
            switch_stone(pos, "phyllite")
        end,
        -- 6. Basic brown quartzite
        [6] = function(pos)
            switch_stone(pos, "quartzite_brown")
        end,
        -- 7. Basic amphibolite
        [7] = function(pos)
            switch_stone(pos, "amphibolite")
        end,
        -- 8. Basic red slate
        [8] = function(pos)
            switch_stone(pos, "slate_red")
        end,
        -- 9. Basic black gneiss
        [9] = function(pos)
            switch_stone(pos, "gneiss_black")
        end,
        -- 10. Basic phonolite
        [10] = function(pos)
            switch_stone(pos, "phonolite")
        end,
        -- 11. Basic aplite
        [11] = function(pos)
            switch_stone(pos, "aplite")
        end,
        -- 12. Basic blue basalt
        [12] = function(pos)
            switch_stone(pos, "basalt_blue")
        end,
        -- 13. Basic pale diorite
        [13] = function(pos)
            switch_stone(pos, "diorite_pale")
        end,
        -- 14. Basic red pegmatite
        [14] = function(pos)
            switch_stone(pos, "pegmatite_red")
        end,
        -- 15. Basic salmon granite
        [15] = function(pos)
            switch_stone(pos, "granite_salmon")
        end,
        -- 16. Basic brown gabbro
        [16] = function(pos)
            switch_stone(pos, "gabbro_brown")
        end,
        -- 17. Pale dolostone cave
        [17] = function(pos)
            switch_stone(pos, "dolostone_pale")
            unilib.jbiomes.ore(pos,
                "unilib:stone_dolostone_pale", "unilib:liquid_water_ordinary_source", 1 / 2000
            )
        end,
        -- 18. Grey limestone with dust
        [18] = function(pos)
            switch_stone(pos, "limestone_grey")
        end,
        -- 19. Amphibolite with coal and dust
        [19] = function(pos)
            switch_stone(pos, "amphibolite")
            unilib.jbiomes.ore(pos,
                "unilib:stone_amphibolite", "unilib:stone_ordinary_with_coal_dense", 1 / 201
            )
        end,
        -- 20. White vindesite with quartz ore and black mushrooms
        [20] = function(pos)
            switch_stone(pos, "vindesite_white")
            unilib.jbiomes.ore(pos,
                "unilib:stone_vindesite_white", "unilib:stone_vindesite_white_with_quartz_white",
                1 / 50
            )
        end,
        -- 21. Phyllite with red/brown mushrooms and moss
        [21] = function(pos)
            switch_stone(pos, "phyllite")
            unilib.jbiomes.ore(pos,
                "unilib:stone_phyllite", "unilib:liquid_water_ordinary_source", 1 / 2000
            )
        end,
        -- 22. Phonolite with torchberries and brown mushrooms
        [22] = function(pos)
            switch_stone(pos, "phonolite")
            unilib.jbiomes.ore(pos,
                "unilib:stone_phonolite", "unilib:liquid_water_ordinary_source", 1 / 2000
            )
        end,
        -- 23. Red schist with tubers and black mushrooms
        [23] = function(pos)
            switch_stone(pos, "schist_red")
            unilib.jbiomes.ore(pos,
                "unilib:stone_schist_red", "unilib:stone_ordinary_with_coal_dense", 1 / 201
            )
            unilib.jbiomes.ore(pos,
                "unilib:stone_schist_red", "unilib:liquid_water_ordinary_source", 1 / 2000
            )
        end,
        -- 24. Red slate with black slime
        [24] = function(pos)
            switch_stone(pos, "slate_red")
            unilib.jbiomes.blob(pos,
                unilib.constant.y_min, unilib.constant.y_max, "unilib:stone_slate_red",
                "unilib:stone_slimestone_black_block_slimy", 0.7, 17, 18, 19
            )
            unilib.jbiomes.ore(pos,
                "unilib:stone_slimestone_black_block_slimy",
                "unilib:stone_slimestone_black_with_eye", 1 / 10
            )
        end,
        -- 25. Pale diorite with quartz crystals
        [25] = function(pos)
            switch_stone(pos, "diorite_pale")
            unilib.jbiomes.ore(pos,
                "unilib:stone_diorite_pale", "unilib:stone_ordinary_with_quartz_white", 1 / 50
            )
            unilib.jbiomes.ore(pos,
                "unilib:stone_diorite_pale", "unilib:liquid_water_ordinary_source", 1 / 2000
            )
        end,
        -- 26. Phonolite with emerald crystals
        [26] = function(pos)
            switch_stone(pos, "phonolite")
            unilib.jbiomes.ore(pos,
                "unilib:stone_phonolite", "unilib:stone_ordinary_with_emerald", 1 / 201
            )
        end,
        -- 27. Blue basalt with moss and brown mushrooms
        [27] = function(pos)
            switch_stone(pos, "basalt_blue")
            unilib.jbiomes.ore(pos,
                "unilib:stone_basalt_blue_cobble", "unilib:stone_basalt_blue_cobble_mossy", 3 / 4
            )
            unilib.jbiomes.ore(pos,
                "unilib:stone_basalt_blue", "unilib:liquid_water_ordinary_source", 1 / 2000
            )
        end,
        -- 28. Green slimestone
        [28] = function(pos)
            switch_stone(pos, "slimestone_green")
            unilib.jbiomes.blob(pos,
                unilib.constant.y_min, unilib.constant.y_max, "unilib:stone_slimestone_green",
                "unilib:stone_slimestone_green_block_slimy", 0.7, 17, 18, 19
            )
            unilib.jbiomes.ore(pos,
                "unilib:stone_slimestone_green_block_slimy",
                "unilib:stone_slimestone_green_with_eye", 1 / 10
            )
        end,
        -- 29. Sichamine with light blocks
        [29] = function(pos)
            switch_stone(pos, "sichamine")
            unilib.jbiomes.ore(pos,
                "unilib:stone_sichamine", "unilib:light_block_sichamine", 1 / 25
            )
        end,
        -- 30. Sichamine with dark stones
        [30] = function(pos)
            switch_stone(pos, "sichamine")
            unilib.jbiomes.ore(pos,
                "unilib:stone_sichamine", "unilib:stone_sichamine_dark", 1 / 9
            )
        end,
        -- 31. Salmon granite with torchberries
        [31] = function(pos)
            switch_stone(pos, "granite_salmon")
            unilib.jbiomes.blob(pos,
                unilib.constant.y_min, unilib.constant.y_max, "unilib:stone_granite_salmon",
                "unilib:dirt_mossy",
                0.5, 17, 18, 19
            )
        end,
        -- 32. Dark andesite with dirt, mould and vines
        [32] = function(pos)
            switch_stone(pos, "andesite_dark")
            unilib.jbiomes.ore(pos,
                "unilib:stone_andesite_dark", "unilib:liquid_water_ordinary_source", 1 / 2000
            )
        end,
        -- 33. Marble with lava springs
        [33] = function(pos)
            switch_stone(pos, "marble_carrara")
            unilib.jbiomes.ore(pos,
                "unilib:stone_marble_carrara", "unilib:liquid_lava_ordinary_source", 1 / 2000
            )
        end,
        -- 34. Phonolite with fiery dust
        [34] = function(pos)
            switch_stone(pos, "phonolite")
        end,
        -- 35. Red schist with fiery dust and fiery vines
        [35] = function(pos)
            switch_stone(pos, "schist_red")
        end,
        -- 36. Blue vindesite with burner stones
        [36] = function(pos)
            switch_stone(pos, "vindesite_blue")
            unilib.jbiomes.ore(pos,
                "unilib:stone_vindesite_blue", "unilib:misc_stone_burner", 1 / 15
            )
        end,
        -- 37. Phyllite with mushrooms and mould
        [37] = function(pos)
            switch_stone(pos, "phyllite")
            unilib.jbiomes.ore(pos,
                "unilib:stone_phyllite", "unilib:liquid_water_ordinary_source", 1 / 2000
            )
        end,
        -- 38. Omphyrite with fiery dust and burning mushrooms
        [38] = function(pos)
            switch_stone(pos, "omphyrite")
        end,
        -- 39. Red pegmatite with fiery dust/vines and burning/orange mushrooms
        [39] = function(pos)
            switch_stone(pos, "pegmatite_red")
        end,
        -- 40. Purple slimestone
        [40] = function(pos)
            switch_stone(pos, "slimestone_purple")
            unilib.jbiomes.blob(pos,
                unilib.constant.y_min, unilib.constant.y_max, "unilib:stone_slimestone_purple",
                "unilib:stone_slimestone_purple_block_slimy", 0.7, 17, 18, 19
            )
            unilib.jbiomes.ore(pos,
                "unilib:stone_slimestone_purple_block_slimy",
                "unilib:stone_slimestone_purple_with_eye", 1 / 10
            )
        end,
        -- 41. Black gneiss with mese and sapphire crystals
        [41] = function(pos)
            switch_stone(pos, "gneiss_black")
            unilib.jbiomes.ore(pos,
                "unilib:stone_gneiss_black", "unilib:stone_ordinary_with_sapphire", 1 / 201
            )
            unilib.jbiomes.ore(pos,
                "unilib:stone_gneiss_black", "unilib:liquid_water_ordinary_source", 1 / 2000
            )
        end,
        -- 42. Salmon granite with ruby crystals
        [42] = function(pos)
            switch_stone(pos, "granite_salmon")
            unilib.jbiomes.ore(pos,
                "unilib:stone_granite_salmon", "unilib:stone_ordinary_with_ruby", 1 / 201
            )
            unilib.jbiomes.ore(pos,
                "unilib:stone_granite_salmon", "unilib:liquid_water_ordinary_source", 1 / 2000
            )
        end,
        -- 43. Blue basalt with moss
        [43] = function(pos)
            switch_stone(pos, "basalt_blue")
        end,
        -- 44. Red slimestone
        [44] = function(pos)
            switch_stone(pos, "slimestone_red")
            unilib.jbiomes.blob(pos,
                unilib.constant.y_min, unilib.constant.y_max, "unilib:stone_slimestone_red",
                "unilib:stone_slimestone_red_block_slimy", 0.7, 17, 18, 19
            )
            unilib.jbiomes.ore(pos,
                "unilib:stone_slimestone_red_block_slimy", "unilib:stone_slimestone_red_with_eye",
                1 / 10
            )
        end,
        -- 45. Sichamine with lava
        [45] = function(pos)
            switch_stone(pos, "sichamine")
            unilib.jbiomes.ore(pos,
                "unilib:stone_sichamine", "unilib:light_block_sichamine", 1 / 25
            )
            unilib.jbiomes.ore(pos,
                "unilib:stone_sichamine", "unilib:stone_hektorite", 1 / 50
            )
            unilib.jbiomes.ore(pos,
                "unilib:stone_sichamine", "unilib:stone_omphyrite_crack_lava", 1 / 50
            )
        end,
        -- 46. Pale diorite with aquamarine and amethyst
        [46] = function(pos)
            switch_stone(pos, "diorite_pale")
            unilib.jbiomes.ore(pos,
                "unilib:stone_diorite_pale", "unilib:stone_ordinary_with_aquamarine", 1 / 50
            )
            unilib.jbiomes.ore(pos,
                "unilib:stone_diorite_pale", "unilib:stone_ordinary_with_amethyst", 1 / 50
            )
            unilib.jbiomes.ore(pos,
                "unilib:stone_diorite_pale", "unilib:liquid_water_ordinary_source", 1 / 2000
            )
        end,
        -- 47. Dark andesite with vines and mushrooms
        [47] = function(pos)
            switch_stone(pos, "andesite_dark")
        end,
        -- 48. Brown gabbro with vines and mushrooms
        [48] = function(pos)
            switch_stone(pos, "gabbro_brown")
            unilib.jbiomes.ore(pos,
                "unilib:stone_gabbro_brown", "unilib:liquid_lava_ordinary_source", 1 / 5000
            )
        end,
        -- 49. Omphyrite with lava
        [49] = function(pos)
            switch_stone(pos, "omphyrite")
            unilib.jbiomes.ore(pos,
                "unilib:stone_omphyrite", "unilib:stone_omphyrite_crack_lava", 1 / 18
            )
            unilib.jbiomes.ore(pos,
                "unilib:stone_omphyrite", "unilib:liquid_lava_ordinary_source", 1 / 1000
            )
        end,
        -- 50. Afualite with coal and diamonds
        [50] = function(pos)
            switch_stone(pos, "afualite")
            unilib.jbiomes.ore(pos,
                "unilib:stone_afualite", "unilib:mineral_coal_block", 1 / 18
            )
            unilib.jbiomes.ore(pos,
                "unilib:mineral_coal_block", "unilib:mineral_coal_block_with_diamond", 1 / 72
            )
            unilib.jbiomes.ore(pos,
                "unilib:stone_afualite", "unilib:liquid_lava_ordinary_source", 1 / 1000
            )
        end,
        -- 51. Afualite with vindesites and lava
        [51] = function(pos)
            switch_stone(pos, "afualite")
            unilib.jbiomes.blob(pos,
                unilib.constant.y_min, unilib.constant.y_max, "unilib:stone_afualite",
                "unilib:stone_vindesite_white",
                0.5, 17, 18, 19
            )
            unilib.jbiomes.blob(pos,
                unilib.constant.y_min, unilib.constant.y_max, "unilib:stone_afualite",
                "unilib:stone_vindesite_blue",
                0.5, 19, 17, 18
            )
            unilib.jbiomes.ore(pos,
                "unilib:stone_afualite", "unilib:liquid_lava_ordinary_source", 1 / 1000
            )
        end,
        -- 52. Black gneiss with copper
        [52] = function(pos)
            switch_stone(pos, "gneiss_black")
            unilib.jbiomes.ore(pos,
                "unilib:stone_gneiss_black", "unilib:stone_ordinary_with_copper_dense", 1 / 201
            )
            unilib.jbiomes.ore(pos,
                "unilib:stone_gneiss_black", "unilib:liquid_lava_ordinary_source", 1 / 1000
            )
        end,
        -- 53. Hektorite with lava
        [53] = function(pos)
            switch_stone(pos, "hektorite")
            unilib.jbiomes.ore(pos,
                "unilib:stone_hektorite", "unilib:liquid_lava_ordinary_source", 1 / 1000
            )
        end,
        -- 54. Blue basalt with gold
        [54] = function(pos)
            switch_stone(pos, "basalt_blue")
            unilib.jbiomes.ore(pos,
                "unilib:stone_basalt_blue", "unilib:stone_ordinary_with_gold_dense", 1 / 407
            )
            unilib.jbiomes.ore(pos,
                "unilib:stone_basalt_blue", "unilib:liquid_lava_ordinary_source", 1 / 1000
            )
        end,
        -- 55. Sichamine with amethyst/aquamarine blocks
        [55] = function(pos)
            unilib.jbiomes.replace_in_converted(pos,
                "unilib:stone_ordinary", "unilib:mineral_quartz_white_block"
            )
            unilib.jbiomes.ore(pos,
                "unilib:mineral_quartz_white_block", "unilib:mineral_aquamarine_block", 1 / 4
            )
            unilib.jbiomes.ore(pos,
                "unilib:mineral_quartz_white_block", "unilib:mineral_amethyst_block", 1 / 3
            )
            unilib.jbiomes.ore(pos,
                "unilib:mineral_quartz_white_block", "unilib:light_block_sichamine", 1 / 25
            )
            switch_stone(pos, "sichamine")
        end,
        -- 56. Salmon granite with iron
        [56] = function(pos)
            switch_stone(pos, "granite_salmon")
            unilib.jbiomes.ore(pos,
                "unilib:stone_granite_salmon", "unilib:stone_ordinary_with_iron_dense", 1 / 207
            )
            unilib.jbiomes.ore(pos,
                "unilib:stone_granite_salmon", "unilib:liquid_lava_ordinary_source", 1 / 1000
            )
        end,
        -- 57. Dark peridotite with malachite and burning mushrooms
        [57] = function(pos)
            switch_stone(pos, "peridotite_dark")
            unilib.jbiomes.blob(pos,
                unilib.constant.y_min, unilib.constant.y_max, "unilib:stone_peridotite_dark",
                "unilib:stone_malachite", 0.2, 17, 18, 19
            )
            unilib.jbiomes.ore(pos,
                "unilib:stone_peridotite_dark", "unilib:liquid_lava_ordinary_source", 1 / 1000
            )
        end,
        -- 58. Hektorite with shinestone
        [58] = function(pos)
            switch_stone(pos, "hektorite")
            unilib.jbiomes.ore(pos,
                "unilib:stone_hektorite", "unilib:liquid_lava_ordinary_source", 1 / 300
            )
        end,
        -- 59. Afualite with obsidian
        [59] = function(pos)
            switch_stone(pos, "afualite")
            unilib.jbiomes.ore(pos,
                "unilib:stone_afualite", "unilib:liquid_lava_ordinary_source", 1 / 300
            )
        end,
        -- 60. Emutite with lava
        [60] = function(pos)
            switch_stone(pos, "emutite")
        end,
        -- 61. Dark peridotite with blue basalt
        [61] = function(pos)
            switch_stone(pos, "peridotite_dark")
            unilib.jbiomes.ore(pos,
                "unilib:stone_peridotite_dark", "unilib:liquid_lava_ordinary_source", 1 / 300
            )
        end,
        -- 62. Obscurite
        [62] = function(pos)
            core.set_node(pos, {name = "unilib:stone_obscurite"})
        end,
    }

    -- There are also two ore generation tables, used by unilib.jbiomes.reveal()
    -- The first one specifies calls to unilib.jbiomes.blob()
    local blob_table = {
        {unilib.constant.y_min, unilib.constant.y_max, nil, "unilib:sand_silver", 0.09, 21, 22, 23},
        {-31, unilib.constant.y_max, nil, "unilib:dirt_ordinary", 0.09, 19, 22, 23},
        {unilib.constant.y_min, unilib.constant.y_max, nil, "unilib:gravel_ordinary", 0.09, 21, 19, 24},
        {-93, unilib.constant.y_max, nil, "unilib:clay_brown", 0.09, 19, 24, 25},
        {-1301, unilib.constant.y_max, nil, "unilib:gravel_mossy", 0.09, 18, 19, 23},
        {unilib.constant.y_min, unilib.constant.y_max, nil, "unilib:stone_ordinary_cobble", 0.09, 20, 21, 19},
    }

    -- The second one specifies calls to unilib.jbiomes.scatter()
    local scatter_table = {
        {unilib.constant.y_min, 64, nil, "unilib:stone_ordinary_with_coal", 150, 29, 32, 33},
        {unilib.constant.y_min, -20, nil, "unilib:stone_ordinary_with_tin", 165, 30, 29, 31},
        {unilib.constant.y_min, -20, nil, "unilib:stone_ordinary_with_copper", 163, 27, 28, 31},
        {unilib.constant.y_min, -40, nil, "unilib:stone_ordinary_with_iron", 170, 29, 27, 31},
        {unilib.constant.y_min, -250, nil, "unilib:stone_ordinary_with_gold", 173, 32, 29, 27},
        {unilib.constant.y_min, -500, nil, "unilib:stone_ordinary_with_mese", 175, 29, 31, 28},
        {unilib.constant.y_min, -500, nil, "unilib:stone_ordinary_with_diamond", 180, 32, 31, 29},
        {unilib.constant.y_min, -1000, nil, "unilib:mineral_mese_block", 200, 29, 32, 35},
        -- (From moreores)
        {unilib.constant.y_min, -2, nil, "unilib:stone_ordinary_with_silver", 173, 30, 31, 37},
        {unilib.constant.y_min, -512, nil, "unilib:stone_ordinary_with_mithril", 185, 33, 28, 29},
        -- (From technic)
        {unilib.constant.y_min, -80, nil, "unilib:stone_ordinary_with_chromium", 170, 28, 31, 33},
        {unilib.constant.y_min, -80, nil, "unilib:stone_ordinary_with_lead", 170, 28, 35, 33},
        {-300, -80, nil, "unilib:stone_ordinary_with_uranium", 170, 30, 31, 28},
        {unilib.constant.y_min, -80, nil, "unilib:stone_ordinary_with_zinc", 170, 28, 37, 30},
        -- (From xtraores)
        -- N.B. In the original underch code, osmium a.k.a. ozymandium is missing from this list,
        --      and the .y_max values (the second item in each mini-list) doesn't match the values
        --      in the original xtraores code. Both problems are corrected here
        --[[
        {unilib.constant.y_min, -100, nil, "unilib:stone_ordinary_with_planexium", 180, 35, 29, 28},
        {unilib.constant.y_min, -1000, nil, "unilib:stone_ordinary_with_sybilline", 190, 29, 33, 34},
        {unilib.constant.y_min, -2000, nil, "unilib:stone_ordinary_with_adamantite", 200, 31, 32, 33},
        {unilib.constant.y_min, -5000, nil, "unilib:stone_ordinary_with_rarium", 205, 30, 34, 37},
        {unilib.constant.y_min, -10000, nil, "unilib:stone_ordinary_with_unobtainium", 210, 29, 37, 34},
        {unilib.constant.y_min, -15000, nil, "unilib:stone_ordinary_with_tritonium", 215, 32, 29, 37},
        {unilib.constant.y_min, -28000, nil, "unilib:stone_ordinary_with_geminitium", 220, 32, 33, 35},
        ]]--
        {unilib.constant.y_min, -100, nil, "unilib:stone_ordinary_with_planexium", 180, 35, 29, 28},
        {unilib.constant.y_min, -1000, nil, "unilib:stone_ordinary_with_sybilline", 190, 29, 33, 34},
        {unilib.constant.y_min, -2000, nil, "unilib:stone_ordinary_with_ozymandium", 200, 31, 32, 33},
        {unilib.constant.y_min, -5000, nil, "unilib:stone_ordinary_with_adamantite", 205, 30, 34, 37},
        {unilib.constant.y_min, -10000, nil, "unilib:stone_ordinary_with_rarium", 210, 29, 37, 34},
        {unilib.constant.y_min, -15000, nil, "unilib:stone_ordinary_with_unobtainium", 215, 32, 29, 37},
        {unilib.constant.y_min, -25000, nil, "unilib:stone_ordinary_with_tritonium", 220, 32, 33, 35},
        {unilib.constant.y_min, -30000, nil, "unilib:stone_ordinary_with_geminitium", 220, 35, 33, 32},
    }

    -- Pass those tables to the code in ../lib/shared/jbiomes/
    unilib.jbiomes.setup_matrix(matrix_table)
    unilib.jbiomes.setup_converted(converted_table, blob_table, scatter_table)

end
