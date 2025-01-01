---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_ore.lua
--      Register ores
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Local storage for the decoration/ore seed offsets
local storage_random_seed_offset = unilib.utils.get_mod_attribute("storage_random_seed_offset")

---------------------------------------------------------------------------------------------------
-- Register ores
---------------------------------------------------------------------------------------------------

function unilib.register._register_ore(def_table, csv_flag)

    -- Original to unilib
    -- Registers an ore distribution in global variables
    -- During the unilib setup consolidation stage (../lib/system/load/load_consolidate_general.lua)
    --      ores are registered with Minetest in the correct order, via a call to
    --      unilib.register_ore_now()
    --
    -- Args:
    --      def_table (table): Usual definition table for the ore distribution. Note that def_table
    --          must include an .ore_type field, whose value is "stratum", "sheet", "vein", "puff",
    --          "blob", or "scatter"
    --
    -- Optional args:
    --      csv_flag (bool): true when called by unilib.register_biome_from_csv()

    -- Apply the random seed offset, if required
    if def_table.noise_params ~= nil and def_table.noise_params.seed ~= nil then
        def_table.noise_params.seed = def_table.noise_params.seed + storage_random_seed_offset
    end

    -- The ore definition is now ready to be registered with the engine
--  core.register_ore(def_table)
    if csv_flag then
        table.insert(unilib.global.ore_csv_final_table[def_table.ore_type], def_table)
    else
        table.insert(unilib.global.ore_other_final_table[def_table.ore_type], def_table)
    end

end
