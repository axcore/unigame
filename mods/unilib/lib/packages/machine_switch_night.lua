---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_switch_night = {}

local S = unilib.intllib
local FS = function(...) return core.formspec_escape(S(...)) end
local mode = unilib.global.imported_mod_table.unilib.add_mode

local this_formname = "unilib:form_machine_switch_night"

-- Table of player names, and the position of the most recent machine for which a formspec was
--      opened
local player_table = {}
-- List of switchable times
local time_list = {
    {FS("Switch to dusk (19:12)"), 0.8},
    {FS("Switch to evening (21:36)"), 0.9},
    {FS("Switch to midnight (00:00)"), 0},
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_formspec(pname, pos)

    local meta = core.get_meta(pos)
    local data = meta:get_string("data")
    local owner_flag = meta:get_string("owner_flag")

    player_table[pname] = pos

    local formspec = "size[8,3.2]" ..
        "image[0,0;1,1;unilib_machine_switch_night_side.png]" ..
        "label[1,0.25;" .. FS("Switch to night") .. "]" ..
        "dropdown[0.5,1.5;7;dropdown_box;"

    for i, mini_list in ipairs(time_list) do

        formspec = formspec .. mini_list[1]
        if i < #time_list then
            formspec = formspec .. ","
        end

    end

    formspec = formspec .. ";" .. data .. ";true]" ..
        "checkbox[0,2.5;owner_box;" .. FS("Only the owner may use this machine") .. ";" ..
            owner_flag .. "]"

    return formspec

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_switch_night.init()

    return {
        description = "Night-switching machine",
        notes = "Right-click the machine to specify a time in the morning (from dusk to" ..
                " midnight). Punch the machine to set the time of day for all players. See also" ..
                " the \"machine_switch_night\" package",
        depends = {"metal_copper", "metal_tin", "mineral_diamond"},
    }

end

function unilib.pkg.machine_switch_night.exec()

    unilib.register_node("unilib:machine_switch_night_off", nil, mode, {
        -- Original to unilib
        description = unilib.utils.brackets(
            S("Night-Switching Machine"), S("punch to change the time, right-click to configure")
        ),
        tiles = {
            "unilib_machine_switch_night_off.png",
            "unilib_machine_switch_night_bottom.png",
            "unilib_machine_switch_night_side.png",
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

        end,

        on_punch = function(pos, node, puncher)

            local pname = puncher:get_player_name()
            if not pname then
                return
            end

            local meta = core.get_meta(pos)
            if meta:get_string("owner_flag") == "true" and meta:get_string("owner") ~= pname then

                core.chat_send_player(pname, S("This machine doesn't belong to you"))
                return

            end

            -- (The button is not "pressed" when the punching player is wielding a tool like a
            --      pickaxe)
            local wielded = puncher:get_wielded_item()
            if wielded and core.registered_tools[wielded:get_name()] ~= nil then
                return
            end

            core.swap_node(pos, {name = "unilib:machine_switch_night_on", param2 = node.param2})
            core.sound_play("unilib_misc_bin_skip", {pos = pos}, true)
            core.get_node_timer(pos):start(2)

            local data = meta:get_string("data")
            if data == "" then
                data = 1
            else
                data = tonumber(data)
            end

            core.set_timeofday(time_list[data][2])

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

            core.show_formspec(pname, this_formname, get_formspec(pname, pos))

        end,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:machine_switch_night_off",
        recipe = {
            {"", "unilib:metal_copper_ingot", ""},
            {"unilib:metal_tin_ingot", "unilib:mineral_diamond_block", "unilib:metal_tin_ingot"},
            {"unilib:metal_tin_ingot", "unilib:metal_tin_ingot", "unilib:metal_tin_ingot"},
        },
    })
    -- N.B. Items in this mod were renamed in unilib v1.2.0
    core.register_alias("unilib:machine_switch_night", "unilib:machine_switch_night_off")

    unilib.register_node("unilib:machine_switch_night_on", nil, mode, {
        -- Original to unilib
        -- (no description)
        tiles = {
            "unilib_machine_switch_night_on.png",
            "unilib_machine_switch_night_bottom.png",
            "unilib_machine_switch_night_side.png",
        },
        groups = {cracky = 3, not_in_creative_inventory = 1},
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        drop = "unilib:machine_switch_night_off",
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
            if node.name ~= "unilib:machine_switch_night_on" then

                -- Node was dug, since the button was pressed
                return

            end

            core.swap_node(pos, {name = "unilib:machine_switch_night_off", param2 = node.param2})

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
        elseif fields.dropdown_box then
            meta:set_string("data", fields.dropdown_box)
        end

        return true

    end)

    core.register_on_leaveplayer(function(player)
        player_table[player:get_player_name()] = nil
    end)

end
