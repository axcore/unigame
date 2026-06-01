---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- atmosphere_base.lua
--      Set up weather and ambient effects
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- unilib enables and disables weather effects on a regional basis, using fractal noise (so players
--      in close proximity will experience the same weather effect, but players in identical biomes
--      at opposite sides of the world may experience different weather effects)
-- Packages may specify weather effects (e.g. heavy rain, light snow, normal cloud), calling
--      unilib.atmosphere.register_weather() to register them
-- unilib groups similar weather effects (e.g. heavy rain, light rain, normal hail) into a so-called
--      "weather prototype". Packages may specify weather prototypes, calling
--      unilib.atmosphere.register_weather_prototype() to register them
-- Each prototype specifies its own fractal noise, determining whether that prototype (representing
--      a group of weather effects) should be turned "on" or "off". When more than one prototype is
--      "on", the fractal noise determines which one is "dominant" (overrides all the others at
--      any given location)
-- Each prototype also specifies probabilities, determining the probability of enabling that group
--      of weather effects particular biomes and at particular elevations. For a prototype which is
--      initially turned "on", we compare those probabilites against a separate set of fractal
--      noise, so that the prototype can be turned "off"
--
-- Table of registered weather prototypes, in the form
--      weather_prototype_table[weather_prototype_name] = data_table
-- ...where data_table consists of compulsory key-value pairs, in the form
--
--      (Specified during the call to unilib.atmosphere.register_weather_prototype() )
--
--      description (str): A displayable string, e.g. "Rain"
--      noise_table (table): Noise parameter table for this prototype, used as an on/off switch for
--          this group of weather effects
--      heat_min_prob, heat_max_prob (float): Probability of this group of weather effects occuring
--          at 0 and 100 temperatures. These values form a straight line on a graph (with
--          temperature on the x-axis and probability on the y-axis), allowing us to calculate the
--          probability at any temperature. Any temperature below 0 is treated as 0, and any
--          temperature above 100 is treated as 100. Any probability below 0 is corrected to 0, and
--          any probability above 1 is corrected to 1
--      humid_min_prob, humid_max_prob (float): Probability of this group of weather effects
--          occuring at 0 and 100 humidity; used to calculate the probability at all values of
--          humidity, as above (humidity range 0-100, probability range 0-1)
--      height_min_prob, humid_min_prob (float): Probability of this group of weather effects
--          occuring at elevations of y=0 and y=100; used to calculate the probability at all
--          eleveations as above (elevation range 0-100, probability range 0-1)
--
--      (Calculated later)
--      effect_list (list): List of weather effects (keys in weather_effect_table) that use this
--          prototype
--      noise (noise value): The result of calling core.get_value_noise() with .noise_table;
--          calculated after the call to unilib.atmosphere.register_weather_prototype(). By
--          convention, prototype should use a seed in the range 0-1000, because the seeds used in
--          the core.after() code below are in the range 1001+
local weather_prototype_table = {}

-- Table of registered weather effects, in the form
--      weather_effect_table[weather_effect_name] = data_table
-- ...where data_table consists of key-value pairs, in the form
--
--      (Compulsory values)
--
--      description (str): A displayable string, e.g. "Heavy rain"
--      prototype (str): The name of the weather prototype; a key in "weather_prototype_table"
--      chance (int): How common each weather effect is, relative to other effects of the same
--          prototype; an integer in the range 1+. Built-in weather packages use 1 (rare effects), 3
--          and 5 (common effects), but you can use any range of values you like
--      tag_list (list): List of arbitrary words, e.g. "rain", "snow". Players can use one of these
--          tags with the "/set_weather" command, instead of typing the full of the weather effect.
--          All packages should specify this list, and (in most cases) it should include the word
--          "random", so that "/set_weather random" can be used to test all weather effects
--
--      (Optional values)
--
--      max_light (int): An integer in the range 0 (complete darkness) to 15 (natural sunlight). If
--          specified, light levels do not exceed this value (but may still be lower, especially at
--          night)
--      min_time (int): Minimum duration, in seconds, for this weather effect once started (assuming
--          the player does not change position). Ignored if the value is less than the default
--          minimum, "min_weather_time"
--      sound_table (table): A table specifying optional sound effects, in the form
--          .default - A sound effect audible when the player is in open air
--          .cover - A sound effect audible when the player is under cover (e.g. in a house)
--          .underground - A sound effect audible when the player is underground
--
--      particle_func (func): Function called once per second to generate particle, e.g. raindrops
--          and snowflakes. Can be omitted if no particles are required
--      ground_func (func): Function called once per second to place items on the ground (puddles,
--          snowfall and so on). Can be omitted if no ground items are required
--
--      sky_colour_list (list): A list of two RGB strings (in the form "#ABCDEF"), the first
--          specifying the skybox colour during the day, the second specifying the skybox colour at
--          night. If .sky_colour_list is specified, then the list must contain both strings.
--          In most cases, .cloud_density = 0 will be specified as well (because engine-generated
--          clouds look weird against a non-blue sky)
--      cloud_density (float): A value in the range 0 (no clouds) to 1 (maximum clouds). For
--          maximum clouds, usually it's better to specify skybox colours instead (because engine-
--          generated clouds don't extend to infinity)
--      lightning_probability (float): If specified, the probability of generating a lightning bolt
--          (in a random direction) each second; e.g. use 1/60 for one bolt per minute on average
--
--      fog_probability (float): A value in the range 0 (no fog) to 1 (always fog). When the value
--          is in between these limits, unilib will decide whether to generate fog at the time the
--          weather effect is set (so fog won't come and go over time, unless the weather effect
--          changes)
--      fog_near (float): A value in the range 0-0.99, representing the fraction of the player's
--          viewing range at which fog "starts". If not specified and fog is visible, a default
--          value is used
--      fog_far (flat): A value in the range 1+, representing the player's viewing range (in blocks)
--          when fog is visible. If not specified and fog is visible, a default value is used
--      fog_colour (str): A string in the form "#ABCDEFGH", where "GH" is the alpha value. Changes
--          the colour of the fog, when present. Most built-in weather packages don't specify a
--          .fog_colour, because specifying the .sky_colour_list is a more pleasing effect
--
--      max_wind_speed (int): A value in the range 0-MAX, where MAX is the absolute maximum
--          specified below
--      min_wind_speed (int): A value in the range 0-MAX, where MAX is the absolute maximum
--          specified below. Must be equal to or less than .max_wind_speed
local weather_effect_table = {}

-- Table of weather tags, in the form
--      weather_tag_table[tag] = list_of_weather_effect_names
local weather_tag_table = {}

-- Table of weather data for each player, in the form
--      player_table[pname] = data_table
-- ...where data_table consists of key-value pairs, in the form
--
--      - The current weather effect for the player
--          .current_weather = weather_name
--          .current_weather = nil (no weather affect currently applies)
--      - The previous weather effect for the player
--          .prev_weather = weather_name
--          .prev_weather = nil (no weather affect previously applied)
--
--      - A new weather effect is typically "locked" (cannot be switched/turned off) for some
--          minimum time, unless the player moves some distance from their position, at the time the
--          weather effect started
--      - The minimum time (matches os.time() ) at which .current_weather must continue (assuming a
--          non-moving player)
--          .unlock_time = epoch time
--          .unlock_time = nil (no weather affect currently applies)
--      - The player's position at the time the current weather effect started
--          .orig_pos = {x = N, y = N, z = N}
--          .orig_pos = nil (no weather affect currently applies)
--      - Flag set to true if the minimum time has not yet expired, or if the player has not yet
--          moved far enough away from the original position
--          .locked_flag = true
--          .locked_flag = false
--
--      - The sound currently audible to the player (used to store the handle for the current
--          weather sound or the current ambient repeating sound; ambient "single" sounds are not
--          stored here)
--          .sound = sound_effect_handle
--          .sound = nil (no weather sound is currently audible)
--
--      - Whether non-default cloud cover is currently visible to the player, because of the
--              current weather effect
--          .cloud_flag = true
--          .cloud_flag = false
--      - Whether fog is currently visible to the player, because of the current weather effect
--          .fog_flag = true
--          .fog_flag = false
--      - Whether artificially reduced light is currently visible to the player, because of the
--              current weather effect
--          .light_flag = true
--          .light_flag = false
--      - Whether an artificial skybox is currently visible to the player, because of the current
--              weather effect
--          .skybox_flag = true
--          .skybox_flag = false
--
--      - Whether the player's current weather effect will change on the next tick
--          .update_flag = true
--          .update_flag = false
--      - Whether the player is currently seeing one weather effect transitioning into another
--          .transition_flag = true
--          .transition_flag = false
--      - Whether the player is in open air, undercover, or underground
--          .status = "default", "cover", "underground" (always "default" when there is no current
--              weather effect); these values match the ones used for sound effects in
--              "weather_effect_table"
--          .status = nil (not set yet)
--
--      - Current wind data for the player
--          .wind_angle (a value in radians in the range 0 - 2*pi, representing the wind direction)
--          .wind_dir (an equivalent string, e.g. "north", "south_southwest"
--          .wind_speed (a value in the range 0 - MAX, where MAX depends on the current weather
--              effect, if any)
local player_table = {}

-- The "main" timer (ticking at once per second, by default) to handle transitions between weather
--      effects and to generate particles
-- (There is also a "mini" timer, ticking at twice the speed of the "main" timer. It's subservient
--      to the "main" timer, so it is not configured here)
local main_timer = 0
local main_timer_tick = 1
-- The "long" timer (ticking every 10 seconds, by default) to handle selection of weather events on
--      a regional basis
local long_timer = 0
local long_timer_tick = 10

-- Weather transition variables
-- Values specifying the length of transitions between two different weather effects
local transition_step_max = 10 * unilib.setting.atmosphere_transition_duration *
        unilib.setting.atmosphere_transition_smooth_factor
local transition_step_interval = 0.1 / unilib.setting.atmosphere_transition_smooth_factor
-- Values to handle smooth transitions between night (time < 0.1875) and day (time > 0.2396)
local transition_min_time = 0.1875
local transition_max_time = 0.2396
local transition_diff = transition_max_time - transition_min_time

-- Weather selection variables (fixed)
-- Weather selection is handled on a regional basis, and implemented using fractal noise, varying
--      over time
-- The time used is not the system epoch time, but the remainder after dividing by this value (i.e.
--      the time used is in the range 0-10000)
local epoch_multiple = 10000
-- There are three sets of fractal noise used in weather selection: the first is unique to each
--      weather prototype; the others are shared by all prototypes (these values are set below)
-- "climate_noise" is used to turn "off" a weather prototype, due to climate factors (heat, humidity
--      and elevation)
-- "selection_noise" is used used to decide which weather effect to select, for the dominant
--      weather prototype
local climate_noise
local selection_noise
-- A fourth set of fractal noise is used to generate wind
local wind_noise

-- Value for the engine's max light (here we can't use unilib.constant.light_max, whose value is 15)
local engine_max_light = 15
-- Default colours of the skybox in its "regular" state, and default cloud density
local default_day_colour = "#60B4F4"
local default_night_colour = "#000A18"
local default_cloud_density = 0.4
-- Normal skybox colours/cloud density (when no weather effects apply; these values can be changed
--      by calling the shared functions below)
local normal_day_colour = default_day_colour
local normal_night_colour = default_night_colour
local normal_cloud_density = default_cloud_density
-- Values used to set the player status
-- Value used to decided whether the player is in open air, or not (true, if nothing is above him
--      up this height; minimum value 2)
local open_air_height = 16
-- Value used to decide whether the player is "underground or not
local sea_level_height = 1
-- Player heights above/below which any weather effect is cancelled, and new weather effects are
--      not initiated (to save on server loads when players are deep underground or far above the
--      clouds)
local weather_top_limit = 512
local weather_bottom_limit = -64

