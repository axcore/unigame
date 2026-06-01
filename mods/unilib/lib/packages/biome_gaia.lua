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

-- Read CSVs from the first remix with the label "gaia"
unilib.pkg.biome_gaia.remix_name = nil

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function refine_value(value, constant_value)

    -- Switch a value read from a remix CSV for the corresponding value in constants.csv, when
    --      available
    -- A copy of the function in ../lib/system/read/read_csv_remix.lua

    if value == nil or constant_value == nil then
        return value
    else
        return constant_value
    end

end

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
        description = "Biomes for \"gaia\"-compatible remixes",
        notes = "Based on \"biome_glemr11\", changing just names and file locations. Code in" ..
                " this package, and in other \"gaia\" packages, is compatible with any remix" ..
                " with the label \"gaia\"",
        depends = "dirt_custom_gaia",
--      optional = "weather_snow_special",
    }

end

function unilib.pkg.biome_gaia.post()

    -- Read CSVs from the first remix with the label "gaia" (default: the "gaia" remix itself)
    unilib.pkg.biome_gaia.remix_name = unilib.utils.get_remix_by_label("gaia") or "gaia"

    -- Biomes for this remix are provided by the file biomes.csv. When loaded, the data is stored
    --      in unilib.global.biome_csv_setup_list until unilib is ready to create the biomes

    local biome_name_table = {}
    local key_list = {
        "dust", "top_str", "fill_str", "stone", "water_top_str", "water", "river", "riverbed_str",
        "cave_liquid", "dungeon", "dungeon_alt", "dungeon_stair",
    }

    for i, data_table in ipairs(unilib.global.biome_csv_setup_list) do

        -- (Don't act on biomes provided by other remixes)
        if data_table.remix_name == unilib.pkg.biome_gaia.remix_name then

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
    local constants_table =
            unilib.global.remix_constants_table[unilib.pkg.biome_gaia.remix_name] or {}
    local remix_dir = unilib.utils.get_remix_dir(unilib.pkg.biome_gaia.remix_name)
    local ecosystems_path = remix_dir .. "/ecosystems.csv"
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
                    -- N.B. "ore_type" cannot be replaced with a constant value
                    biome_name = refine_value(biome_name, constants_table[biome_name])
                    ore_name = refine_value(ore_name, constants_table[ore_name])
                    wherein = refine_value(wherein, constants_table[wherein])
                    threshold = refine_value(threshold, constants_table[threshold])
                    y_max = refine_value(y_max, constants_table[y_max])
                    y_min = refine_value(y_min, constants_table[y_min])

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

                    -- (Minetest will show a warning if the ore's .biome is an empty string)
                    if biome_name == "" then
                        biome_name = nil
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
                                    tonumber(constants_table[y_max]) + biome_vertical_blend
                                ),
                                y_min = tonumber(y_min) or (
                                    tonumber(constants_table[y_min]) - biome_vertical_blend
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
    if constants_table["OCEAN"] ~= nil then
        unilib.global.pseudo_biome_limit = tonumber(constants_table["OCEAN"])
    end

    -- N.B. In v1.2.0, removed compatibility with the "weather_snow_special" package, since unilib
    --      now has its own weather system
    -- If you want to reinsert it, uncomment the code below, uncomment the line above to reinstante
    --      add "weather_snow_special" as an optional package, and add that package to the "gaia" or
    --      "gaia_simple" remixes
    --
    -- The snowflakes package, if loaded, must be asked to reduce the maximum temperature at which
    --      it will act (default 35), to one that suits this "gaia"-compatible remix (default 25)
    -- (To remove snowflake effects entirely, just comment out this package in the remix)
    --[[
    if unilib.global.pkg_executed_table["weather_snow_special"] ~= nil then

        local cool = tonumber(constants_table["COOL"])
        if cool ~= nil then
            unilib.pkg.weather_snow_special.set_max_temp(cool)
        end

        -- We also restrict the biomes in which snowflake effects appear, for aesthetics
        local cold = tonumber(constants_table["COLD"])
        local temperate = tonumber(constants_table["TEMPERATE"])
        if cold ~= nil and temperate ~= nil then

            for i, data_table in ipairs(unilib.global.biome_csv_setup_list) do

                local heat = tonumber(data_table.heat)
                local humidity = tonumber(data_table.humidity)

                if heat ~= nil and heat <= cold and humidity ~= nil and humidity >= temperate then
                    unilib.pkg.weather_snow_special.set_exclusive_biome(data_table.biome_name)
                end

            end

        end

    end
    ]]--

end
