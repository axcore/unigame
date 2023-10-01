---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.potion_flight = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

-- Seconds per check
local timer_check = 5
-- Seconds of flight
local flight_secs = 5 * 60

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function set_flight(player, set)

    -- Adapted from ethereal-ng/flight.lua
    -- Enables/disables flight

    local name = player:get_player_name()
    local privs = minetest.get_player_privs(name)
    privs.fly = set
    minetest.set_player_privs(name, privs)

    -- When "fly" privilege removed, set timer to a temporary value for checks
    if not set then
        unilib.set_player_attribute(player, "pkg_potion_flight_timer", "-99")
    end

end

local function handle_flight(player)

    -- Adapted from ethereal-ng/flight.lua
    -- Minetest .after() function to handle flight

    local timer = tonumber(unilib.get_player_attribute(player, "pkg_potion_flight_timer"))
    if not timer then
        return
    end

    -- If timer ran out then remove "fly" privelage
    if timer <= 0 and timer ~= -99 then

        set_flight(player, nil)
        return

    end

    local name = player:get_player_name()
    local privs = minetest.get_player_privs(name)

    -- Have we already applied "fly" privilege?
    if not privs.fly then
        set_flight(player, true)
    end

    -- Handle timer
    timer = timer - timer_check

    -- Show expiration message and play sound
    if timer < 10 then

        minetest.chat_send_player(
            name,
            minetest.get_color_escape_sequence("#ff5500") .. S("The flight potion is wearing off!")
        )

        minetest.sound_play(
            "unilib_dig_dig_immediate",
            {to_player = name, gain = 1.0},
            true
        )

    end

    -- Store new timer setting
    unilib.set_player_attribute(player, "pkg_potion_flight_timer", timer)
    minetest.after(timer_check, function()
        handle_flight(player)
    end)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.potion_flight.init()

    return {
        description = "Flight potion",
        notes = "Enables flying for five minutes",
        depends = {"flower_fire", "mineral_aetherium", "vessel_bottle_glass_empty"},
    }

end

function unilib.pkg.potion_flight.exec()

    local c_dust = "unilib:mineral_aetherium_dust"

    unilib.register_node("unilib:potion_flight", "ethereal:flight_potion", mode, {
        -- From ethereal:flight_potion
        description = S("Flight Potion"),
        tiles = {"unilib_potion_flight.png"},
        groups = {dig_immediate = 3},
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_potion_flight.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.37, -0.2, 0.2, 0.31, 0.2},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_potion_flight.png",

        on_use = function(itemstack, player, pointed_thing)

            -- Get privs
            local name = player:get_player_name()
            local privs = minetest.get_player_privs(name)
            local timer = unilib.get_player_attribute(player, "pkg_potion_flight_timer")

            if privs.fly then

                local msg = timer

                if timer == "" or timer == "-99" then
                    msg = S("unlimited")
                end

                minetest.chat_send_player(
                    name,
                    minetest.get_color_escape_sequence("#ffff00") ..
                            S("Flight already granted, @1 seconds left!", msg)
                )

                return

            end

            unilib.set_player_attribute(player, "pkg_potion_flight_timer", flight_secs)

            minetest.chat_send_player(
                name,
                minetest.get_color_escape_sequence("#1eff00") ..
                        S("Flight granted, you can fly for @1 seconds!", flight_secs)
            )

            handle_flight(player)

            -- Take potion and return empty bottle
            itemstack:take_item()

            local inv = player:get_inventory()
            if inv:room_for_item("main", {name = "unilib:vessel_bottle_glass_empty"}) then
                player:get_inventory():add_item("main", "unilib:vessel_bottle_glass_empty")
            else
                minetest.add_item(player:get_pos(), {name = "unilib:vessel_bottle_glass_empty"})
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
            {c_dust, "unilib:vessel_bottle_glass_empty", c_dust}
        }
    })

    minetest.register_on_joinplayer(function(player)

        local timer = tonumber(unilib.get_player_attribute(player, "pkg_potion_flight_timer"))
        if timer and timer == -99 then
            return
        end

        local privs = minetest.get_player_privs(player:get_player_name())

        if privs.fly and timer then

            minetest.after(timer_check, function()
                handle_flight(player)
            end)

        end

    end)

end
