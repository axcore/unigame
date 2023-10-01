---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    pipeworks
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_default_chest = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

-- Do not change these values
-- The minimum chest inventory size for the "large" chest variant; the maximum inventory size for
--      the "small" chest variant
local default_x = 8
local default_y = 4
-- The number of pages for a new "large" chest
local default_pages = 1

-- Table of all chests currently in their "open" state. The key is a player name; the corresponding
--      value is a table of properties used to switch the "open" chest back to its "closed" state
local open_chest_table = {}

-- Pipeworks compatibility
local pipeworks_flag = false
if minetest.get_modpath("pipeworks") then
    pipeworks_flag = true
end

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_pipeworks_switch(pos, y)

    if not pipeworks_flag then

        return ""

    else

        local formspec = pipeworks.fs_helpers.cycling_button(
            minetest.get_meta(pos),
            "image_button[0," .. tostring(y) .. ";1,0.6",
            "splitstacks",
            {pipeworks.button_off, pipeworks.button_on}
        )

        formspec = formspec .. "label[0.9," .. tostring(y) .. ";" ..
                S("Allow splitting incoming stacks from tubes") .. "]"

        return formspec

    end

end

local function get_chest_formspec(pos, large_flag)

    local formspec
    local pos_str = pos.x .. "," .. pos.y .. "," .. pos.z

    if not large_flag then

        -- "small" chest variant. Adapted from default/chests.lua

        local meta = minetest.get_meta(pos)
        local grid_x = meta:get_int("x")
        local grid_y = meta:get_int("y")

        local pagesize = grid_x * grid_y
        local dx = default_x - grid_x
        local dy = default_y - grid_y

        local pw_dy = 0
        if pipeworks_flag then
            pw_dy = 0.1
        end

        formspec =
            "size[8," .. tostring(9 - dy + pw_dy) .. "]" ..
            -- Chest contents
            "list[nodemeta:" .. pos_str .. ";main;" .. tostring(dx / 2) .. ",0.3;" ..
                    tostring(grid_x) .. "," .. tostring(grid_y) .. ";]" ..
            -- Pipeworks switch (if available)
            get_pipeworks_switch(pos, 4.35 - dy) ..
            -- Player inventory (hotbar)
            "list[current_player;main;0," .. tostring(4.85 - dy + pw_dy) .. ";8,1;]" ..
            "list[current_player;main;0," .. tostring(6.08 - dy + pw_dy) .. ";8,3;8]" ..
            -- Player inventory (other)
            "listring[nodemeta:" .. pos_str .. ";main]" ..
            "listring[current_player;main]" ..
            unilib.get_hotbar_bg(0, 4.85 - dy + pw_dy)

    else

        -- "large" chest variant. Original to unilib

        local meta = minetest.get_meta(pos)
        local page = meta:get_int("page")
        local pagecount = meta:get_int("pagecount")
        local grid_x = meta:get_int("x")
        local grid_y = meta:get_int("y")

        local pagesize = grid_x * grid_y
        local column = (grid_x - default_x) / 2
        local dx = grid_x - default_x
        local dy = grid_y - default_y

        local pw_dy = 0
        if pipeworks_flag then
            pw_dy = 0.5
        end

        formspec =
            "size[" .. tostring(8 + dx) .. "," .. tostring(9.5 + dy + pw_dy) .. "]" ..
            -- Chest contents
            "list[nodemeta:" .. pos_str .. ";main;0,0.3;" .. tostring(grid_x) .. "," ..
                    tostring(grid_y) .. ";" .. tostring((page - 1) * pagesize) .. "]" ..
            -- Pipeworks switch (if available)
            get_pipeworks_switch(pos, 4.3 + dy) ..
            -- Page buttons
            "button[" .. tostring(column + 1) ..  "," .. tostring(4.3 + dy + pw_dy) ..
                    ";1,1;delpage;-]" ..
            "button[" .. tostring(column + 2) ..  "," .. tostring(4.3 + dy + pw_dy) ..
                    ";1,1;prevpage;<<]" ..
            "label[" .. tostring(column + 3) .. "," .. tostring(4.48 + dy + pw_dy) ..
                    ";Page " .. page .. " of " .. pagecount .. "]" ..
            "button[" .. tostring(column + 5) .. "," .. tostring(4.3 + dy + pw_dy) ..
                    ";1,1;nextpage;>>]" ..
            "button[" .. tostring(column + 6) .. "," .. tostring(4.3 + dy + pw_dy) ..
                    ";1,1;addpage;+]" ..
            -- Player inventory (hotbar)
            "list[current_player;main;" .. tostring(column) .. "," ..
                    tostring(4.35 + dy + pw_dy + 1) .. ";8,1;]" ..
            "list[current_player;main;" .. tostring(column) .. "," ..
                    tostring(5.58 + dy + pw_dy + 1) .. ";8,3;8]" ..
            -- Player inventory (other)
            "listring[nodemeta:" .. pos_str .. ";main]" ..
            "listring[current_player;main]" ..
            unilib.get_hotbar_bg(column, 4.35 + dy + pw_dy + 1)

    end

    return formspec

