---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_glemr11 = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

-- Values specified by GLEMr11's init.lua
local biome_altitude_range = 40
local biome_vertical_blend = biome_altitude_range / 5

-- Flag set to true, if we should check that specified nodes and biomes exist, showing a warning for
--      any problems. This flag can be disabled once any changes to the remix and its packages have
--      been checked
local debug_warning_flag = false

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_dirt_on_demand(full_name)

    local data_table = unilib.pkg.dirt_custom_glemr11.dirt_table[full_name]
    if data_table.dirt_part_name == nil then

        -- Short format, specifying only orig_name and the node definition
        unilib.register_node(full_name, data_table.orig_name, mode, data_table.def_table)

    else

        -- Long format, specifying everything required by calls to
        --      unilib.register_dirt_with_turf()
        unilib.register_dirt_with_turf(data_table)

    end

end

local function check_node(full_name)

    if unilib.is_registered_node_or_mtgame_alias(full_name) == nil then

        if debug_warning_flag then
            unilib.show_warning("biome_glemr11 package: Unrecognised node", full_name)
        end

        return false

    elseif unilib.get_mod_name(full_name) ~= "unilib" then

        -- (Not a fatal error)
        if debug_warning_flag then
            unilib.show_warning("biome_glemr11 package: Non-unilib node", full_name)
        end

    end

    return true

end

local function register_ore(def_table)

    -- Don't create the ecosystem/ore, if the nodes don't exist
    if not check_node(def_table.ore) or not check_node(def_table.wherein) then
        return
    end

    unilib.register_ore(def_table)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_glemr11.init()

    return {
        description = "Biomes from GLEMr11",
        notes = "This package should be used with the corresponding remix, as it assumes that" ..
                " packages specified by the remix have been loaded",
        depends = "dirt_custom_glemr11",
    }

end

