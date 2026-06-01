---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_weather_monitor = {}

local S = unilib.intllib
local FS = function(...) return core.formspec_escape(S(...)) end
local mode = unilib.global.imported_mod_table.unilib.add_mode

local this_formname = "unilib:form_machine_weather_monitor"
local dark_colour = "#000000"

-- Table of player names, and the position of the most recent machine for which a formspec was
--      opened
local player_table = {}

-- Number of seconds per (in-game) day
local secs_per_day = 1200
-- Data collection time (in seconds)
local data_time = 60
-- When no weather effect applies at a given position, use this weather effect "name" and
--      description
local nil_weather_name = "no_weather"
local nil_weather_description = S("Clear skies")

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function analyse_sample(pos, weather_name)

    -- Add the specified "weather_name" (which may be nil if no weather effect applies) to our
    --      stored data, to be retrieved when the formspec is next opened

    local meta = core.get_meta(pos)
    if not weather_name then
        weather_name = nil_weather_name
    end

    local data_table = core.deserialize(meta:get_string("data")) or {}
    if data_table[weather_name] == nil then
        data_table[weather_name] = 1
    else
        data_table[weather_name] = data_table[weather_name] + 1
    end

    meta:set_string("data", core.serialize(data_table))
    meta:set_int("sample_count", meta:get_int("sample_count") + 1)

end

local function compile_data(pos)

    local meta = core.get_meta(pos)
    local sample_count = meta:get_int("sample_count") or 0
    local data_table = core.deserialize(meta:get_string("data")) or {}

    local weather_list = {}
    for weather_name, _ in pairs(data_table) do
        table.insert(weather_list, weather_name)
    end

    table.sort(weather_list, function(a, b)
        return data_table[a] > data_table[b]
    end)

    local str = ""
    for _, weather_name in ipairs(weather_list) do

        local description = nil_weather_description
        if weather_name ~= nil_weather_name then
            description = unilib.atmosphere.get_weather_effect_description(weather_name)
        end

        local percentage = data_table[weather_name] / sample_count * 100
        if percentage < 1 then
            str = str .. description .. ": < 1%\n"
        else
            str = str .. description .. ": " .. math.ceil(percentage) .. "%\n"
        end

    end

    return str

end

local function compile_summary(pos)

    local meta = core.get_meta(pos)
    local sample_count = meta:get_int("sample_count") or 0
    local running_time = string.format("%.1f", (sample_count * data_time / secs_per_day))
    return S("Collected @1 weather samples (@2 days)", sample_count, running_time)

end

local function get_formspec(pname, pos)

    local meta = core.get_meta(pos)
    local owner_name = meta:get_string("owner")
    local on_flag = false
    if meta:get_string("on_flag") == "true" then
        on_flag = true
    end

    player_table[pname] = pos

    local formspec = "size[8,8]"

    if not on_flag then

        formspec = formspec ..
            "image[0,0;1,1;unilib_machine_weather_monitor_front_off.png]" ..
            "label[1,0.2;" .. FS("Weather Monitoring Station") .. " (" .. FS("Off") .. ")]"

    else

        formspec = formspec ..
            "image[0,0;1,1;unilib_machine_weather_monitor_front_on.png]" ..
            "label[1,0.2;" .. FS("Weather Monitoring Station") .. " (" .. FS("On") .. ")]"

    end

    formspec = formspec ..
        "label[0.23,1.4;" .. compile_summary(pos) .. "]" ..
        "box[0.2,2;7.4,4.5;" .. dark_colour .. "]" ..
        "textarea[0.5,2;7.5,5.3;;;" .. compile_data(pos) .. "]"

    if pname == owner_name then

        if not on_flag then

            formspec = formspec ..
                "button[1,7;2,1;start_btn;" .. FS("Start") .. "]" ..
                "button[3,7;2,1;blank_btn;]"

        else

            formspec = formspec ..
                "button[1,7;2,1;blank_btn;]" ..
                "button[3,7;2,1;stop_btn;" .. FS("Stop") .. "]"

        end

        formspec = formspec ..
            "button[5,7;2,1;reset_btn;" .. FS("Reset") .. "]"

    else

        formspec = formspec ..
            "label[0.23,7.2;" .. FS("This station belongs to @1", owner_name) .. "]"

    end

    if core.check_player_privs(meta:get_string("owner"), {unilib_admin = true}) then

        formspec = formspec ..
            "checkbox[6,0;force_box;" .. FS("Force load") .. ";" ..
            meta:get_string("force_flag") .. "]"

    end

    return formspec

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_weather_monitor.init()

    return {
        description = "Weather monitoring station",
        notes = "Samples the weather at the station's location over a period of time." ..
                " Right-click to show an analysis of the results. Sampling can be started or" ..
                " paused with the Start/Stop buttons. This machine does not detect weather" ..
                " effects generated artificially (e.g. using the /set_weather command), and the" ..
                " samples may not match the weather seen by a nearby player exactly" ..
                " (e.g. because of aesthetic adjustments; for example, a new weather effect has" ..
                " a minimum duration, when enabled for a player)",
        depends = {"mineral_coal", "mineral_mese", "metal_gold", "metal_steel"},
    }

