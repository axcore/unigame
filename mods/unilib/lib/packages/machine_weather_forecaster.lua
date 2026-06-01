---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_weather_forecaster = {}

local S = unilib.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end
local mode = unilib.global.imported_mod_table.unilib.add_mode

local this_formname = "unilib:form_machine_weather_forecaster"
local dark_colour = "#000000"

-- Number of seconds per (in-game) day
local secs_per_day = 1200
-- Number of samples per (in-game) day; increase this value to increase accuracy
local sample_rate = 10
-- Size (radius) of the sampling area, with the machine at the middle of it (in blocks). Use 0 to
--      test weather at the machine's position only
local sample_radius = 64
-- Sample distance; ignored if sample_radius is 0, otherwise should be a factor of sample_radius
-- e.g. Use the same value as "sample_radius" itself to sample 9 points (with the sign in the
--      middle); use half the value to sample 25 points (with the sign in the middle)
local sample_distance = sample_radius
-- Store the output for a short time (duration in seconds), re-displaying it if the formspec is
--      re-opened, rather than re-calculating it each time
local memory_length = secs_per_day / sample_rate

-- When no weather effect applies at a given position, use this weather effect "name" and
--      description
local nil_weather_name = "no_weather"
local nil_weather_description = S("Clear skies")

-- N.B. node_box adapted from the one used in "shared_default_sign"
local nbox = {
    type = "wallmounted",
    wall_top = {-0.4375, 0.4375, -0.3125, 0.4375, 0.5, 0.3125},
    wall_bottom = {-0.4375, -0.5, -0.3125, 0.4375, -0.4375, 0.3125},
    wall_side = {-0.5, -0.3125, -0.4375, -0.4375, 0.3125, 0.4375},
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function produce_weather_output(weather_table, sample_count)

    -- Compile a sorted list
    local weather_list = {}
    for weather_name, _ in pairs(weather_table) do
        table.insert(weather_list, weather_name)
    end

    table.sort(weather_list, function(a, b)
        return weather_table[a] > weather_table[b]
    end)

    -- Produce the output
    local str = ""
    for _, weather_name in ipairs(weather_list) do

        local description = nil_weather_description
        if weather_name ~= nil_weather_name then
            description = unilib.atmosphere.get_weather_effect_description(weather_name)
        end

        local percentage = weather_table[weather_name] / sample_count * 100
        if percentage < 1 then
            str = str .. description .. ": < 1%\n"
        else
            str = str .. description .. ": " .. math.ceil(percentage) .. "%\n"
        end

    end

    return str

end

local function compile_weather_data(pos, machine_type)

    local current_time = os.time()

    -- Short-range forecast results
    local short_table = {}
    local short_count = 0
    -- Long-range forecast results
    local long_table = {}
    local long_count = 0

    -- The number of samples to take over the period of the forecasts
    local short_sample_count, long_sample_count
    if machine_type == "simple" then

        short_sample_count = sample_rate * 1
        long_sample_count = sample_rate * 3

    else

        short_sample_count = sample_rate * 7
        long_sample_count = sample_rate * 28

    end

    -- Time between each sample
    local delta_time = secs_per_day / sample_rate

    -- Correct for a zero value of "sample_radius" (meaning sample the weather only at the
    --      machine's location), allowing the x/z loops just below to run at least once
    local this_sample_distance = sample_distance
    if this_sample_distance == 0 then
        this_sample_distance = 1
    end

    for x = (pos.x - sample_radius), (pos.x + sample_radius), this_sample_distance do

        for z = (pos.z - sample_radius), (pos.z + sample_radius), this_sample_distance do

            for i = 1, long_sample_count do

                current_time = current_time + delta_time

                local weather_name = unilib.atmosphere.sample_weather(
                    {x = x, y = pos.y, z = z}, current_time
                )
                if not weather_name then
                    weather_name = nil_weather_name
                end

                -- Short-range forecast
                if i <= short_sample_count then

                    short_count = short_count + 1
                    if not short_table[weather_name] then
                        short_table[weather_name] = 1
                    else
                        short_table[weather_name] = short_table[weather_name] + 1
                    end

                end

                -- Long-range forecast
                long_count = long_count + 1
                if not long_table[weather_name] then
                    long_table[weather_name] = 1
                else
                    long_table[weather_name] = long_table[weather_name] + 1
                end

            end

        end

    end

    return produce_weather_output(short_table, short_count),
            produce_weather_output(long_table, long_count)

end

local function get_formspec(pos, pname, machine_type, description)

    local meta = core.get_meta(pos)

    -- Short-term and long-term forecasts
    local short_str = meta:get_string("short_str")
    local long_str = meta:get_string("long_str")
    if short_str == "" then

        -- Memory has expired, re-calculate output
        short_str, long_str = compile_weather_data(pos, machine_type)
        meta:set_string("short_str", short_str)
        meta:set_string("long_str", long_str)
        -- Set the time after which the new forecast will exire
        core.get_node_timer(pos):start(memory_length)

    end

    -- N.B. If the player is standing (quite a few) blocks from the machine, then these messages
    --      won't be 100% accurate...
    local weather_msg, wind_msg

    local weather_name = unilib.atmosphere.get_weather(pname)
    if not weather_name then
        weather_msg = nil_weather_description
    else
        weather_msg = unilib.atmosphere.get_weather_effect_description(weather_name)
    end
    weather_msg = S("Current weather: @1", weather_msg)

    local wind_angle, wind_dir, wind_speed = unilib.atmosphere.get_wind(pname)
    -- N.B. Wind should always be available, but just in case...
    if not wind_speed then
        wind_msg = S("Current wind: unknown")
    else
        wind_msg = S("Current wind: @1 kph @2", wind_speed, wind_dir)
    end

    local short_title, long_title
    if machine_type == "simple" then

        short_title = S("24-hour forecast")
        long_title = S("3-day forecast")

    else

        short_title = S("7-day forecast")
        long_title = S("28-day forecast")

    end

    return "size[8,6]" ..
        "image[0,0;1,1;unilib_machine_weather_forecaster_" .. machine_type .. "_inv.png]" ..
        "label[1,0.2;" .. F(description) .. "]" ..
        "label[0.2,1;" .. weather_msg .. "]" ..
        "label[0.2,1.5;" .. wind_msg .. "]" ..
        "label[0.2,2.2;" .. F(short_title) .. "]" ..
        "box[0.2,2.7;3.5,3.1;" .. dark_colour .. "]" ..
        "textarea[0.5,2.7;3.75,3.8;;;" .. short_str .. "]" ..
        "label[4,2.2;" .. F(long_title) .. "]" ..
        "box[4,2.7;3.5,3.1;" .. dark_colour .. "]" ..
        "textarea[4.3,2.7;3.75,3.8;;;" .. long_str .. "]"

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_weather_forecaster.init()

    return {
        description = "Weather forecasting consoles",
        notes = "Provides simple and advanced consoles. The simple console provides 24-hour and" ..
                " 3-day forecasts, intended for use by all players. The advanced console" ..
                " provides 7-day and 28-day forecasts, intended for use by anyone trying to" ..
                " tweak the weather variables in ../lib/effects/atmosphere/atmosphere_base.lua" ..
                " (when used, it places a slight burden on a server). Note that forecasts apply" ..
                " to the surrounding area (by default), not just the position occupied by the" ..
                " console; this behaviour can be changed by tweaking the package code",
        depends = {"glass_ordinary", "metal_steel", "mineral_diamond", "mineral_mese"},
    }

end

function unilib.pkg.machine_weather_forecaster.exec()

    local simple_description = S("Simple Weather Forecasting Console")
    unilib.register_node("unilib:machine_weather_forecaster_simple", nil, mode, {
        -- Original to unilib
        description = simple_description,
        tiles = {
            "unilib_machine_weather_forecaster_simple.png",
        },
        groups = {cracky = 2, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        inventory_image = "unilib_machine_weather_forecaster_simple_inv.png",
        is_ground_content = false,
        light_source = 3,
        node_box = nbox,
        paramtype = "light",
        paramtype2 = "wallmounted",
        sunlight_propagates = true,
        use_texture_alpha = "opaque",
        walkable = false,

        on_rightclick = function(pos, node, clicker)

            local pname = clicker:get_player_name()
            if not pname then
                return
            end

            core.show_formspec(
                pname,
                this_formname,
                get_formspec(pos, pname, "simple", simple_description)
            )

        end,

        on_timer = function(pos, elapsed)

            -- When the timer goes off, empty memory (allowing the weather forecast to be
            --      re-calculated, the next time the formspec is opened)
            local node = core.get_node_or_nil(pos)
            if not node or node.name ~= "unilib:machine_weather_forecaster_simple" then
                return false
            end

            local meta = core.get_meta(pos)
            meta:set_string("short_str", "")
            meta:set_string("long_str", "")
            return false

        end,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:machine_weather_forecaster_simple",
        recipe = {
            {"unilib:glass_ordinary", "unilib:glass_ordinary", "unilib:glass_ordinary"},
            {"unilib:metal_steel_ingot", "unilib:mineral_diamond_gem", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "unilib:mineral_mese_crystal", "unilib:metal_steel_ingot"},
        },
    })

    local advanced_description = S("Advanced Weather Forecasting Console")
    unilib.register_node("unilib:machine_weather_forecaster_advanced", nil, mode, {
        -- Original to unilib
        description = advanced_description,
        tiles = {
            "unilib_machine_weather_forecaster_advanced.png",
        },
        groups = {cracky = 2, not_in_creative_inventory = 1, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        inventory_image = "unilib_machine_weather_forecaster_advanced_inv.png",
        is_ground_content = false,
        light_source = 3,
        node_box = nbox,
        paramtype = "light",
        paramtype2 = "wallmounted",
        sunlight_propagates = true,
        use_texture_alpha = "opaque",
        walkable = false,

        on_rightclick = function(pos, node, clicker)

            local pname = clicker:get_player_name()
            if not pname then
                return
            end

            core.show_formspec(
                pname,
                this_formname,
                get_formspec(pos, pname, "advanced", advanced_description)
            )

        end,

        on_timer = function(pos, elapsed)

            -- When the timer goes off, empty memory (allowing the weather forecast to be
            --      re-calculated, the next time the formspec is opened)
            local node = core.get_node_or_nil(pos)
            if not node or node.name ~= "unilib:machine_weather_forecaster_advanced" then
                return false
            end

            local meta = core.get_meta(pos)
            meta:set_string("short_str", "")
            meta:set_string("long_str", "")
            return false

        end,
    })

end
