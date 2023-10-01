---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    orienteering
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_orienteering = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.orienteering.add_mode

local player_hud_table = {}
local speed_unit = S("m/s")
local length_unit = S("m")
local hud_pos = {x = 0.5, y = 0}
local hud_offset = {x = 0, y = 15}
local hud_alignment = {x = 0, y = 0}
-- Number of lines in HUD
local hud_lines = 4

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function tool_active(player, item)

    -- Checks whether a certain orienteering tool is "active" and ready for use

    -- Requirement: player carries the tool in the hotbar
    local inv = player:get_inventory()
    -- Exception: minetest_game's Mapping Kit can be anywhere
    if item == "unilib:item_kit_mapping" then
        return inv:contains_item("main", item)
    end

    local hotbar = player:hud_get_hotbar_itemcount()
    for i = 1, hotbar do

        if inv:get_stack("main", i):get_name() == item then
            return true
        end

    end

    return false

end

local function update_satnav(player)

    if unilib.pkg_executed_table["shared_map"] ~= nil then

        -- Code just below interferes with code in the shared mapping package
        unilib.pkg.shared_map.update_hud_flags(player)

    else

        -- No shared mapping package available, so use our own code
        if tool_active(player, "unilib:item_satnav_digital") or
                tool_active(player, "unilib:item_quadcorder_digital") or
                tool_active(player, "unilib:item_kit_radar") or
                tool_active(player, "minimap_radar:radar") or
                unilib.is_creative(player) then

            player:hud_set_flags({minimap = true, minimap_radar = true})

        elseif tool_active(player, "unilib:item_satnav_analogue") or
                tool_active(player, "unilib:item_kit_mapping") or
                tool_active(player, "map:mapping_kit") or
                unilib.is_creative(player) then

            player:hud_set_flags({minimap = true, minimap_radar = false})

        else

            player:hud_set_flags({minimap = false, minimap_radar = false})

        end

    end

end

local function init_hud(player)

    update_satnav(player)

    local name = player:get_player_name()
    player_hud_table[name] = {}

    for i = 1, hud_lines do

        player_hud_table[name]["hud_line" .. i] = player:hud_add({
            name = "orienteering",
            hud_elem_type = "text",

            alignment = hud_alignment,
            number = 0xFFFFFF,
            offset = {x = hud_offset.x, y = hud_offset.y + 20 * (i - 1)},
            position = hud_pos,
            scale = {x = 100, y = 20},
            text = "",
            z_index = 0,
        })

    end

end

