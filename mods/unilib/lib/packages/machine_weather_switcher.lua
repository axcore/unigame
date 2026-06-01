---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_weather_switcher = {}

local S = unilib.intllib
local FS = function(...) return core.formspec_escape(S(...)) end
local mode = unilib.global.imported_mod_table.unilib.add_mode

local this_formname = "unilib:form_machine_weather_switcher"

-- All players within this range are affected by the machine, when used (unless this value is
--      changed to 0, in which case only the punching player is affected)
local range = 100
-- Table of player names, and the position of the most recent machine for which a formspec was
--      opened
local player_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_formspec(pname, pos)

    local meta = core.get_meta(pos)
    local data = meta:get_string("data")
    local owner_flag = meta:get_string("owner_flag")

    player_table[pname] = pos

    return "size[8,4.2]" ..
        "image[0,0;1,1;unilib_machine_weather_switcher_side_1.png]" ..
        "label[1,0.25;" .. FS("Switch weather") .. "]" ..
        "image[0,1.25;1,1;unilib_machine_weather_switcher_side_2.png]" ..
        "label[1,1.25;" .. FS("Type a weather tag, e.g. rain, random" ) .. "\n" ..
                FS("or a weather name, e.g. unilib_rain_normal") .. "]" ..
        "field[0.5,2.8;7.4,1;data_field;;" .. data .. "]" ..
        "checkbox[0,3.5;owner_box;" .. FS("Only the owner may use this machine") .. ";" ..
            owner_flag .. "]"

end

