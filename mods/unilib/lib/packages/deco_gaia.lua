---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_gaia = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Flag set to true, if we should check that specified nodes and biomes exist, showing a warning for
--      any problems. This flag can be disabled once any changes to the remix and its packages have
--      been checked
local debug_warning_flag = false

-- Table of schematics, loaded from ecosystems.csv, and their package dependences; see the comments
--      in .init()
local exception_table = {
    unilib_glem_tree_apple_mature_1 = "tree_apple_mature",
    -- N.B. this remix uses mature apple tree leaves, as well as banana tree leaves (for some
    --      reason)
    unilib_glem_tree_banana_1 = "tree_apple_mature",
    unilib_glem_plant_bulrush_1 = "plant_reedmace",
}

-- In the code below, we need to be able to check both biomes that have been created, and those
--      that are waiting to be created
-- Table of biome names, compiled from core.registered_biomes() and
--      unilib.global.biome_csv_setup_list()
local biome_check_table = {}

-- Flag set to true, to show a summary of "gaia" remix decorations on startup
local deco_summary_flag = false
-- Table of regions and their decorations, e.g.
--      region_summary_table["hot_humid"] = frequency_table
-- ...where "frequency_table" is in the form
--      frequency_table[node_or_schematic] = number_of_occurences
-- N.B. Assumes that all biomes mentioned in biomes.csv are in the form
--      "gaia_TEMPERATURE_HUMIDITY_ALTITUDE", for which we only want the "TEMPERATURE_HUMIDITY" part
local region_summary_table = {}
-- Table of all regions and their decorations, in the form
--      general_summary_table[node_or_schematic] = number_of_occurences
local general_summary_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function convert_to_list(arg)

    -- Modified version of unilib.utils.convert_to_list() (from utils.lua), taking into account that
    --      a string may be a list of whitespace-separated values

    if type(arg) == "table" then

        -- Already a list
        return arg

    elseif arg == nil or arg == "" then

        -- For nil/empty strings, return an empty list
        return {}

    else

        return unilib.utils.split_string_by_whitespace(arg, true)

    end

end

local function check_biomes(biome_list)

    -- Check arguments
    for _, biome_name in pairs(biome_list) do

        if core.registered_biomes[biome_name] == nil and
                unilib.global.biome_name_check_table[biome_name] == nil and
                biome_check_table[biome_name] == nil then

            if debug_warning_flag then
                unilib.utils.show_warning("deco_gaia package: Unrecognised biome", biome_name)
            end

            return false

        end

    end

    return true

end

local function check_nodes(node_list)

    -- Register dirt on demand (see comments in the "dirt_custom_gaia" package)
    if unilib.setting.dirt_on_demand_flag then

        for _, full_name in pairs(node_list) do

            if core.registered_nodes[full_name] == nil and
                    unilib.pkg.dirt_custom_gaia.dirt_table[full_name] ~= nil then

                local data_table = unilib.pkg.dirt_custom_gaia.dirt_table[full_name]
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

                -- Register woodsoils, if required
                if unilib.pkg.dirt_custom_gaia.woodsoil_table[full_name] ~= nil then

                    unilib.pkg.dirt_custom_gaia.register_woodsoils(
                        unilib.pkg.dirt_custom_gaia.woodsoil_table[full_name],
                        full_name
                    )

                end

            end

        end

    end

    -- Check arguments
    for _, full_name in pairs(node_list) do

        if not unilib.utils.is_registered_node_or_mtgame_alias(full_name) then

            if debug_warning_flag then
                unilib.utils.show_warning("deco_gaia package: Unrecognised node", full_name)
            end

            return false

        elseif unilib.utils.get_mod_name(full_name) ~= "unilib" then

            -- (Not a fatal error)
            if debug_warning_flag then
                unilib.utils.show_warning("deco_gaia package: Non-unilib node", full_name)
            end

        end

    end

    return true

end

local function check_schematics(schem_list)

    -- Check arguments
    for _, schem_name in pairs(schem_list) do

        if not unilib.utils.is_file(unilib.core.path_mod .. "/mts/" .. schem_name .. ".mts") then

            if debug_warning_flag then
                unilib.utils.show_warning("deco_gaia package: Missing schematic file", schem_name)
            end

            return false

        elseif exception_table[schem_name] ~= nil and
                unilib.global.pkg_executed_table[exception_table[schem_name]] == nil then

            if debug_warning_flag then

                unilib.utils.show_warning(
                    "deco_gaia package: Can\'t use decoration schematic because package not" ..
                            " executed",
                    schem_name,
                    exception_table[schem_name]
                )

            end

            return false

        end

    end

    return true

end