local function update_hud_displays(player)

    local to_degrees = 180 / math.pi
    local name = player:get_player_name()
    local gps, altimeter, triangulator, compass, sextant, watch, speedometer, quadcorder

    if tool_active(player, "unilib:item_gps_digital") then
        gps = true
    end
    if tool_active(player, "unilib:item_altimeter_digital") then
        altimeter = true
    end
    if tool_active(player, "unilib:item_triangulator_digital") then
        triangulator = true
    end
    if tool_active(player, "unilib:item_compass_digital") then
        compass = true
    end
    if tool_active(player, "unilib:item_sextant_digital") then
        sextant = true
    end
    if tool_active(player, "unilib:item_watch_digital") then
        watch = true
    end
    if tool_active(player, "unilib:item_speedometer_digital") then
        speedometer = true
    end
    if tool_active(player, "unilib:item_quadcorder_digital") then
        quadcorder = true
    end

    local str_pos, str_angles, str_time, str_speed
    local pos = vector.round(player:get_pos())
    if (altimeter and triangulator) or gps or quadcorder then
        str_pos = S("Coordinates: X=@1, Y=@2, Z=@3", pos.x, pos.y, pos.z)
    elseif altimeter then
        str_pos = S("Height: Y=@1", pos.y)
    elseif triangulator then
        str_pos = S("Coordinates: X=@1, Z=@2", pos.x, pos.z)
    else
        str_pos = ""
    end

    -- Yaw in Minetest goes counter-clockwise, which is the opposite of how compasses work
    local yaw = 360 - player:get_look_horizontal() * to_degrees
    local pitch = player:get_look_vertical() * to_degrees
    if ((compass or gps) and sextant) or quadcorder then

        str_angles = S(
            "Yaw: @1°, pitch: @2°",
            string.format("%.1f", yaw),
            string.format("%.1f", pitch)
        )

    elseif compass or gps then

        str_angles = S("Yaw: @1°", string.format("%.1f", yaw))

    elseif sextant then

        str_angles = S("Pitch: @1°", string.format("%.1f", pitch))

    else

        str_angles = ""

    end

    local time = minetest.get_timeofday()
    if watch or gps or quadcorder then

        local totalminutes = time * 1440
        local minutes = totalminutes % 60
        local hours = math.floor((totalminutes - minutes) / 60)
        minutes = math.floor(minutes)

        local twelve = unilib.get_player_attribute(player, "pkg_shared_orienteering_twelve")
        if twelve == "true" then

            if hours == 12 and minutes == 0 then

                str_time = S("Time: noon")

            elseif hours == 0 and minutes == 0 then

                str_time = S("Time: midnight")

            else

                local hours12 = math.fmod(hours, 12)
                if hours12 == 0 then hours12 = 12 end
                if hours >= 12 then

                    str_time = S(
                        "Time: @1:@2 p.m.",
                        string.format("%i", hours12),
                        string.format("%02i", minutes)
                    )

                else

                    str_time = S(
                        "Time: @1:@2 a.m.",
                        string.format("%i", hours12),
                        string.format("%02i", minutes)
                    )

                end

            end

        else

            str_time = S(
                "Time: @1:@2",
                string.format("%02i", hours),
                string.format("%02i", minutes)
            )

        end

    else

        str_time = ""

    end

    if speedometer or quadcorder then

        local speed_hor, speed_ver
        local v
        local attach = player:get_attach()

        if attach == nil then

            v = player:get_velocity()

        else

            v = attach:get_velocity()
            if not v then
                v = player:get_velocity()
            end

        end

        speed_ver = v.y
        v.y = 0
        speed_hor = vector.length(v)

        local u = speed_unit
        str_speed = S(
            "Speed: hor.: @1 @2, vert.: @3 @4",
            string.format("%.1f", speed_hor),
            u,
            string.format("%.1f", speed_ver),
            u
        )
    else

        str_speed = ""

    end

    local strs = {str_pos, str_angles, str_time, str_speed}
    local line = 1
    for i = 1, hud_lines do

        if strs[i] ~= "" then

            player:hud_change(player_hud_table[name]["hud_line" .. line], "text", strs[i])
            line = line + 1

        end

    end

    for l = line, hud_lines do
        player:hud_change(player_hud_table[name]["hud_line" .. l], "text", "")
    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_orienteering.toggle_time_mode(itemstack, player, pointed_thing)

    -- Function to switch between 12h and 24 mode for the displayed time

    -- Player attribute "unilib:orienteering_twelve":
    --      "true": Use 12h mode for time
    --      "false" or unset: Use 24h mode for time
    if unilib.get_player_attribute(player, "pkg_shared_orienteering_twelve") == "true" then
        unilib.set_player_attribute(player, "pkg_shared_orienteering_twelve", "false")
    else
        unilib.set_player_attribute(player, "pkg_shared_orienteering_twelve", "true")
    end

    update_hud_displays(player)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_orienteering.init()

    return {
        description = "Shared functions for digital meters (from orienteering mod)",
        optional = "shared_map",
    }

end

function unilib.pkg.shared_orienteering.exec()

    if minetest.get_modpath("map") and
            unilib.pkg_executed_table["shared_map"] ~= nil then

        -- Override the minetest_game/map handling functions, so the code below can take over
        -- The "shared_map" package does a similar thing; don't override it twice (code in
        --      update_satnav() has been refactored to take account of this problem)
        function map.update_hud_flags(player) end

    end

    minetest.register_on_newplayer(init_hud)
    minetest.register_on_joinplayer(init_hud)

    minetest.register_on_leaveplayer(function(player)
        player_hud_table[player:get_player_name()] = nil
    end)

    local updatetimer = 0
    minetest.register_globalstep(function(dtime)

        updatetimer = updatetimer + dtime
        if updatetimer > 0.1 then
            local players = minetest.get_connected_players()
            for i = 1, #players do

                update_satnav(players[i])
                update_hud_displays(players[i])

            end

            updatetimer = updatetimer - dtime

        end

    end)

end