end

local function chest_page_update(pn, player, formname, fields)

    -- Original to unilib

    local chest_open_info = open_chest_table[pn]
    local pos = chest_open_info.pos
    local meta = minetest.get_meta(pos)

    local page = meta:get_int("page")
    if page == nil then

        -- "small" chest variant
        return

    end

    local grid_x = meta:get_int("x")
    local grid_y = meta:get_int("y")
    local pagecount = meta:get_int("pagecount")
    local pagesize = grid_x * grid_y

    if fields.delpage then

        -- User has clicked the "-" (remove page) button

        inv = meta:get_inventory()
        stack_list = inv:get_list("main")

        -- Don't allow the user to remove the first (and only) page
        if pagecount > 1 then

            -- Obviously only remove the last page if it's not empty
            for i = (((pagecount - 1) * pagesize) + 1), (pagecount * pagesize) do

                stack = stack_list[i]
                if stack ~= nil and stack:get_name() ~= "" then

                    minetest.chat_send_player(
                        player:get_player_name(),
                        S("The last page in the chest is not empty!")
                    )

                    return

                end

            end

            pagecount = pagecount - 1
            inv:set_size("main", grid_x * grid_y * pagecount)

            if page > pagecount then
                page = pagecount
            end

        end

    elseif fields.prevpage then

        -- User has clicked the "previous" button
        page = page - 1
        if page < 1 then
            page = pagecount
        end

    elseif fields.nextpage then

        -- User has clicked the "next" button
        page = page + 1
        if page > pagecount then
            page = 1
        end

    elseif fields.addpage then

        -- User has clicked the "+" (add page) button

        inv = meta:get_inventory()
        max_pages = meta:get_int("page_max")

        if max_pages == 0 or pagecount < max_pages then

            pagecount = pagecount + 1
            inv:set_size("main", grid_x * grid_y * pagecount)

        end

    end

    meta:set_int("page", page)
    meta:set_int("pagecount", pagecount)

    minetest.show_formspec(
        player:get_player_name(),
        formname,
        get_chest_formspec(pos, true)
    )

end

local function chest_switch_update(pn, player, formname, fields)

    -- Adapted from pipeworks

    local chest_open_info = open_chest_table[pn]
    local pos = chest_open_info.pos
    local meta = minetest.get_meta(pos)
    local large_flag = false
    if meta:get_int("page") then
        large_flag = true
    end

    if pipeworks.may_configure(pos, player) then

        pipeworks.fs_helpers.on_receive_fields(pos, fields)
        minetest.show_formspec(
            player:get_player_name(),
            formname,
            get_chest_formspec(pos, large_flag)
        )

        return true

    else

        return

    end

end

local function chest_lid_obstructed(pos)

    -- Adapted from default/chests.lua

    local above = {x = pos.x, y = pos.y + 1, z = pos.z}
    local def = minetest.registered_nodes[minetest.get_node(above).name]

    -- Allow ladders, signs, wallmounted things and torches to not obstruct a chest
    if def and (
        def.drawtype == "airlike" or
        def.drawtype == "signlike" or
        def.drawtype == "torchlike" or
        (def.drawtype == "nodebox" and def.paramtype2 == "wallmounted")
    ) then
        return false
    else
        return true
    end

end

