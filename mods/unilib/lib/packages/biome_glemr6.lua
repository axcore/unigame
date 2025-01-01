---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_glemr6 = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr6.add_mode

-- Environmental constants (from lib_ecology/init.lua)
local ALTITUDE_RANGE = 40
local BIOME_VERTICAL_BLEND = ALTITUDE_RANGE / 10
if not unilib.setting.glem_biome_blend_flag then
    BIOME_VERTICAL_BLEND = nil
end

local HEIGHT_OCEAN = -192
local HEIGHT_BEACH_MIN = -4
local HEIGHT_SEA = 0
local HEIGHT_BEACH_MAX = 4
local HEIGHT_SNOW_MIN = 285
local HEIGHT_SNOW_MAX = 485

local HEIGHT_COASTAL = HEIGHT_SEA + ALTITUDE_RANGE
local HEIGHT_LOWLAND = HEIGHT_COASTAL + ALTITUDE_RANGE
local HEIGHT_SHELF = HEIGHT_LOWLAND + ALTITUDE_RANGE
local HEIGHT_HIGHLAND = HEIGHT_SHELF + ALTITUDE_RANGE
local HEIGHT_MOUNTAIN = HEIGHT_HIGHLAND + ALTITUDE_RANGE
local HEIGHT_STRATO = 1800

local TEMP_HOT = 90
local TEMP_WARM = 70
local TEMP_TEMPERATE = 50
local TEMP_COOL = 30
local TEMP_COLD = 10

local HUMIDITY_HUMID = 90
local HUMIDITY_SEMIHUMID = 70
local HUMIDITY_TEMPERATE = 50
local HUMIDITY_SEMIARID = 30
local HUMIDITY_ARID = 10

-- Flag set to true, if we should check that specified nodes exist, and that integer values are
--      really integers, showing a warning for any problems. This flag can be disabled once any
--      changes to the custom biomes have been checked
local debug_warning_flag = false

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

-- (Also used by the "deco_glemr6" package)

unilib.pkg.biome_glemr6.generic_biome_flag = false
-- Flags set to true if biomes, adapted from GLEM and valleys_c, should be added
unilib.pkg.biome_glemr6.glem_biome_flag = true
unilib.pkg.biome_glemr6.valleys_biome_flag = false
-- Flag set to true if biomes, commented out in the original GLEMr6 code, should be added. This
--      setting applies to all biome groups
unilib.pkg.biome_glemr6.optional_biome_flag = false

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function add_biome(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o)

    -- Register dirt on demand (see comments in the "dirt_custom_glemr6" package)
    if unilib.setting.dirt_on_demand_flag then

        for _, arg in pairs({b, c, e, g, h, i, j, k}) do

            if arg ~= nil and
                    core.registered_nodes[arg] == nil and
                    unilib.pkg.dirt_custom_glemr6.dirt_table[arg] ~= nil then

                local data_table = unilib.pkg.dirt_custom_glemr6.dirt_table[arg]
                if data_table.dirt_part_name == nil then

                    -- Short format, specifying only orig_name and the node definition
                    unilib.register_node(arg, data_table.orig_name, mode, data_table.def_table)

                else

                    -- Long format, specifying everything required by calls to
                    --      unilib.register_dirt_with_turf()
                    unilib.register_dirt_with_turf(data_table)

                end

            end

        end

    end

    -- Check arguments
    for _, arg in pairs({b, c, e, g, h, i, j, k}) do

        if arg ~= nil then

            if not unilib.utils.is_registered_node_or_mtgame_alias(arg) then

                if debug_warning_flag then
                    unilib.utils.show_warning("biome_glemr6 package: Unrecognised node", a, arg)
                end

                return

            elseif unilib.utils.get_mod_name(arg) ~= "unilib" then

                -- (Not a fatal error)
                if debug_warning_flag then
                    unilib.utils.show_warning("biome_glemr6 package: Non-unilib node", a, arg)
                end

            end

        end

        for _, arg in pairs({d, f, l, m, n, o}) do

            if arg ~= nil and tonumber(arg) == nil then

                if debug_warning_flag then

                    unilib.utils.show_warning(
                        "biome_glemr6 package: Invalid value (should be numeric)", a, arg
                    )

                end

                return

            end

        end

    end

    -- N.B. The biome description used here is simplistic and untranslated (but should be
    --      sufficient for anyone who actually wants to use this package)
    local component_list = unilib.utils.split_string_by_underline(a)
    local description = nil
    for _, component in ipairs(component_list) do

        if component ~= "glemr4" then

            if component == "semiarid" then
                component = "semi-arid"
            end

            if component == "semihumid" then
                component = "semi-humid"
            end

            if description == nil then
                description = unilib.utils.first_to_upper(component)
            else
                description = description .. " " .. component
            end

        end

    end

    if description ~= nil then
        description = description .. " biome"
    end

    unilib.register_biome({
        name = a,
        description = description,
        node_dust = b,
        node_top = c,
        depth_top = d,
        node_filler = e,
        depth_filler = f,
        node_stone = g,
        node_water_top = h,
        depth_water_top = i,
        node_water = j,
        node_river_water = k,
        y_min = l,
        y_max = m,
        vertical_blend = BIOME_VERTICAL_BLEND,
        heat_point = n,
        humidity_point = o,
    })

end

---------------------------------------------------------------------------------------------------
-- Hot biomes
---------------------------------------------------------------------------------------------------

local function add_biomes_hot_humid()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_hot_humid", nil, "unilib:dirt_clayey_with_litter_rainforest", 1, "unilib:dirt_clayey", 4, nil, nil, nil, nil, nil, 0, 100, TEMP_HOT, HUMIDITY_HUMID)
        add_biome("glemr6_hot_humid_generic", nil, "unilib:dirt_clayey_with_litter_rainforest", 1, "unilib:dirt_clayey", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_HOT, HUMIDITY_HUMID)
        add_biome("glemr6_hot_humid_underground", nil, nil, nil, nil, nil, "unilib:stone_basalt_dark", nil, nil, nil, nil, -100, -192, TEMP_HOT, HUMIDITY_HUMID)

    end

    add_biome("glemr6_hot_humid_ocean", nil, "unilib:dirt_silt_coarse", 4, "unilib:dirt_silt_coarse", 6, "unilib:stone_basalt_dark", nil, nil, nil, nil, -192, -2, TEMP_HOT, HUMIDITY_HUMID)
    add_biome("glemr6_hot_humid_beach", nil, "unilib:dirt_silt_coarse", 2, "unilib:dirt_silt_coarse", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, -2, 2, TEMP_HOT, HUMIDITY_HUMID)

    add_biome("glemr6_hot_humid_coastal", nil, "unilib:dirt_ordinary_with_turf_hot_humid_coastal", 1, "unilib:dirt_silt_coarse", 6, "unilib:stone_basalt_dark", nil, nil, nil, nil, 2, HEIGHT_COASTAL, TEMP_HOT, HUMIDITY_HUMID)
    add_biome("glemr6_hot_humid_lowland", nil, "unilib:dirt_ordinary_with_turf_hot_humid_lowland", 1, "unilib:dirt_silt_fine", 5, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_HOT, HUMIDITY_HUMID)
    add_biome("glemr6_hot_humid_shelf", nil, "unilib:dirt_ordinary_with_turf_hot_humid_shelf", 1, "unilib:dirt_dark", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_HOT, HUMIDITY_HUMID)
    add_biome("glemr6_hot_humid_highland", nil, "unilib:dirt_ordinary_with_turf_hot_humid_highland", 1, "unilib:dirt_ordinary", 3, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_HOT, HUMIDITY_HUMID)

    add_biome("glemr6_hot_humid_mountain", nil, "unilib:stone_brownstone_dark", 10, "unilib:stone_basalt_dark", 20, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_HOT, HUMIDITY_HUMID)
    add_biome("glemr6_hot_humid_strato", nil, "unilib:stone_sandstone_ordinary", 15, "unilib:stone_sandstone_desert", 25, "unilib:stone_sandstone_brown", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_HOT, HUMIDITY_HUMID)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_hot_humid_volcanic", nil, "unilib:stone_basalt_dark_rubble", TEMP_COLD, "unilib:stone_basalt_dark", 20, "unilib:liquid_lava_ordinary_source", nil, nil, nil, nil, 140, 140, TEMP_HOT, HUMIDITY_HUMID)
        add_biome("glemr6_hot_humid_sky", nil, "lib_clouds:cloud_cirrus", 3, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_HOT, HUMIDITY_HUMID)

    end

end

