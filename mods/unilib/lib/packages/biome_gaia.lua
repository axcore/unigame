---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_gaia = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Values specified by GLEMr11's init.lua. The blend value has been halved to reduce the amount of
--      sand in low-lying areas (especially those far from the coast)
local biome_altitude_range = 40
--local biome_vertical_blend = biome_altitude_range / 5
local biome_vertical_blend = biome_altitude_range / 10

-- Perlin noise scale values to use for "sheet" ores, placed as ecosystems
-- The "rare" one is intended for ecosystems placed in badlands-style environments; the optimum
--      value seem to be around 0.65-0.7
local perlin_scale_table = {
    default = 1,
    rare = 0.66,
}

-- For ecosystem (ore) seeds we use a base value which is increased, whenever an ecosystem is
--      generated
local base_seed = unilib.utils.get_mod_attribute("storage_random_seed_offset")

-- Flag set to true, if we should check that specified nodes and biomes exist, showing a warning for
--      any problems. This flag can be disabled once any changes to the remix and its packages have
--      been checked
local debug_warning_flag = false

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

-- Constants read from the constants.csv must be available to other "gaia" packages
unilib.pkg.biome_gaia.constant_flag = false
unilib.pkg.biome_gaia.constant_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_dirt_on_demand(full_name)

    local data_table = unilib.pkg.dirt_custom_gaia.dirt_table[full_name]
    if data_table.dirt_part_name == nil then

        -- Short format, specifying only orig_name and the node definition
        unilib.register_node(full_name, data_table.orig_name, mode, data_table.def_table)

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

local function check_node(full_name)

    if unilib.utils.is_registered_node_or_mtgame_alias(full_name) == nil then

        if debug_warning_flag then
            unilib.utils.show_warning("biome_gaia package: Unrecognised node", full_name)
        end

        return false

    elseif unilib.utils.get_mod_name(full_name) ~= "unilib" then

        -- (Not a fatal error)
        if debug_warning_flag then
            unilib.utils.show_warning("biome_gaia package: Non-unilib node", full_name)
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

function unilib.pkg.biome_gaia.init()

    return {
        description = "Biomes for the \"gaia\" remix",
        notes = "Based on \"biome_glemr11\", changing just names and file locations. Code in" ..
                " this package, and in other \"gaia\" packages, is also compatible with the" ..
                " \"gaia_simple\" remix",
        depends = "dirt_custom_gaia",
        optional = "weather_snowflakes",
    }

end