local function chest_lid_close(pn)

    -- Adapted from default/chests.lua

    local chest_open_info = open_chest_table[pn]
    local pos = chest_open_info.pos
    local sound = chest_open_info.sound
    local swap = chest_open_info.swap

    open_chest_table[pn] = nil
    for k, v in pairs(open_chest_table) do

        if v.pos.x == pos.x and v.pos.y == pos.y and v.pos.z == pos.z then
            return true
        end

    end

    local node = minetest.get_node(pos)
    if not pipeworks_flag then

        minetest.after(0.2, minetest.swap_node, pos, {name = swap, param2 = node.param2})

    else

        minetest.after(0.2, function()

            minetest.swap_node(pos, {name = swap, param2 = node.param2})
            -- Pipeworks notification
            pipeworks.after_place(pos)

        end)

    end

    minetest.sound_play(sound, {gain = 0.3, pos = pos, max_hear_distance = 10}, true)

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_default_chest.register_chest(data_table)

    -- Adapted from default/chests.lua
    -- Create a chest with a specified capacity
    --
    -- This function creates two types of chest, based on the chests in minetest_game:
    --      - A "small" chest with a capacity of 8x4, or smaller (e.g. the "compact" chest in the
    --          "container_chest_compact" package). The chest's inventory is displayed on a single
    --          formspec page
    --      - A "large" chest with a capacity of 8x4, or larger (e.g. the "bottomless" chest in the
    --          "container_chest_bottomless" package). The chest's inventory is displayed on
    --          multiple formspec pages. The chest can have limited or a limitless capacity
    --
    -- Chests created by this function behave like chests in minetest_game: they can have locked
    --      variants which can be used with skeleton keys
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "ordinary"
    --      orig_name (list): The closed and open chests, in that order, e.g.
    --          {"default:chest", "default:chest_open"},
    --      def_table (table): The partial definition table. See the packages mentioned above for
    --          practical examples
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      grid_x, grid_y (int): The chest inventory size (expressed as a grid with x width and y
    --          height). For a "small" chest, the maximum values are x=8, y=4. For a "large" chest,
    --          the minimum values are x=8, y=4
    --      large_flag (bool): If true, creates the "large" variant. If false (default), creates the
    --          "small" variant
    --      max_pages (int): The absolute maximum number of pages for a "large" chest. If zero, no
    --          no maximum applies. Otherwise, a positive integer (default 1). Ignored for "small"
    --          chests

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local def_table = data_table.def_table

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local grid_x = data_table.grid_x or default_x
    local grid_y = data_table.grid_y or default_y
    local large_flag = data_table.large_flag or false
    local max_pages = data_table.max_pages or nil

    local full_name = "unilib:container_chest_" .. part_name

    if not large_flag then

        if grid_x > default_x then
            grid_x = default_x
        end

        if grid_y > default_y then
            grid_y = default_y
        end

    else

        if grid_x < default_x then
            grid_x = default_x
        end

        if grid_y < default_y then
            grid_y = default_y
        end

        if max_pages == nil or (max_pages ~= 0 and max_pages < default_pages) then
            max_pages = default_pages
        end

    end

    if def_table.tiles and pipeworks_flag then

        for i = 1, 4 do

            -- (Imported the texture from pipeworks, in case its filename is changed)
            def_table.tiles[i] = def_table.tiles[i] .. "^unilib_tube_connection_wood.png"

        end

    end

    if def_table.groups and pipeworks_flag then

        def_table.groups.tubedevice = 1
        def_table.groups.tubedevice_receiver = 1

    end

    def_table.drawtype = "mesh"
    def_table.is_ground_content = false
    def_table.paramtype = "light"
    def_table.paramtype2 = "facedir"
    def_table.visual = "mesh"

    if def_table.protected then

        if pipeworks_flag then
            def_table.after_dig_node = pipeworks.after_dig
        end

        def_table.after_place_node = function(pos, placer)

            local meta = minetest.get_meta(pos)
            meta:set_string("owner", placer:get_player_name() or "")
            meta:set_string(
                "infotext",
                unilib.brackets(def_table.description, S("owned by @1", meta:get_string("owner")))
            )

            if pipeworks_flag then
                pipeworks.after_place(pos)
            end

        end

        def_table.allow_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            if not unilib.can_interact_with_node(player, pos) then
                return 0
            end

            return count

        end

        def_table.allow_metadata_inventory_put = function(pos, listname, index, stack, player)

            if not unilib.can_interact_with_node(player, pos) then
                return 0
            end

            return stack:get_count()

        end

        def_table.allow_metadata_inventory_take = function(pos, listname, index, stack, player)

            if not unilib.can_interact_with_node(player, pos) then
                return 0
            end

            return stack:get_count()

        end

        def_table.can_dig = function(pos,player)

            local meta = minetest.get_meta(pos);
            local inv = meta:get_inventory()
            return inv:is_empty("main") and unilib.can_interact_with_node(player, pos)

        end

        def_table.on_blast = function() end

        def_table.on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            meta:set_string("infotext", def_table.description)
            meta:set_string("owner", "")
            local inv = meta:get_inventory()

            if not large_flag then

                inv:set_size("main", grid_x * grid_y)
                meta:set_int("x", grid_x)
                meta:set_int("y", grid_y)

            else

                inv:set_size("main", grid_x * grid_y * default_pages)
                meta:set_int("page", 1)
                meta:set_int("pagecount", default_pages)
                meta:set_int("pagemax", max_pages)
                meta:set_int("x", grid_x)
                meta:set_int("y", grid_y)

            end

        end

        def_table.on_key_use = function(pos, player)

            local secret = minetest.get_meta(pos):get_string("key_lock_secret")
            local itemstack = player:get_wielded_item()
            local key_meta = itemstack:get_meta()

            if itemstack:get_metadata() == "" then
                return
            end

            if key_meta:get_string("secret") == "" then

                key_meta:set_string(
                    "secret",
                    minetest.parse_json(itemstack:get_metadata()).secret
                )
                itemstack:set_metadata("")

            end

            if secret ~= key_meta:get_string("secret") then
                return
            end

            minetest.show_formspec(
                player:get_player_name(),
                full_name .. "_locked",
                get_chest_formspec(pos, large_flag)
            )

        end

        def_table.on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

            if not unilib.can_interact_with_node(clicker, pos) then
                return itemstack
            end

            minetest.sound_play(
                def_table.sound_open,
                {gain = 0.3, pos = pos, max_hear_distance = 10},
                true
            )

            if not chest_lid_obstructed(pos) then
                minetest.swap_node(pos, { name = full_name .. "_open", param2 = node.param2 })
            end

            minetest.after(
                0.2,
                minetest.show_formspec,
                clicker:get_player_name(),
                full_name,
                get_chest_formspec(pos, large_flag)
            )

            open_chest_table[clicker:get_player_name()] = {
                pos = pos,
                sound = def_table.sound_close,
                swap = full_name,
            }

        end

        if pipeworks_flag then
            def_table.on_rotate = pipeworks.on_rotate
        end

        def_table.on_skeleton_key_use = function(pos, player, newsecret)

            local meta = minetest.get_meta(pos)
            local owner = meta:get_string("owner")
            local pn = player:get_player_name()

            -- Verify placer is owner of lockable chest
            if owner ~= pn then

                minetest.record_protection_violation(pos, pn)
                minetest.chat_send_player(pn, S("You do not own this chest"))
                return nil

            end

            local secret = meta:get_string("key_lock_secret")
            if secret == "" then

                secret = newsecret
                meta:set_string("key_lock_secret", secret)

            end

            return secret, S("a locked chest"), owner

        end

    else

        if pipeworks_flag then

            def_table.after_place_node = pipeworks.after_place
            def_table.after_dig_node = pipeworks.after_dig

        end

        def_table.can_dig = function(pos,player)

            local meta = minetest.get_meta(pos);
            local inv = meta:get_inventory()
            return inv:is_empty("main")

        end

        def_table.on_blast = function(pos)

            local drops = {}
            unilib.get_inventory_drops(pos, "main", drops)
            drops[#drops + 1] = full_name
            minetest.remove_node(pos)
            return drops

        end

        def_table.on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            meta:set_string("infotext", def_table.description)
            local inv = meta:get_inventory()
            if not large_flag then

                inv:set_size("main", grid_x * grid_y)
                meta:set_int("x", grid_x)
                meta:set_int("y", grid_y)

            else

                inv:set_size("main", grid_x * grid_y * default_pages)
                meta:set_int("page", 1)
                meta:set_int("pagecount", default_pages)
                meta:set_int("pagemax", max_pages)
                meta:set_int("x", grid_x)
                meta:set_int("y", grid_y)

            end

        end

        def_table.on_rightclick = function(pos, node, clicker)

            minetest.sound_play(
                def_table.sound_open,
                {gain = 0.3, pos = pos, max_hear_distance = 10},
                true
            )

            if not chest_lid_obstructed(pos) then
                minetest.swap_node(pos, {name = full_name .. "_open", param2 = node.param2})
            end

            minetest.after(
                0.2,
                minetest.show_formspec,
                clicker:get_player_name(),
                full_name,
                get_chest_formspec(pos, large_flag)
            )

            open_chest_table[clicker:get_player_name()] = {
                pos = pos,
                sound = def_table.sound_close,
                swap = full_name,
            }

        end

        if pipeworks_flag then
            def_table.on_rotate = pipeworks.on_rotate
        end

    end

    def_table.on_metadata_inventory_move = function(
        pos, from_list, from_index, to_list, to_index, count, player
    )
        unilib.log(
            "action",
            player:get_player_name() .. " moves stuff in chest at " .. minetest.pos_to_string(pos)
        )

    end

    def_table.on_metadata_inventory_put = function(pos, listname, index, stack, player)

        unilib.log(
            "action",
            player:get_player_name() .. " moves " .. stack:get_name() .. " to chest at " ..
                    minetest.pos_to_string(pos)
        )

    end

    def_table.on_metadata_inventory_take = function(pos, listname, index, stack, player)

        unilib.log(
            "action",
            player:get_player_name() .. " takes " .. stack:get_name() .. " from chest at " ..
                    minetest.pos_to_string(pos)
        )

    end

    if pipeworks_flag then

        def_table.tube = {
            connect_sides = {left = 1, right = 1, back = 1, bottom = 1, top = 1},
            input_inventory = "main",

            can_insert = function(pos, node, stack, direction)

                local meta = minetest.get_meta(pos)
                local inv = meta:get_inventory()
                if meta:get_int("splitstacks") == 1 then
                    stack = stack:peek_item(1)
                end

                return inv:room_for_item("main", stack)

            end,

            insert_object = function(pos, node, stack, direction)

                local meta = minetest.get_meta(pos)
                local inv = meta:get_inventory()
                return inv:add_item("main", stack)

            end,
        }

    end

    local def_opened = table.copy(def_table)
    local def_closed = table.copy(def_table)

    def_opened.mesh = "unilib_chest_open.obj"
    for i = 1, #def_opened.tiles do

        if type(def_opened.tiles[i]) == "string" then
            def_opened.tiles[i] = {name = def_opened.tiles[i], backface_culling = true}
        elseif def_opened.tiles[i].backface_culling == nil then
            def_opened.tiles[i].backface_culling = true
        end

    end

    def_opened.drop = full_name
    def_opened.groups.not_in_creative_inventory = 1
    def_opened.selection_box = {
        type = "fixed",
        fixed = {-1/2, -1/2, -1/2, 1/2, 3/16, 1/2},
    }

    def_opened.can_dig = function()
        return false
    end

    def_opened.on_blast = function() end

    def_closed.mesh = nil
    def_closed.drawtype = nil
    -- Swap textures around for "normal" drawtype to make them match the mesh
    def_closed.tiles[6] = def_table.tiles[5]
    def_closed.tiles[5] = def_table.tiles[3]
    def_closed.tiles[3] = def_table.tiles[3] .. "^[transformFX"

    -- ("orig_name" should be a list containing both variants, the "open" variant last)
    unilib.register_node(full_name, orig_name, replace_mode, def_closed)
    unilib.register_node(full_name .. "_open", nil, replace_mode, def_opened)

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

minetest.register_on_player_receive_fields(function(player, formname, fields)

    -- Adapted from default/chests.lua
    -- Handles opening/closing the chest and responds to any button presses in the chest's formspec

    if string.find(formname, "unilib:container_chest_") == nil or not player then
        return
    end

    local pn = player:get_player_name()
    if not open_chest_table[pn] then
        return
    end

    if fields.delpage or fields.prevpage or fields.nextpage or fields.addpage then

        chest_page_update(pn, player, formname, fields)
        return true

    elseif fields.quit then

        chest_lid_close(pn)
        return true

    elseif pipeworks_flag then

        -- (Returns nil or true)
        return chest_switch_update(pn, player, formname, fields)

    end

end)

minetest.register_on_leaveplayer(function(player)

    -- Adapted from default/chests.lua

    local pn = player:get_player_name()
    if open_chest_table[pn] then
        chest_lid_close(pn)
    end

end)

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_default_chest.init()

    return {
        description = "Shared functions for chests (from minetest_game/default)",
        notes = "This package creates two types of chest, based on the chests in minetest_game:" ..
                " a \"small\" chest with a capacity of 8x4 or smaller, and a \"large\" chest" ..
                " with a capacity of 8x4 or larger. \"large\" chests display their inventory" ..
                " on multiple pages, and can have a limited or infinite capacity",
        mod_optional = "pipeworks",
    }

end