local function add_biomes_hot_semihumid()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_hot_semihumid", nil, "unilib:dirt_clayey_with_litter_coniferous", 1, "unilib:dirt_clayey", 4, nil, nil, nil, nil, nil, 0, 100, TEMP_HOT, HUMIDITY_SEMIHUMID)
        add_biome("glemr6_hot_semihumid_generic", nil, "unilib:dirt_clayey_with_litter_coniferous", 1, "unilib:dirt_clayey", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_HOT, HUMIDITY_SEMIHUMID)
        add_biome("glemr6_hot_semihumid_underground", nil, nil, nil, nil, nil, "unilib:stone_basalt_dark", nil, nil, nil, nil, -100, -192, TEMP_HOT, HUMIDITY_SEMIHUMID)

    end

    add_biome("glemr6_hot_semihumid_ocean", nil, "unilib:dirt_silt_coarse", 4, "unilib:dirt_silt_coarse", 6, "unilib:stone_basalt_dark", nil, nil, nil, nil, -192, 0, TEMP_HOT, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_hot_semihumid_beach", nil, "unilib:sand_volcanic_dust", 2, "unilib:dirt_silt_coarse", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, -3, 3, TEMP_HOT, HUMIDITY_SEMIHUMID)

    add_biome("glemr6_hot_semihumid_coastal", nil, "unilib:dirt_ordinary_with_turf_hot_semihumid_coastal", 1, "unilib:dirt_silt_fine", 6, "unilib:stone_basalt_dark", nil, nil, nil, nil, 0, HEIGHT_COASTAL, TEMP_HOT, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_hot_semihumid_lowland", nil, "unilib:dirt_ordinary_with_turf_hot_semihumid_lowland", 1, "unilib:dirt_dark", 5, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_HOT, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_hot_semihumid_shelf", nil, "unilib:dirt_ordinary_with_turf_hot_semihumid_shelf", 1, "unilib:dirt_ordinary", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_HOT, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_hot_semihumid_highland", nil, "unilib:dirt_ordinary_with_turf_hot_semihumid_highland", 1, "unilib:dirt_coarse", 3, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_HOT, HUMIDITY_SEMIHUMID)

    add_biome("glemr6_hot_semihumid_mountain", nil, "unilib:stone_sandstone_brown", 10, "unilib:stone_brownstone_dark", 20, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_HOT, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_hot_semihumid_strato", nil, "unilib:stone_sandstone_ordinary", 15, "unilib:stone_sandstone_desert", 25, "unilib:stone_sandstone_brown", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_HOT, HUMIDITY_SEMIHUMID)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_hot_semihumid_volcanic", nil, "unilib:stone_basalt_dark_rubble", TEMP_COLD, "unilib:stone_basalt_dark", 20, "unilib:liquid_lava_ordinary_source", nil, nil, nil, nil, 140, 140, TEMP_HOT, HUMIDITY_SEMIHUMID)
        add_biome("glemr6_hot_semihumid_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_HOT, HUMIDITY_SEMIHUMID)

    end

end

local function add_biomes_hot_temperate()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_hot_temperate", nil, "unilib:dirt_clayey_with_turf", 1, "unilib:dirt_clayey", 2, nil, nil, nil, nil, nil, 0, 100, TEMP_HOT, HUMIDITY_TEMPERATE)
        add_biome("glemr6_hot_temperate_generic", nil, "unilib:dirt_clayey_with_turf", 1, "unilib:dirt_clayey", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_HOT, HUMIDITY_TEMPERATE)
        add_biome("glemr6_hot_temperate_underground", nil, nil, nil, nil, nil, "unilib:stone_brownstone_dark", nil, nil, nil, nil, -10000, -192, TEMP_HOT, HUMIDITY_TEMPERATE)

    end

    add_biome("glemr6_hot_temperate_ocean", nil, "unilib:sand_ordinary", 4, "unilib:dirt_silt_coarse", 6, "unilib:stone_brownstone_dark", nil, nil, nil, nil, -192, -4, TEMP_HOT, HUMIDITY_TEMPERATE)
    add_biome("glemr6_hot_temperate_beach", nil, "unilib:sand_volcanic_dust", 2, "unilib:dirt_silt_coarse", 4, "unilib:stone_brownstone_dark", nil, nil, nil, nil, -4, 4, TEMP_HOT, HUMIDITY_TEMPERATE)

    add_biome("glemr6_hot_temperate_coastal", nil, "unilib:dirt_ordinary_with_turf_hot_temperate_coastal", 1, "unilib:dirt_dark", 6, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, TEMP_HOT, HUMIDITY_TEMPERATE)
    add_biome("glemr6_hot_temperate_lowland", nil, "unilib:dirt_ordinary_with_turf_hot_temperate_lowland", 1, "unilib:dirt_ordinary", 5, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_HOT, HUMIDITY_TEMPERATE)
    add_biome("glemr6_hot_temperate_shelf", nil, "unilib:dirt_ordinary_with_turf_hot_temperate_shelf", 1, "unilib:dirt_coarse", 4, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_HOT, HUMIDITY_TEMPERATE)
    add_biome("glemr6_hot_temperate_highland", nil, "unilib:dirt_ordinary_with_turf_hot_temperate_highland", 1, "unilib:clay_red", 3, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_HOT, HUMIDITY_TEMPERATE)

    add_biome("glemr6_hot_temperate_mountain", nil, "unilib:stone_desert", 10, "unilib:stone_sandstone_ordinary", 20, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_HOT, HUMIDITY_TEMPERATE)
    add_biome("glemr6_hot_temperate_strato", nil, "unilib:stone_sandstone_ordinary", 15, "unilib:stone_sandstone_desert", 25, "unilib:stone_sandstone_brown", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_HOT, HUMIDITY_TEMPERATE)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_hot_temperate_volcanic", nil, "unilib:stone_basalt_dark_rubble", 1, "unilib:stone_basalt_dark", 4, "unilib:liquid_lava_ordinary_source", nil, nil, nil, nil, 140, 140, TEMP_HOT, HUMIDITY_TEMPERATE)
        add_biome("glemr6_hot_temperate_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_HOT, HUMIDITY_TEMPERATE)

    end

end

local function add_biomes_hot_semiarid()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_hot_semiarid", nil, "unilib:dirt_clayey_with_turf_dry", 1, "unilib:dirt_clayey", 2, nil, nil, nil, nil, nil, 0, 100, TEMP_HOT, HUMIDITY_SEMIARID)
        add_biome("glemr6_hot_semiarid_generic", nil, "unilib:dirt_clayey_with_turf_dry", 1, "unilib:dirt_clayey", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_HOT, HUMIDITY_SEMIARID)
        add_biome("glemr6_hot_semiarid_underground", nil, nil, nil, nil, nil, "unilib:stone_sandstone_brown", nil, nil, nil, nil, -6000, -192, TEMP_HOT, HUMIDITY_SEMIARID)

    end

    add_biome("glemr6_hot_semiarid_ocean", nil, "unilib:sand_ordinary", 2, "unilib:sand_ordinary", 4, "unilib:stone_sandstone_brown", nil, nil, nil, nil, -192, -4, TEMP_HOT, HUMIDITY_SEMIARID)
    add_biome("glemr6_hot_semiarid_beach", nil, "unilib:sand_ordinary", 1, "unilib:dirt_clayey", 4, "unilib:stone_sandstone_brown", nil, nil, nil, nil, -4, 4, TEMP_HOT, HUMIDITY_SEMIARID)

    add_biome("glemr6_hot_semiarid_coastal", nil, "unilib:dirt_ordinary_with_turf_hot_semiarid_coastal", 1, "unilib:dirt_ordinary", 6, "unilib:stone_sandstone_brown", nil, nil, nil, nil, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, TEMP_HOT, HUMIDITY_SEMIARID)
    add_biome("glemr6_hot_semiarid_lowland", nil, "unilib:dirt_ordinary_with_turf_hot_semiarid_lowland", 1, "unilib:dirt_coarse", 5, "unilib:stone_sandstone_brown", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_HOT, HUMIDITY_SEMIARID)
    add_biome("glemr6_hot_semiarid_shelf", nil, "unilib:dirt_ordinary_with_turf_hot_semiarid_shelf", 1, "unilib:clay_red", 4, "unilib:stone_sandstone_brown", nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_HOT, HUMIDITY_SEMIARID)
    add_biome("glemr6_hot_semiarid_highland", nil, "unilib:dirt_ordinary_with_turf_hot_semiarid_highland", 1, "unilib:dirt_clayey", 3, "unilib:stone_sandstone_brown", nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_HOT, HUMIDITY_SEMIARID)

    add_biome("glemr6_hot_semiarid_mountain", nil, "unilib:stone_sandstone_desert", 10, "unilib:stone_desert", 20, "unilib:stone_sandstone_brown", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_HOT, HUMIDITY_SEMIARID)
    add_biome("glemr6_hot_semiarid_strato", nil, "unilib:stone_sandstone_ordinary", 15, "unilib:stone_sandstone_desert", 25, "unilib:stone_sandstone_brown", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_HOT, HUMIDITY_SEMIARID)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_hot_semiarid_volcanic", nil, "unilib:stone_basalt_dark_rubble", 1, "unilib:stone_basalt_dark", 4, "unilib:liquid_lava_ordinary_source", nil, nil, nil, nil, 140, 140, TEMP_HOT, HUMIDITY_SEMIARID)
        add_biome("glemr6_hot_semiarid_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_HOT, HUMIDITY_SEMIARID)

    end

end

local function add_biomes_hot_arid()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_hot_arid", nil, "unilib:sand_desert", 1, "unilib:stone_brownstone_dark", 4, nil, nil, nil, nil, nil, 0, 100, TEMP_HOT, HUMIDITY_ARID)
        add_biome("glemr6_hot_arid_generic", nil, "unilib:sand_desert", 1, "unilib:stone_brownstone_dark", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_HOT, HUMIDITY_ARID)
        add_biome("glemr6_hot_arid_underground", nil, nil, nil, nil, nil, "unilib:stone_basalt_dark", nil, nil, nil, nil, -100, -192, TEMP_HOT, HUMIDITY_ARID)

    end

    add_biome("glemr6_hot_arid_ocean", nil, "unilib:sand_ordinary", 2, "unilib:clay_red", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, -192, -4, TEMP_HOT, HUMIDITY_ARID)
    add_biome("glemr6_hot_arid_beach", nil, "unilib:sand_ordinary", 1, "unilib:clay_red", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, -4, 4, TEMP_HOT, HUMIDITY_ARID)

    add_biome("glemr6_hot_arid_coastal", nil, "unilib:stone_sandstone_white", 5, "unilib:stone_brownstone_dark", 10, "unilib:stone_basalt_dark", nil, nil, nil, "unilib:clay_ordinary", HEIGHT_BEACH_MAX, HEIGHT_COASTAL, TEMP_HOT, HUMIDITY_ARID)
    add_biome("glemr6_hot_arid_lowland", nil, "unilib:stone_sandstone_white", 10, "unilib:stone_sandstone_brown", 15, "unilib:stone_brownstone_dark", nil, nil, nil, "unilib:clay_ordinary", HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_HOT, HUMIDITY_ARID)
    add_biome("glemr6_hot_arid_shelf", nil, "unilib:stone_sandstone_white", 10, "unilib:stone_desert", 20, "unilib:stone_sandstone_brown", nil, nil, nil, "unilib:clay_ordinary", HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_HOT, HUMIDITY_ARID)
    add_biome("glemr6_hot_arid_highland", nil, "unilib:stone_sandstone_white", 15, "unilib:stone_sandstone_desert", 25, "unilib:stone_desert", nil, nil, nil, "unilib:clay_ordinary", HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_HOT, HUMIDITY_ARID)

    add_biome("glemr6_hot_arid_mountain", nil, "unilib:sand_white", 10, "unilib:stone_brownstone_dark", 20, "unilib:stone_desert", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_HOT, HUMIDITY_ARID)
    add_biome("glemr6_hot_arid_strato", nil, "unilib:stone_sandstone_ordinary", 15, "unilib:stone_sandstone_desert", 25, "unilib:stone_sandstone_brown", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_HOT, HUMIDITY_ARID)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_hot_arid_volcanic", nil, "unilib:stone_basalt_dark_rubble", 1, "unilib:stone_basalt_dark", 4, "unilib:liquid_lava_ordinary_source", nil, nil, nil, nil, 140, 140, TEMP_HOT, HUMIDITY_ARID)
        add_biome("glemr6_hot_arid_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_HOT, HUMIDITY_ARID)

    end

end

---------------------------------------------------------------------------------------------------
-- Warm biomes
---------------------------------------------------------------------------------------------------

local function add_biomes_warm_humid()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_warm_humid", nil, "unilib:dirt_dark_with_litter_rainforest", 1, "unilib:dirt_dark", 2, nil, nil, nil, nil, nil, 0, 100, TEMP_WARM, HUMIDITY_HUMID)
        add_biome("glemr6_warm_humid_generic", nil, "unilib:dirt_dark_with_litter_rainforest", 1, "unilib:dirt_dark", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_WARM, HUMIDITY_HUMID)
        add_biome("glemr6_warm_humid_underground", nil, nil, nil, nil, nil, "unilib:stone_basalt_dark", nil, nil, nil, nil, -100, -192, TEMP_WARM, HUMIDITY_HUMID)

    end

    add_biome("glemr6_warm_humid_ocean", nil, "unilib:dirt_silt_coarse", 4, "unilib:dirt_silt_coarse", 6, "unilib:stone_basalt_dark", nil, nil, nil, nil, -192, -3, TEMP_WARM, HUMIDITY_HUMID)
    add_biome("glemr6_warm_humid_beach", nil, "unilib:sand_silica", 1, "unilib:sand_volcanic_dust", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, -3, 3, TEMP_WARM, HUMIDITY_HUMID)

    add_biome("glemr6_warm_humid_coastal", nil, "unilib:dirt_ordinary_with_turf_warm_humid_coastal", 1, "unilib:dirt_silt_coarse", 6, "unilib:stone_basalt_dark", nil, nil, nil, nil, -3, HEIGHT_COASTAL, TEMP_WARM, HUMIDITY_HUMID)
    add_biome("glemr6_warm_humid_lowland", nil, "unilib:dirt_ordinary_with_turf_warm_humid_lowland", 1, "unilib:dirt_silt_fine", 5, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_WARM, HUMIDITY_HUMID)
    add_biome("glemr6_warm_humid_shelf", nil, "unilib:dirt_ordinary_with_turf_warm_humid_shelf", 1, "unilib:dirt_dark", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_WARM, HUMIDITY_HUMID)
    add_biome("glemr6_warm_humid_highland", nil, "unilib:dirt_ordinary_with_turf_warm_humid_highland", 1, "unilib:dirt_ordinary", 3, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_WARM, HUMIDITY_HUMID)

    add_biome("glemr6_warm_humid_mountain", nil, "unilib:stone_sandstone_brown", 10, "unilib:stone_brownstone_dark", 20, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_WARM, HUMIDITY_HUMID)
    add_biome("glemr6_warm_humid_strato", nil, "unilib:stone_sandstone_desert", 15, "unilib:stone_sandstone_brown", 25, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_WARM, HUMIDITY_HUMID)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_warm_humid_volcanic", nil, "unilib:stone_basalt_dark_rubble", 1, "unilib:stone_basalt_dark", 4, "unilib:liquid_lava_ordinary_source", nil, nil, nil, nil, 140, 140, TEMP_WARM, HUMIDITY_HUMID)
        -- N.B. In original code, warm_semihumid_sky
        add_biome("glemr6_warm_humid_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_WARM, HUMIDITY_HUMID)

    end

end

local function add_biomes_warm_semihumid()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_warm_semihumid", nil, "unilib:dirt_dark_with_litter_coniferous", 1, "unilib:dirt_dark", 2, nil, nil, nil, nil, nil, 0, 100, TEMP_WARM, HUMIDITY_SEMIHUMID)
        add_biome("glemr6_warm_semihumid_generic", nil, "unilib:dirt_dark_with_litter_coniferous", 1, "unilib:dirt_dark", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_WARM, HUMIDITY_SEMIHUMID)
        add_biome("glemr6_warm_semihumid_underground", nil, nil, nil, nil, nil, "unilib:stone_brownstone_dark", nil, nil, nil, nil, -10000, -192, TEMP_WARM, HUMIDITY_SEMIHUMID)

    end

    add_biome("glemr6_warm_semihumid_ocean", nil, "unilib:dirt_silt_coarse", 2, "unilib:sand_ordinary", 4, "unilib:stone_brownstone_dark", nil, nil, nil, nil, -192, -4, TEMP_WARM, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_warm_semihumid_beach", nil, "unilib:sand_silica", 1, "unilib:sand_silica", 4, "unilib:stone_brownstone_dark", nil, nil, nil, nil, -4, 4, TEMP_WARM, HUMIDITY_SEMIHUMID)

    add_biome("glemr6_warm_semihumid_coastal", nil, "unilib:dirt_ordinary_with_turf_warm_semihumid_coastal", 1, "unilib:dirt_silt_fine", 6, "unilib:stone_brownstone_dark", nil, nil, nil, nil, -HEIGHT_BEACH_MAX, HEIGHT_COASTAL, TEMP_WARM, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_warm_semihumid_lowland", nil, "unilib:dirt_ordinary_with_turf_warm_semihumid_lowland", 1, "unilib:dirt_ordinary", 5, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_WARM, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_warm_semihumid_shelf", nil, "unilib:dirt_ordinary_with_turf_warm_semihumid_shelf", 1, "unilib:dirt_coarse", 4, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_WARM, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_warm_semihumid_highland", nil, "unilib:dirt_ordinary_with_turf_warm_semihumid_highland", 1, "unilib:dirt_parched", 3, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_WARM, HUMIDITY_SEMIHUMID)

    add_biome("glemr6_warm_semihumid_mountain", nil, "unilib:stone_granite_pink", 10, "unilib:stone_andesite_grey", 20, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_WARM, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_warm_semihumid_strato", nil, "unilib:stone_sandstone_desert", 15, "unilib:stone_granite_pink", 25, "unilib:stone_andesite_grey", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_WARM, HUMIDITY_SEMIHUMID)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_warm_semihumid_volcanic", nil, "unilib:stone_basalt_dark_rubble", 1, "unilib:stone_basalt_dark", 4, "unilib:liquid_lava_ordinary_source", nil, nil, nil, nil, 140, 140, TEMP_WARM, HUMIDITY_SEMIHUMID)
        add_biome("glemr6_warm_semihumid_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_WARM, HUMIDITY_SEMIHUMID)

    end

end

local function add_biomes_warm_temperate()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_warm_temperate", nil, "unilib:dirt_dark_with_turf", 1, "unilib:dirt_dark", 2, nil, nil, nil, nil, nil, 0, 100, TEMP_WARM, HUMIDITY_TEMPERATE)
        add_biome("glemr6_warm_temperate_generic", nil, "unilib:dirt_dark_with_turf", 1, "unilib:dirt_dark", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_WARM, HUMIDITY_TEMPERATE)
        add_biome("glemr6_warm_temperate_underground", nil, nil, nil, nil, nil, "unilib:stone_sandstone_brown", nil, nil, nil, nil, -6000, -192, TEMP_WARM, HUMIDITY_SEMIHUMID)

    end

    add_biome("glemr6_warm_temperate_ocean", nil, "unilib:dirt_silt_coarse", 2, "unilib:sand_ordinary", 4, "unilib:stone_sandstone_ordinary", nil, nil, nil, nil, -192, -4, TEMP_WARM, HUMIDITY_TEMPERATE)
    add_biome("glemr6_warm_temperate_beach", nil, "unilib:sand_ordinary", 1, "unilib:sand_ordinary", 4, nil, nil, nil, nil, nil, -4, 4, TEMP_WARM, HUMIDITY_TEMPERATE)

    add_biome("glemr6_warm_temperate_coastal", nil, "unilib:dirt_ordinary_with_turf_warm_temperate_coastal", 1, "unilib:dirt_dark", 6, "unilib:stone_limestone_white", nil, nil, nil, nil, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, TEMP_WARM, HUMIDITY_TEMPERATE)
    add_biome("glemr6_warm_temperate_lowland", nil, "unilib:dirt_ordinary_with_turf_warm_temperate_lowland", 1, "unilib:dirt_ordinary", 5, "unilib:stone_limestone_white", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_WARM, HUMIDITY_TEMPERATE)
    add_biome("glemr6_warm_temperate_shelf", nil, "unilib:dirt_ordinary_with_turf_warm_temperate_shelf", 1, "unilib:dirt_coarse", 4, "unilib:stone_limestone_white", nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_WARM, HUMIDITY_TEMPERATE)
    add_biome("glemr6_warm_temperate_highland", nil, "unilib:dirt_ordinary_with_turf_warm_temperate_highland", 1, "unilib:clay_red", 3, "unilib:stone_limestone_white", nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_WARM, HUMIDITY_TEMPERATE)

    add_biome("glemr6_warm_temperate_mountain", nil, "unilib:stone_sandstone_desert", 10, "unilib:stone_sandstone_brown", 20, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_WARM, HUMIDITY_TEMPERATE)
    add_biome("glemr6_warm_temperate_strato", nil, "unilib:stone_sandstone_ordinary", 15, "unilib:stone_sandstone_desert", 25, "unilib:stone_sandstone_brown", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_WARM, HUMIDITY_TEMPERATE)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_warm_temperate_volcanic", nil, "air", 2, "air", 4, "unilib:liquid_lava_ordinary_source", nil, nil, nil, nil, 140, 140, 15, 15)
        add_biome("glemr6_warm_temperate_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_WARM, HUMIDITY_TEMPERATE)

    end

end

local function add_biomes_warm_semiarid()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_warm_semiarid", nil, "unilib:dirt_dark_with_turf_dry", 1, "unilib:dirt_dark", 2, nil, nil, nil, nil, nil, 0, 100, TEMP_WARM, HUMIDITY_SEMIARID)
        add_biome("glemr6_warm_semiarid_generic", nil, "unilib:dirt_dark_with_turf_dry", 1, "unilib:dirt_dark", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_WARM, HUMIDITY_SEMIARID)
        add_biome("glemr6_warm_semiarid_underground", nil, nil, nil, nil, nil, "unilib:stone_desert", nil, nil, nil, nil, -100 -192, TEMP_WARM, HUMIDITY_SEMIARID)

    end

    add_biome("glemr6_warm_semiarid_ocean", nil, "unilib:sand_ordinary", 2, "unilib:sand_ordinary", 4, "unilib:stone_sandstone_ordinary", nil, nil, nil, nil, -192, -4, TEMP_WARM, HUMIDITY_SEMIARID)
    add_biome("glemr6_warm_semiarid_beach", nil, "unilib:sand_ordinary", 1, "unilib:sand_ordinary", 4, nil, nil, nil, nil, nil, -4, 4, TEMP_WARM, HUMIDITY_SEMIARID)

    add_biome("glemr6_warm_semiarid_coastal", nil, "unilib:dirt_ordinary_with_turf_warm_semiarid_coastal", 1, "unilib:dirt_ordinary", 4, "unilib:stone_desert", nil, nil, nil, nil, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, TEMP_WARM, HUMIDITY_SEMIARID)
    add_biome("glemr6_warm_semiarid_lowland", nil, "unilib:dirt_ordinary_with_turf_warm_semiarid_lowland", 1, "unilib:dirt_coarse", 4, "unilib:stone_desert", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_WARM, HUMIDITY_SEMIARID)
    add_biome("glemr6_warm_semiarid_shelf", nil, "unilib:dirt_ordinary_with_turf_warm_semiarid_shelf", 1, "unilib:clay_red", 4, "unilib:stone_desert", nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_WARM, HUMIDITY_SEMIARID)
    add_biome("glemr6_warm_semiarid_highland", nil, "unilib:dirt_ordinary_with_turf_warm_semiarid_highland", 1, "unilib:dirt_clayey", 4, "unilib:stone_desert", nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_WARM, HUMIDITY_SEMIARID)

    add_biome("glemr6_warm_semiarid_mountain", nil, "unilib:stone_sandstone_desert", 10, "unilib:stone_sandstone_brown", 20, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_WARM, HUMIDITY_SEMIARID)
    add_biome("glemr6_warm_semiarid_strato", nil, "unilib:stone_sandstone_ordinary", 15, "unilib:stone_sandstone_desert", 25, "unilib:stone_sandstone_brown", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_WARM, HUMIDITY_SEMIARID)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_warm_semiarid_volcanic", nil, "unilib:dirt_dark_with_turf", 1, "unilib:dirt_dark", 4, "unilib:stone_limestone_white", nil, nil, nil, nil, 140, 140, TEMP_WARM, HUMIDITY_SEMIARID)
        add_biome("glemr6_warm_semiarid_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_WARM, HUMIDITY_SEMIARID)

    end

end

local function add_biomes_warm_arid()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_warm_arid", nil, "unilib:sand_desert", 1, "unilib:stone_sandstone_brown", 2, nil, nil, nil, nil, nil, 0, 100, TEMP_WARM, HUMIDITY_ARID)
        add_biome("glemr6_warm_arid_generic", nil, "unilib:sand_desert", 1, "unilib:stone_sandstone_brown", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_WARM, HUMIDITY_ARID)
        add_biome("glemr6_warm_arid_underground", nil, nil, nil, nil, nil, "unilib:stone_basalt_dark", nil, nil, nil, nil, -100, -192, TEMP_WARM, HUMIDITY_ARID)

    end

    add_biome("glemr6_warm_arid_ocean", nil, "unilib:sand_ordinary", 2, "unilib:sand_ordinary", 4, "unilib:stone_sandstone_ordinary", nil, nil, nil, nil, -192, -4, TEMP_WARM, HUMIDITY_ARID)
    add_biome("glemr6_warm_arid_beach", nil, "unilib:gravel_sandstone_desert", 1, "unilib:sand_ordinary", 4, nil, nil, nil, nil, nil, -4, 4, TEMP_WARM, HUMIDITY_ARID)

    add_biome("glemr6_warm_arid_coastal", nil, "unilib:sand_desert", 10, "unilib:stone_sandstone_brown", TEMP_COLD, "unilib:stone_basalt_dark", nil, nil, nil, "unilib:stone_sandstone_white", HEIGHT_BEACH_MAX, HEIGHT_COASTAL, TEMP_WARM, HUMIDITY_ARID)
    add_biome("glemr6_warm_arid_lowland", nil, "unilib:gravel_sandstone_desert", 10, "unilib:stone_sandstone_brown", TEMP_COLD, "unilib:stone_basalt_dark", nil, nil, nil, "unilib:stone_sandstone_white", HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_WARM, HUMIDITY_ARID)
    add_biome("glemr6_warm_arid_shelf", nil, "unilib:sand_desert", 10, "unilib:stone_sandstone_brown", TEMP_COLD, "unilib:stone_basalt_dark", nil, nil, nil, "unilib:stone_sandstone_white", HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_WARM, HUMIDITY_ARID)
    add_biome("glemr6_warm_arid_highland", nil, "unilib:gravel_sandstone_desert", 10, "unilib:stone_sandstone_brown", TEMP_COLD, "unilib:stone_sandstone_desert", nil, nil, nil, "unilib:stone_sandstone_white", HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_WARM, HUMIDITY_ARID)

    add_biome("glemr6_warm_arid_mountain", nil, "unilib:stone_sandstone_desert", 10, "unilib:stone_sandstone_brown", 20, "unilib:stone_brownstone_dark", nil, nil, nil, "unilib:stone_sandstone_white", HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_WARM, HUMIDITY_ARID)
    add_biome("glemr6_warm_arid_strato", nil, "unilib:stone_sandstone_ordinary", 15, "unilib:stone_sandstone_desert", 25, "unilib:stone_sandstone_brown", nil, nil, nil, "unilib:stone_sandstone_white", HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_WARM, HUMIDITY_ARID)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_warm_arid_volcanic", nil, "unilib:stone_sandstone_desert", 10, "unilib:stone_sandstone_brown", 40, "unilib:stone_basalt_dark", nil, nil, nil, nil, 140, 140, TEMP_WARM, HUMIDITY_ARID)
        add_biome("glemr6_warm_arid_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_WARM, HUMIDITY_ARID)

    end

end

---------------------------------------------------------------------------------------------------
-- Temperate biomes
---------------------------------------------------------------------------------------------------

local function add_biomes_temperate_humid()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_temperate_humid", nil, "unilib:dirt_ordinary_with_litter_rainforest", 1, "unilib:dirt_ordinary", 2, nil, nil, nil, nil, nil, 0, 100, TEMP_TEMPERATE, HUMIDITY_HUMID)
        add_biome("glemr6_temperate_humid_generic", nil, "unilib:dirt_ordinary_with_litter_rainforest", 1, "unilib:dirt_ordinary", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_TEMPERATE, HUMIDITY_HUMID)
        add_biome("glemr6_temperate_humid_underground", nil, nil, nil, nil, nil, "unilib:stone_brownstone_dark", nil, nil, nil, nil, -10000, -192, TEMP_TEMPERATE, HUMIDITY_HUMID)

    end

    add_biome("glemr6_temperate_humid_ocean", nil, "unilib:dirt_silt_coarse", 4, "unilib:sand_ordinary", 6, "unilib:stone_sandstone_ordinary", nil, nil, nil, nil, -192, -4, TEMP_TEMPERATE, HUMIDITY_HUMID)
    add_biome("glemr6_temperate_humid_beach", nil, "unilib:sand_ordinary", 2, "unilib:sand_ordinary", 4, "unilib:stone_sandstone_ordinary", nil, nil, nil, nil, -4, 4, TEMP_TEMPERATE, HUMIDITY_HUMID)

    add_biome("glemr6_temperate_humid_coastal", nil, "unilib:dirt_ordinary_with_turf_temperate_humid_coastal", 1, "unilib:dirt_silt_coarse", 6, "unilib:stone_brownstone_dark", nil, nil, nil, nil, -HEIGHT_BEACH_MAX, HEIGHT_COASTAL, TEMP_TEMPERATE, HUMIDITY_HUMID)
    add_biome("glemr6_temperate_humid_lowland", nil, "unilib:dirt_ordinary_with_turf_temperate_humid_lowland", 1, "unilib:dirt_silt_fine", 5, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_TEMPERATE, HUMIDITY_HUMID)
    add_biome("glemr6_temperate_humid_shelf", nil, "unilib:dirt_ordinary_with_turf_temperate_humid_shelf", 1, "unilib:dirt_dark", 4, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_TEMPERATE, HUMIDITY_HUMID)
    add_biome("glemr6_temperate_humid_highland", nil, "unilib:dirt_ordinary_with_turf_temperate_humid_highland", 1, "unilib:dirt_ordinary", 3, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_TEMPERATE, HUMIDITY_HUMID)

    add_biome("glemr6_temperate_humid_mountain", nil, "unilib:stone_gabbro_red", 10, "unilib:stone_bluestone", 20, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_TEMPERATE, HUMIDITY_HUMID)
    add_biome("glemr6_temperate_humid_strato", nil, "unilib:stone_diorite_dark", 15, "unilib:stone_bluestone", 25, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_TEMPERATE, HUMIDITY_HUMID)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_temperate_humid_volcanic", nil, "unilib:stone_basalt_dark_rubble", TEMP_COLD, "unilib:stone_basalt_dark", 20, "unilib:liquid_lava_ordinary_source", nil, nil, nil, nil, 140, 140, TEMP_TEMPERATE, HUMIDITY_HUMID)
        add_biome("glemr6_temperate_humid_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_TEMPERATE, HUMIDITY_HUMID)

    end

end

local function add_biomes_temperate_semihumid()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_temperate_semihumid", nil, "unilib:dirt_ordinary_with_litter_coniferous", 1, "unilib:dirt_ordinary", 2, nil, nil, nil, nil, nil, 0, 100, TEMP_TEMPERATE, HUMIDITY_SEMIHUMID)
        add_biome("glemr6_temperate_semihumid_generic", nil, "unilib:dirt_ordinary_with_litter_coniferous", 1, "unilib:dirt_ordinary", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_TEMPERATE, HUMIDITY_SEMIHUMID)
        add_biome("glemr6_temperate_semihumid_underground", nil, nil, nil, nil, nil, "unilib:stone_basalt_dark", nil, nil, nil, nil, unilib.constant.y_min, -TEMP_HOT, TEMP_TEMPERATE, HUMIDITY_SEMIHUMID)

    end

    add_biome("glemr6_temperate_semihumid_ocean", nil, "unilib:dirt_silt_coarse", 2, "unilib:sand_ordinary", 4, "unilib:stone_sandstone_ordinary", nil, nil, nil, nil, -192, -4, TEMP_TEMPERATE, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_temperate_semihumid_beach", nil, "unilib:sand_ordinary", 1, "unilib:sand_ordinary", 4, nil, nil, nil, nil, nil, -4, 4, TEMP_TEMPERATE, HUMIDITY_SEMIHUMID)

    add_biome("glemr6_temperate_semihumid_coastal", nil, "unilib:dirt_ordinary_with_turf_temperate_semihumid_coastal", 1, "unilib:dirt_silt_fine", 4, "unilib:stone_bluestone", nil, nil, nil, nil, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, TEMP_TEMPERATE, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_temperate_semihumid_lowland", nil, "unilib:dirt_ordinary_with_turf_temperate_semihumid_lowland", 1, "unilib:dirt_dark", 4, "unilib:stone_bluestone", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_TEMPERATE, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_temperate_semihumid_shelf", nil, "unilib:dirt_ordinary_with_turf_temperate_semihumid_shelf", 1, "unilib:dirt_ordinary", 4, "unilib:stone_bluestone", nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_TEMPERATE, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_temperate_semihumid_highland", nil, "unilib:dirt_ordinary_with_turf_temperate_semihumid_highland", 1, "unilib:clay_red", 4, "unilib:stone_bluestone", nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_TEMPERATE, HUMIDITY_SEMIHUMID)

    add_biome("glemr6_temperate_semihumid_mountain", nil, "unilib:stone_bluestone", 10, "unilib:stone_brownstone_dark", 20, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_TEMPERATE, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_temperate_semihumid_strato", nil, "unilib:stone_bluestone", 15, "unilib:stone_gabbro_red", 25, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_TEMPERATE, HUMIDITY_SEMIHUMID)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_temperate_semihumid_volcanic", nil, "unilib:stone_basalt_dark_rubble", TEMP_COLD, "unilib:stone_basalt_dark", 20, "unilib:liquid_lava_ordinary_source", nil, nil, nil, nil, 140, 140, TEMP_TEMPERATE, HUMIDITY_SEMIHUMID)
        add_biome("glemr6_temperate_semihumid_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_TEMPERATE, HUMIDITY_SEMIHUMID)

    end

end

local function add_biomes_temperate_temperate()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_temperate_temperate", nil, "unilib:dirt_ordinary_with_turf", 1, "unilib:dirt_ordinary", 2, nil, nil, nil, nil, nil, 0, 100, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)
        add_biome("glemr6_temperate_temperate_generic", nil, "unilib:dirt_ordinary_with_turf", 1, "unilib:dirt_ordinary", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)
        add_biome("glemr6_temperate_temperate_underground", nil, nil, nil, nil, nil, "unilib:stone_basalt_dark", nil, nil, nil, nil, unilib.constant.y_min, -TEMP_HOT, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)

    end

    add_biome("glemr6_temperate_temperate_ocean", nil, "unilib:dirt_silt_coarse", 2, "unilib:sand_ordinary", 4, "unilib:stone_sandstone_ordinary", nil, nil, nil, nil, -192, -4, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)
    add_biome("glemr6_temperate_temperate_beach", nil, "unilib:sand_ordinary", 1, "unilib:sand_ordinary", 4, nil, nil, nil, nil, nil, -4, 4, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)

    add_biome("glemr6_temperate_temperate_coastal", nil, "unilib:dirt_ordinary_with_turf_temperate_temperate_coastal", 1, "unilib:dirt_dark", 4, "unilib:stone_limestone_white", nil, nil, nil, nil, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)
    add_biome("glemr6_temperate_temperate_lowland", nil, "unilib:dirt_ordinary_with_turf_temperate_temperate_lowland", 1, "unilib:dirt_ordinary", 4, "unilib:stone_limestone_white", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)
    add_biome("glemr6_temperate_temperate_shelf", nil, "unilib:dirt_ordinary_with_turf_temperate_temperate_shelf", 1, "unilib:dirt_coarse", 4, "unilib:stone_limestone_white", nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)
    add_biome("glemr6_temperate_temperate_highland", nil, "unilib:dirt_ordinary_with_turf_temperate_temperate_highland", 1, "unilib:clay_red", 4, "unilib:stone_limestone_white", nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)

    add_biome("glemr6_temperate_temperate_mountain", nil, "unilib:stone_greenstone", 10, "unilib:stone_schist_grey", 20, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)
    add_biome("glemr6_temperate_temperate_strato", "unilib:snow_ordinary_block", "unilib:stone_basalt_brown", 15, "unilib:stone_greenstone", 25, "unilib:stone_schist_grey", nil, nil, nil, nil, HEIGHT_SNOW_MIN, HEIGHT_SNOW_MAX, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)
    -- N.B. Commented out as it's a duplicate biome name
--  add_biome("glemr6_temperate_temperate_strato", nil, "unilib:stone_basalt_brown", 15, "unilib:stone_greenstone", 25, "unilib:stone_schist_grey", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_temperate_temperate_volcanic", nil, "air", 2, "air", 4, "unilib:liquid_lava_ordinary_source", nil, nil, nil, nil, 140, 140, 15, 15)
        add_biome("glemr6_temperate_temperate_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)

    end

end

local function add_biomes_temperate_semiarid()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_temperate_semiarid", nil, "unilib:dirt_ordinary_with_turf_dry", 1, "unilib:dirt_ordinary", 2, nil, nil, nil, nil, nil, 0, 100, TEMP_TEMPERATE, HUMIDITY_SEMIARID)
        add_biome("glemr6_temperate_semiarid_generic", nil, "unilib:dirt_ordinary_with_turf_dry", 1, "unilib:dirt_ordinary", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_TEMPERATE, HUMIDITY_SEMIARID)
        add_biome("glemr6_temperate_semiarid_underground", nil, nil, nil, nil, nil, "unilib:stone_basalt_dark", nil, nil, nil, nil, unilib.constant.y_min, -TEMP_HOT, TEMP_TEMPERATE, HUMIDITY_SEMIARID)

    end

    add_biome("glemr6_temperate_semiarid_ocean", nil, "unilib:sand_ordinary", 2, "unilib:sand_ordinary", 4, "unilib:stone_sandstone_ordinary", nil, nil, nil, nil, -192, -4, TEMP_TEMPERATE, HUMIDITY_SEMIARID)
    add_biome("glemr6_temperate_semiarid_beach", nil, "unilib:sand_ordinary", 1, "unilib:sand_ordinary", 4, nil, nil, nil, nil, nil, -4, 4, TEMP_TEMPERATE, HUMIDITY_SEMIARID)

    add_biome("glemr6_temperate_semiarid_coastal", nil, "unilib:dirt_ordinary_with_turf_temperate_semiarid_coastal", 1, "unilib:dirt_ordinary", 4, nil, nil, nil, nil, nil, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, TEMP_TEMPERATE, HUMIDITY_SEMIARID)
    add_biome("glemr6_temperate_semiarid_lowland", nil, "unilib:dirt_ordinary_with_turf_temperate_semiarid_lowland", 1, "unilib:dirt_coarse", 4, nil, nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_TEMPERATE, HUMIDITY_SEMIARID)
    add_biome("glemr6_temperate_semiarid_shelf", nil, "unilib:dirt_ordinary_with_turf_temperate_semiarid_shelf", 1, "unilib:clay_red", 4, nil, nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_TEMPERATE, HUMIDITY_SEMIARID)
    add_biome("glemr6_temperate_semiarid_highland", nil, "unilib:dirt_ordinary_with_turf_temperate_semiarid_highland", 1, "unilib:dirt_clayey", 4, nil, nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_TEMPERATE, HUMIDITY_SEMIARID)

    add_biome("glemr6_temperate_semiarid_mountain", nil, "unilib:stone_sandstone_brown", 10, "unilib:stone_brownstone_dark", 20, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_TEMPERATE, HUMIDITY_SEMIARID)
    add_biome("glemr6_temperate_semiarid_strato", nil, "unilib:stone_desert", 15, "unilib:stone_sandstone_brown", 25, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_TEMPERATE, HUMIDITY_SEMIARID)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_temperate_semiarid_volcanic", nil, "air", 2, "air", 4, "unilib:liquid_lava_ordinary_source", nil, nil, nil, nil, 140, 140, TEMP_TEMPERATE, HUMIDITY_SEMIARID)
        add_biome("glemr6_temperate_semiarid_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_TEMPERATE, HUMIDITY_SEMIARID)

    end

end

local function add_biomes_temperate_arid()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_temperate_arid", nil, "unilib:sand_desert", 1, "unilib:stone_sandstone_desert", 2, nil, nil, nil, nil, nil, 0, 100, TEMP_TEMPERATE, HUMIDITY_ARID)
        add_biome("glemr6_temperate_arid_generic", nil, "unilib:sand_desert", 1, "unilib:stone_sandstone_desert", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_TEMPERATE, HUMIDITY_ARID)
        add_biome("glemr6_temperate_arid_underground", nil, nil, nil, nil, nil, "unilib:stone_basalt_dark", nil, nil, nil, nil, unilib.constant.y_min, -192, TEMP_TEMPERATE, HUMIDITY_ARID)

    end

    add_biome("glemr6_temperate_arid_ocean", nil, "unilib:sand_ordinary", 2, "unilib:sand_ordinary", 4, "unilib:stone_sandstone_ordinary", nil, nil, nil, nil, -192, -4, TEMP_TEMPERATE, HUMIDITY_ARID)
    add_biome("glemr6_temperate_arid_beach", nil, "unilib:sand_ordinary", 1, "unilib:sand_ordinary", 4, nil, nil, nil, nil, nil, -4, 4, TEMP_TEMPERATE, HUMIDITY_ARID)

    add_biome("glemr6_temperate_arid_coastal", nil, "unilib:dirt_coarse", 5, "unilib:stone_brownstone_dark", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, TEMP_TEMPERATE, HUMIDITY_ARID)
    add_biome("glemr6_temperate_arid_lowland", nil, "unilib:dirt_parched", 4, "unilib:stone_sandstone_brown", 6, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_TEMPERATE, HUMIDITY_ARID)
    add_biome("glemr6_temperate_arid_shelf", nil, "unilib:dirt_clayey", 3, "unilib:stone_desert", 8, "unilib:stone_sandstone_brown", nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_TEMPERATE, HUMIDITY_ARID)
    add_biome("glemr6_temperate_arid_highland", nil, "unilib:dirt_sandy", 2, "unilib:stone_sandstone_desert", 10, "unilib:stone_desert", nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_TEMPERATE, HUMIDITY_ARID)

    add_biome("glemr6_temperate_arid_mountain", nil, "unilib:stone_desert", 15, "unilib:stone_brownstone_dark", 25, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_TEMPERATE, HUMIDITY_ARID)
    add_biome("glemr6_temperate_arid_strato", nil, "unilib:stone_desert", 15, "unilib:stone_sandstone_brown", 25, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_TEMPERATE, HUMIDITY_ARID)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_temperate_arid_volcanic", nil, "unilib:stone_basalt_dark_rubble", TEMP_COLD, "unilib:stone_basalt_dark", 20, "unilib:liquid_lava_ordinary_source", nil, nil, nil, nil, 140, 140, TEMP_TEMPERATE, HUMIDITY_ARID)
        add_biome("glemr6_temperate_arid_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_TEMPERATE, HUMIDITY_ARID)

    end

end

---------------------------------------------------------------------------------------------------
-- Cool biomes
---------------------------------------------------------------------------------------------------

local function add_biomes_cool_humid()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_cool_humid", nil, "unilib:dirt_sandy_with_litter_coniferous", 1, "unilib:dirt_sandy", 2, nil, nil, nil, nil, nil, 0, 100, TEMP_COOL, HUMIDITY_HUMID)
        add_biome("glemr6_cool_humid_generic", nil, "unilib:dirt_sandy_with_litter_coniferous", 1, "unilib:dirt_sandy", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_COOL, HUMIDITY_HUMID)
        add_biome("glemr6_cool_humid_underground", nil, nil, nil, nil, nil, "unilib:stone_basalt_dark", nil, nil, nil, nil, unilib.constant.y_min, -TEMP_HOT, TEMP_COOL, HUMIDITY_HUMID)

    end

    add_biome("glemr6_cool_humid_ocean", nil, "unilib:sand_ordinary", 2, "unilib:sand_ordinary", 4, "unilib:stone_sandstone_ordinary", nil, nil, nil, nil, -192, -4, TEMP_COOL, HUMIDITY_HUMID)
    add_biome("glemr6_cool_humid_beach", nil, "unilib:sand_ordinary", 1, "unilib:sand_ordinary", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, -4, 4, TEMP_COOL, HUMIDITY_HUMID)

    add_biome("glemr6_cool_humid_coastal", nil, "unilib:dirt_ordinary_with_turf_cool_humid_coastal", 1, "unilib:dirt_silt_coarse", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, TEMP_COOL, HUMIDITY_HUMID)
    add_biome("glemr6_cool_humid_lowland", nil, "unilib:dirt_ordinary_with_turf_cool_humid_lowland", 1, "unilib:dirt_silt_fine", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_COOL, HUMIDITY_HUMID)
    add_biome("glemr6_cool_humid_shelf", nil, "unilib:dirt_ordinary_with_turf_cool_humid_shelf", 1, "unilib:dirt_dark", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_COOL, HUMIDITY_HUMID)
    add_biome("glemr6_cool_humid_highland", nil, "unilib:dirt_ordinary_with_turf_cool_humid_highland", 1, "unilib:dirt_ordinary", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_COOL, HUMIDITY_HUMID)

    add_biome("glemr6_cool_humid_mountain", nil, "unilib:stone_sandstone_brown", 10, "unilib:stone_brownstone_dark", 20, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_COOL, HUMIDITY_HUMID)
    add_biome("glemr6_cool_humid_strato", nil, "unilib:stone_granite_white", 15, "unilib:stone_sandstone_brown", 25, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_COOL, HUMIDITY_HUMID)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_cool_humid_volcanic", nil, nil, nil, nil, nil, nil, "unilib:ice_ordinary", nil, nil, nil, 140, 140, TEMP_COOL, HUMIDITY_HUMID)
        add_biome("glemr6_cool_humid_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_COOL, HUMIDITY_HUMID)

    end

end

local function add_biomes_cool_semihumid()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_cool_semihumid", nil, "unilib:dirt_sandy_with_litter_coniferous", 1, "unilib:dirt_sandy", 2, nil, nil, nil, nil, nil, 0, 100, TEMP_COOL, HUMIDITY_SEMIHUMID)
        add_biome("glemr6_cool_semihumid_generic", nil, "unilib:dirt_sandy_with_litter_coniferous", 1, "unilib:dirt_sandy", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_COOL, HUMIDITY_SEMIHUMID)
        add_biome("glemr6_cool_semihumid_underground", nil, nil, nil, nil, nil, "unilib:stone_basalt_dark", nil, nil, nil, nil, unilib.constant.y_min, -TEMP_HOT, TEMP_COOL, HUMIDITY_SEMIHUMID)

    end

    add_biome("glemr6_cool_semihumid_ocean", nil, "unilib:sand_ordinary", 2, "unilib:sand_ordinary", 4, "unilib:stone_sandstone_ordinary", nil, nil, nil, nil, -192, -4, TEMP_COOL, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_cool_semihumid_beach", nil, "unilib:sand_ordinary", 1, "unilib:sand_ordinary", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, -4, 4, TEMP_COOL, HUMIDITY_SEMIHUMID)

    add_biome("glemr6_cool_semihumid_coastal", nil, "unilib:dirt_ordinary_with_turf_cool_semihumid_coastal", 1, "unilib:dirt_silt_fine", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, TEMP_COOL, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_cool_semihumid_lowland", nil, "unilib:dirt_ordinary_with_turf_cool_semihumid_lowland", 1, "unilib:dirt_dark", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_COOL, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_cool_semihumid_shelf", nil, "unilib:dirt_ordinary_with_turf_cool_semihumid_shelf", 1, "unilib:dirt_ordinary", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_COOL, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_cool_semihumid_highland", nil, "unilib:dirt_ordinary_with_turf_cool_semihumid_highland", 1, "unilib:clay_red", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_COOL, HUMIDITY_SEMIHUMID)

    add_biome("glemr6_cool_semihumid_mountain", nil, "unilib:stone_sandstone_brown", 10, "unilib:stone_brownstone_dark", 20, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_COOL, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_cool_semihumid_strato", nil, "unilib:stone_gneiss_brown", 15, "unilib:stone_granite_white", 25, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_COOL, HUMIDITY_SEMIHUMID)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_cool_semihumid_volcanic", nil, nil, nil, nil, nil, "unilib:ice_ordinary", nil, nil, nil, nil, 140, 140, TEMP_COOL, HUMIDITY_SEMIHUMID)
        add_biome("glemr6_cool_semihumid_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_COOL, HUMIDITY_SEMIHUMID)

    end

end

local function add_biomes_cool_temperate()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_cool_temperate", nil, "unilib:dirt_sandy_with_turf", 1, "unilib:dirt_sandy", 2, nil, nil, nil, nil, nil, 0, 100, TEMP_COOL, HUMIDITY_TEMPERATE)
        add_biome("glemr6_cool_temperate_generic", nil, "unilib:dirt_sandy_with_turf", 1, "unilib:dirt_sandy", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_COOL, HUMIDITY_TEMPERATE)
        add_biome("glemr6_cool_temperate_underground", nil, nil, nil, nil, nil, "unilib:stone_basalt_dark", nil, nil, nil, nil, unilib.constant.y_min, -TEMP_HOT, TEMP_COOL, HUMIDITY_TEMPERATE)

    end

    add_biome("glemr6_cool_temperate_ocean", nil, "unilib:sand_ordinary", 2, "unilib:sand_ordinary", 4, "unilib:stone_sandstone_ordinary", nil, nil, nil, nil, -192, -4, TEMP_COOL, HUMIDITY_TEMPERATE)
    add_biome("glemr6_cool_temperate_beach", nil, "unilib:sand_ordinary", 1, "unilib:sand_ordinary", 4, nil, nil, nil, nil, nil, -4, 4, TEMP_COOL, HUMIDITY_TEMPERATE)

    add_biome("glemr6_cool_temperate_coastal", nil, "unilib:dirt_ordinary_with_turf_cool_temperate_coastal", 1, "unilib:dirt_dark", 4, "unilib:stone_limestone_white", nil, nil, nil, nil, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, TEMP_COOL, HUMIDITY_TEMPERATE)
    add_biome("glemr6_cool_temperate_lowland", nil, "unilib:dirt_ordinary_with_turf_cool_temperate_lowland", 1, "unilib:dirt_ordinary", 4, "unilib:stone_limestone_white", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_COOL, HUMIDITY_TEMPERATE)
    add_biome("glemr6_cool_temperate_shelf", nil, "unilib:dirt_ordinary_with_turf_cool_temperate_shelf", 1, "unilib:dirt_coarse", 4, "unilib:stone_limestone_white", nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_COOL, HUMIDITY_TEMPERATE)
    add_biome("glemr6_cool_temperate_highland", nil, "unilib:dirt_ordinary_with_turf_cool_temperate_highland", 1, "unilib:clay_red", 4, "unilib:stone_limestone_white", nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_COOL, HUMIDITY_TEMPERATE)

    add_biome("glemr6_cool_temperate_mountain", nil, "unilib:stone_sandstone_brown", 10, "unilib:stone_brownstone_dark", 20, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_COOL, HUMIDITY_TEMPERATE)
    add_biome("glemr6_cool_temperate_strato", nil, "unilib:stone_gneiss_brown", 15, "unilib:stone_granite_white", 25, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_COOL, HUMIDITY_TEMPERATE)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_cool_temperate_volcanic", nil, nil, nil, nil, nil, "unilib:ice_ordinary", nil, nil, nil, nil, 140, 140, TEMP_COOL, HUMIDITY_TEMPERATE)
        add_biome("glemr6_cool_temperate_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_COOL, HUMIDITY_TEMPERATE)

    end

end

local function add_biomes_cool_semiarid()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_cool_semiarid", nil, "unilib:dirt_sandy_with_turf_dry", 1, "unilib:dirt_sandy", 2, nil, nil, nil, nil, nil, 0, 100, TEMP_COOL, HUMIDITY_SEMIARID)
        add_biome("glemr6_cool_semiarid_generic", nil, "unilib:dirt_sandy_with_turf_dry", 1, "unilib:dirt_sandy", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_COOL, HUMIDITY_SEMIARID)
        add_biome("glemr6_cool_semiarid_underground", nil, nil, nil, nil, nil, "unilib:stone_basalt_dark", nil, nil, nil, nil, unilib.constant.y_min, -TEMP_HOT, TEMP_COOL, HUMIDITY_SEMIARID)

    end

    add_biome("glemr6_cool_semiarid_ocean", nil, "unilib:sand_ordinary", 2, "unilib:sand_ordinary", 4, "unilib:stone_sandstone_ordinary", nil, nil, nil, nil, -192, -4, TEMP_COOL, HUMIDITY_SEMIARID)
    add_biome("glemr6_cool_semiarid_beach", nil, "unilib:sand_ordinary", 1, "unilib:sand_ordinary", 4, nil, nil, nil, nil, nil, -4, 4, TEMP_COOL, HUMIDITY_SEMIARID)

    add_biome("glemr6_cool_semiarid_coastal", nil, "unilib:dirt_ordinary_with_turf_cool_semiarid_coastal", 1, "unilib:dirt_sandy", 4, nil, nil, nil, nil, nil, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, TEMP_COOL, HUMIDITY_SEMIARID)
    add_biome("glemr6_cool_semiarid_lowland", nil, "unilib:dirt_ordinary_with_turf_cool_semiarid_lowland", 1, "unilib:dirt_coarse", 4, nil, nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_COOL, HUMIDITY_SEMIARID)
    add_biome("glemr6_cool_semiarid_shelf", nil, "unilib:dirt_ordinary_with_turf_cool_semiarid_shelf", 1, "unilib:clay_red", 4, nil, nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_COOL, HUMIDITY_SEMIARID)
    add_biome("glemr6_cool_semiarid_highland", nil, "unilib:dirt_ordinary_with_turf_cool_semiarid_highland", 1, "unilib:dirt_clayey", 4, nil, nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_COOL, HUMIDITY_SEMIARID)

    add_biome("glemr6_cool_semiarid_mountain", nil, "unilib:stone_granite_dark", 10, "unilib:stone_brownstone_dark", 20, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_COOL, HUMIDITY_SEMIARID)
    add_biome("glemr6_cool_semiarid_strato", nil, "unilib:stone_gneiss_brown", 15, "unilib:stone_granite_white", 25, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_COOL, HUMIDITY_SEMIARID)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_cool_semiarid_volcanic", nil, "air", 1, "air", 1, "unilib:liquid_lava_ordinary_source", nil, nil, nil, nil, 140, 140, TEMP_COOL, HUMIDITY_SEMIARID)
        add_biome("glemr6_cool_semiarid_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_COOL, HUMIDITY_SEMIARID)

    end

end

local function add_biomes_cool_arid()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_cool_arid", nil, "unilib:dirt_sandy", 1, "unilib:stone_sandstone_brown", 2, nil, nil, nil, nil, nil, 0, 100, TEMP_COOL, HUMIDITY_ARID)
        add_biome("glemr6_cool_arid_generic", nil, "unilib:dirt_sandy", 1, "unilib:stone_sandstone_brown", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_COOL, HUMIDITY_ARID)
        add_biome("glemr6_cool_arid_underground", nil, nil, nil, nil, nil, "unilib:stone_basalt_dark", nil, nil, nil, nil, unilib.constant.y_min, -192, TEMP_COOL, HUMIDITY_ARID)

    end

    add_biome("glemr6_cool_arid_ocean", nil, "unilib:sand_ordinary", 2, "unilib:sand_ordinary", 4, "unilib:stone_sandstone_ordinary", nil, nil, nil, nil, -192, -4, TEMP_COOL, HUMIDITY_ARID)
    add_biome("glemr6_cool_arid_beach", nil, "unilib:sand_ordinary", 1, "unilib:sand_ordinary", 4, nil, nil, nil, nil, nil, -4, 4, TEMP_COOL, HUMIDITY_ARID)

    add_biome("glemr6_cool_arid_coastal", nil, "unilib:clay_red", 5, "unilib:stone_granite_dark", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, TEMP_COOL, HUMIDITY_ARID)
    add_biome("glemr6_cool_arid_lowland", nil, "unilib:dirt_clayey", 4, "unilib:stone_gabbro_red", 6, "unilib:stone_granite_dark", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_COOL, HUMIDITY_ARID)
    add_biome("glemr6_cool_arid_shelf", nil, "unilib:sand_desert", 3, "unilib:stone_granite_pink", 8, "unilib:stone_gabbro_red", nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_COOL, HUMIDITY_ARID)
    add_biome("glemr6_cool_arid_highland", nil, "unilib:gravel_sandstone_desert", 2, "unilib:stone_andesite_grey", 10, "unilib:stone_granite_pink", nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_COOL, HUMIDITY_ARID)

    add_biome("glemr6_cool_arid_mountain", nil, "unilib:stone_andesite_grey", 15, "unilib:stone_granite_pink", 25, "unilib:stone_gabbro_red", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_COOL, HUMIDITY_ARID)
    add_biome("glemr6_cool_arid_strato", nil, "unilib:stone_gneiss_brown", 15, "unilib:stone_granite_white", 25, "unilib:stone_andesite_grey", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_COOL, HUMIDITY_ARID)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_cool_arid_volcanic", nil, "air", 1, "air", 4, "unilib:liquid_lava_ordinary_source", nil, nil, nil, nil, 140, 140, TEMP_COOL, HUMIDITY_ARID)
        add_biome("glemr6_cool_arid_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_COOL, HUMIDITY_ARID)

    end

end

---------------------------------------------------------------------------------------------------
-- Cold biomes
---------------------------------------------------------------------------------------------------

local function add_biomes_cold_humid()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_cold_humid", nil, "unilib:dirt_coarse_with_litter_rainforest", 1, "unilib:dirt_coarse", 4, nil, nil, nil, nil, nil, 0, 100, TEMP_COLD, HUMIDITY_HUMID)
        add_biome("glemr6_cold_humid_generic", nil, "unilib:dirt_coarse_with_litter_rainforest", 1, "unilib:dirt_coarse", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_COLD, HUMIDITY_HUMID)
        add_biome("glemr6_cold_humid_underground", nil, nil, nil, nil, nil, "unilib:stone_basalt_dark", nil, nil, nil, nil, unilib.constant.y_min, -TEMP_HOT, TEMP_COLD, HUMIDITY_HUMID)

    end

    add_biome("glemr6_cold_humid_ocean", nil, "unilib:sand_volcanic_dust", 2, "unilib:stone_brownstone_dark", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, -192, -4, TEMP_COLD, HUMIDITY_HUMID)
    add_biome("glemr6_cold_humid_beach", nil, "unilib:dirt_ordinary_with_cover_snow", 1, "unilib:stone_brownstone_dark", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, -4, 4, TEMP_COLD, HUMIDITY_HUMID)

    add_biome("glemr6_cold_humid_coastal", nil, "unilib:dirt_ordinary_with_cover_snow", 1, "unilib:dirt_silt_coarse", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, -HEIGHT_BEACH_MAX, HEIGHT_COASTAL, TEMP_COLD, HUMIDITY_HUMID)
    add_biome("glemr6_cold_humid_lowland", nil, "unilib:dirt_ordinary_with_cover_snow", 1, "unilib:dirt_silt_fine", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_COLD, HUMIDITY_HUMID)
    add_biome("glemr6_cold_humid_shelf", nil, "unilib:dirt_ordinary_with_cover_snow", 1, "unilib:dirt_dark", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_COLD, HUMIDITY_HUMID)
    add_biome("glemr6_cold_humid_highland", nil, "unilib:dirt_ordinary_with_cover_snow", 1, "unilib:dirt_ordinary", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_COLD, HUMIDITY_HUMID)

    add_biome("glemr6_cold_humid_mountain", "unilib:snow_ordinary_block", "unilib:ice_ordinary", 10, "unilib:stone_brownstone_dark", 20, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_COLD, HUMIDITY_HUMID)
    add_biome("glemr6_cold_humid_strato", "unilib:ice_ordinary", "unilib:ice_ordinary", 15, "unilib:stone_granite_white", 25, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_COLD, HUMIDITY_HUMID)

    if unilib.pkg.biome_glemr6.optional_biome_flag then


        add_biome("glemr6_cold_humid_volcanic", nil, nil, nil, "unilib:ice_ordinary", 20, "unilib:stone_basalt_dark", nil, nil, nil, nil, 140, 140, TEMP_COLD, HUMIDITY_HUMID)
        add_biome("glemr6_cold_humid_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_COLD, HUMIDITY_HUMID)

    end

end

local function add_biomes_cold_semihumid()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_cold_semihumid", nil, "unilib:dirt_coarse_with_litter_coniferous", 1, "unilib:dirt_coarse", 4, nil, nil, nil, nil, nil, 0, 100, TEMP_COLD, HUMIDITY_SEMIHUMID)
        add_biome("glemr6_cold_semihumid_generic", nil, "unilib:dirt_coarse_with_litter_coniferous", 1, "unilib:dirt_coarse", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_COLD, HUMIDITY_SEMIHUMID)
        add_biome("glemr6_cold_semihumid_underground", nil, nil, nil, nil, nil, "unilib:stone_basalt_dark", nil, nil, nil, nil, unilib.constant.y_min, -TEMP_HOT, TEMP_COLD, HUMIDITY_SEMIHUMID)

    end

    add_biome("glemr6_cold_semihumid_ocean", nil, "unilib:sand_volcanic_dust", 2, "unilib:stone_brownstone_dark", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, -192, -4, TEMP_COLD, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_cold_semihumid_beach", nil, "unilib:dirt_ordinary_with_cover_snow", 1, "unilib:stone_brownstone_dark", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, -4, 4, TEMP_COLD, HUMIDITY_SEMIHUMID)

    add_biome("glemr6_cold_semihumid_coastal", nil, "unilib:dirt_ordinary_with_cover_snow", 1, "unilib:dirt_silt_fine", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, TEMP_COLD, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_cold_semihumid_lowland", nil, "unilib:dirt_ordinary_with_cover_snow", 1, "unilib:dirt_dark", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_COLD, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_cold_semihumid_shelf", nil, "unilib:dirt_ordinary_with_cover_snow", 1, "unilib:dirt_ordinary", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_COLD, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_cold_semihumid_highland", nil, "unilib:dirt_ordinary_with_cover_snow", 1, "unilib:dirt_coarse", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_COLD, HUMIDITY_SEMIHUMID)

    add_biome("glemr6_cold_semihumid_mountain", "unilib:snow_ordinary_block", "unilib:ice_ordinary", 10, "unilib:stone_brownstone_dark", 20, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_COLD, HUMIDITY_SEMIHUMID)
    add_biome("glemr6_cold_semihumid_strato", "unilib:ice_ordinary", "unilib:ice_ordinary", 15, "unilib:stone_granite_white", 25, "unilib:stone_brownstone_dark", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_COLD, HUMIDITY_SEMIHUMID)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_cold_semihumid_volcanic", nil, nil, nil, "unilib:ice_ordinary", 15, "unilib:stone_basalt_dark", nil, nil, nil, nil, 140, 140, TEMP_COLD, HUMIDITY_SEMIHUMID)
        add_biome("glemr6_cold_semihumid_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_COLD, HUMIDITY_SEMIHUMID)

    end

end

local function add_biomes_cold_temperate()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_cold_temperate", nil, "unilib:dirt_coarse_with_turf", 1, "unilib:dirt_coarse", 4, nil, nil, nil, nil, nil, 0, 100, TEMP_COLD, HUMIDITY_TEMPERATE)
        add_biome("glemr6_cold_temperate_generic", nil, "unilib:dirt_coarse_with_turf", 1, "unilib:dirt_coarse", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_COLD, HUMIDITY_TEMPERATE)
        add_biome("glemr6_cold_temperate_underground", nil, nil, nil, nil, nil, "unilib:stone_basalt_dark", nil, nil, nil, nil, unilib.constant.y_min, -TEMP_HOT, TEMP_COLD, HUMIDITY_TEMPERATE)

    end

    add_biome("glemr6_cold_temperate_ocean", nil, "unilib:sand_silver", 2, "unilib:sand_ordinary", 4, "unilib:stone_sandstone_ordinary", nil, nil, nil, nil, -192, -4, TEMP_COLD, HUMIDITY_TEMPERATE)
    add_biome("glemr6_cold_temperate_beach", nil, "unilib:dirt_ordinary_with_cover_snow", 1, "unilib:sand_silver", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, -4, 4, TEMP_COLD, HUMIDITY_TEMPERATE)

    add_biome("glemr6_cold_temperate_coastal", nil, "unilib:dirt_ordinary_with_cover_snow", 1, "unilib:dirt_dark", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, TEMP_COLD, HUMIDITY_TEMPERATE)
    add_biome("glemr6_cold_temperate_lowland", nil, "unilib:dirt_ordinary_with_cover_snow", 1, "unilib:dirt_ordinary", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_COLD, HUMIDITY_TEMPERATE)
    add_biome("glemr6_cold_temperate_shelf", nil, "unilib:dirt_ordinary_with_cover_snow", 1, "unilib:dirt_coarse", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_COLD, HUMIDITY_TEMPERATE)
    add_biome("glemr6_cold_temperate_highland", nil, "unilib:dirt_ordinary_with_cover_snow", 1, "unilib:clay_red", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_COLD, HUMIDITY_TEMPERATE)

    add_biome("glemr6_cold_temperate_mountain", "unilib:snow_ordinary_block", "unilib:snow_ordinary_block", 10, "unilib:stone_brownstone_dark", 20, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_COLD, HUMIDITY_TEMPERATE)
    add_biome("glemr6_cold_temperate_strato", "unilib:ice_ordinary", "unilib:ice_ordinary", 15, "unilib:stone_granite_white", 25, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_COLD, HUMIDITY_TEMPERATE)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_cold_temperate_volcanic", nil, nil, nil, "unilib:ice_ordinary", TEMP_COLD, "unilib:stone_basalt_dark", nil, nil, nil, nil, 140, 140, TEMP_COLD, HUMIDITY_TEMPERATE)
        add_biome("glemr6_cold_temperate_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_COLD, HUMIDITY_TEMPERATE)

    end

end

local function add_biomes_cold_semiarid()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_cold_semiarid", nil, "unilib:dirt_coarse_with_turf_dry", 1, "unilib:dirt_coarse", 2, nil, nil, nil, nil, nil, 0, 100, TEMP_COLD, HUMIDITY_SEMIARID)
        add_biome("glemr6_cold_semiarid_generic", nil, "unilib:dirt_coarse_with_turf_dry", 1, "unilib:dirt_coarse", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_COLD, HUMIDITY_SEMIARID)
        add_biome("glemr6_cold_semiarid_underground", nil, nil, nil, nil, nil, "unilib:stone_basalt_dark", nil, nil, nil, nil, unilib.constant.y_min, -TEMP_HOT, TEMP_COLD, HUMIDITY_SEMIARID)

    end

    add_biome("glemr6_cold_semiarid_ocean", nil, "unilib:sand_silver", 2, "unilib:stone_sandstone_silver", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, -192, -4, TEMP_COLD, HUMIDITY_SEMIARID)
    add_biome("glemr6_cold_semiarid_beach", nil, "unilib:dirt_ordinary_with_cover_snow", 1, "unilib:stone_sandstone_silver", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, -4, 4, TEMP_COLD, HUMIDITY_SEMIARID)

    add_biome("glemr6_cold_semiarid_coastal", nil, "unilib:dirt_ordinary_with_cover_snow", 1, "unilib:dirt_ordinary", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, TEMP_COLD, HUMIDITY_SEMIARID)
    add_biome("glemr6_cold_semiarid_lowland", nil, "unilib:dirt_ordinary_with_cover_snow", 1, "unilib:dirt_coarse", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_COLD, HUMIDITY_SEMIARID)
    add_biome("glemr6_cold_semiarid_shelf", nil, "unilib:dirt_permafrost_dark", 1, "unilib:clay_red", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_COLD, HUMIDITY_SEMIARID)
    add_biome("glemr6_cold_semiarid_highland", nil, "unilib:dirt_permafrost_dark", 1, "unilib:dirt_clayey", TEMP_COLD, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_COLD, HUMIDITY_SEMIARID)

    add_biome("glemr6_cold_semiarid_mountain", nil, "unilib:stone_diorite_dark", 10, "unilib:stone_gneiss_brown", 20, "unilib:stone_granite_white", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_COLD, HUMIDITY_SEMIARID)
    add_biome("glemr6_cold_semiarid_strato", nil, "unilib:stone_andesite_grey", 15, "unilib:stone_diorite_dark", 25, "unilib:stone_gneiss_brown", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_COLD, HUMIDITY_SEMIARID)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_cold_semiarid_volcanic", nil, "air", 1, "air", 1, "unilib:liquid_lava_ordinary_source", nil, nil, nil, nil, 140, 140, TEMP_COLD, HUMIDITY_SEMIARID)
        -- N.B. In original code, cold_temperate_sky
        add_biome("glemr6_cold_semiarid_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_COLD, HUMIDITY_SEMIARID)

    end

end

local function add_biomes_cold_arid()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_cold_arid", nil, "unilib:dirt_coarse", 1, "unilib:stone_savanna", 2, nil, nil, nil, nil, nil, 0, 100, TEMP_COLD, HUMIDITY_ARID)
        add_biome("glemr6_cold_arid_generic", nil, "unilib:dirt_coarse", 1, "unilib:stone_savanna", 4, nil, nil, nil, nil, nil, -192, unilib.constant.y_max, TEMP_COLD, HUMIDITY_ARID)
        add_biome("glemr6_cold_arid_underground", nil, nil, nil, nil, nil, "unilib:stone_basalt_dark", nil, nil, nil, nil, unilib.constant.y_min, -192, TEMP_COLD, HUMIDITY_ARID)

    end

    add_biome("glemr6_cold_arid_ocean", nil, "unilib:sand_silver", 2, "unilib:stone_sandstone_silver", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, -192, -4, TEMP_COLD, HUMIDITY_ARID)
    add_biome("glemr6_cold_arid_beach", nil, "unilib:dirt_ordinary_with_cover_snow", 1, "unilib:stone_sandstone_silver", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, -4, 4, TEMP_COLD, HUMIDITY_ARID)

    add_biome("glemr6_cold_arid_coastal", nil, "unilib:dirt_ordinary_with_cover_snow", 8, "unilib:stone_granite_dark", 10, "unilib:stone_basalt_dark", nil, nil, nil, nil, HEIGHT_BEACH_MAX, HEIGHT_COASTAL, TEMP_COLD, HUMIDITY_ARID)
    add_biome("glemr6_cold_arid_lowland", nil, "unilib:dirt_permafrost_dark", 8, "unilib:stone_gabbro_red", 10, "unilib:stone_granite_dark", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, TEMP_COLD, HUMIDITY_ARID)
    add_biome("glemr6_cold_arid_shelf", nil, "unilib:dirt_permafrost_dark", 8, "unilib:stone_granite_pink", 10, "unilib:stone_gabbro_red", nil, nil, nil, nil, HEIGHT_LOWLAND, HEIGHT_SHELF, TEMP_COLD, HUMIDITY_ARID)
    add_biome("glemr6_cold_arid_highland", nil, "unilib:dirt_permafrost_dark", 8, "unilib:stone_granite_white", 15, "unilib:stone_granite_pink", nil, nil, nil, nil, HEIGHT_SHELF, HEIGHT_HIGHLAND, TEMP_COLD, HUMIDITY_ARID)

    add_biome("glemr6_cold_arid_mountain", nil, "unilib:stone_diorite_dark", 15, "unilib:stone_gneiss_brown", 20, "unilib:stone_granite_white", nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_COLD, HUMIDITY_ARID)
    add_biome("glemr6_cold_arid_strato", nil, "unilib:stone_andesite_grey", 15, "unilib:stone_diorite_dark", 25, "unilib:stone_gneiss_brown", nil, nil, nil, nil, HEIGHT_MOUNTAIN, HEIGHT_STRATO, TEMP_COLD, HUMIDITY_ARID)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_cold_arid_volcanic", nil, "air", 1, "air", 1, "unilib:liquid_lava_ordinary_source", nil, nil, nil, nil, 140, 140, 15, 15)
        add_biome("glemr6_cold_arid_sky", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 180, unilib.constant.y_max, TEMP_COLD, HUMIDITY_ARID)

    end

end

---------------------------------------------------------------------------------------------------
-- Generic biomes
---------------------------------------------------------------------------------------------------

local function add_biomes_generic()

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_generic_beach", nil, "unilib:sand_ordinary", 1, "unilib:stone_sandstone_ordinary", 4, nil, nil, nil, nil, nil, -4, 4, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)
        add_biome("glemr6_generic_ocean", nil, "unilib:sand_silt", 1, "unilib:dirt_silt_coarse", 4, nil, nil, nil, nil, nil, -192, -4, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)
        add_biome("glemr6_generic_underground", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, unilib.constant.y_min, -192, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)
        add_biome("glemr6_generic_mountain", nil, "unilib:snow_ordinary_block", 1, "unilib:ice_ordinary", 4, nil, nil, nil, nil, nil, HEIGHT_HIGHLAND, HEIGHT_MOUNTAIN, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)
        add_biome("glemr6_generic_volcanic", nil, "unilib:stone_basalt_dark_rubble", 1, "unilib:stone_basalt_dark", 3, "unilib:stone_brownstone_dark", nil, nil, nil, nil, TEMP_TEMPERATE, unilib.constant.y_max, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)

    end

    add_biome("glemr6_generic_mantle", nil, nil, 1, nil, 4, "unilib:liquid_lava_ordinary_source", nil, nil, nil, nil, unilib.constant.y_min, -20000, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)
    add_biome("glemr6_generic_layer_stone_basalt_dark", nil, nil, 1, nil, 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, -20000, -15000, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)
    add_biome("glemr6_generic_layer_stone_brownstone_dark", nil, nil, 1, nil, 4, "unilib:stone_brownstone_dark", nil, nil, nil, nil, -15000, -10000, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)
    add_biome("glemr6_generic_layer_stone_sandstone_brown", nil, nil, 1, nil, 4, "unilib:stone_sandstone_brown", nil, nil, nil, nil, -10000, -6000, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)
    add_biome("glemr6_generic_layer_stone_desert", nil, nil, 1, nil, 4, "unilib:stone_desert", nil, nil, nil, nil, -6000, -5000, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)
    add_biome("glemr6_generic_layer_stone_sandstone_desert", nil, nil, 1, nil, 4, "unilib:stone_sandstone_desert", nil, nil, nil, nil, -5000, -4000, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)
    add_biome("glemr6_generic_layer_stone_limestone_white", nil, nil, 1, nil, 4, "unilib:stone_limestone_white", nil, nil, nil, nil, -4000, -3000, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)
    add_biome("glemr6_generic_layer_stone_granite_dark", nil, nil, 1, nil, 4, "unilib:stone_granite_dark", nil, nil, nil, nil, -3000, -2000, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)
    add_biome("glemr6_generic_layer_stone_ordinary", nil, nil, 1, nil, 4, "unilib:stone_ordinary", nil, nil, nil, nil, -2000, -192, TEMP_TEMPERATE, HUMIDITY_TEMPERATE)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_generic_burned", nil, "unilib:dirt_ordinary_with_turf_grey", 1, "unilib:stone_basalt_dark_rubble", 4, "unilib:stone_basalt_dark", nil, nil, nil, nil, 30, 45, 63, 37)
        add_biome("glemr6_generic_mushroom", nil, "unilib:dirt_ordinary_with_cover_fungi", 1, "unilib:dirt_ordinary", 3, nil, nil, nil, nil, nil, 30, TEMP_TEMPERATE, 45, 55)
        add_biome("glemr6_generic_desert", nil, "unilib:sand_ordinary", 1, "unilib:sand_desert", 3, nil, nil, nil, nil, nil, 4, unilib.constant.y_max, TEMP_COOL, 30)
        add_biome("glemr6_generic_cavern", nil, "unilib:stone_limestone_white", 4, "air", 8, "unilib:stone_basalt_dark", nil, nil, nil, nil, -115, -85, -TEMP_COLD, 60)

    end

end

---------------------------------------------------------------------------------------------------
-- valleys_c biomes
---------------------------------------------------------------------------------------------------

local function add_biomes_valleys()

    add_biome("glemr6_valleys_tropical_rainforest_swamp", nil, "unilib:dirt_mud_swamp", 1, "unilib:dirt_mud_swamp", 2, "unilib:stone_brownstone_dark", nil, nil, nil, nil, -1, 2, 85, 95)
    add_biome("glemr6_valleys_subtropical_rainforest_swamp", nil, "unilib:dirt_mud_swamp", 1, "unilib:dirt_mud_swamp", 2, "unilib:stone_brownstone_dark", nil, nil, nil, nil, -1, 2, 75, 95)
    add_biome("glemr6_valleys_deciduous_forest_swamp", nil, "unilib:dirt_mud_swamp", 1, "unilib:dirt_silt_fine", 3, "unilib:stone_mudstone", nil, nil, nil, nil, -4, 4, 60, 60)
    add_biome("glemr6_valleys_temperate_rainforest_swamp", nil, "unilib:dirt_mud_swamp", 1, "unilib:dirt_mud_swamp", 2, "unilib:stone_brownstone_dark", nil, nil, nil, nil, -1, 2, 50, 95)

    if unilib.pkg.biome_glemr6.optional_biome_flag then

        add_biome("glemr6_valleys_desert", nil, "unilib:sand_desert", 1, "unilib:stone_sandstone_desert", 3, "unilib:stone_desert", nil, nil, nil, nil, 30, 90, 80, HUMIDITY_ARID)
        add_biome("glemr6_valleys_desertstone_grassland", nil, "unilib:dirt_clayey_with_turf_hot_temperate_lowland", 1, "unilib:dirt_clayey", 2, "unilib:stone_desert", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, 80, 55)
        add_biome("glemr6_valleys_savanna", nil, "unilib:dirt_clayey_with_turf_hot_semiarid_lowland", 1, "unilib:clay_red", 4, "unilib:stone_claystone_red", nil, nil, nil, nil, HEIGHT_COASTAL, HEIGHT_LOWLAND, 80, HUMIDITY_SEMIARID)
        add_biome("glemr6_valleys_savanna_swamp", nil, "unilib:dirt_clayey", 1, "unilib:clay_red", 3, "unilib:stone_claystone_red", nil, nil, nil, nil, -3, 0, 80, HUMIDITY_SEMIARID)
        add_biome("glemr6_valleys_tropical_rainforest", nil, "unilib:dirt_ordinary_with_litter_rainforest", 1, "unilib:dirt_ordinary", 2, "unilib:stone_brownstone_dark", nil, nil, nil, nil, 30, 90, 85, 95)
        add_biome("glemr6_valleys_subtropical_rainforest", nil, "unilib:dirt_ordinary_with_litter_rainforest", 1, "unilib:dirt_ordinary", 2, "unilib:stone_brownstone_dark", nil, nil, nil, nil, 30, 90, 75, 95)
        add_biome("glemr6_valleys_sandstone_grassland", nil, "unilib:dirt_sandy_with_turf_temperate_temperate_coastal", 1, "unilib:dirt_sandy", 2, "unilib:stone_limestone_white", nil, nil, nil, nil, 5, 24, 55, 40)
        add_biome("glemr6_valleys_sandstone_grassland_dunes", nil, "unilib:sand_ordinary", 1, "unilib:dirt_sandy", 2, "unilib:stone_sandstone_ordinary", nil, nil, nil, nil, 1, 5, 55, 40)
        add_biome("glemr6_valleys_temperate_rainforest", nil, "unilib:dirt_ordinary_with_litter_rainforest", 1, "unilib:dirt_ordinary", 2, "unilib:stone_brownstone_dark", nil, nil, nil, nil, 30, 90, 50, 95)
        add_biome("glemr6_valleys_coniferous_forest_dunes", nil, "unilib:sand_ordinary", 1, "unilib:dirt_sandy", 3, "unilib:stone_limestone_white", nil, nil, nil, nil, 1, 5, 35, 60)
        add_biome("glemr6_valleys_stone_grassland_dunes", nil, "unilib:sand_ordinary", 1, "unilib:dirt_sandy", 3, "unilib:stone_limestone_white", nil, nil, nil, nil, 5, 5, 35, 40)
        add_biome("glemr6_valleys_rainforest", nil, "unilib:dirt_ordinary_with_litter_rainforest", 1, "unilib:dirt_ordinary", 2, "unilib:stone_brownstone_dark", nil, nil, nil, nil, 30, 90, 85, 70)
        add_biome("glemr6_valleys_rainforest_swamp", nil, "unilib:dirt_mud_swamp", 1, "unilib:dirt_mud_swamp", 2, nil, nil, nil, nil, nil, -1, 2, 85, 60)

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_glemr6.init()

    return {
        description = "Biomes from GLEMr6",
        notes = "This package should be used with the corresponding remix, as it assumes that" ..
                " packages specified by the remix have been loaded",
        depends = "dirt_custom_glemr6",
    }

end

function unilib.pkg.biome_glemr6.post()

    if unilib.pkg.biome_glemr6.generic_biome_flag then
        add_biomes_generic()
    end

    if unilib.pkg.biome_glemr6.glem_biome_flag then

        add_biomes_hot_humid()
        add_biomes_hot_semihumid()
        add_biomes_hot_temperate()
        add_biomes_hot_semiarid()
        add_biomes_hot_arid()

        add_biomes_warm_humid()
        add_biomes_warm_semihumid()
        add_biomes_warm_temperate()
        add_biomes_warm_semiarid()
        add_biomes_warm_arid()

        add_biomes_temperate_humid()
        add_biomes_temperate_semihumid()
        add_biomes_temperate_temperate()
        add_biomes_temperate_semiarid()
        add_biomes_temperate_arid()

        add_biomes_cool_humid()
        add_biomes_cool_semihumid()
        add_biomes_cool_temperate()
        add_biomes_cool_semiarid()
        add_biomes_cool_arid()

        add_biomes_cold_humid()
        add_biomes_cold_semihumid()
        add_biomes_cold_temperate()
        add_biomes_cold_semiarid()
        add_biomes_cold_arid()

    end

    if unilib.pkg.biome_glemr6.valleys_biome_flag then
        add_biomes_valleys()
    end

end