function unilib.pkg.biome_gaia.post()

    -- Biomes for this remix are provided by the file biomes.csv. When loaded, the data is stored
    --      in unilib.global.biome_csv_setup_list until unilib is ready to create the biomes

    local biome_name_table = {}
    local key_list = {
        "dust", "top_str", "fill_str", "stone", "water_top_str", "water", "river", "riverbed_str",
        "cave_liquid", "dungeon", "dungeon_alt", "dungeon_stair",
    }

    for i, data_table in ipairs(unilib.global.biome_csv_setup_list) do

        -- (Don't act on biomes provides by incompatible remixes)
        if data_table.remix_name == "gaia" or data_table.remix_name == "gaia_simple" then

            biome_name_table[data_table.biome_name] = true

            for _, key in pairs(key_list) do

                if data_table[key] ~= nil then

                    -- e.g. "unilib:stone_ordinary 5"; remove the 5
                    local this_list = data_table[key]:split("%s", false, 1, true)
                    local full_name = this_list[1]

                    if full_name ~= nil and full_name ~= "" then

                        -- Register dirt on demand (see comments in the "dirt_custom_gaia"
                        --      package)
                        if unilib.setting.dirt_on_demand_flag and
                                core.registered_nodes[full_name] == nil and
                                unilib.pkg.dirt_custom_gaia.dirt_table[full_name] ~= nil then
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
            unilib.global.biome_csv_setup_list[i]["blend"] = biome_vertical_blend

        end

    end

    -- Ecosystems create variety within biomes, placing ore distributions in which a unique
    --      selection of decorations can be placed
    -- The ecosystems are specified by an ecosystems.csv in the remix folder

    -- (This code is adapted from read_csv.lua)
    local remix_dir
    if unilib.global.remix_dir_table["gaia_simple"] ~= nil then
        remix_dir = unilib.utils.get_remix_dir("gaia_simple")
    else
        remix_dir = unilib.utils.get_remix_dir("gaia")
    end

    local constants_path = remix_dir .. "/constants.csv"
    local ecosystems_path = remix_dir .. "/ecosystems.csv"

    if unilib.utils.is_file(constants_path) then

        for i, csv_table in ipairs(unilib.utils.read_csv(constants_path)) do

            -- "key" is expected to contain at least one letter, "value" at least one digit
            local key, value = unpack(csv_table)
            if key ~= nil and value ~= nil then

                if not string.find(key, "%a") then

                    unilib.utils.show_warning(
                        "biome_gaia package: Invalid biome constant", constants_path, i
                    )

                elseif not string.find(value, "[%d]") then

                    unilib.utils.show_warning(
                        "biome_gaia package: Invalid biome constant value", constants_path, i
                    )

                else

                    unilib.pkg.biome_gaia.constant_table[key] = tonumber(value)
                    -- (Table is not empty)
                    unilib.pkg.biome_gaia.constant_flag = true

                end

            end

        end

    end

    if unilib.utils.is_file(ecosystems_path) then

        for i, csv_table in ipairs(unilib.utils.read_csv(ecosystems_path)) do

            local ore_type, biome_name, ore_name, wherein, threshold, y_max, y_min =
                    unpack(csv_table)

            if ore_type ~= nil and string.find(ore_type, "%a") then

                if ore_type ~= "default" and ore_type ~= "rare" and ore_type ~= "fungi" then

                    unilib.utils.show_warning(
                        "biome_gaia package: Invalid ore type", ecosystems_path, i
                    )

                else

                    -- Replace unspecified values. Also, when biome showcase mode is enabled, all
                    --      ecosystems must spawn at all heights
                    if y_max == nil or y_max == "" or unilib.setting.debug_biome_showcase_flag then
                        y_max = unilib.constant.y_max
                    end

                    if y_min == nil or y_min == "" or unilib.setting.debug_biome_showcase_flag then
                        y_min = unilib.constant.y_min
                    end

                    -- Replace constant values
                    if unilib.pkg.biome_gaia.constant_flag then

                        if y_max ~= nil and unilib.pkg.biome_gaia.constant_table[y_max] ~= nil then
                            y_max = unilib.pkg.biome_gaia.constant_table[y_max]
                        end

                        if y_min ~= nil and unilib.pkg.biome_gaia.constant_table[y_min] ~= nil then
                            y_min = unilib.pkg.biome_gaia.constant_table[y_min]
                        end

                    end

                    -- Register dirt on demand (see comments in the "dirt_custom_gaia" package)
                    if unilib.setting.dirt_on_demand_flag then

                        if core.registered_nodes[ore_name] == nil and
                                unilib.pkg.dirt_custom_gaia.dirt_table[ore_name] ~= nil then
                            register_dirt_on_demand(ore_name)
                        end

                        if core.registered_nodes[wherein] == nil and
                                unilib.pkg.dirt_custom_gaia.dirt_table[wherein] ~= nil then
                            register_dirt_on_demand(wherein)
                        end

                    end

                    -- Check biome names (if specified)
                    if biome_name ~= "" and
                            biome_name_table[biome_name] == nil and
                            core.registered_biomes[biome_name] == nil and
                            unilib.global.biome_name_check_table[biome_name] == nil then

                        if debug_warning_flag then

                            unilib.utils.show_warning(
                                "biome_gaia package: Unrecognised biome", biome_name
                            )

                        end

                    -- Check nodes
                    elseif not unilib.utils.is_registered_node_or_mtgame_alias(ore_name) then

                        if debug_warning_flag then

                            unilib.utils.show_warning(
                                "biome_gaia package: Unrecognised node", ore_name
                            )

                        end

                    elseif not unilib.utils.is_registered_node_or_mtgame_alias(wherein) then

                        if debug_warning_flag then

                            unilib.utils.show_warning(
                                "biome_gaia package: Unrecognised node(s)", wherein
                            )

                        end

                    -- Register the ecosystems as ores
                    else

                        local spread_val = 2 ^ (tonumber(threshold) * 10)
--                      local ore_seed = math.random(1, spread_val)

                        if ore_type == "default" or ore_type == "rare" then

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
                                    scale = perlin_scale_table[ore_type],   -- default = 1
--                                  seed = ore_seed,
                                    seed = base_seed + spread_val,
                                    spread = {x = 128, y = 128, z = 128},
                                },
                                noise_threshold = tonumber(threshold),
                                y_max = tonumber(y_max) or (
                                    unilib.pkg.biome_gaia.constant_table[y_max] +
                                    biome_vertical_blend
                                ),
                                y_min = tonumber(y_min) or (
                                    unilib.pkg.biome_gaia.constant_table[y_min] -
                                    biome_vertical_blend
                                ),
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
--                                  seed = ore_seed,
                                    seed = base_seed + spread_val,
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

    -- Apply the upper limit for pseudo-biomes created by remixes like "hades", "hades_jit",
    --      "underch" and "underch_jit"
    if unilib.pkg.biome_gaia.constant_table["OCEAN"] ~= nil then
        unilib.global.pseudo_biome_limit = tonumber(unilib.pkg.biome_gaia.constant_table["OCEAN"])
    end

    -- The snowflakes package, if loaded, must be asked to reduce the maximum temperature at which
    --      it will act (default 35), to one that suits the "gaia" remix (default 25)
    -- (To remove snowflake effects entirely, just comment out this package in the remix)
    if unilib.global.pkg_executed_table["weather_snowflakes"] ~= nil then

        local cool = unilib.pkg.biome_gaia.constant_table["COOL"]
        if cool ~= nil then
            unilib.pkg.weather_snowflakes.set_max_temp(cool)
        end

    end

end