local function set_weather(pname, pos)

    local meta = core.get_meta(pos)
    local data = meta:get_string("data")

    -- If the player has typed (for example) several weather tags, choose one at random (the true
    --      flag means ignore duplicates)
    local weather_list = unilib.utils.split_string_by_whitespace(data, true)
    local choice = weather_list[math.random(#weather_list)] or ""
    if choice == "" then
        unilib.atmosphere.reset_weather(pname)
    else
        choice = unilib.atmosphere.set_weather(pname, choice)
    end

    -- The machine affects all other players within a 100-block radius (unless the value has been
    --      changed to 0)
    if range > 0 then

        for _, this_player in ipairs(core.get_connected_players()) do

            local this_pname = this_player:get_player_name()
            if pname ~= this_pname then

                local this_pos = this_player:get_pos()
                if vector.distance(pos, this_pos) <= range then

                    if choice == "" then
                        unilib.atmosphere.reset_weather(this_pname)
                    else
                        unilib.atmosphere.set_weather(this_pname, choice)
                    end

                end

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_weather_switcher.init()

    return {
        description = "Weather-switching machine",
        notes = "Right-click the machine to specify one or more weather effects names and/or" ..
                " weather tags. Punch the machine to apply the specified weather effect (if" ..
                " more than one was specified, an effect is chosen at random; if nothing is" ..
                " specified, the current weather effect is reset). The formspec can also be used" ..
                " to restrict use of the machine to its owner. When a new weather effect is set," ..
                " only players within a hundred-block range of the machine are affected. See" ..
                " also the \"machine_weather_calmer\" package, which is a quicker way of" ..
                " resetting weather effects. Note that this machine overrides natural weather" ..
                " selection (at least until you move to a different position), and that weather" ..
                " effects don't occur very far above or below sea level",
        depends = {"metal_bronze", "metal_copper", "metal_tin"},
    }

end

function unilib.pkg.machine_weather_switcher.exec()

    unilib.register_node("unilib:machine_weather_switcher_off", nil, mode, {
        -- Original to unilib
        description = unilib.utils.brackets(
            S("Weather-Switching Machine"), S("punch to switch weather, right-click to configure")
        ),
        tiles = {
            "unilib_machine_weather_switcher_off.png",
            "unilib_machine_weather_switcher_bottom.png",
            "unilib_machine_weather_switcher_side_1.png",
            "unilib_machine_weather_switcher_side_1.png",
            "unilib_machine_weather_switcher_side_2.png",
            "unilib_machine_weather_switcher_side_2.png",
        },
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        is_ground_content = false,
        light_source = 3,
        node_box = {
            type = "fixed",
            fixed = {
                {-8/16, -8/16, -8/16, 8/16, 7/16, 8/16},    -- Main box
                {-5/16, 6/16, -3/16, 5/16, 8/16, 3/16},     -- Button
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",

        after_place_node = function(pos, placer)

            local pname = placer:get_player_name()
            local meta = core.get_meta(pos)
            meta:set_string("owner", pname)
            meta:set_string("data", "random")

        end,

        on_punch = function(pos, node, puncher)

            local pname = puncher:get_player_name()
            if not pname then
                return
            end

            -- (The button is not "pressed" when the punching player is wielding a tool like a
            --      pickaxe)
            local wielded = puncher:get_wielded_item()
            if wielded and core.registered_tools[wielded:get_name()] ~= nil then
                return
            end

            local meta = core.get_meta(pos)
            if meta:get_string("owner_flag") == "true" and meta:get_string("owner") ~= pname then

                core.chat_send_player(pname, S("This machine doesn't belong to you"))
                return

            end

            if not unilib.atmosphere.is_weather_in_range(pos) then

                core.sound_play("unilib_dig_metal", {pos = pos}, true)
                return

            end

            core.swap_node(pos, {name = "unilib:machine_weather_switcher_on", param2 = node.param2})
            core.sound_play("unilib_misc_bin_skip", {pos = pos}, true)
            core.get_node_timer(pos):start(2)

            set_weather(pname, pos)

        end,

        on_rightclick = function(pos, node, clicker)

            local pname = clicker:get_player_name()
            if not pname then
                return
            end

            local meta = core.get_meta(pos)
            if meta:get_string("owner_flag") == "true" and meta:get_string("owner") ~= pname then

                core.chat_send_player(pname, S("This machine doesn't belong to you"))
                return

            end

            if not unilib.atmosphere.is_weather_in_range(pos) then

                core.sound_play("unilib_dig_metal", {pos = pos}, true)
                return

            end

            core.show_formspec(pname, this_formname, get_formspec(pname, pos))

        end,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:machine_weather_switcher_off",
        recipe = {
            {"", "unilib:metal_copper_ingot", ""},
            {"unilib:metal_tin_ingot", "unilib:metal_bronze_ingot", "unilib:metal_tin_ingot"},
            {"unilib:metal_tin_ingot", "unilib:metal_tin_ingot", "unilib:metal_tin_ingot"},
        },
    })

    unilib.register_node("unilib:machine_weather_switcher_on", nil, mode, {
        -- Original to unilib
        -- (no description)
        tiles = {
            "unilib_machine_weather_switcher_on.png",
            "unilib_machine_weather_switcher_bottom.png",
            "unilib_machine_weather_switcher_side_1.png",
            "unilib_machine_weather_switcher_side_1.png",
            "unilib_machine_weather_switcher_side_2.png",
            "unilib_machine_weather_switcher_side_2.png",
        },
        groups = {cracky = 3, not_in_creative_inventory = 1},
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        drop = "unilib:machine_weather_switcher_off",
        is_ground_content = false,
        light_source = 7,
        node_box = {
            type = "fixed",
            fixed = {
                {-8/16, -8/16, -8/16, 8/16, 7/16, 8/16},    -- Main box
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",

        on_timer = function(pos)

            local node = core.get_node(pos)
            if node.name ~= "unilib:machine_weather_switcher_on" then

                -- Node was dug, since the button was pressed
                return

            end

            core.swap_node(
                pos, {name = "unilib:machine_weather_switcher_off", param2 = node.param2}
            )

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

        local meta = core.get_meta(player_table[pname])
        if not meta then
            return false
        end

        if fields.owner_box then
            meta:set_string("owner_flag", fields.owner_box)
        elseif fields.data_field then
            meta:set_string("data", fields.data_field)
        end

        return true

    end)

    core.register_on_leaveplayer(function(player)
        player_table[player:get_player_name()] = nil
    end)

end