-- Default sky colours when lightning is present, ahd the size of the images used to (temporarily)
--      replace them
local lightning_sky_rgb = "#8F8C8C"
local lightning_flash_rgb = "#F1F1DE"
local lightning_sky_size = 256
-- Size of the lightning textures
local lightning_w = 48
local lightning_h = 128
-- Number of lightning textures available (4 by default, named unilib_weather_lightning_N.png)
local lightning_count = 4
-- The lightning flash occurs in a few short stages; the length (in seconds) of each stage
local lightning_flash_interval = 0.4
local lightning_dark_interval = 0.66
-- At sea level, the bottom of a 64x128 lightning image is just above the horizon; so compensate for
--      that by adding a horizontal offset of 2. At a height of y=25, the offset required to place
--      the lightning image at the horizon would be 16
local lightning_y_offset = 16

-- Default fog values
local fog_default_near = 1.0
local fog_default_far = 100
local fog_default_colour = "#00000000"

-- Absolute maximum/minimum wind speeds, in kph
local abs_max_wind_speed = 80
local abs_min_wind_speed = 0
-- Default max/min wind speeds (used when there is no current weather effect, or when weather
--      effects don't specify their own max/min speeds)
local default_max_wind_speed = 20
local default_min_wind_speed = 0
-- Values used to smooth the transition between drastically different wind speeds
local wind_smoothness_limit = 5
local wind_smoothness_ratio = 0.2
-- List of cardinal directions, used with wind
local compass_dir_list = {
    S("north"),
    S("north-northeast"),
    S("northeast"),
    S("east-northeast"),
    S("east"),
    S("east-southeast"),
    S("southeast"),
    S("south-southeast"),
    S("south"),
    S("south-southwest"),
    S("southwest"),
    S("west-southwest"),
    S("west"),
    S("west-northwest"),
    S("northwest"),
    S("north-northwest"),
}

-- Values used in the Abramowitz & Stegun approximation
local asap_a1, asap_a2, asap_a3, asap_a4, asap_a5 =
        0.254829592, -0.284496736, 1.421413741, -1.453152027, 1.061405429
local asap_p = 0.3275911
local asap_sigma = 0.35

-- The "ambient" timer to handle selection of ambient effects (general background noise, sometimes
--      associated with biomes and nodes)
local ambient_timer = 0
local ambient_timer_tick = 2
-- Table of registered ambient effects, in the form
--      ambient_effect_table[effect_name] = data_table
-- ...where data_table consists of key-value pairs, in the form
--      biome_list (list): List of biome names; if empty, there is no biome requirement, otherwise
--          the ambient effect is triggered only when the player is in one of these biomes
--      node_list (list): List of node full names; if empty, there is no node requirement, otherwise
--          the ambient effect is triggered only when the player is on one of these nodes
--      play_func (func): If specified, a function which returns true if this ambient effect can be
--          triggered, false if it cannot
--      single_list (list): List of Minetest SimpleSoundSpec tables, used for play-once sounds (e.g.
--          water drips in caves). Each table contains the keys .name, .gain, .pitch, .fade
--      single_prob (float): Probability that a sound in .single_list will be triggered; if not
--          specified, a default value of 0.01 is used
--      repeat_list (list): List of Minetest SimpleSoundSpec tables, used for repeating sounds (e.g.
--          general birdsong, light winds). Each able contains the keys .name, .gain, .pitch, .fade
--      repeat_prob (float): Probability that a sound in .repeat_list will be triggered; if not
--          specified, a default value of 1 is used
local ambient_effect_table = {}
-- The radius of the area to search, when checking nodes in .node_list
local ambient_search_radius = 3

-- The "environment" timer to handle environment effects (specific background noise heard when a
--      player is near specified nodes like water and lava)
-- The code for the "environment" timer is based on the minetest_game/env_sounds mod
local environment_timer = 0
-- N.B. The sound repeats after this interval, so any sound effect files must be at least this
--      length; value was 3.5 in original code
local environment_timer_tick = 4
-- Table of registered environment effects, in the form
--      environment_effect_table[effect_name] = data_table
-- ...where data_table consists of key-value pairs, in the form
--      sound (str): The name of the sound to play, e.g. "unilib_env_lava"
--      node_list (list): List of full node names (for liquids, including both the source and
--          flowing variants)
--      base_volume (float): e.g. 0
--      max_volume (float): e.g. 0.4
--      node_volume (float): e.g. 0.004 (the increase in sound volume for every nearby matching
--          node)
--      node_volume_table (table): Ignored if .node_valume is not nil. A table of node full_names
--          and their corresponding increase in sound volume per node (for example, if source and
--          flowing nodes have a different volume)
local environment_effect_table = {}
-- The union of all items in every .node_list field
local environment_cache_list = {}
-- The radius of the area to search, when checking nodes in .node_list
local environment_search_radius = 8

-- Customisable variables - modify these values to tweak which weather effects appear, and how often
-- Weather selection variables
-- The (fractal noise) threshold above which a weather prototype is turned "on". Increase this value
--      to reduce server load (at the cost of reducing the number of weather events experienced by
--      players)
-- Recommended range: 0.1 - 0.5. In testing, 0.1 provides approx 70% clear skies (all other things
--      being equal), 0.5 about 80% clear skies, 0.6 about 85% clear skies, 0.7 about 90% clear
--      skies (the outcome raises exponentially throughout)
local general_noise_threshold = 0.3
-- Climate boost factor. The default value is 1; increase this value to reduce the probability that
--      a weather prototype, initially turned "on", will be turned "off" because of climate factors
--      (which will increase the number of weather events experienced by players - in most cases,
--      you should tweak this value, rather than the one above)
-- Recommended range: 1-10. In testing, 1 provides approx 95% clear skies (all other things being
--      equal), 2 about 90% clear skies, 3 about 75% clear skies, 4 about 65% clear skies,
--      5 about 55% clear skies, 6 about 50% clear skies, 8 about 40% clear skies, 10 about
--      37% clear skies, 15 about 35% clear skies (the outcome falling exponentially throughout)
local climate_boost_factor = 4
-- Position granularity factor. Increase this value to reduce the amount of variation in weather
--      selection between two players at nearby positions (since it's possible for them to see two
--      different weather effects, infrequently and briefly, depending on what the fractal noise is
--      doing)
-- Recommended range 1-100; use 1 in single-player games; 10 and 100 are good values on servers. The
--      value has little effect on the amount of clear skies over the long term
local posn_granularity_factor = 10
-- Temporal granularity factor. Increase this value to reduce the amount of variation in weather
--      selection over time (also making each weather effect last longer). Recommended range 1-10
local time_granularity_factor = 2
-- The minimum duration, in seconds, for a weather effect once started (assuming the player does not
--      change position)
local min_weather_time = 60
-- However, a weather effect can end early (or be switched for another one) if a player travels a
--      minimum distance from their position, at the time the effect started; the number of blocks
--      to travel, in order to force a recalculation
local min_weather_range = 100
-- Wind variables
-- Wind speed variability factor; increase this value to slow changes in wind speed over time
local wind_speed_variable_factor = 2
-- Wind direction variability factor; increase this value to slow changes in wind direction over
--      time
local wind_dir_variable_factor = 2
-- Debug variables
-- Flag set to true to show weather effect changes as log messages
local debug_log_flag = false
-- Flag set to true to ignore minimum times for weather effects (so the visible weather effect
--      depends entirely on fractal noise). Enable this flag for fine-tuning the weather selection
--      system, when modifying the values just above
local debug_no_lock_flag = false
-- Flag set to true to produce frequent lightning in all directions, for testing lightning texture
--      placement
local debug_lightning_flag = false

-- Localise math functions (for speed)
local abs = math.abs
local ceil = math.ceil
local exp = math.exp
local floor = math.floor
local min = math.min
local pi = math.pi
local random = math.random
local sqrt = math.sqrt

-- Text used in error/warning messages
local msg_path = "../lib/effects/atmosphere/atmosphere_base.lua: "

---------------------------------------------------------------------------------------------------
-- Local functions (weather utility functions)
---------------------------------------------------------------------------------------------------

local function adjust_light_level(player, data_table)

    -- Called by on_mini_tick() during transitions to adjust the light level for the specified
    --      "player"
    -- "data_table" is that player's data in "player_table"

    -- We only need to act if the natural light is higher than the maximum specified by the player's
    --      current weather effect
    local natural_light = core.time_to_day_night_ratio(core.get_timeofday()) or engine_max_light
    if (natural_light * engine_max_light) <= data_table.max_light then

        -- Natural light is now lower than the maximum specified by the weather effect; cancel the
        ---     override, if it exists
        if player:get_day_night_ratio() then
            player:override_day_night_ratio(nil)
        end

    else

        -- Apply the override to reduce light to the maximum
        player:override_day_night_ratio(data_table.max_light / engine_max_light)

    end

end

local function convert_hex_to_int(hex)

    -- Called by numerous functions
    -- Converts a hex value, e.g. "#ABCDEF", to three RGB values, each in the range 0-255

    return tonumber(hex:sub(2, 3), 16), tonumber(hex:sub(4, 5), 16), tonumber(hex:sub(6, 7), 16)

end

local function convert_int_to_hex(r, g, b)

    -- Called by numerous functions
    -- Converts three RGB values, each in the range 0-255, to a hex value, e.g. "#ABCDEF"

    return string.format("#%02X%02X%02X", r, g, b)

end

local function convert_noise_to_uniform_distribution(noise_val)

    -- Called by select_weather_effect()
    -- Converts a fractal noise value (which is approximately Gaussian) to a mean distribution,
    --      using a CDF transform

    local function erf(x)

        -- Abramowitz & Stegun approximation
        local sign = 1
        if x < 0 then
            sign = -1
        end

        x = abs(x)
        local t = 1 / (1 + asap_p * x)
        local y = 1 - (
            (((((asap_a5 * t + asap_a4) * t) + asap_a3) * t + asap_a2) * t + asap_a1) *
                t * exp(-x * x)
        )
        return sign * y

    end

    return 0.5 * (1 + erf(noise_val / (asap_sigma * sqrt(2))))

end

local function convert_weather_tag(pname, weather_tag)

    -- Called by unilib.atmosphere.set_weather()
    -- Converts the specified "weather_tag" (a key in "weather_tag_table") into the name of a
    --      weather effect (a key in "weather_effect_table"), selecting one at random if multiple
    --      weather effects match the tag
    -- Returns nil if no weather effects match the tag, or if the tag matches only the specified
    --      player's current weather effect

    local available_list = {}
    local current_weather = player_table[pname]["current_weather"]

    for _, weather_name in ipairs(weather_tag_table[weather_tag]) do

        if not current_weather or weather_name ~= current_weather then
            table.insert(available_list, weather_name)
        end

    end

    -- (In case "weather_tag" matches only the player's current weather effect, return a nil value,
    --      which the calling code can ignore)
    if #available_list > 0 then
        return available_list[random(#available_list)]
    end

end

local function get_mirror_time()

    -- Called by on_main_tick()
    -- "mirror_time" is the return value of core.get_timeofday(), restricted to the range 0 - 0.5
    -- Values outside of that range are mirrored, such that 0.6 becomes 0.4, 0.95 becomes 0.05, and
    --      (most importantly) dawn and dusk have the same value

    local mirror_time = core.get_timeofday()
    if mirror_time >= 0.5 then
        return 1 - mirror_time
    else
        return mirror_time
    end

end

local function get_time_value_for_fractal_noise(time_val)

    -- Called by numerous functions
    -- Values from fractal noise are obtained using "time_value", the output of os.time() (either
    --      now or at some hypothetical time in the future), with all but the last 4 digits stripped
    --      away (since we don't actually need to work with very large time values)

    -- Number of intervals since epoch, ignore all but last 4 digits
    return (floor(time_val / long_timer_tick)) % epoch_multiple

end

local function get_sky_colour(mirror_time, day_colour, night_colour)

    -- Called by numerous functions
    -- "mirror_time" is the return value of core.get_timeofday(), restricted to the range 0 - 0.5
    -- During daytime or nighttime, the specified "day_colour" or "night_colour" is returned (both
    --      are hex values, e.g. "#ABCDEF")
    -- During the transition between night and day (or vice-versa), we calculate an intermediate
    --      value, so that the skybox colour transitions relatively smoothly from one colour to the
    --      other

    if mirror_time <= transition_min_time then
        return night_colour
    elseif mirror_time >= transition_max_time then
        return day_colour
    end

    -- Handle a smooth transition between night and day, in either direction
    local nr, ng, nb = convert_hex_to_int(night_colour)
    local dr, dg, db = convert_hex_to_int(day_colour)
    local factor = (mirror_time - transition_min_time) / transition_diff

    local tr, tg, tb
    tr = nr + ( (dr - nr) * factor )
    tg = ng + ( (dg - ng) * factor )
    tb = nb + ( (db - nb) * factor )

    return convert_int_to_hex(tr, tg, tb)

end

local function start_weather_sound(pname, sound)

    -- Called by numerous functions
    -- Fades in the specified sound effect for the specified player

    local handle = core.sound_play(sound, {to_player = pname, gain = 0, loop = true})
    if handle then

        -- (Fade in)
        core.sound_fade(handle, (1 / unilib.setting.atmosphere_transition_duration), 1.0)
        player_table[pname]["sound"] = handle

    end

end

local function start_ambient_sound(pname, sound_spec, repeat_flag)

    -- Called by on_ambient_tick()
    -- Fades in the specified Minetest SimpleSoundSpec for the specified player
    local handle = core.sound_play(sound_spec, {to_player = pname, loop = repeat_flag})
    if handle then
        player_table[pname]["sound"] = handle
    end

end

local function stop_sound(pname)

    -- Called by numerous functions
    -- Fades out the current sound effect for the specified player

    local handle = player_table[pname]["sound"]
    if handle then

        core.sound_fade(handle, (1 / unilib.setting.atmosphere_transition_duration), 0)
        player_table[pname]["sound"] = nil

    end

end

local function update_player_status(player, pname, weather_name)

    -- Called by on_main_tick(), just before every call to on_mini_tick()
    -- Checks the player's position and, if necessary, updates their status (a field in
    --      "player_table", having the values "default", "cover", "underground")
    -- Returns the value of the player's status, and a flag that's true if the status has changed
    --      during this call (and false otherwise)

    local status = "default"
    local status_change_flag = false

    -- Shortcut: use values other than "default" only when there is a current weather effect for
    --      this player
    if weather_name then

        local pos = player:get_pos()
        if (
            pos.y > weather_top_limit or pos.y < weather_bottom_limit
        ) and (
            player_table[pname]["locked_flag"] == false or
            player_table[pname]["unlock_time"] ~= nil
        ) then

            unilib.atmosphere.reset_weather(pname)
            status = "underground"

        else

            local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}
            local pos_high = {x = pos.x, y = pos.y + open_air_height, z = pos.z}

            if pos.y < sea_level_height then

                if core.get_node(pos_above).name ~= "air" or
                        not core.line_of_sight(pos_above, pos_high) then
                    status = "underground"
                end

            else

                -- N.B. The "cover" sound effects are great under a roof, but sound weird under tree
                --      leaves or even when standing under a non-cube object, like a torch; so this
                --      code block is a bit more complex, than it otherwise would be
                local test_node = core.get_node(pos_above)
                if test_node.name == "air" then

                    local uncovered_flag, covered_pos = core.line_of_sight(pos_above, pos_high)
                    if not uncovered_flag then
                        test_node = core.get_node(covered_pos)
                    end

                end

                if test_node.name ~= "air" and
                        core.get_item_group(test_node.name, "leaves") < 1 then

                    local def_table = core.registered_nodes[test_node.name]
                    if def_table and def_table.walkable then
                        status = "cover"
                    end

                end

            end

        end

    end

    local pname = player:get_player_name()
    if player_table[pname]["status"] == nil or player_table[pname]["status"] ~= status then

        player_table[pname]["status"] = status
        status_change_flag = true

    end

    return status, status_change_flag

end

---------------------------------------------------------------------------------------------------
-- Local functions (weather reset functions)
---------------------------------------------------------------------------------------------------

local function hide_heavens(player)

    -- Called by do_transition() (or any other code)
    -- Hides the stars, sun and moon for the specified player

--  player:set_clouds({density = 0})
    player:set_stars({visible = false})
    player:set_sun({visible = false})
    player:set_moon({visible = false})

end

local function reveal_heavens(player)

    -- Called by reset_sky() (or any other code)
    -- Reveals the stars, sun and moon for the specified player

--  player:set_clouds({density = normal_cloud_density})
    player:set_stars({visible = true})
    player:set_sun({visible = true})
    player:set_moon({visible = true})

end

local function reset_sky(player)

    -- Called by numerous functions
    -- Resets the sky to normal conditions for the specified player

    player:set_sky({
        type = "regular",
        clouds = true,
        fog = {
            fog_start = -1,
            fog_distance = -1,
            fog_colour = fog_default_colour,
        },
    })
    player:set_clouds({
        density = normal_cloud_density,
    })
    player:override_day_night_ratio(nil)

    reveal_heavens(player)

end

---------------------------------------------------------------------------------------------------
-- Local functions (weather embellishments)
---------------------------------------------------------------------------------------------------

local function do_lightning(player)

    -- Called by on_main_tick()
    -- Makes lightning visible (briefly) to the specified "player"

    local sky_table = player:get_sky(true)

    -- Obtain the current sky's colour
    local sky_dark_rgb
    if sky_table.base_color and sky_table.base_color.r then

        sky_dark_rgb = convert_int_to_hex(
            sky_table.base_color.r, sky_table.base_color.g, sky_table.base_color.b
        )

    else

        -- If sky's base colour not obtainable, use the "weather_storm_normal" package's colour
        sky_dark_rgb = lightning_sky_rgb

    end

    -- In debug mode, the lightning should be centred at an exact cardinal direction; otherwise,
    --      the horizontal position is random
    local lightning_x_offset
    if not debug_lightning_flag then
        lightning_x_offset = random(lightning_sky_size - lightning_w)
    else
        lightning_x_offset = tostring((lightning_sky_size - lightning_w) / 2)
    end
    -- N.B. At sea level, the bottom of a 64x128 lightning image is just above the horizon; so
    --      compensate for that by adding a horizontal offset of 2. At a height of y=25, the offset
    --      required to place the lightning image at the horizon would be 16
    -- (The fixed value of "lightning_y_offset" is specified at the top of this file)
    local sky_pos_str = lightning_x_offset .. "," .. lightning_y_offset

    -- Generate the sky background images
    local sky_size_str = tostring(lightning_sky_size) .. "x" .. tostring(lightning_sky_size)
    local template_img = "unilib_template_white.png"

    local sky_dark_img = template_img .. "^[resize:" .. sky_size_str ..
            "^[colorize:" .. sky_dark_rgb
    local sky_flash_img = template_img .. "^[resize:" .. sky_size_str ..
            "^[colorize:" .. lightning_flash_rgb

    -- Choose one of the lightning textures at random
    local random_img = "unilib_weather_lightning_" .. random(lightning_count) .. ".png"

    -- Generate composite images, with lightning on top of the sky background
    -- Strings in the form
    -- "(base.png^[colorize:#RRGGBB^[resize:256x256)^[combine:256x256:64,64=overlay_128.png"
    local composite_dark_img = "(" .. template_img .. "^[colorize:" .. sky_dark_rgb ..
            "^[resize:" .. sky_size_str .. ")^[combine:" .. sky_size_str .. ":" .. sky_pos_str ..
            "=" .. random_img
    local composite_flash_img = "(" .. template_img .. "^[colorize:" .. lightning_flash_rgb ..
            "^[resize:" .. sky_size_str .. ")^[combine:" .. sky_size_str .. ":" .. sky_pos_str ..
            "=" .. random_img

    local dark_img_list, flash_img_list
    if not debug_lightning_flag then

        -- (Randomly place the lightning bolt in of the four cardinal direction; the offset
        --      calculated above has already shifted the bolt a little to the left or right of that
        --      position)
        dark_img_list = {
            sky_dark_img, sky_dark_img, sky_dark_img, sky_dark_img, sky_dark_img, sky_dark_img,
        }
        flash_img_list = {
            sky_flash_img, sky_flash_img, sky_flash_img, sky_flash_img, sky_flash_img, sky_flash_img
        }

        local index = 2 + random(4)
        dark_img_list[index] = composite_dark_img
        flash_img_list[index] = composite_flash_img

    else

        dark_img_list = {
            sky_dark_img,
            sky_dark_img,
            composite_dark_img,
            composite_dark_img,
            composite_dark_img,
            composite_dark_img,
        }

        flash_img_list = {
            sky_flash_img,
            composite_flash_img,
            composite_flash_img,
            composite_flash_img,
            composite_flash_img,
            composite_flash_img
        }

    end

    -- A bright sky (with lightning bolt)...
    player:set_sky({
        type = "skybox",
        textures = flash_img_list,
    })

    -- ...followed by the normal sky (with lightning bolt)
    core.after(lightning_flash_interval, function()

        player:set_sky({
            type = "skybox",
            textures = dark_img_list,
        })

    end)

    -- ...followed by the normal sky (without lightning bolt)
    core.after(lightning_dark_interval, function()
        player:set_sky(sky_table)
    end)

end

---------------------------------------------------------------------------------------------------
-- Local functions (weather transitions)
---------------------------------------------------------------------------------------------------

local function get_cloud_fade_in_params(data_table, trans_table)

    trans_table.cloud_type = "fade_in"

    trans_table.cloud_start = normal_cloud_density
    trans_table.cloud_target = data_table.cloud_density

    return trans_table

end

local function get_cloud_switch_params(data_table, prev_data_table, trans_table)

    trans_table.cloud_type = "switch"

    trans_table.cloud_start = prev_data_table.cloud_density
    trans_table.cloud_target = data_table.cloud_density

    return trans_table

end

local function get_cloud_fade_out_params(prev_data_table, trans_table)

    trans_table.cloud_type = "fade_out"

    trans_table.cloud_start = prev_data_table.cloud_density
    trans_table.cloud_target = normal_cloud_density

    return trans_table

end

local function get_fog_fade_in_params(data_table, trans_table)

    trans_table.fog_type = "fade_in"

    trans_table.fog_near_start = fog_default_near
    trans_table.fog_near_target = data_table.fog_near or fog_default_near
    trans_table.fog_far_start = fog_default_far
    trans_table.fog_far_target = data_table.fog_far or fog_default_far

    if data_table.fog_colour then

        trans_table.fog_colour_sr, trans_table.fog_colour_sg, trans_table.fog_colour_sb =
                convert_hex_to_int(fog_default_colour)
        trans_table.fog_colour_tr, trans_table.fog_colour_tg, trans_table.fog_colour_tb =
                convert_hex_to_int(data_table.fog_colour)

    end

    return trans_table

end

local function get_fog_switch_params(data_table, prev_data_table, trans_table)

    trans_table.fog_type = "switch"

    trans_table.fog_near_start = prev_data_table.fog_near or fog_default_near
    trans_table.fog_near_target = data_table.fog_near or fog_default_near
    trans_table.fog_far_start = prev_data_table.fog_far or fog_default_far
    trans_table.fog_far_target = data_table.fog_far or fog_default_far

    if data_table.fog_colour or prev_data_table.fog_colour then

        trans_table.fog_colour_sr, trans_table.fog_colour_sg, trans_table.fog_colour_sb =
                convert_hex_to_int(prev_data_table.fog_colour or fog_default_colour)
        trans_table.fog_colour_tr, trans_table.fog_colour_tg, trans_table.fog_colour_tb =
                convert_hex_to_int(data_table.fog_colour or fog_default_colour)

    end

    return trans_table

end

local function get_fog_fade_out_params(prev_data_table, trans_table)

    trans_table.fog_type = "fade_out"

    trans_table.fog_near_start = prev_data_table.fog_near or fog_default_near
    trans_table.fog_near_target = fog_default_near
    trans_table.fog_far_start = prev_data_table.fog_far or fog_default_far
    trans_table.fog_far_target = fog_default_far

    if prev_data_table.fog_colour then

        trans_table.fog_colour_sr, trans_table.fog_colour_sg, trans_table.fog_colour_sb =
                convert_hex_to_int(prev_data_table.fog_colour)
        trans_table.fog_colour_tr, trans_table.fog_colour_tg, trans_table.fog_colour_tb =
                convert_hex_to_int(fog_default_colour)

    end

    return trans_table

end

local function get_light_fade_in_params(player, data_table, trans_table)

    local natural_light = core.get_node_light(player:get_pos()) or engine_max_light
    if data_table.max_light and data_table.max_light < natural_light then

        trans_table.light_type = "fade_in"
        trans_table.light_start = natural_light
        trans_table.light_target = data_table.max_light

    end

    return trans_table

end

local function get_light_switch_params(player, data_table, prev_data_table, trans_table)

    local natural_light = core.get_node_light(player:get_pos()) or engine_max_light
    if data_table.max_light or prev_data_table.max_light then

        local light_start = prev_data_table.max_light
        if not light_start or light_start > natural_light then
            light_start = natural_light
        end

        local light_target = data_table.max_light
        if not light_target or light_target > natural_light then
            light_target = natural_light
        end

        -- (If the light level will not change, then we don't need to do transition it at all)
        if light_start ~= light_target then

            trans_table.light_type = "switch"
            trans_table.light_start = light_start
            trans_table.light_target = light_target

        end

    end

    return trans_table

end

local function get_light_fade_out_params(player, prev_data_table, trans_table)

    local natural_light = core.get_node_light(player:get_pos()) or engine_max_light
    if prev_data_table.max_light and prev_data_table.max_light < natural_light then

        trans_table.light_type = "fade_out"
        trans_table.light_start = prev_data_table.max_light
        trans_table.light_target = natural_light

    end

    return trans_table

end

local function get_skybox_fade_in_params(player, mirror_time, data_table, trans_table)

    trans_table.skybox_type = "fade_in"

    trans_table.skybox_colour_sr, trans_table.skybox_colour_sg, trans_table.skybox_colour_sb =
        convert_hex_to_int(
            get_sky_colour(
                mirror_time,
                normal_day_colour,
                normal_night_colour
            )
        )

    trans_table.skybox_colour_tr, trans_table.skybox_colour_tg, trans_table.skybox_colour_tb =
        convert_hex_to_int(
            get_sky_colour(
                mirror_time,
                data_table.sky_colour_list[1],
                data_table.sky_colour_list[2]
            )
        )

    return trans_table

end

local function get_skybox_switch_params(
    player, mirror_time, data_table, prev_data_table, trans_table
)
    trans_table.skybox_type = "switch"

    trans_table.skybox_colour_sr, trans_table.skybox_colour_sg, trans_table.skybox_colour_sb =
        convert_hex_to_int(
            get_sky_colour(
                mirror_time,
                prev_data_table.sky_colour_list[1],
                prev_data_table.sky_colour_list[2]
            )
        )

    trans_table.skybox_colour_tr, trans_table.skybox_colour_tg, trans_table.skybox_colour_tb =
        convert_hex_to_int(
            get_sky_colour(
                mirror_time,
                data_table.sky_colour_list[1],
                data_table.sky_colour_list[2]
            )
        )

    return trans_table

end

local function get_skybox_fade_out_params(player, mirror_time, prev_data_table, trans_table)

    trans_table.skybox_type = "fade_out"

    trans_table.skybox_colour_sr, trans_table.skybox_colour_sg, trans_table.skybox_colour_sb =
        convert_hex_to_int(
            get_sky_colour(
                mirror_time,
                prev_data_table.sky_colour_list[1],
                prev_data_table.sky_colour_list[2]
            )
        )

    trans_table.skybox_colour_tr, trans_table.skybox_colour_tg, trans_table.skybox_colour_tb =
        convert_hex_to_int(
            get_sky_colour(
                mirror_time,
                normal_day_colour,
                normal_night_colour
            )
        )

    return trans_table

end

local function do_transition(player, pname, trans_table, reset_sky_flag)

    -- Called by on_main_tick()
    -- Over a short period of time, performs a weather transition: fading in a new weather effect,
    --      fading out the current weather effect, or smoothly transitioning between one weather
    --      weather effect and another
    -- (The time period is specified by "transition_step_max" and "transition_step_interval")
    --
    -- Args:
    --      player (player): The player for whom the weather effect(s) are visible
    --      trans_table (table): A table of data specifying the beginning ("start" and end
    --          ("target") states of the transition, in the form
    --
    --          .cloud_type
    --              - "fade_in", "switch", "fade_out"
    --          .cloud_start, .cloud_target
    --              - Value in range 0 (no clouds) to 1 (maximum clouds)
    --
    --          .fog_type
    --              - "fade_in", "switch", "fade_out"
    --              - N.B. The fog parameters are independent; default values are used for any
    --                  unspecified fields
    --          .fog_near_start, .fog_near_target
    --              - Fraction of visible at which fogs starts to be rendered. Matches the engine's
    --                  .fog_start field
    --          .fog_far_start, .fog_far_target
    --              - Integer, sets an upper bound for the client's viewing range. Matches the
    --                  engine's .fog_distance field
    --          .fog_colour_sr, .fog_colour_sg, .fog_colour_sb
    --          .fog_colour_tr, .fog_colour_tg, .fog_colour_tb
    --              - Start and target RGB values (in the range 0-255). When converted to "#ABCDEF",
    --                  tatches the engine's .fog_color field
    --
    --          .light_type
    --              - "fade_in", "switch", "fade_out"
    --          .light_start, .light_target
    --              - Value in range 0 (no light) to 15 (engine maximum light)
    --
    --          .skybox_type
    --              - "fade_in", "switch", "fade_out"
    --          .skybox_colour_sr, .skybox_colour_sg, .skybox_colour_sb
    --          .skybox_colour_tr, .skybox_colour_tg, .skybox_colour_tb
    --              - Start and target RGB values (in the range 0-255). Matches the engine's
    --                  .fog_color field. When converted to "#ABCDEF", matches the engine's
    --                  .base_color field
    --
    --      reset_sky_flag (bool): true when a weather effect is being faded out; causes a call to
    --          reset_sky() at the end of the transition

    local step = 0

    local function update()

        -- (This enclosed function is called at the start of the transition, and then calls itself
        --      recursively for the duration of the transition)
        step = step + 1

        -- If the player leaves the server during a transition, then obviously don't continue it
        if not core.get_player_by_name(pname) then
            return
        end

        -- A table of paramenters representing the sky's momentary appearance, to be used in an
        --      imminent call to player:set_sky()
        -- Table with the parameters
        --      .type, .base_color, .clouds, .fog
        local sky_table = {clouds = true}
        -- Paramter defining the cloud density (a value in the range 0-1, or nil if not required)
        local cloud_density
        -- Parameter defining the light (a value in the range 0 to "engine_max_light", or nil if not
        --      required)
        local light_density
        -- A fractional value (range 0-1) representing how much of the transition has been
        --      performed, as of this call
        local factor = step / transition_step_max

        -- Prepare cloud parameters
        if trans_table.cloud_type then

            if step == transition_step_max then

                cloud_density = trans_table.cloud_target

            elseif trans_table.cloud_start < trans_table.cloud_target then

                cloud_density = trans_table.cloud_start +
                        ((trans_table.cloud_target - trans_table.cloud_start) * factor)

            else

                cloud_density = trans_table.cloud_target +
                        ((trans_table.cloud_start - trans_table.cloud_target) * (1 - factor))

            end

            if cloud_density == 0 then
                sky_table.clouds = false
            end

        end

        -- Prepare fog parameters
        if trans_table.fog_type then

            local fog_start, fog_distance, fog_colour

            if step == transition_step_max then

                fog_start = trans_table.fog_near_target

            elseif trans_table.fog_near_start < trans_table.fog_near_target then

                fog_start = trans_table.fog_near_start +
                        ((trans_table.fog_near_target - trans_table.fog_near_start) * factor)

            else

                fog_start = trans_table.fog_near_target +
                        ((trans_table.fog_near_start - trans_table.fog_near_target) * (1 - factor))

            end

            if step == transition_step_max then

                fog_distance = trans_table.fog_far_target

            elseif trans_table.fog_far_start < trans_table.fog_far_target then

                fog_distance = trans_table.fog_far_start +
                        ((trans_table.fog_far_target - trans_table.fog_far_start) * factor)

            else

                fog_distance = trans_table.fog_far_target +
                        ((trans_table.fog_far_start - trans_table.fog_far_target) * (1 - factor))

            end

            if not trans_table.fog_colour_sr then

                fog_colour = fog_default_colour

            else

                local ir, ig, ib
                ir = trans_table.fog_colour_sr +
                        ((trans_table.fog_colour_tr - trans_table.fog_colour_sr) * factor)
                ig = trans_table.fog_colour_sg +
                        ((trans_table.fog_colour_tg - trans_table.fog_colour_sg) * factor)
                ib = trans_table.fog_colour_sb +
                        ((trans_table.fog_colour_tb - trans_table.fog_colour_sb) * factor)
                fog_colour = convert_int_to_hex(ir, ig, ib)

            end

            if step == transition_step_max and trans_table.fog_type == "fade_out" then

                -- (At the end of a transition, faded out fog disappears completely)
                sky_table.fog = {
                    fog_start = -1,
                    fog_distance = -1,
                    fog_colour = fog_default_colour,
                }

            else

                sky_table.fog = {
                    fog_start = fog_start,
                    fog_distance = fog_distance,
                    fog_color = fog_colour,
                }

            end

        end

        -- Prepare light parameters
        if trans_table.light_type then

            if step == transition_step_max then

                light_density = trans_table.light_target

            elseif trans_table.light_start < trans_table.light_target then

                light_density = trans_table.light_start +
                        ((trans_table.light_target - trans_table.light_start) * factor)

            else

                light_density = trans_table.light_target +
                        ((trans_table.light_start - trans_table.light_target) * (1 - factor))

            end

        end

        -- Prepare skybox parameters
        if trans_table.skybox_type then

            local ir, ig, ib
            ir = trans_table.skybox_colour_sr +
                    ((trans_table.skybox_colour_tr - trans_table.skybox_colour_sr) * factor)
            ig = trans_table.skybox_colour_sg +
                    ((trans_table.skybox_colour_tg - trans_table.skybox_colour_sg) * factor)
            ib = trans_table.skybox_colour_sb +
                    ((trans_table.skybox_colour_tb - trans_table.skybox_colour_sb) * factor)

            sky_table.type = "plain"
            sky_table.base_color = convert_int_to_hex(ir, ig, ib)

        else

            sky_table.type = "regular"

        end

        -- Set the appearance of the sky
        player:set_sky(sky_table)
        if cloud_density ~= nil then
            player:set_clouds({density = cloud_density})
        end

        -- (Set an artificial light level; or cancel the existing artificial light level, if it has
        --      been applied)
        if light_density ~= nil then
            player:override_day_night_ratio(light_density / engine_max_light)
        elseif player:get_day_night_ratio() then
            player:override_day_night_ratio(nil)
        end

        if step < transition_step_max then

            -- Call this enclosed function recursively, until the end of the transition
            core.after(transition_step_interval, update)

        else

            -- The end of the transition
            player_table[pname]["transition_flag"] = false

            if reset_sky_flag then

                -- (If the player now has no weather effect, guarantee that the sky has been
                --      returned to its normal state)
                core.after(transition_step_interval, function()
                    reset_sky(player)
                end)

            elseif sky_table.type == "plain" then

                -- (The transition looks a little smoother if stars etc are hidden at the end of the
                --      transition, rather than at the beginning of it)
                hide_heavens(player)

            end

        end

    end

    -- The main loop in on_main_tick() won't start a new transition, until this one is finished
    player_table[pname]["transition_flag"] = true
    -- Call the enclosed function for the first time
    update()

end

---------------------------------------------------------------------------------------
-- Local functions (wind calculations)
---------------------------------------------------------------------------------------------------

local function convert_radians_to_compass_direction(angle)

    -- Called by set_wind()
    -- Converts an angle in radians, in the range 0 - 2*pi, into a string like "north"

    angle = angle % (2 * pi)
    local index = floor(angle / (2 * pi) * 16) + 1

    return compass_dir_list[index]

end

local function get_wind_speed_range(weather_name)

    -- Called by set_wind()
    -- Returns the maximum and minimum wind speeds for the specified weather effect (if any), or
    --      otherwise the default maximum/minimum values

    local max_wind_speed = default_max_wind_speed
    local min_wind_speed = default_min_wind_speed

    if weather_name then

        local data_table = weather_effect_table[weather_name]

        if data_table.max_wind_speed then
            max_wind_speed = data_table.max_wind_speed
        end

        if data_table.min_wind_speed then
            min_wind_speed = data_table.min_wind_speed
        end

    end

    return max_wind_speed, min_wind_speed

end

local function get_wind_speed(pos, t, max_wind_speed, min_wind_speed)

    -- Called by set_wind()
    -- Gets the wind speed for the specified position and time ("t" specifies the "long" timer's
    --      current cycle)

    -- Generate wind speed
    local current_speed
    if max_wind_speed == min_wind_speed or max_wind_speed < min_wind_speed then

        -- Special case - wind speed doesn't vary
        return max_wind_speed

    end

    -- Wind speed varies with fractal noise
    local noise_val = abs(
        wind_noise:get_2d({
            x = pos.x + (t / wind_speed_variable_factor),
            y = pos.z,
        })
    )

    if noise_val > 1 then
        noise_val = 1
    end

    -- (Squaring a fractional value introduces a bias towards calm winds)
    return floor((noise_val * noise_val) * (max_wind_speed - min_wind_speed)) + min_wind_speed

end

local function get_wind_angle(pos, t)

    -- Called by set_wind()
    -- Gets the wind angle for the specified position and time ("t" specifies the "long" timer's
    --      current cycle)

    local noise_val = abs(
        wind_noise:get_2d({
            x = pos.x,
            y = pos.z + (t / wind_dir_variable_factor),
        })
    )

    if noise_val > 1 then
        noise_val = 1
    end

    return pi * 2 * noise_val

end

local function set_wind(pname, pos, t)

    -- Called by on_long_tick()
    -- Sets the wind speed and direction for the specified player, at the specified position, at
    --      the "long" timer cycle specified by "t"
    -- Updates "player_table" with the new values

    -- Get wind speed range, given the player's current weather effect
    local weather_name = player_table[pname]["current_weather"]
    local max_wind_speed, min_wind_speed = get_wind_speed_range(weather_name)

    -- Get wind speed at the specified position
    local target_speed = get_wind_speed(pos, t, max_wind_speed, min_wind_speed)
    -- (In case of switching between weather effects with radically different max/min wind speeds,
    --      speeds, approach the target semi-smoothly)
    local current_speed = player_table[pname]["wind_speed"]
    local diff = target_speed - current_speed
    if abs(diff) > wind_smoothness_limit then

        -- Approach the target semi-smoothly. Because of the duration of the cycle used by
        --      on_long_tick(), the smoothness doesn't need to be very smooth (a jump of, say,
        --      10kph is acceptable)

        -- (e.g. wind_smoothness_ratio = 0.2 = 20%, so increase speed by 10-30% of the difference on
        --      this step)
        local jump = (random() * wind_smoothness_ratio) + (wind_smoothness_ratio / 2)
        if current_speed < target_speed then

            current_speed = current_speed + ceil(diff * jump)
            -- (Don't exceed the target - it might be the maximum)
            if current_speed > target_speed then
                current_speed = target_speed
            end

        else

            current_speed = current_speed + floor(diff * jump)
            if current_speed < target_speed then
                current_speed = target_speed
            end

        end

    else

        -- The change in wind speed isn't so big, so just use the target speed
        current_speed = target_speed

    end

    -- Generate wind direction (we can re-use the same fractal noise, just decorrelating it)
    local current_angle = get_wind_angle(pos, t)

    -- Register the new values
    player_table[pname]["wind_angle"] = current_angle
    player_table[pname]["wind_dir"] = convert_radians_to_compass_direction(current_angle)
    player_table[pname]["wind_speed"] = current_speed

end

---------------------------------------------------------------------------------------
-- Local functions (weather selection)
---------------------------------------------------------------------------------------------------

local function get_climate_probability(data_table, pos)

    -- Called by select_weather_prototype()
    -- "data_table" is the definition of a particular weather prototype (the value of a key in
    --      "weather_prototype_table")
    -- Each weather prototype specifies the probability that they it will apply at any given heat,
    --      humidity or elevation; calculate the combined probability for the specified position
    --      "pos"

    local function lerp(y0, y1, x)

        local y = y0 + (y1 - y0) * (x / 100)
        if y < 0 then
            y = 0
        elseif y > 1 then
            y = 1
        end

        return y

    end

    local heat_prob = lerp(
        data_table.heat_min_prob,
        data_table.heat_max_prob,
        core.get_heat(pos)
    )

    local humid_prob = lerp(
        data_table.humid_min_prob,
        data_table.humid_max_prob,
        core.get_humidity(pos)
    )

    local height_prob = lerp(
        data_table.height_min_prob,
        data_table.height_max_prob,
        pos.y
    )

    return heat_prob * humid_prob * height_prob * climate_boost_factor

end

local function select_weather_prototype(pos, t)

    -- Called by check_weather() and unilib.atmosphere.sample_weather()
    -- Use fractal noise to select one of the available weather prototypes, returning its name (a
    --      key in "weather_prototype_table")
    -- "pos" is the position at which a weather prototype must be selected, and "t" specifies the
    --      "long" timer's current cycle

    -- The "dominant" weather prototype is the one whose noise at this horizontal position has the
    --      highest value (above a minimum threshold)
    local prototype_name, data_table, highest_noise

    local granular_t = t / time_granularity_factor
    local granular_pos = {
        x = floor(pos.x / posn_granularity_factor),
        y = floor(pos.y / posn_granularity_factor),
        z = floor(pos.z / posn_granularity_factor),
    }

    for this_prototype, this_data_table in pairs(weather_prototype_table) do

        local noise_val = abs(
            this_data_table.noise:get_3d({
                x = granular_pos.x,
                y = granular_t,
                z = granular_pos.z,
            })
        )

        if noise_val > general_noise_threshold and
                (not highest_noise or highest_noise < noise_val) then

            prototype_name = this_prototype
            data_table = this_data_table
            highest_noise = noise_val

        end

    end

    if not prototype_name then

        -- No weather prototypes exceed the threshold
        return

    end

    -- Does the dominant prototye suit the specified position's climate (taking into account heat,
    --      humidity and elevation)
    local noise_val = abs(
        climate_noise:get_3d({
            x = granular_pos.x,
            y = granular_pos.y + granular_t,
            z = granular_pos.z,
        })
    )

    -- N.B. Function called deliberately with "pos", not "granular_pos"
    local comb_prob = get_climate_probability(data_table, pos)
    if noise_val < comb_prob then
        return prototype_name
    end

end

local function select_weather_effect(pos, t, prototype_name)

    -- Called by check_weather() and unilib.atmosphere.sample_weather()
    -- Use fractal noise to select one of the weather effects belong to the specified weather
    --      prototype, returning its name (a key in "weather_effect_table")
    -- "pos" is the position at which a weather prototype must be selected, and "t" specifies the
    --      "long" timer's current cycle

    -- Compile a list of weather effects, weighted by their relative probability
    -- List of mini-lists, each in the form [ weather_effect_name, combined_chance], where
    --      "combined_chance" is the chance for this weather effect, and all effects earlier
    --      in the list, combined
    local effect_list = {}
    local total_chance = 0

    for _, weather_name in ipairs(weather_prototype_table[prototype_name]["effect_list"]) do

        local data_table = weather_effect_table[weather_name]
        total_chance = total_chance + data_table.chance
        table.insert(effect_list, {weather_name, total_chance})

    end

    -- If "effect_list" contains at least one weather effect, then choose one
    if total_chance > 0 then

        -- (Convert a noise value to a uniform distribution)
        local probability = total_chance * convert_noise_to_uniform_distribution(
            abs(
                selection_noise:get_3d({
                    x = pos.x,
                    y = t,
                    z = pos.z,
                })
            )
        )

        for _, mini_list in ipairs(effect_list) do

            if mini_list[2] >= probability then
                return mini_list[1]
            end

        end

    end

end

local function check_weather(player, pname, t)

    -- Called by on_main_tick() and on_long_tick()
    -- Over time, enable, switch or disable weather effects for the specified player
    -- "t" specifies the "long" timer's current cycle

    -- Select a weather prototype at this position (the choice, all other things being equal,
    --      varying over time)
    local pos = player:get_pos()
    local prototype_name, weather_name

    prototype_name = select_weather_prototype(pos, t)
    if prototype_name then
        weather_name = select_weather_effect(pos, t, prototype_name)
    end

    if weather_name then

        if player_table[pname]["current_weather"] == nil then

            unilib.atmosphere.set_weather(pname, weather_name)
            if player_table[pname]["locked_flag"] == true then
                unilib.atmosphere.set_weather_unlock_time(pname)
            end
            if debug_log_flag then

                unilib.utils.show_msg(
                    msg_path .. "WEATHER ON: " .. pname .. " - " .. weather_name
                )

            end

        elseif player_table[pname]["current_weather"] ~= weather_name then

            unilib.atmosphere.set_weather(pname, weather_name)
            if player_table[pname]["locked_flag"] == true then
                unilib.atmosphere.set_weather_unlock_time(pname)
            end
            if debug_log_flag then

                unilib.utils.show_msg(
                    msg_path .. "WEATHER SWITCH: " .. pname .. " - " .. weather_name
                )

            end

        end

    elseif player_table[pname]["current_weather"] ~= nil then

        if debug_log_flag then

            unilib.utils.show_msg(
                msg_path .. "WEATHER OFF: " .. pname .. " - " ..
                    player_table[pname]["current_weather"]
            )

        end

        -- Disable current weather effect
        unilib.atmosphere.reset_weather(pname)

    end

end

---------------------------------------------------------------------------------------
-- Local functions (ambient effect selection)
---------------------------------------------------------------------------------------------------

local function check_biomes_for_ambient_effects(pos, data_table)

    -- Called by select_ambient_effect()
    -- "data_table" is a value in "ambient_effect_table", representing the definition of a single
    --      ambient effect
    -- If "data_table" specifies biomes, check whether the specified position is in one of those
    --      biomes

    -- If the ambient effect specifies no biomes, then the effect can be played in any biome (hence
    --      we return true), and we don't need to poll core.get_biome_data()
    if #data_table.biome_list == 0 then
        return true
    end

    local bdata = core.get_biome_data(pos)
    local biome_name = core.get_biome_name(bdata.biome)

    for _, other_biome_name in ipairs(data_table.biome_list) do

        if other_biome_name == biome_name then
            return true
        end

    end

    return false

end

local function check_nodes_for_ambient_effects(pos, data_table)

    -- Called by select_ambient_effect()
    -- "data_table" is a value in "ambient_effect_table", representing the definition of a single
    --      ambient effect
    -- If "data_table" specifies nodes, check whether one of the nodes exists near the specified
    --      position

    -- (Don't need to poll core.find_node_near(), if the ambient effect specifies no nodes)
    if #data_table.node_list == 0 then
        return true
    end

    if core.find_node_near(pos, ambient_search_radius, data_table.node_list, true) then
        return true
    else
        return false
    end

end

local function select_ambient_effect(pos)

    -- Each ambient effect (a key-value pair in "ambient_effect_table") specifies any number of
    --      play-once sounds (.single_list), and any number of repeating sounds (.repeat_list)
    -- Each item in .single_list and .repeat_list is a Minetest SimpleSoundSpec table
    -- Return two values - a random choice from each list, each of which may be nil if no sounds are
    --      available at the specified position

    local single_spec_list = {}
    local repeat_spec_list = {}

    for _, data_table in pairs(ambient_effect_table) do

        if check_biomes_for_ambient_effects(pos, data_table) and
                check_nodes_for_ambient_effects(pos, data_table) and
                (not data_table.play_func or data_table.play_func(pos) == true) then

            if #data_table.single_list > 0 and random() < data_table.single_prob then

                table.insert(
                    single_spec_list, data_table.single_list[random(#data_table.single_list)]
                )

            end

            if #data_table.repeat_list > 0 and random() < data_table.repeat_prob then

                table.insert(
                    repeat_spec_list, data_table.repeat_list[random(#data_table.repeat_list)]
                )

            end

        end

    end

    -- If each list contains, by chance, more than one SimpleSoundSpec, choose one at random
    local single_spec, repeat_spec
    if #single_spec_list then
        single_spec = single_spec_list[random(#single_spec_list)]
    end
    if #repeat_spec_list then
        repeat_spec = repeat_spec_list[random(#repeat_spec_list)]
    end

    return single_spec, repeat_spec

end

---------------------------------------------------------------------------------------
-- Local functions (main loop)
---------------------------------------------------------------------------------------------------

local function on_mini_tick(player, pname, mirror_time, data_table, status, status_change_flag)

    -- Called by on_main_tick() for every player with a current weather effect
    -- This is an artificial "mini" timer, running at twice the speed of the "main" timer so that
    --      transitions are smoother
    -- (Using one timer instead of two separate ones solves a lot of code complexity problems)
    -- Update the skybox colour, light levels, player status and/or sound effects

    if data_table.sky_colour_list and
            mirror_time > transition_min_time and
            transition_min_time < transition_max_time then

        -- Update the skybox colour, according to the time of day (but only around dawn and dusk)
        player:set_sky({
            type = "plain",
            base_color = get_sky_colour(
                mirror_time,
                data_table.sky_colour_list[1],
                data_table.sky_colour_list[2]
            ),
        })

    end

    if data_table.max_light then

        -- Adjust the light level, if necessary
        adjust_light_level(player, data_table)

    end

    if status_change_flag then

        -- Player has moved from open air to cover, or vice-versa (etc)
        -- Fade out the current sound effect, if any
        if player_table[pname]["sound"] then
            stop_sound(pname)
        end

        -- Fade in the sound effect for the player's new status, if any
        if data_table.sound_table and data_table.sound_table[status] then
            start_weather_sound(pname, data_table.sound_table[status])
        end

    end

end

local function on_main_tick()

    -- Main loop for weather, called once a second by core.register_globalstep()
    -- Handles transitions between weather effects and generates particles

    -- Time value used in the transition between day/night sky/cloud colours, in the range 0-0.5
    local mirror_time = get_mirror_time()

    -- Check weather for all connected players
    for _, player in ipairs(core.get_connected_players()) do

        local pname = player:get_player_name()

        local weather_name = player_table[pname]["current_weather"]
        local data_table = {}
        if weather_name and weather_effect_table[weather_name] then
            data_table = weather_effect_table[weather_name]
        end

        local prev_weather_name = player_table[pname]["prev_weather"]
        local prev_data_table = {}
        if prev_weather_name and weather_effect_table[prev_weather_name] then
            prev_data_table = weather_effect_table[prev_weather_name]
        end

        -- Check whether the player is in the open air, under cover, or underground, updating
        --      "player_table"
        local status, status_change_flag = update_player_status(player, pname, weather_name)

        -- Enable a new weather effect and/or disable the existing one (but don't interfere with an
        --      on-going transition)
        if player_table[pname]["transition_flag"] == false then

            if player_table[pname]["update_flag"] == true then

                player_table[pname]["update_flag"] = false

                -- If the new weather effect (if any) specifies some probability of a fog, decide
                --      now whether it's going to apply, or not
                local old_fog_flag = player_table[pname]["fog_flag"]
                local new_fog_flag = false
                if weather_name and
                        data_table.fog_probability and
                        random() < data_table.fog_probability then
                    new_fog_flag = true
                end

                local trans_table = {}
                if not weather_name then

                    -- Disable weather effects

                    if prev_data_table.cloud_density then

                        trans_table = get_cloud_fade_out_params(prev_data_table, trans_table)
                        player_table[pname]["cloud_flag"] = false

                    end

                    if old_fog_flag then

                        trans_table = get_fog_fade_out_params(prev_data_table, trans_table)
                        player_table[pname]["fog_flag"] = false

                    end

                    if prev_data_table.max_light then

                        trans_table =
                                get_light_fade_out_params(player, prev_data_table, trans_table)
                        player_table[pname]["light_flag"] = false

                    end

                    if prev_data_table.sky_colour_list then

                        trans_table = get_skybox_fade_out_params(
                            player, mirror_time, prev_data_table, trans_table
                        )

                        player_table[pname]["skybox_flag"] = false

                    end

                    if unilib.utils.is_table_empty(trans_table) then

                        -- No transition required (and the previous sound effect, if any, has
                        --      already been faded out)
                        -- For safety's sake, sure that a normal sky is visible to the player
                        reset_sky(player)

                    else

                        -- Transition required; the "true" flag tells the transition code to call
                        --      reset_sky() at the end of the transition
                        do_transition(player, pname, trans_table, true)

                    end

                elseif not prev_weather_name then

                    -- Enable weather effects

                    if data_table.cloud_density then

                        trans_table = get_cloud_fade_in_params(data_table, trans_table)
                        player_table[pname]["cloud_flag"] = true

                    end

                    if new_fog_flag then

                        trans_table = get_fog_fade_in_params(data_table, trans_table)
                        player_table[pname]["fog_flag"] = true

                    end

                    if data_table.max_light then

                        trans_table = get_light_fade_in_params(player, data_table, trans_table)
                        player_table[pname]["light_flag"] = true

                    end

                    if data_table.sky_colour_list then

                        trans_table = get_skybox_fade_in_params(
                            player, mirror_time, data_table, trans_table
                        )

                    end

                    if unilib.utils.is_table_empty(trans_table) then

                        -- No transition required
                        -- For safety's sake, sure that a normal sky is visible to the player
                        reset_sky(player)

                    else

                        -- Transition required
                        do_transition(player, pname, trans_table)

                    end

                    -- Fade in the new sound effect, if any
                    if data_table.sound_table and data_table.sound_table[status] then
                        start_weather_sound(pname, data_table.sound_table[status])
                    end

                else

                    -- Switch weather effects

                    if data_table.cloud_density and prev_data_table.cloud_density then

                        trans_table = get_cloud_switch_params(
                            data_table, prev_data_table, trans_table
                        )

                    elseif data_table.cloud_density then

                        trans_table = get_cloud_fade_in_params(data_table, trans_table)
                        player_table[pname]["cloud_flag"] = true

                    elseif prev_data_table.cloud_density then

                        trans_table = get_cloud_fade_out_params(prev_data_table, trans_table)
                        player_table[pname]["cloud_flag"] = false

                    end

                    if new_fog_flag and old_fog_flag then

                        trans_table = get_fog_switch_params(
                            data_table, prev_data_table, trans_table
                        )

                    elseif new_fog_flag then

                        trans_table = get_fog_fade_in_params(data_table, trans_table)
                        player_table[pname]["fog_flag"] = true

                    elseif old_fog_flag then

                        trans_table = get_fog_fade_out_params(prev_data_table, trans_table)
                        player_table[pname]["fog_flag"] = false

                    end

                    if data_table.max_light and prev_data_table.max_light then

                        trans_table = get_light_switch_params(
                            player, data_table, prev_data_table, trans_table
                        )

                    elseif data_table.max_light then

                        trans_table = get_light_fade_in_params(player, data_table, trans_table)
                        player_table[pname]["light_flag"] = true

                    elseif prev_data_table.max_light then

                        trans_table =
                                get_light_fade_out_params(player, prev_data_table, trans_table)
                        player_table[pname]["light_flag"] = false

                    end

                    if data_table.sky_colour_list and prev_data_table.sky_colour_list then

                        trans_table = get_skybox_switch_params(
                            player, mirror_time, data_table, prev_data_table, trans_table
                        )

                    elseif data_table.sky_colour_list then

                        trans_table = get_skybox_fade_in_params(
                            player, mirror_time, data_table, trans_table
                        )
                        player_table[pname]["light_flag"] = true

                    elseif prev_data_table.sky_colour_list then

                        trans_table = get_skybox_fade_out_params(
                            player, mirror_time, prev_data_table, trans_table
                        )
                        player_table[pname]["light_flag"] = false

                    end

                    if unilib.utils.is_table_empty(trans_table) then

                        -- No transition required
                        -- For safety's sake, sure that a normal sky is visible to the player
                        reset_sky(player)

                    else

                        -- Transition required
                        do_transition(player, pname, trans_table)

                    end

                    -- Fade in the new sound effect, if any
                    if data_table.sound_table and data_table.sound_table[status] then
                        start_weather_sound(pname, data_table.sound_table[status])
                    end

                end

            elseif weather_name then

                -- An artificial "mini" timer, running at twice the speed of the "main" timer that
                --      called this function
                -- (Using one timer instead of two separate ones solves a lot of complexity
                --      problems)
                on_mini_tick(player, pname, mirror_time, data_table, status, status_change_flag)

                core.after((main_timer_tick / 2), function()

                    local status, status_change_flag =
                            update_player_status(player, pname, weather_name)
                    on_mini_tick(
                        player, pname, mirror_time, data_table, status, status_change_flag
                    )

                end)

                -- Display lightning bolts periodically
                if data_table.lightning_probability and (
                    debug_lightning_flag or
                    random() < data_table.lightning_probability
                ) then
                    do_lightning(player)
                end

                -- If the player has moved too far from their position, at the time the current
                --      weather effect started, then we can unlock it
                if player_table[pname]["locked_flag"] and player_table[pname]["orig_pos"]then

                    local dist = vector.distance(player:get_pos(), player_table[pname]["orig_pos"])
                    if dist > min_weather_range then

                        player_table[pname]["locked_flag"] = false
                        check_weather(player, pname, get_time_value_for_fractal_noise(os.time()))

                    end

                end

            end

        end

        if weather_name and status ~= "underground" then

            local ppos = player:get_pos()

            -- Generate particles on each tick
            if data_table.particle_func then

                data_table.particle_func(
                    pname,
                    ppos,
                    player_table[pname]["wind_speed"],
                    player_table[pname]["wind_angle"]
                )

            end

            -- Deposit things on the ground (e.g. snowfall, puddles) on each tick
            if data_table.ground_func then
                data_table.ground_func(pname, ppos)
            end

        end

    end

end

local function on_long_tick()

    -- Weather selection loop, running considerably more slowly than the "main" loop handled by
    --      on_main_tick(), called periodically by core.register_globalstep()
    -- For all online players, enable, switch or disable a weather effect, and set the wind speed
    --      and direction

    -- Number of intervals since epoch, ignore all but last 4 digits
    local t = get_time_value_for_fractal_noise(os.time())

    for _, player in ipairs(core.get_connected_players()) do

        local pname = player:get_player_name()
        local pos = player:get_pos()

        -- If the minimum time for this weather effect has expired, unlock it (enabling switching to
        --      a different effect, or turning off the weather effect)
        if player_table[pname]["locked_flag"] and
                player_table[pname]["unlock_time"] and
                os.time() > player_table[pname]["unlock_time"] then
            player_table[pname]["locked_flag"] = false
        end

        -- Decide whether to enable, disable or switch weather effects for this player
        if not player_table[pname]["locked_flag"] and
                pos.y <= weather_top_limit and
                pos.y >= weather_bottom_limit then
            check_weather(player, pname, t)
        end

        -- Set wind for this cycle
        if unilib.setting.atmosphere_wind_enable_flag and pos.y >= weather_bottom_limit then
            set_wind(pname, pos, t)
        end

    end

end

local function on_ambient_tick()

    -- Check ambient effects for all connected players
    for _, player in ipairs(core.get_connected_players()) do

        local pname = player:get_player_name()
        local pos = player:get_pos()

        local single_spec, repeat_spec  = select_ambient_effect(player:get_pos())
        -- "single" and "repeat" sounds can play simultaneously, but they don't start at the
        --      same time
        if repeat_spec and player_table[pname]["sound"] == nil then
            start_ambient_sound(pname, repeat_spec, true)
        elseif single_spec then
            start_ambient_sound(pname, single_spec, false)
        end

    end

end

local function on_environment_tick()

    -- Check environment effects for all connected players
    for _, player in ipairs(core.get_connected_players()) do

        local pname = player:get_player_name()
        local pos = player:get_pos()
        local ppos = vector.add(pos, player:get_properties().eye_height)
        local area_min = vector.subtract(ppos, environment_search_radius)
        local area_max = vector.add(ppos, environment_search_radius)

        local node_table = core.find_nodes_in_area(area_min, area_max, environment_cache_list, true)
        if next(node_table) == nil then -- If table empty
            return
        end

        for _, data_table in pairs(environment_effect_table) do

            -- Find average position
            local avg_pos = {0, 0, 0}
            local count = 0
            for _, full_name in ipairs(data_table.node_list) do

                if node_table[full_name] then

                    for _, p in ipairs(node_table[full_name]) do

                        avg_pos[1] = avg_pos[1] + p.x
                        avg_pos[2] = avg_pos[2] + p.y
                        avg_pos[3] = avg_pos[3] + p.z

                    end

                    count = count + #node_table[full_name]

                end

            end

            if count > 0 then

                -- Re-calculate average position
                avg_pos = vector.new(avg_pos[1] / count, avg_pos[2] / count, avg_pos[3] / count)

                -- Calculate gain
                local gain = data_table.base_volume
                if data_table.node_volume then

                    gain = gain + (count * data_table.node_volume)

                elseif data_table.node_volume_table then

                    for full_name, multiplier in pairs(data_table.node_volume_table) do

                        if node_table[full_name] then
                            gain = gain + #node_table[full_name] * multiplier
                        end

                    end

                end

                gain = min(gain, data_table.max_volume)

                core.sound_play(
                    data_table.sound,
                    {
                        to_player = pname,
                        pos = avg_pos,
                        gain = gain,
                    },
                    true
                )

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (weather effects)
---------------------------------------------------------------------------------------------------

function unilib.atmosphere.register_sky_colours(day_colour, night_colour)

    -- Weather effects using skyboxes (to simulate overcast skies) fade the new colour in or out,
    --      assuming that the player can see the engine's default sky colours (blue during the day,
    --      and black at night)
    -- If the those default sky colours have been changed by some part of the code, that code
    --      should call this function to register the changes, so that transitions continue to work
    --      as intended
    -- "day_colour" and "night_colour" are hex values, e.g. "#ABCDEF"

    normal_day_colour = day_colour
    normal_night_colour = night_colour

end

function unilib.atmosphere.unregister_sky_colours()

    -- After an earlier call to unilib.atmosphere.register_sky_colours(), call this function to
    --      reset the expected sky colours back to their defaults

    normal_day_colour = default_day_colour
    normal_night_colour = default_night_colour

end

function unilib.atmosphere.register_cloud_density(cloud_density)

    -- Weather effects using skyboxes typically obscure clouds by reducing their density to zero
    -- The engine's default density for clouds is 0.4; if that value has been changed by some part
    --      of the code, that code should call this function to register the new default density

    normal_cloud_density = cloud_density

end

function unilib.atmosphere.unregister_cloud_density()

    -- After an earlier call to unilib.atmosphere.register_cloud_density(), call this function to
    --      reset the expected cloud density back to its default

    normal_cloud_density = default_cloud_density

end

function unilib.atmosphere.register_weather_prototype(prototype_name, data_table)

    -- Called by any weather prototype package
    -- Registers a weather prototype
    --
    -- "prototype_name" can be any string (duplicate names will generate an error)
    -- For the format of "data_table", see the comments at the top of this file. This function
    --      supplies default key-value pairs, if "data_table" does not specify them (so "data_table"
    --      may be an empty table). Note that the .noise field cannot be calculated now (it's
    --      calculated later), so it should not be specified in calls to this function

    -- Basic checks
    if weather_prototype_table[prototype_name] ~= nil then
       return unilib.utils.show_error(msg_path .. "Duplicate weather prototype", prototype_name)
    end

    -- Apply default values, if not specified
    if data_table.noise_table == nil then

        data_table.noise_table = {
            lacunarity = 2.0,
            octaves = 3,
            offset = 0,
            persistence = 0.5,
            scale = 1,
            spread = {x = 100, y = 100, z = 100},
            -- N.B. By convention, prototype should use a seed in the range 0-1000, because the
            --      seeds used in the core.after() code below are in the range 1001+
            seed = random(1000),
        }

    end

    if data_table.description == nil then
        data_table.description = prototype_name
    end

    if data_table.heat_min_prob == nil then
        data_table.heat_min_prob = 0.5
    end

    if data_table.heat_max_prob == nil then
        data_table.heat_max_prob = 0.5
    end

    if data_table.humid_min_prob == nil then
        data_table.humid_min_prob = 0.5
    end

    if data_table.humid_max_prob == nil then
        data_table.humid_max_prob = 0.5
    end

    if data_table.height_min_prob == nil then
        data_table.height_min_prob = 0.5
    end

    if data_table.height_max_prob == nil then
        data_table.height_max_prob = 0.5
    end

    -- Register the weather prototype
    weather_prototype_table[prototype_name] = data_table

end

function unilib.atmosphere.register_weather(weather_name, prototype_name, data_table)

    -- Called by any weather effect package
    -- Registers a weather effect
    --
    -- "weather_name" and "prototype_name" can be any string (duplicate names will generate an
    --      error)
    -- For the format of "data_table", see the comments above. This function supplies an empty table
    --      as the value of data_table.tag_list, and 1 as the value of .chance, if they are not
    --      specified; otherwise all key-value pairs are optional, having the value nil if not
    --      specified

    -- Basic checks
    if weather_effect_table[weather_name] ~= nil then
       return unilib.utils.show_error(msg_path .. "Duplicate weather effect", weather_name)
    elseif weather_prototype_table[prototype_name] == nil then
       return unilib.utils.show_error(msg_path .. "Unregistered weather prototype", prototype_name)
    end

    -- Apply default values, if not specified
    if data_table.description == nil then
        data_table.description = weather_name
    end

    if data_table.max_light ~= nil and (
        data_table.max_light < 0 or data_table.max_light > engine_max_light
    ) then

        unilib.utils.show_warning(msg_path .. "Invalid .max_light field", data_table.max_light)
        data_table.max_light = nil

    end

    if data_table.min_time == nil or data_table.min_time < min_weather_time then
        data_table.min_time = min_weather_time
    end

    if data_table.sky_colour_list and #data_table.sky_colour_list ~= 2 then

        unilib.utils.show_warning(
            msg_path .. "Invalid .sky_colour_list field", tostring(data_table.sky_colour_list)
        )
        data_table.sky_colour_list = nil

    end

    if data_table.max_wind_speed and data_table.max_wind_speed > abs_max_wind_speed then
        data_table.max_wind_speed = abs_max_wind_speed
    end

    if data_table.min_wind_speed and data_table.min_wind_speed < abs_min_wind_speed then

        data_table.min_wind_speed = abs_min_wind_speed
        if data_table.max_wind_speed and data_table.min_wind_speed > data_table.max_wind_speed then
            data_table.min_wind_speed = data_table.max_wind_speed
        end

    end

    if data_table.chance == nil then
        data_table.chance = 1
    end

    if data_table.tag_list == nil then
        data_table.tag_list = {}
    end

    -- Register the weather effect
    data_table.prototype = prototype_name
    weather_effect_table[weather_name] = data_table

    -- Update the weather prototype
    local prototype_data_table = weather_prototype_table[prototype_name]
    if prototype_data_table.effect_list == nil then
        prototype_data_table.effect_list = {weather_name}
    else
        table.insert(prototype_data_table.effect_list, weather_name)
    end

    -- Update the weather tag table
    if data_table.tag_list then

        for _, tag in ipairs(data_table.tag_list) do

            if not weather_tag_table[tag] then
                weather_tag_table[tag] = {weather_name}
            else
                table.insert(weather_tag_table[tag], weather_name)
            end

        end

    end

end

function unilib.atmosphere.set_weather(pname, weather_name)

    -- Called by code in the "chat_set_weather" package, or by any other suitable package
    -- Sets the current weather effect for the player
    -- "weather_name" can be a weather effect name (a key in "weather_effect_table"), or a weather
    --      tag (a key in "weather_tag_table")
    -- For weather tags, one of the corresponding weather effects is chosen at random (having
    --      omitted from that list the current weather effect, if it's included)

    -- If "weather_name" is a weather tag, convert it to a weather effect name
    if weather_tag_table[weather_name] then
        weather_name = convert_weather_tag(pname, weather_name)
    end

    -- Basic checks
    local data_table = weather_effect_table[weather_name]
    local player = core.get_player_by_name(pname)
    if data_table == nil or player == nil or
            player_table[pname]["current_weather"] == weather_name then
        return nil
    end

    player_table[pname]["prev_weather"] = player_table[pname]["current_weather"]
    player_table[pname]["current_weather"] = weather_name
    -- N.B. The .unlock_time field must be set, if required, by a call to
    --      unilib.atmosphere.set_weather_unlock_time()
    player_table[pname]["orig_pos"] =  player:get_pos()
    if not debug_no_lock_flag then
        player_table[pname]["locked_flag"] = true
    else
        player_table[pname]["locked_flag"] = false
    end
    player_table[pname]["update_flag"] = true
    -- Fade out the existing sound effect now (don't wait for the tick)
    if player_table[pname]["sound"] then
        stop_sound(pname)
    end

    return weather_name

end

function unilib.atmosphere.reset_weather(pname)

    -- Called by code in the "chat_reset_weather" package, or by any other suitable package
    -- Resets the current weather effect, so that the player sees default conditions (mostly clear
    --      skies)

    -- Basic checks
    if not player_table[pname]["current_weather"] then
        return false
    end

    player_table[pname]["prev_weather"] = player_table[pname]["current_weather"]
    player_table[pname]["current_weather"] = nil
    player_table[pname]["unlock_time"] = nil
    player_table[pname]["orig_pos"] = nil
    player_table[pname]["locked_flag"] = false
    player_table[pname]["update_flag"] = true
    if player_table[pname]["sound"] then
        stop_sound(pname)
    end

    return true

end

function unilib.atmosphere.set_weather_unlock_time(pname)

    -- Called directly after a call to unilib.atmosphere.set_weather(), if the new weather effect
    --      (whose status is "locked") should be unlocked after some minimum time interval
    -- If not called, then the new weather effect continues until the player moves sufficiently far
    --      from their location (at the time the weather effect started), or until the next call to
    --      unilib.atmosphere.set_weather() or .reset_weather()

    local data_table = player_table[pname]
    if not data_table.current_weather then
        return
    end

    local min_time = data_table.min_time or min_weather_time
    player_table[pname]["unlock_time"] = floor(os.time() + min_time + random(min_time / 3))

end

function unilib.atmosphere.get_weather(pname)

    -- Returns the name of the current weather effect (a key in "weather_effect_table") for the
    --      specified player, or nil if that player has no current weather effect

    if player_table[pname] then
        return player_table[pname]["current_weather"]
    end

end

function unilib.atmosphere.get_wind(pname)

    -- Returns the wind speed and direction for the specifed player, returning 3 values in the form
    --      wind_angle (a value in radians in the range 0 - 2*pi, representing the wind direction)
    --      wind_dir (an equivalent string, e.g. "north", "south_southwest"
    --      wind_speed (a value in the range 0 - MAX, where MAX depends on the current weather
    --          effect, if any)

    local data_table = player_table[pname]
    if data_table then
        return data_table.wind_angle, data_table.wind_dir, data_table.wind_speed
    end

end

function unilib.atmosphere.sample_weather(pos, time_val)

    -- Can be called by any package to sample the weather at a given position and time
    -- "time_val" is the epoch time, matching the output of os.time(); if not specified, the current
    --      time is used
    -- Returns the name of a weather effect (matches a key in "weather_effect_table"), or nil if no
    --      weather effect will be selected at the specified time

    if not time_val then
        time_val = os.time()
    end

    -- Number of intervals since epoch, ignore all but last 4 digits
    local t = get_time_value_for_fractal_noise(time_val)

    -- Get the weather effect that would be selected, if a player were at "pos"
    local prototype_name, weather_name
    prototype_name = select_weather_prototype(pos, t)
    if prototype_name then
        weather_name = select_weather_effect(pos, t, prototype_name)
    end

    return weather_name

end

function unilib.atmosphere.sample_wind(pos, time_val)

    -- Can be called by any package to sample the wind at a given position and time
    -- "time_val" is the epoch time, matching the output of os.time(); if not specified, the current
    --      time is used
    -- Returns the wind speed and direction, returning 3 values in the form
    --      wind_angle (a value in radians in the range 0 - 2*pi, representing the wind direction)
    --      wind_dir (an equivalent string, e.g. "north", "south_southwest"
    --      wind_speed (a value in the range 0 - MAX, where MAX depends on the current weather
    --          effect, if any)

    if not time_val then
        time_val = os.time()
    end

    -- Number of intervals since epoch, ignore all but last 4 digits
    local t = get_time_value_for_fractal_noise(time_val)

    -- Get the weather effect that would be selected, if a player were at "pos" (may be nil)
    local prototype_name, weather_name
    prototype_name = select_weather_prototype(pos, t)
    if prototype_name then
        weather_name = select_weather_effect(pos, t, prototype_name)
    end

    -- Get the wind speed range for that weather effect
    local max_wind_speed, min_wind_speed = get_wind_speed_range(weather_name)
    -- Get wind speed at the specified position
    local wind_speed = get_wind_speed(pos, t, max_wind_speed, min_wind_speed)

    -- Generate wind direction (we can re-use the same fractal noise, just decorrelating it)
    local wind_angle = get_wind_angle(pos, t)

    return wind_angle, convert_radians_to_compass_direction(wind_angle), wind_speed

end

function unilib.atmosphere.is_weather_in_range(pos)

    -- As described in the comments at the top of the file, weather effects are not enabled deep
    --      underground, or far above the surface
    -- Returns true if the specified position is between those bounds, or false if outside it

    if pos.y > weather_top_limit or pos.y < weather_bottom_limit then
        return false
    else
        return true
    end

end

function unilib.atmosphere.get_list_of_weather_effects()

    -- Returns a list of registered weather effect names (keys in "weather_effect_table")

    return unilib.utils.sort_table(weather_effect_table)

end

function unilib.atmosphere.get_list_of_weather_tags()

    -- Returns a list of registered weather tag names (keys in "weather_tag_table")

    return unilib.utils.sort_table(weather_tag_table)

end

function unilib.atmosphere.get_weather_effect_description(weather_name)

    -- Returns the .description of the specified weather effect ("weather_name" is a key in
    --      "weather_effect_table"), or nil if the specified weather effect is not registered

    local data_table = weather_effect_table[weather_name]
    if data_table then
        return data_table.description
    end

end

function unilib.atmosphere.get_weather_prototype_description(prototype_name)

    -- Returns the .description of the specified weather prototype ("prototype_name" is a key in
    --      "weather_prototype_table"), or nil if the specified weather prototype is not registered

    local data_table = weather_prototype_table[prototype_name]
    if data_table then
        return data_table.description
    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (ambient/environment effects)
---------------------------------------------------------------------------------------------------

function unilib.atmosphere.register_ambient(effect_name, data_table)

    -- Called by any ambient effect package
    -- Registers an ambient effect
    --
    -- "effect_name" can be any string (duplicate names will generate an error)
    -- For the format of "data_table", see the comments at the top of this file. This function
    --      supplies default key-value pairs, if "data_table" does not specify them (so "data_table"
    --      may be an empty table)

    -- Basic checks
    if ambient_effect_table[effect_name] ~= nil then
       return unilib.utils.show_error(msg_path .. "Duplicate ambient effect", effect_name)
    end

    -- Apply default values, if not specified
    if data_table.biome_list == nil then
        data_table.biome_list = {}
    end

    if data_table.node_list == nil then
        data_table.node_list = {}
    end

    if data_table.single_list == nil then
        data_table.single_list = {}
    end

    if data_table.single_prob == nil then
        data_table.single_prob = 0.01
    end

    if data_table.repeat_list == nil then
        data_table.repeat_list = {}
    end

    if data_table.repeat_prob == nil then
        data_table.repeat_prob = 1
    end

    -- Register the ambient effect
    ambient_effect_table[effect_name] = data_table

end

function unilib.atmosphere.register_environment(effect_name, data_table)

    -- Called by any package that creates nodes requiring their own environment effect
    -- Registers an environment effect
    --
    -- "effect_name" can be any string (duplicate names will generate an error)
    -- For the format of "data_table", see the comments at the top of this file. This function
    --      supplies default key-value pairs, if "data_table" does not specify them (so "data_table"
    --      may be an empty table)

    -- Basic checks
    if environment_effect_table[effect_name] ~= nil then
       return unilib.utils.show_error(msg_path .. "Duplicate environment effect", effect_name)
    end

    -- Apply default values, if not specified
    if data_table.sound == nil then
        data_table.sound = ""
    end

    if data_table.node_list == nil then
        data_table.node_list = {}
    end

    if data_table.base_volume == nil then
        data_table.base_volume = 0
    end

    if data_table.max_volume == nil then
        data_table.max_volume = 0.4
    end

    if data_table.node_volume_table == nil and data_table.node_value == nil then
        data_table.node_volume = 0.004
    end

    -- Register the environment effect
    environment_effect_table[effect_name] = data_table
    for _, full_name in ipairs(data_table.node_list) do
        table.insert(environment_cache_list, full_name)
    end

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

core.register_on_joinplayer(function(player)

    player_table[player:get_player_name()] = {
        cloud_flag = false,
        fog_flag = false,
        light_flag = false,
        locked_flag = false,
        skybox_flag = false,
        transition_flag = false,
        update_flag = false,
        wind_angle = 0,
        wind_dir = compass_dir_list[1],
        wind_speed = 0,
    }

end)

core.register_on_leaveplayer(function(player)
    player_table[player:get_player_name()] = nil
end)

core.register_on_mods_loaded(function()

    -- minetest_game's weather mod updates clouds and lighting on a regular cycle, overriding cloud
    --      and lighting specified by unilib's weather effects
    -- An acceptable solution is to intercept the return values of that mod's weather.get() function
    if core.get_modpath("weather") and weather.get then

        local old_func = weather.get

        weather.get = function(player)

            local t = old_func(player)

            local pname = player:get_player_name()
            if player_table[pname] and player_table[pname]["cloud_flag"] == true then
                t.clouds = nil
            end

            return t

        end

    end

end)

core.register_globalstep(function(dtime)

    if unilib.setting.atmosphere_weather_enable_flag then

        long_timer = long_timer + dtime
        if long_timer >= long_timer_tick then

            long_timer = 0
            on_long_tick()

        end

        main_timer = main_timer + dtime
        if main_timer >= main_timer_tick then

            main_timer = 0
            on_main_tick()

        end

    end

    if unilib.setting.atmosphere_ambient_enable_flag then

        ambient_timer = ambient_timer + dtime
        if ambient_timer >= ambient_timer_tick then

            ambient_timer = 0
            on_ambient_tick()

        end

    end

    if unilib.setting.atmosphere_environment_enable_flag then

        environment_timer = environment_timer + dtime
        if environment_timer >= environment_timer_tick then

            environment_timer = 0
            on_environment_tick()

        end

    end

end)

core.after(0.1, function()

    -- Once the games starts, we can prepare fractal noise for weather prototypes...

    for prototype_name, data_table in pairs(weather_prototype_table) do
        data_table.noise = core.get_value_noise(data_table.noise_table)
    end

    -- ...and for climate/weather selection/wind calculations
    climate_noise = core.get_value_noise({
        lacunarity = 2.0,
        octaves = 3,
        offset = 0,
        persistence = 0.5,
        scale = 1,
        spread = {x = 100, y = 100, z = 100},
        seed = 1001,
    })

    selection_noise = core.get_value_noise({
        lacunarity = 2.0,
        octaves = 3,
        offset = 0,
        persistence = 0.5,
        scale = 1,
        spread = {x = 100, y = 100, z = 100},
        seed = 1002,
    })

    wind_noise = core.get_value_noise({
        lacunarity = 2.0,
        octaves = 3,
        offset = 0,
        persistence = 0.5,
        scale = 1,
        spread = {x = 100, y = 100, z = 100},
        seed = 1003,
    })

    -- Create an environment effect for all water nodes, not already represented in
    --      "environment_effect_table"
    -- (N.B. In the original minetest_game/env_sounds, only default and river water were used)
    local check_table = {}
    for _, full_name in ipairs(environment_cache_list) do
        check_table[full_name] = true
    end

    local water_count = 0
    local water_table = {
        sound = "unilib_env_water",
        node_list = {},
        base_volume = 0.04,
        max_volume = 0.4,
        node_volume = 0.004,
    }

    for liquid_type, data_table in pairs(unilib.global.generic_liquid_table) do

        -- (Don't add a water node, that's already been added by some package or other)
        if data_table.water_flag and
                data_table.flowing_name and
                not check_table[data_table.flowing_name] then

            water_count = water_count + 1
            check_table[data_table.flowing_name] = true
            table.insert(water_table.node_list, data_table.flowing_name)

        end

    end

    -- (As in the original code, a river source node has an environment sound, depending on
    --      settings)
    if core.settings:get_bool("river_source_sounds") and
            not check_table["unilib:liquid_water_river_source"] then

        water_count = water_count + 1
        check_table[data_table.flowing_name] = true
        table.insert(water_table.node_list, "unilib:liquid_water_river_source")

    end

    if water_count > 0 then

        environment_effect_table["unilib_water_general"] = water_table
        for full_name, _ in pairs(check_table) do
            table.insert(environment_cache_list, full_name)
        end

    end

    -- As in the original code, create an environmental effect for ordinary lava (only; any other
    --      types of lava must register their own environmental effect)
    if unilib.global.pkg_executed_table["liquid_lava_ordinary"] ~= nil and
            check_table["unilib:liquid_lava_ordinary_source"] == nil and
            check_table["unilib:liquid_lava_ordinary_flowing"] == nil then

        environment_effect_table["unilib_lava_general"] = {
            sound = "unilib_env_lava",
            node_list = {
                "unilib:liquid_lava_ordinary_source",
                "unilib:liquid_lava_ordinary_flowing",
            },
            base_volume = 0,
            max_volume = 0.6,
            node_volume_table = {
                ["unilib:liquid_lava_ordinary_source"] = 0.008,
                ["unilib:liquid_lava_ordinary_flowing"] = 0.002,
            },
        }

        table.insert(environment_cache_list, "unilib:liquid_lava_ordinary_source")
        table.insert(environment_cache_list, "unilib:liquid_lava_ordinary_flowing")

    end

end)