function unilib.pkg.biome_glemr11.post()

    -- Biomes for this remix are provided by the file biomes.csv. When loaded, the data is stored
    --      in unilib.biome_setup_list until unilib is ready to create the biomes

    local biome_name_table = {}
    local key_list = {
        "dust", "top_str", "fill_str", "stone", "water_top_str", "water", "river", "riverbed_str",
        "cave_liquid", "dungeon", "dungeon_alt", "dungeon_stair",
    }

    for i, data_table in ipairs(unilib.biome_setup_list) do

        -- (Don't act on biomes provides by other remixes)
        if data_table.remix_name == "glemr11" then

            biome_name_table[data_table.biome_name] = true

            for _, key in pairs(key_list) do

                if data_table[key] ~= nil then

                    -- e.g. "unilib:stone_ordinary 5"; remove the 5
                    local this_list = data_table[key]:split("%s", false, 1, true)
                    local full_name = this_list[1]

                    if full_name ~= nil and full_name ~= "" then

                        -- Register dirt on demand (see comments in the "dirt_custom_glemr11"
                        --      package)
                        if unilib.glem_dirt_on_demand_flag and
                                minetest.registered_nodes[full_name] == nil and
                                unilib.pkg.dirt_custom_glemr11.dirt_table[full_name] ~= nil then
                            register_dirt_on_demand(full_name)
                        end

                        -- Check node names. The function shows a warning, if warnings are enabled
                        check_node(full_name)

                    end

                end

            end

            -- Set the biome's vertical blend. It is possible for a remix's biomes.csv to specify
            --      the value directly, but in this case, we want to use the value specified above,
            --      so it can also be used in the ecosystems below
            unilib.biome_setup_list[i]["blend"] = biome_vertical_blend

        end

    end

    -- Ecosystems create variety within biomes, placing ore distributions in which a unique
    --      selection of decorations can be placed
    -- The ecosystems are specified by an ecosystems.csv in the remix folder

    -- (This code is adapted from read_csv.lua)
    local constants_path = unilib.path_mod .. "/csv/remixes/glemr11/constants.csv"
    local constant_flag = false
    local constant_table = {}

    local ecosystems_path = unilib.path_mod .. "/csv/remixes/glemr11/ecosystems.csv"

    if unilib.is_file(constants_path) then

        for i, csv_table in ipairs(unilib.read_csv(constants_path)) do

            -- "key" is expected to contain at least one letter, "value" at least one digit
            local key, value = unpack(csv_table)
            if key ~= nil and value ~= nil then

                if not string.find(key, "%a") then

                    unilib.show_warning(
                        "biome_glemr11 package: Invalid biome constant", constants_path, i
                    )

                elseif not string.find(value, "[%d]") then

                    unilib.show_warning(
                        "biome_glemr11 package: Invalid biome constant value", constants_path, i
                    )

                else

                    constant_table[key] = value
                    -- (Table is not empty)
                    constant_flag = true

                end

            end

        end

    end

    if unilib.is_file(ecosystems_path) then

        for i, csv_table in ipairs(unilib.read_csv(ecosystems_path)) do

            local ore_type, biome_name, ore_name, wherein, threshold, y_max, y_min =
                    unpack(csv_table)

            if ore_type ~= nil and string.find(ore_type, "%a") then

                if ore_type ~= "dirt" and ore_type ~= "fungi" then

                    unilib.show_warning(
                        "biome_glemr11 package: Invalid ore type", ecosystems_path, i
                    )

                else

                    -- Replace constant values
                    if constant_flag then

                        if y_max ~= nil and constant_table[y_max] ~= nil then
                            y_max = constant_table[y_max]
                        end

                        if y_min ~= nil and constant_table[y_min] ~= nil then
                            y_min = constant_table[y_min]
                        end

                    end

                    -- Register dirt on demand (see comments in the "dirt_custom_glemr11" package)
                    if unilib.glem_dirt_on_demand_flag then

                        if minetest.registered_nodes[ore_name] == nil and
                                unilib.pkg.dirt_custom_glemr11.dirt_table[ore_name] ~= nil then
                            register_dirt_on_demand(ore_name)
                        end

                        if minetest.registered_nodes[wherein] == nil and
                                unilib.pkg.dirt_custom_glemr11.dirt_table[wherein] ~= nil then
                            register_dirt_on_demand(wherein)
                        end

                    end

                    -- Check biome names
                    if biome_name_table[biome_name] == nil and
                            minetest.registered_biomes[biome_name] == nil then

                        if debug_warning_flag then

                            unilib.show_warning(
                                "biome_glemr11 package: Unrecognised biome", biome_name
                            )

                        end

                    -- Check nodes
                    elseif not unilib.is_registered_node_or_mtgame_alias(ore_name) then

                        if debug_warning_flag then

                            unilib.show_warning(
                                "biome_glemr11 package: Unrecognised node", ore_name
                            )

                        end

                    elseif not unilib.is_registered_node_or_mtgame_alias(wherein) then

                        if debug_warning_flag then

                            unilib.show_warning(
                                "biome_glemr11 package: Unrecognised node(s)", wherein
                            )

                        end

                    -- Register the ecosystems as ores
                    else

                        local spread_val = 2 ^ (tonumber(threshold) * 10)
                        local ore_seed = math.random(1, spread_val)

                        if ore_type == "dirt" then

                            register_ore({
                                ore_type = "sheet",
                                ore = ore_name,
                                wherein = wherein,

                                biomes = biome_name or nil,
                                clust_size = 8,
                                column_height_max =
                                        biome_altitude_range + (biome_vertical_blend * 2),
                                column_height_min =
                                        (biome_altitude_range / 2) + biome_vertical_blend,
                                column_midpoint_factor = 0.5,
                                noise_params = {
                                    octaves = 5,
                                    offset = 0,
                                    persist = 0.60,
                                    scale = 1,
                                    seed = ore_seed,
                                    spread = {x = 128, y = 128, z = 128},
                                },
                                noise_threshold = tonumber(threshold),
                                y_max = tonumber(y_max) or
                                        (constant_table[y_max] + biome_vertical_blend),
                                y_min = tonumber(y_min) or
                                        (constant_table[y_min] - biome_vertical_blend),
                            })

                        elseif ore_type == "fungi" then

                            register_ore({
                                ore_type = "sheet",
                                ore = ore_name,
                                wherein = wherein,

                                biomes = biome_name or nil,
                                clust_size = (tonumber(threshold) * 10),
                                column_height_max = biome_altitude_range,
                                column_height_min = 1,
                                column_midpoint_factor = 0.5,
                                noise_params = {
                                    octaves = 5,
                                    offset = 0,
                                    persist = 0.60,
                                    scale = 1,
                                    seed = ore_seed,
                                    spread = {x = spread_val, y = spread_val, z = spread_val},
                                },
                                noise_threshold = tonumber(threshold),
                                y_max = tonumber(y_max),
                                y_min = tonumber(y_min),
                            })

                        end

                    end

                end

            end

        end

    end

end
