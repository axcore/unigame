---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.potion_flight = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

-- Total flight time, in seconds
local total_flight_time = 5 * 60
-- Seconds between every check
local check_time = 5

-- Table of warnings issued to players flying over no-fly zones
local warning_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_flight_time(player)

    -- Adapted from ethereal-ng/flight.lua, was get_timer()
    -- Get the player flight time

    if not player then
        return
    end

    return unilib.utils.get_player_attribute(player, "pkg_potion_flight_time") or ""

end

local function set_flight_time(player, flight_time)

    -- Adapted from ethereal-ng/flight.lua, was set_timer()
    -- Set the player flight time

    unilib.utils.set_player_attribute(player, "pkg_potion_flight_time", flight_time)

end


local function has_fly(pname)

    -- Adapted from ethereal-ng/flight.lua, was has_fly()
    -- Does the specified play have fly privileges

    return core.get_player_privs(pname).fly

end

local function toggle_flight(player, value)

    -- Adapted from ethereal-ng/flight.lua, was set_flight()
    -- Enables/disables flight

    local pname = player and player:get_player_name()
    if not pname then
        return
    end

    local privs = core.get_player_privs(pname)
    privs.fly = value
    core.set_player_privs(pname, privs)

    -- When the "fly" privilege is removed, set the flight time to a temporary value for checks
    if value ~= true then
        set_flight_time(player, "-99")
    end

    -- Reset the warning table populated by handle_flight()
    warning_table[pname] = nil

end

local function handle_flight(player)

    -- Adapted from ethereal-ng/flight.lua, was ethereal_set_flight()
    -- Minetest .after() function to handle flight

    local pname = player and player:get_player_name()
    if not pname then
        return
    end

    local flight_time = tonumber(get_flight_time(player)) or 0

    -- This code block is adapted from the "hangglider" mod (and the "item_hangglider" package);
    --      any other flight devices that depend on the "shared_hangglider" package can use this
    --      code to prevent flights in no-fly zones
    if unilib.global.pkg_executed_table["shared_hangglider"] ~= nil and
            not unilib.pkg.shared_hangglider.can_fly(pname, player:get_pos()) then

        -- Warning shot
        if warning_table[pname] == nil then

            warning_table[pname] = 0
            unilib.pkg.shared_hangglider.play_shooting_sound(pos)
            core.chat_send_player(
                pname,
                S(
                    "No fly zone! You will be shot down in @1 seconds!",
                    unilib.setting.hangglider_warning_time
                )
            )

        end

        -- Shoot down
        warning_table[pname] = warning_table[pname] + (total_flight_time - flight_time)
        if warning_table[pname] > unilib.setting.hangglider_warning_time then

            player:set_hp(1)
            unilib.pkg.shared_hangglider.play_shooting_sound(pos)
            toggle_flight(player, nil)
            return

        end

    end

    -- Now we're back to code from the ethereal mod
    -- If the flight time has run out then remove "fly" privelage
    if flight_time <= 0 and flight_time ~= -99 then

        toggle_flight(player, nil)
        return

    end

    -- Have we already applied "fly" privilege?
    local privs = core.get_player_privs(pname)
    if not privs.fly then
        toggle_flight(player, true)
    end

    -- Handle the flight time
    flight_time = flight_time - check_time

    -- Show expiration message and play sound
    if flight_time <= 10 then

        core.chat_send_player(
            pname,
            core.get_color_escape_sequence("#ff5500") .. S("The flight potion is wearing off!")
        )

        core.sound_play(
            "unilib_dig_immediate",
            {to_player = pname, gain = 1.0},
            true
        )

    end

    -- Store new flight time setting
    set_flight_time(player, flight_time)
    -- Restart checks
    core.after(check_time, function()
        handle_flight(player)
    end)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.potion_flight.init()

    return {
        description = "Flight potion",
        notes = "Enables flying for five minutes. Use the /no_fly_zone command to disable flying" ..
                " in your protected areas",
        depends = {"flower_fire", "mineral_aetherium", "vessel_bottle_glass_empty"},
        optional = "shared_hangglider",
    }

end

function unilib.pkg.potion_flight.exec()

    local c_dust = "unilib:mineral_aetherium_dust"

    unilib.register_node("unilib:potion_flight", "ethereal:flight_potion", mode, {
        -- From ethereal:flight_potion
        description = S("Flight Potion"),
        tiles = {"unilib_potion_flight.png"},
        groups = {dig_immediate = 3},
        sounds = unilib.global.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_potion_flight.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.37, -0.2, 0.2, 0.31, 0.2},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_potion_flight.png",

        on_use = function(itemstack, player, pointed_thing)

            if player.is_fake_player then
                return
            end

            -- Get privs
            local pname = player:get_player_name()
            local privs = core.get_player_privs(pname)
            local flight_time = get_flight_time(player)

            if privs.fly then

                local msg = flight_time
                if flight_time == "" or flight_time == "-99" then
                    msg = S("unlimited")
                end

                core.chat_send_player(
                    pname,
                    core.get_color_escape_sequence("#ffff00") ..
                            S("Flight already granted, @1 seconds left!", msg)
                )

                return

            end

            -- Set the flight time
            set_flight_time(player, total_flight_time)

            -- Show time remaining
            core.chat_send_player(
                pname,
                core.get_color_escape_sequence("#1eff00") ..
                        S("Flight granted, you can fly for @1 seconds!", total_flight_time)
            )

            -- Start check
            handle_flight(player)

            -- Take potion and return empty bottle
            itemstack:take_item()

            local inv = player:get_inventory()
            if inv:room_for_item("main", {name = "unilib:vessel_bottle_glass_empty"}) then
                player:get_inventory():add_item("main", "unilib:vessel_bottle_glass_empty")
            else
                core.add_item(player:get_pos(), {name = "unilib:vessel_bottle_glass_empty"})
            end

            return itemstack

        end,
    })
    unilib.register_craft({
        -- From ethereal:flight_potion
        output = "unilib:potion_flight",
        recipe = {
            {c_dust, c_dust, c_dust},
            {c_dust, "unilib:flower_fire_dust", c_dust},
            {c_dust, "unilib:vessel_bottle_glass_empty", c_dust},
        },
    })

    core.register_on_dieplayer(function(player)

        -- Original to unilib
        toggle_flight(player, nil)

    end)

    core.register_on_joinplayer(function(player)

        -- From ethereal

        -- Wait 2 seconds before doing flight checks on player
        core.after(2.0, function(player)

            -- Get player
            local pname = player and player:get_player_name()
            if not pname then
                return
            end

            -- Get the flight time; if it's blank and the player can already fly, then set the
            --      default value and return
            local flight_time = get_flight_time(player)
            if flight_time == "" and has_fly(pname) then

                set_flight_time(player, "-99")
                return

            end

            flight_time = tonumber(flight_time) or 0

            -- If the flight time is set to the default value then return
            if flight_time == -99 then
                return
            end

            -- If we got this far, and the player is flying, then start the countdown check
            if has_fly(pname) then

                core.after(check_time, function()
                    handle_flight(player)
                end)

            end

        end, player)

    end)

    core.register_on_leaveplayer(function(player)

        -- Original to unilib
        toggle_flight(player, nil)

    end)

end
