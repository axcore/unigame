---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    chunkkeeper
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_chunkkeeper = {}

local S = unilib.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end
local mode = unilib.global.imported_mod_table.chunkkeeper.add_mode

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_chunkkeeper.fuel_multiplier = 2.0

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function format_timestamp(timestamp)

    -- Converts a timestamp (in seconds) to a formatted string, in the form "HH:MM:SS" or
    --      "DD::HH:MM:SS"

    local mins = math.floor(timestamp / 60)
    timestamp = timestamp - (mins * 60)
    local hours = math.floor(mins / 60)
    mins = mins - (hours * 60)
    local days = math.floor(hours / 24)
    hours = hours - (days * 24)

    -- N.B. The original code used a timestamp in the form "Nh:Nm:Ns" or "Nd:Nh:Nm:Ns"
    local result = ""
    if days ~= 0 then
        result = result .. days .. ":"
    end

    if days ~= 0 or hours ~= 0 then
        result = result .. string.format("%02d", hours) .. ":"
    end

    if days ~= 0 or hours ~= 0 or mins ~= 0 or timestamp ~= 0 then
        result = result .. string.format("%02d", mins) .. ":" ..
                string.format("%02d", timestamp)
    end

    return result

end

---------------------------------------------------------------------------------------------------
-- Shared functions (callbacks)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_chunkkeeper.after_place_node(pos, placer)

    -- Only update the owner when we have an owner
    if placer and placer:is_player() then

        local meta = core.get_meta(pos)
        meta:set_string("owner", placer:get_player_name())
        core.get_node_timer(pos):start(1)

        if meta:get_int("super_user") == 0 then
            unilib.pkg.shared_chunkkeeper.update_formspec(pos)
        else
            unilib.pkg.shared_chunkkeeper.update_formspec_admin(pos)
        end

    end

end

function unilib.pkg.shared_chunkkeeper.on_receive_fields(pos, formname, fields, player)

    local meta = core.get_meta(pos)
    local run = meta:get_int("running") == 1
    local hide_owner = meta:get_int("hide_owner") == 1
    local super = meta:get_int("super_user") == 1
    local owner = meta:get_string("owner")

    if owner ~= "" and player:get_player_name() ~= owner then

        if not core.check_player_privs(player, {protection_bypass = true}) then
            return
        end

    end

    local dirty_flag = false
    if fields.toggle_running then

        if run then

            meta:set_int("running", 0)
            if not super then
                core.swap_node(pos, {name = "unilib:machine_caretaker_off"})
            else
                core.swap_node(pos, {name = "unilib:admin_machine_caretaker_off"})
            end

            core.forceload_free_block(pos)

        else

            meta:set_int("running", 1)
            if not super then
                core.swap_node(pos, {name = "unilib:machine_caretaker_on"})
            else
                core.swap_node(pos, {name = "unilib:admin_machine_caretaker_on"})
            end

            core.forceload_block(pos)

        end

        dirty_flag = true

    elseif fields.toggle_hide_owner then

        if hide_owner then
            meta:set_int("hide_owner", 0)
        else
            meta:set_int("hide_owner", 1)
        end

        dirty_flag = true

    end

    if dirty_flag then

        if not super then
            unilib.pkg.shared_chunkkeeper.update_formspec(pos)
        else
            unilib.pkg.shared_chunkkeeper.update_formspec_admin(pos)
        end

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (other)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_chunkkeeper.process_fuel(pos)

    -- Removes time from the time_left, except for admin caretaker machines

    local node = core.get_node_or_nil(pos)
    local meta = core.get_meta(pos)
    local timer = meta:get_int("time_left") or 0
    local super = meta:get_int("super_user") == 1
    local run = meta:get_int("running") == 1
    local dirty_flag = false

    if not super and run then

        timer = timer - 1
        if timer <= 0 then

            if timer < 0 then
                timer = 0
            end

            if run then

                meta:set_int("running", 0)
                meta:set_int("time_left", timer)
                run = false
                dirty_flag = true
                core.swap_node(pos, {name = "unilib:machine_caretaker_off"})
                core.forceload_free_block(pos)

            end

        end

        meta:set_int("time_left", timer)
        dirty_flag = true

    elseif super then

        -- Just update with super
        dirty_flag = true

    end

    if dirty_flag then

        if not super then
            unilib.pkg.shared_chunkkeeper.update_formspec(pos)
        else
            unilib.pkg.shared_chunkkeeper.update_formspec_admin(pos)
        end

    end

    return true

end