end

function unilib.pkg.machine_weather_monitor.exec()

    unilib.register_node("unilib:machine_weather_monitor_off", nil, mode, {
        -- Original to unilib
        description = S("Weather Monitoring Station"),
        tiles = {
            "unilib_machine_weather_monitor_top.png",
            "unilib_machine_weather_monitor_bottom.png",
            "unilib_machine_weather_monitor_side.png",
            "unilib_machine_weather_monitor_side.png",
            "unilib_machine_weather_monitor_side.png",
            "unilib_machine_weather_monitor_front_off.png",
        },
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.metal,

        is_ground_content = false,
        paramtype2 = "facedir",

        after_place_node = function(pos, placer)

            local pname = placer:get_player_name()
            local meta = core.get_meta(pos)
            meta:set_string("owner", pname)
            meta:set_string("on_flag", "false")
            meta:set_string("force_flag", "false")
            meta:set_string("data", core.serialize({}))
            meta:set_int("sample_count", 0)

        end,

        on_rightclick = function(pos, node, clicker)

            local pname = clicker:get_player_name()
            if not pname then
                return
            end

            core.show_formspec(pname, this_formname, get_formspec(pname, pos))

        end,

        on_timer = function(pos, elapsed)
            return false
        end,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:machine_weather_monitor_off",
        recipe = {
            {"unilib:mineral_coal_lump", "unilib:mineral_mese_crystal", "unilib:mineral_coal_lump"},
            {"unilib:metal_steel_ingot", "unilib:metal_gold_ingot", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
        },
    })

    unilib.register_node("unilib:machine_weather_monitor_on", nil, mode, {
        -- Original to unilib
        description = S("Weather Monitoring Station"),
        tiles = {
            "unilib_machine_weather_monitor_top.png",
            "unilib_machine_weather_monitor_bottom.png",
            "unilib_machine_weather_monitor_side.png",
            "unilib_machine_weather_monitor_side.png",
            "unilib_machine_weather_monitor_side.png",
            "unilib_machine_weather_monitor_front_on.png",
        },
        groups = {cracky = 3, not_in_creative_inventory = 1},
        sounds = unilib.global.sound_table.metal,

        drop = "unilib:machine_weather_monitor_off",
        is_ground_content = false,
        light_source = 3,
        paramtype2 = "facedir",

        on_destruct = function(pos)

            local meta = core.get_meta(pos)
            if meta:get_string("force_flag") == "true" then
                core.forceload_free_block(pos)
            end

        end,

        on_rightclick = function(pos, node, clicker)

            local pname = clicker:get_player_name()
            if not pname then
                return
            end

            core.show_formspec(pname, this_formname, get_formspec(pname, pos))

        end,

        on_timer = function(pos, elapsed)

            -- (Don't force the mapblock to re-load by calling core.get_node() )
            local node = core.get_node_or_nil(pos)
            if not node then
                return true
            end

            local meta = core.get_meta(pos)
            if node.name ~= "unilib:machine_weather_monitor_on" or
                    meta:get_string("on_flag") ~= "true" then
                return false
            end

            analyse_sample(pos, unilib.atmosphere.sample_weather(pos))
            return true

        end,
    })

    core.register_on_player_receive_fields(function(player, formname, fields)

        if formname ~= this_formname then
            return false
        end

        local pname = player:get_player_name()
        if not pname or not player_table[pname] then
            return false
        end

        local pos = player_table[pname]
        local node = core.get_node(pos)
        local meta = core.get_meta(pos)
        if not node or not meta then
            return false
        end

        if fields.force_box and
                core.check_player_privs(meta:get_string("owner"), {unilib_admin = true}) then

            meta:set_string("force_flag", fields.force_box)
            if fields.force_box == "false" then
                core.forceload_free_block(pos)
            else
                core.forceload_block(pos)
            end

        elseif fields.start_btn then

            meta:set_string("on_flag", "true")
            core.swap_node(pos, {name = "unilib:machine_weather_monitor_on", param2 = node.param2})
            core.get_node_timer(pos):start(data_time)

            if meta:get_string("force_flag") == "true" then
                core.forceload_block(pos)
            end

            core.show_formspec(pname, this_formname, get_formspec(pname, pos))

        elseif fields.stop_btn then

            meta:set_string("on_flag", "false")
            core.swap_node(pos, {name = "unilib:machine_weather_monitor_off", param2 = node.param2})

            if meta:get_string("force_flag") == "true" then
                core.forceload_free_block(pos)
            end

            core.show_formspec(pname, this_formname, get_formspec(pname, pos))

        elseif fields.reset_btn then

            meta:set_string("on_flag", "false")
            meta:set_string("data", core.serialize({}))
            meta:set_int("sample_count", 0)
            core.swap_node(pos, {name = "unilib:machine_weather_monitor_off", param2 = node.param2})

            if meta:get_string("force_flag") == "true" then
                core.forceload_free_block(pos)
            end

            core.show_formspec(pname, this_formname, get_formspec(pname, pos))

        end

        return true

    end)

    core.register_on_leaveplayer(function(player)
        player_table[player:get_player_name()] = nil
    end)

end
