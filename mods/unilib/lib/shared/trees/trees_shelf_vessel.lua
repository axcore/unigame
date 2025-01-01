---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- trees_shelf_vessel.lua
--      Registry functions for vessel shelves
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local vessels_shelf_formspec =
    "size[8,7;]" ..
    "list[context;vessels;0,0.3;8,2;]" ..
    "list[current_player;main;0,2.85;8,1;]" ..
    "list[current_player;main;0,4.08;8,3;8]" ..
    "listring[context;vessels]" ..
    "listring[current_player;main]" ..
    unilib.misc.get_hotbar_bg(0, 2.85)

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function update_vessels_shelf(pos)

    -- Adapted from vessels:shelf

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    local invlist = inv:get_list("vesels")

    local formspec = vessels_shelf_formspec
    -- Inventory slots overlay
    local vx, vy = 0, 0.3
    local n_items = 0

    -- (Vessels shelf has room for 16 vessels)
    for i = 1, 16 do

        if i == 9 then

            vx = 0
            vy = vy + 1

        end

        if not invlist or invlist[i]:is_empty() then

            formspec = formspec ..
                "image[" .. vx .. "," .. vy .. ";1,1;unilib_furniture_shelf_vessel_slot.png]"

        else

            local stack = invlist[i]
            if not stack:is_empty() then
                n_items = n_items + stack:get_count()
            end

        end

        vx = vx + 1

    end

    meta:set_string("formspec", formspec)
    if n_items == 0 then
        meta:set_string("infotext", S("Empty Vessels Shelf"))
    else
        meta:set_string("infotext", S("Vessels Shelf (@1 items)", n_items))
    end

end

---------------------------------------------------------------------------------------------------
-- Registry functions for vessel shelves
---------------------------------------------------------------------------------------------------

function unilib.trees._register_vessels_shelf(data_table)

    -- Adapted from vessels:shelf
    -- Creates a vessels shelf for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.global.tree_table
    --      orig_name (str): e.g. "vessels:shelf"
    --
    -- data_table compulsory fields:
    --      replace_mode (str): e.g. "defer"
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global/global_variables.lua.
    --          If 0, the item is not flammable. If 1-5, overrides the value of "burntime"
    --      burntime (int): e.g. 22. If 0, the item is not flammable
    --      description (str): e.g. "Vessels Shelf (Aspen Wood)"
    --      group_table (table): Complete group table
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local burnlevel = data_table.burnlevel or nil
    local burntime = data_table.burntime or 30
    local description = data_table.description or S("Wooden Vessels Shelf")
    local group_table = data_table.group_table or nil

    local full_name = "unilib:furniture_shelf_vessel_" .. part_name
    local ingredient = "unilib:tree_" .. part_name .. "_wood"
    local shelf_img = "unilib_tree_" .. part_name .. "_wood.png" ..
            "^unilib_furniture_shelf_vessel_overlay.png"
    local wood_img = "unilib_tree_" .. part_name .. "_wood.png"

    if group_table == nil then

        -- N.B. no vessels_shelf = 1 in original code
        group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2, vessels_shelf = 1}

    end

    if burnlevel ~= nil and burnlevel ~= 0 then

        burntime = unilib.global.tree_burn_table.vessels_shelf[burnlevel]

    elseif burnlevel == 0 then

        burntime = 0
        group_table.flammable = nil

    end

    local def_table = {
        description = description,
        tiles = {wood_img, wood_img, wood_img, wood_img, shelf_img, shelf_img},
        groups = group_table,
        sounds = unilib.global.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",

        allow_metadata_inventory_put = function(pos, listname, index, stack, player)

            if core.get_item_group(stack:get_name(), "vessel") ~= 0 then
                return stack:get_count()
            end

            return 0

        end,

        can_dig = function(pos,player)

            local inv = core.get_meta(pos):get_inventory()
            return inv:is_empty("vessels")

        end,

        on_blast = function(pos)

            local drops = {}
            default.get_inventory_drops(pos, "vessels", drops)
            drops[#drops + 1] = full_name
            core.remove_node(pos)
            return drops

        end,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            update_vessels_shelf(pos)
            local inv = meta:get_inventory()
            inv:set_size("vessels", 8 * 2)

        end,

        --[[
        on_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            unilib.utils.log("action", player:get_player_name() ..
                   " moves items in vessels shelf at " .. core.pos_to_string(pos))
            update_vessels_shelf(pos)

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            unilib.utils.log("action", player:get_player_name() ..
                   " moves items to vessels shelf at " .. core.pos_to_string(pos))
            update_vessels_shelf(pos)

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            unilib.utils.log("action", player:get_player_name() ..
                   " takes items from vessels shelf at " .. core.pos_to_string(pos))
            update_vessels_shelf(pos)

        end,
        ]]--

        on_metadata_inventory_move = function(pos)
            update_vessels_shelf(pos)
        end,

        on_metadata_inventory_put = function(pos)
            update_vessels_shelf(pos)
        end,

        on_metadata_inventory_take = function(pos)
            update_vessels_shelf(pos)
        end,
    }
    unilib.utils.set_inventory_action_loggers(def_table, "vessels shelf")
    unilib.register_node(full_name, orig_name, replace_mode, def_table)

    unilib.register_craft({
        output = full_name,
        recipe = {
            {ingredient, ingredient, ingredient},
            {"group:vessel", "group:vessel", "group:vessel"},
            {ingredient, ingredient, ingredient},
        },
    })
    if burntime ~= 0 then

        unilib.register_craft({
            type = "fuel",
            recipe = full_name,
            burntime = burntime,
        })

    end

    return full_name

end