function unilib.pkg.shared_chunkkeeper.update_formspec(pos)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    local timer = meta:get_int("time_left")
    local super = meta:get_int("super_user") == 1
    local run = meta:get_int("running") == 1
    local hide_owner = meta:get_int("hide_owner") == 1
    local owner = meta:get_string("owner")

    local running_button = ""
    if run then
        running_button = S("Running") .. ": " .. S("On")
    else
        running_button = S("Running") .. ": " .. S("Off")
    end

    local hide_owner_button = ""
    if hide_owner then
        hide_owner_button = S("Owner") .. ": " .. S("Hidden")
    else
        hide_owner_button = S("Owner") .. ": " .. S("Visible")
    end

    local time_str = format_timestamp(timer)

    -- Inventory and settings (formspec)
    -- N.B. The formspec has been tweaked for better aesthetics
    meta:set_string("formspec",
        "size[8,6]" ..
--      "label[0.3,0.3;" .. time_str .. "]" ..
--      "list[context;main;2,0;1,1;]" ..
        "label[0,0.25;" .. FS("Fuel") .. ":]" ..
        "list[context;main;1,0;1,1;]" ..
        "label[3,0.25;" .. FS("Force-load mapblock") .. ": " .. F(time_str) .. "]" ..
--      "button[0,1; 1.5,1;toggle_running;" .. F(running_button) .. "]" ..
        "button[0,1; 2.5,1;toggle_running;" .. F(running_button) .. "]" ..
        "button[3,1; 2.5,1;toggle_hide_owner;" .. F(hide_owner_button) .. "]" ..
        "list[current_player;main;0,2;8,4;]" ..
        "listring[current_player;main]" ..
        "listring[context;main]"
    )

    -- Hover text (infotext)
    local title
    if not super then

        if hide_owner or owner == "" then
            title = unilib.utils.brackets(S("Caretaker Machine"), tostring(time_str))
        else
            title = unilib.utils.brackets(S("@1's Caretaker Machine", owner), tostring(time_str))
        end

    else

        if hide_owner or owner == "" then

            title = unilib.utils.brackets(S("Admin Caretaker Machine"), tostring(time_str))

        else

            title = unilib.utils.brackets(
                S("@1's Adming Caretaker Machine", owner), tostring(time_str)
            )

        end

    end

    meta:set_string("infotext", title)

end

function unilib.pkg.shared_chunkkeeper.update_formspec_admin(pos)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    local timer = meta:get_int("time_left")
    local super = meta:get_int("super_user") == 1
    local run = meta:get_int("running") == 1
    local hide_owner = meta:get_int("hide_owner") == 1
    local owner = meta:get_string("owner")

    local running_button = ""
    if run then
        running_button = S("Running") .. ": " .. S("On")
    else
        running_button = S("Running") .. ": " .. S("Off")
    end

    local hide_owner_button = ""
    if hide_owner then
        hide_owner_button = S("Owner") .. ": " .. S("Hidden")
    else
        hide_owner_button = S("Owner") .. ": " .. S("Visible")
    end

    local time_str = format_timestamp(timer)

    -- Inventory and settings (formspec)
    -- N.B. The formspec has been tweaked for better aesthetics
    meta:set_string("formspec",
        "size[8,6]" ..
--      "label[0.3,0.3;Inf]" ..
        "label[0,0.25;" .. FS("No fuel required") .. "]" ..
        "label[3,0.25;" .. FS("Force-load mapblock") .. ": " .. FS("Indefinite") .. "]" ..
--      "button[0,1; 1.5,1;toggle_running;" .. F(running_button).."]" ..
        "button[0,1; 2.5,1;toggle_running;" .. F(running_button).."]" ..
        "button[3,1; 2.5,1;toggle_hide_owner;" .. F(hide_owner_button) .. "]" ..
        "list[current_player;main;0,2;8,4;]" ..
        "listring[current_player;main]"  ..
        "listring[context;main]"
    )

    -- Hover text (infotext)
    local title
    if not super then

        if hide_owner or owner == "" then
            title = unilib.utils.brackets(S("Caretaker Machine"), tostring(time_str))
        else
            title = unilib.utils.brackets(S("@1's Caretaker Machine", owner), tostring(time_str))
        end

    else

        if hide_owner or owner == "" then

            title = unilib.utils.brackets(S("Admin Caretaker Machine"), tostring(time_str))

        else

            title = unilib.utils.brackets(
                S("@1's Admin Caretaker Machine", owner), tostring(time_str)
            )

        end

    end

    meta:set_string("infotext", title)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_chunkkeeper.init()

    return {
        description = "Shared functions for caretaker machines (from chunkkeeper mod)",
    }

end
