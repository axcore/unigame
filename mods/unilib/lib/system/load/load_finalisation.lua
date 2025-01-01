---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- load_finalisation.lua
--      Execute finalisation code
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_ore(def_table)

    -- Original to unilib
    -- Registers an ore distribution with the Minetest engine, after making a few checks
    --
    -- Args:
    --      def_table (table): Usual definition table for the ore distribution

    -- Check for valid heights, if required
    if unilib.setting.debug_check_heights_flag and
            not unilib.utils.check_heights(def_table.y_max, def_table.y_min) then

        unilib.utils.show_warning(
            "unilib.register_ore_now(): Invalid height values in ore registration",
            def_table.ore,
            def_table.y_max,
            def_table.y_min
        )

    -- Ores with non-existent nodes cause unified_inventory to crash, so we must filter them out
    elseif not unilib.utils.is_registered_node_or_mtgame_alias(def_table.ore) then

        unilib.utils.show_warning(
            "unilib.register_ore_now(): Unspecified or non-existent node in ore registration",
            def_table.ore
        )

    elseif not unilib.utils.is_registered_node_or_mtgame_alias(def_table.wherein) then

        unilib.utils.show_error(
            "unilib.register_ore_now(): Unspecified or non-existent node(s) in ore registration",
            def_table.wherein
        )

    else

        core.register_ore(def_table)

    end

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- After all package .post() functions have been called, we do some finalisation

-- Create aliases, mapping any unilib nodes/craftitems/tools which have not been created onto their
--      minetest_game equivalents
for orig_name, unilib_name in pairs(unilib.global.mtgame_convert_table) do

    if core.registered_items[unilib_name] == nil then
        core.register_alias(unilib_name, orig_name)
    end

end

-- Create biome definitions for any biomes loaded from a remix biome table (when used in a package,
--      they usually appear in the .post() function)
for _, biome_name in ipairs(unilib.global.biome_csv_setup_list) do
    unilib.register_biome_from_csv(biome_name)
end

-- Create decoration decorations for any decorations loaded from a remix decoration table (when used
--      in a package, they usually appear in the .post() function)
for _, mini_table in ipairs(unilib.global.deco_csv_setup_list) do
    unilib.register_decoration_from_csv(mini_table)
end

-- Create ores decorations for any ores loaded from a remix ore table (when used in a package, they
--      usually appear in the .post() function)
for _, mini_table in ipairs(unilib.global.ore_csv_setup_list) do
    unilib.register_ore_from_csv(mini_table)
end

-- We can now register the biomes, decorations and ores with the Minetest engine, using CSV items
--      first, followed by those created by packages
for _, def_table in ipairs(unilib.global.biome_csv_final_list) do
    core.register_biome(def_table)
end

for _, def_table in ipairs(unilib.global.biome_other_final_list) do
    core.register_biome(def_table)
end

for _, def_table in ipairs(unilib.global.deco_csv_final_list) do
    core.register_decoration(def_table)
end

for _, def_table in ipairs(unilib.global.deco_other_final_list) do
    core.register_decoration(def_table)
end

for _, ore_type in ipairs({"stratum", "sheet", "vein", "puff", "blob", "scatter"}) do

    -- For each ore definition, do a few final checks before calling core.register_ore()
    for _, def_table in ipairs(unilib.global.ore_csv_final_table[ore_type]) do
        register_ore(def_table)
    end

    for _, def_table in ipairs(unilib.global.ore_other_final_table[ore_type]) do
        register_ore(def_table)
    end

end

-- We can now release some memory by resetting biome/decoration/ore variables that we don't need any
--      more
unilib.global.biome_csv_setup_list = {}
unilib.global.deco_csv_setup_list = {}
unilib.global.ore_csv_setup_list = {}
unilib.global.biome_csv_final_list = {}
unilib.global.biome_other_final_list = {}
unilib.global.deco_csv_final_list = {}
unilib.global.deco_other_final_list = {}
unilib.global.ore_csv_final_table = {}
unilib.global.ore_other_final_table = {}
unilib.global.biome_name_check_table = {}
unilib.global.deco_name_check_table = {}

-- Set up growth of crop/produce items using code imported from the farming_redo mod
unilib.farming.register_growth_stages()

-- Update the table of turf seeder items, unilib.global.turf_seeder_table, replacing items
--      represented as groups (e.g. "group:dry_grass") with actual node names
--      (e.g. "unilib:grass_dry_1")
unilib.dirt.update_turf_seeder_items()

-- Update sapling growth requirements according to Minetest settings
if unilib.setting.sapling_override_flag then

    core.register_on_mods_loaded(function()
        unilib.flora.update_sapling_growth_requirements()
    end)

end
