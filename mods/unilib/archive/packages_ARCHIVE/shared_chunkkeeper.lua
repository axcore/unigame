---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    chunkkeeper
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- Removes time from the time_left, but allows for super_user placed versions with no issues
function chunkkeeper.processFuel(pos)
    local node = minetest.get_node_or_nil(pos)
    local meta = minetest.get_meta(pos)
    local timer = meta:get_int("time_left") or 0
    local super = meta:get_int("super_user") == 1
    local run = meta:get_int("running") == 1
    local dirty = false
    --chunkkeeper.log({timer=timer, super=super, running=run})
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
                --chunkkeeper.log({timer=timer, super=super, running=run})
                dirty = true
                minetest.swap_node(pos, {name = "chunkkeeper:keeper_off"})
                minetest.forceload_free_block(pos)
            end
        end
        meta:set_int("time_left", timer)
        dirty = true
    elseif super then -- Just update with super
        dirty = true
    end

    if dirty then
        if not super then
            chunkkeeper.update_formspec(pos)
        else
            chunkkeeper.update_formspec_inf(pos)
        end
    end
    return true
end

-- Returns days hours minutes and seconds of a given timestamp (in seconds)
function chunkkeeper.ts2string(timestamp)
    local mins = math.floor(timestamp / 60)
    timestamp = timestamp - (mins * 60)
    local hours = math.floor(mins / 60)
    mins = mins - (hours * 60)
    local days = math.floor(hours / 24)
    hours = hours - (days * 24)

    local result = ""
    if days ~= 0 then
        result = result .. days .. "d"
    end
    if hours ~= 0 then
        result = result .. hours .. "h"
    end
    if mins ~= 0 then
        result = result .. mins .. "m"
    end
    result = result .. timestamp .. "s"
    return result
end

function chunkkeeper.update_formspec(pos)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local timer = meta:get_int("time_left")
    local super = meta:get_int("super_user") == 1
    local run = meta:get_int("running") == 1
    local hide_owner = meta:get_int("hide_owner") == 1
    local owner = meta:get_string("owner")

    local running_button = ""
    if run then
        running_button = "Run: On"
    else
        running_button = "Run: Off"
    end
    local hide_owner_button = ""
    if hide_owner then
        hide_owner_button = "Owner: Hidden"
    else
        hide_owner_button = "Owner: Shown"
    end

    -- Inventory and settings (formspec)
    if chunkkeeper.get_game() == "MTG" then
        meta:set_string("formspec",
            "size[8,6]" ..
            "label[0.3,0.3;"..chunkkeeper.ts2string(timer).."]" ..
            "list[context;main;2,0;1,1;]" ..
            "button[0,1; 1.5,1;toggle_running;"..minetest.formspec_escape(running_button).."]" ..
            "button[3,1; 2.5,1;toggle_hide_owner;" .. minetest.formspec_escape(hide_owner_button) .."]" ..
            "list[current_player;main;0,2;8,4;]" ..
            "listring[current_player;main]"  ..
            "listring[context;main]"
        )
    elseif chunkkeeper.get_game() == "MCL" and mclform ~= nil then
        meta:set_string("formspec",
            "size[9, 6.5]"..
            "label[0.3,0.3;"..chunkkeeper.ts2string(timer).."]"..
            "list[context;main;2,0;1,1;]"..
            mclform.get_itemslot_bg(2, 0, 1, 1)..
            "button[0,1; 1.5,1;toggle_running;"..minetest.formspec_escape(running_button).."]" ..
            "button[3,1; 2.5,1;toggle_hide_owner;" .. minetest.formspec_escape(hide_owner_button) .."]" ..
            "label[0,1.85;Inventory]"..
--            "list[current_player;main;0,6.5;9,4;]" ..
--            mclform.get_itemslot_bg(0, 6.5, 9, 4)..
		    "list[current_player;main;0,2.5;9,3;9]"..
		    mclform.get_itemslot_bg(0,2.5,9,3)..
		    "list[current_player;main;0,5.74;9,1;]"..
		    mclform.get_itemslot_bg(0,5.74,9,1)..
            "listring[current_player;main]"  ..
            "listring[context;main]"
        )
    end

    -- Hover text (infotext)
    local title = owner .. "'s Chunk Keeper (" .. tostring(chunkkeeper.ts2string(timer)) .. ")"
    if hide_owner or owner == "" then
        title = "Chunk Keeper (" .. tostring(chunkkeeper.ts2string(timer)) .. ")"
    end
    if super then
        if not hide_owner and owner ~= "" then
            title = owner .. "'s Chunk Keeper (Inf)"
        else
            title = "Chunk Keeper (Inf)"
        end
    end

    meta:set_string("infotext", title)
end

function chunkkeeper.update_formspec_inf(pos)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local timer = meta:get_int("time_left")
    local super = meta:get_int("super_user") == 1
    local run = meta:get_int("running") == 1
    local hide_owner = meta:get_int("hide_owner") == 1
    local owner = meta:get_string("owner")

    local running_button = ""
    if run then
        running_button = "Run: On"
    else
        running_button = "Run: Off"
    end
    local hide_owner_button = ""
    if hide_owner then
        hide_owner_button = "Owner: Hidden"
    else
        hide_owner_button = "Owner: Shown"
    end

    -- Inventory and settings (formspec)
    if chunkkeeper.get_game() == "MTG" then
        meta:set_string("formspec",
            "size[8,6]" ..
            "label[0.3,0.3;Inf]" ..
            "button[0,1; 1.5,1;toggle_running;"..minetest.formspec_escape(running_button).."]" ..
            "button[3,1; 2.5,1;toggle_hide_owner;" .. minetest.formspec_escape(hide_owner_button) .."]" ..
            "list[current_player;main;0,2;8,4;]" ..
            "listring[current_player;main]"  ..
            "listring[context;main]"
        )
    elseif chunkkeeper.get_game() == "MCL" and mclform ~= nil then
        meta:set_string("formspec",
            "size[9, 6.5]"..
            "label[0.3,0.3;Inf]"..
            "button[0,1; 1.5,1;toggle_running;"..minetest.formspec_escape(running_button).."]" ..
            "button[3,1; 2.5,1;toggle_hide_owner;" .. minetest.formspec_escape(hide_owner_button) .."]" ..
            "label[0,1.85;Inventory]"..
--            "list[current_player;main;0,6.5;9,4;]" ..
--            mclform.get_itemslot_bg(0, 6.5, 9, 4)..
		    "list[current_player;main;0,2.5;9,3;9]"..
		    mclform.get_itemslot_bg(0,2.5,9,3)..
		    "list[current_player;main;0,5.74;9,1;]"..
		    mclform.get_itemslot_bg(0,5.74,9,1)..
            "listring[current_player;main]"  ..
            "listring[context;main]"
        )
    end

    -- Hover text (infotext)
    local title = owner .. "'s Chunk Keeper (Inf)"
    if hide_owner or owner == "" then
        title = "Chunk Keeper (Inf)"
    end
    if super then
        if not hide_owner and owner ~= "" then
            title = owner .. "'s Chunk Keeper (Inf)"
        else
            title = "Chunk Keeper (Inf)"
        end
    end

    meta:set_string("infotext", title)
end
]]--