local function check_deco(data_table)

    -- Checks one of the values in unilib.global.deco_csv_setup_list (representing a decoration that
    --      hasn't been created yet) for validity

     -- (Don't act on decorations provides by incompatible remixes)
    if data_table.remix_name ~= "gaia" and data_table.remix_name ~= "gaia_simple" then
        return false
    end

    if data_table.deco_type == "simple" then

        -- If required, check that nodes actually exist, and register dirt on demand
        if not check_nodes(convert_to_list(data_table.deco_name)) then
            return false
        end

    elseif data_table.deco_type == "treelog" then

        -- Items in "treelog" constructions can the name of the schematic for the tree itself, or
        --      the full_name of the trunk node used to construct the log
        for _, item_name in ipairs(convert_to_list(data_table.deco_name)) do

            if not string.find(item_name, ":") then

                if not check_schematics({item_name}) then
                    return
                end

            else

                if not check_nodes({item_name}) then
                    return
                end

            end

        end

    else

        -- If required, check that the schematics actually exist and are suitable for use
        if not check_schematics(convert_to_list(data_table.deco_name)) then
            return false
        end

    end

    if data_table.place_on ~= nil then

        if not check_nodes(convert_to_list(data_table.place_on)) then
            return false
        end

    end

    if data_table.spawn_by ~= nil then

        if not check_nodes(convert_to_list(data_table.spawn_by)) then
            return false
        end

    end

    -- If required, check that biomes actually exist
    for _, biome_table in pairs(unilib.global.biome_csv_setup_list) do
        biome_check_table[biome_table.biome_name] = true
    end

    if data_table.biomes ~= nil then

        if not check_biomes(convert_to_list(data_table.biomes)) then
            return false
        end

    end

    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_gaia.init()

    return {
        description = "Decorations for the \"gaia\" remix",
        notes = "This package should be used with the corresponding remix, as it assumes that" ..
                " packages specified by the remix have been loaded",
        depends = "biome_gaia",
        -- A few lines in decorations.csv will generate errors when the replace_mode for
        --      minetest_game mods is "defer", because the corresponding packages won't have been
        --      executed
        -- Rather than add an extra column to decorations.lua, specifying package dependencies
        --      (which will be empty in almost all cases), just use a simple exception table
        --      (specified above) to filter out any such problems
        -- The packages involved are those listed here
        optional = {"plant_reedmace", "tree_apple_mature"},
    }

end

function unilib.pkg.deco_gaia.post()

    -- (Most) decorations for this remix are provided by the file decorations.csv. When loaded, the
    --      data is stored in unilib.global.deco_csv_setup_list until unilib is ready to create the
    --      decorations

    -- Compile a table of biome names for checking
    -- Some biomes have already been registered in core.registered_nodes(), others are waiting to be
    --      registered in unilib.global.biome_csv_setup_list()
    for name, _ in pairs(core.registered_biomes) do
        biome_check_table[name] = true
    end

    for _, data_table in pairs(unilib.global.biome_csv_setup_list) do
        biome_check_table[data_table.biome_name] = true
    end

    -- Check decorations loaded from CSV, filtering out any that are invalid
    local new_setup_list = {}
    for _, data_table in ipairs(unilib.global.deco_csv_setup_list) do

        if check_deco(data_table) then

            -- Decoration has passed checks, so use it
            table.insert(new_setup_list, data_table)

            -- Compile decoration frequency table, if required
            if deco_summary_flag then

                for _, deco_name in pairs(
                    unilib.utils.split_string_by_whitespace(data_table.deco_name)
                ) do

                    if general_summary_table[deco_name] == nil then

                        general_summary_table[deco_name] = 1

                    else

                        local count = general_summary_table[deco_name] + 1
                        general_summary_table[deco_name] = count

                    end

                    for _, biome_name in ipairs(
                        unilib.utils.split_string_by_whitespace(data_table.biomes)
                    ) do

                        -- N.B. As noted above, assumes that all biomes mentioned in biomes.csv are
                        --      in the form "gaia_TEMPERATURE_HUMIDITY_ALTITUDE", for which we only
                        --      want the "TEMPERATURE_HUMIDITY" part
                        local region_name = string.gsub(biome_name, "^%w+_(%w+_%w+)_.*", "%1")

                        if region_summary_table[region_name] == nil then
                            region_summary_table[region_name] = {}
                        end

                        if region_summary_table[region_name][deco_name] == nil then

                            region_summary_table[region_name][deco_name] = 1

                        else

                            local count = region_summary_table[region_name][deco_name] + 1
                            region_summary_table[region_name][deco_name] = count

                        end

                    end

                end

            end

        end

    end

    -- Update global variables
    unilib.global.deco_csv_setup_list = new_setup_list

    -- Display the frequency tables, if required
    if deco_summary_flag then

        unilib.utils.show_msg("deco_gaia package: overall decoration frequency")
        if general_summary_table == nil then

            unilib.utils.show_msg("   <no decorations set>")

        else

            for _, deco in ipairs(unilib.utils.sort_table(general_summary_table)) do
                unilib.utils.show_msg("   " .. deco .. ": " .. general_summary_table[deco])
            end

            unilib.utils.show_msg("End of list")

            unilib.utils.show_msg("deco_gaia package: decoration frequency by region")
            for _, region in ipairs(unilib.utils.sort_table(region_summary_table)) do

                unilib.utils.show_msg("   " .. region)

                for _, deco in ipairs(unilib.utils.sort_table(region_summary_table[region])) do

                    local data_table = region_summary_table[region][deco]
                    unilib.utils.show_msg(
                        "      " .. deco .. ": " ..
                        region_summary_table[region][deco]
                    )

                end

            end

            unilib.utils.show_msg("End of list")

        end

    end

end
