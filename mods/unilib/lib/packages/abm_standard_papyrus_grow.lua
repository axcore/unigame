---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_standard_papyrus_grow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

local dirt_table = {}
dirt_table["unilib:dirt_ordinary"] = true
dirt_table["unilib:dirt_dry"] = true

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

-- Table populated below
unilib.pkg.abm_standard_papyrus_grow.neighbour_table = {}

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_standard_papyrus_grow.register_papyrus_dirt(dirt_name, add_turf_nodes_flag)

    -- Original to unilib
    -- In the original minetest_game code, papyrus grows only on (the equivalents of) ordinary dirt
    --      and dry dirt, as well as any related dirt-with-turf nodes. Those dirts are the ones that
    --      occur in the minetest_game biomes, in which papyrus spawns
    -- unilib packages, during their execution phase (the .exec() function), can call this function
    --      to increase the number of dirts on which papyrus can grow
    --
    -- There is no need to call this function for ordinary and dry dirt; papyrus always grows on
    --      them and all associated dirt-with-turf nodes. If you like, your code can call this
    --      function with the arguments ( "unilib:dirt_ordinary", false ), which will remove the
    --      ability to grow on the associated dirt-with-turf nodes
    -- There is no need to call this function for any associated dirt-with-turf nodes; just make
    --      one call specifying the dirt node itself
    --
    -- Args:
    --      dirt_name (str): e.g. "unilib:dirt_silt_coarse"
    --      add_turf_nodes_flag (bool): If true, both the dirt and its dirt-with-turf nodes are
    --          added. If false (or nil), only the dirt node is added

    if add_turf_nodes_flag == nil then
        add_turf_nodes_flag = false
    end

    -- (Eliminate duplicates by using a table, rather than a list)
    dirt_table[dirt_name] = add_turf_nodes_flag

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_standard_papyrus_grow.init()

    return {
        description = "ABM to handle papyrus growth (from minetest_game/default)",
    }

end

function unilib.pkg.abm_standard_papyrus_grow.post()

    -- Adadpted from default/functions.lua
    -- Handles growth of papyrus from a single node, in an upwards direction

    -- Compile a reverse lookup table, converting dirt nodes into dirt-with-turf nodes
    local reverse_table = {}

    for turf_name, data_table in pairs(unilib.global.dirt_with_turf_table) do

        local dirt_name = "unilib:" .. data_table.dirt_part_name
        if reverse_table[dirt_name] == nil then
            reverse_table[dirt_name] = {}
        end

        table.insert(reverse_table[dirt_name], turf_name)

    end

    -- Compile a list of dirt and dirt-with-turf nodes, on which the papyrus can grow
    local neighbour_list = {}
    for dirt_name, add_turf_nodes_flag in pairs(dirt_table) do

        table.insert(neighbour_list, dirt_name)
        unilib.pkg.abm_standard_papyrus_grow.neighbour_table[dirt_name] = true

        if add_turf_nodes_flag and reverse_table[dirt_name] ~= nil then

            for _, turf_name in pairs(reverse_table[dirt_name]) do

                table.insert(neighbour_list, turf_name)
                unilib.pkg.abm_standard_papyrus_grow.neighbour_table[turf_name] = true

            end

        end

    end

    -- Register the ABM
    unilib.register_abm({
        label = "Papyrus growth [plant_papyrus_ordinary]",
        nodenames = {"group:papyrus_grow"},
        neighbors = neighbour_list,

        chance = 71,
        interval = 14,

        action = function(...)
            unilib.flora.grow_papyrus(...)
        end
    })
    unilib.register_obsolete_abm({
        mod_origin = "default",
        label = "Grow papyrus",
    })

end
