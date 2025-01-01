---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- trees_shelf_utility.lua
--      Registry functions for utility shelves
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Registry functions for utility shelves
---------------------------------------------------------------------------------------------------

function unilib.trees._register_utility_shelf(data_table)

    -- Adapted from moreblocks:empty_shelf and xdecor:multishelf
    -- Creates a utility shelf for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    -- Unlike bookshelves and vessels shelves, utility shelves can contain any item
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.global.tree_table
    --      orig_name (str): e.g. "moreblocks:empty_shelf"
    --
    -- data_table compulsory fields:
    --      replace_mode (str): e.g. "defer"
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global/global_variables.lua.
    --          If 0, the item is not flammable. If 1-5, overrides the value of "burntime"
    --      burntime (int): e.g. 22. If 0, the item is not flammable
    --      description (str): e.g. "Utility Shelf (Aspen Wood)"
    --      group_table (table): Complete group table
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local burnlevel = data_table.burnlevel or nil
    local burntime = data_table.burntime or 22
    local description = data_table.description or S("Wooden Utility Shelf")
    local group_table = data_table.group_table or nil

    local full_name = "unilib:furniture_shelf_utility_" .. part_name
    local wood_img = "unilib_tree_" .. part_name .. "_wood.png"
    local shelf_img = wood_img .. "^unilib_furniture_shelf_utility_overlay.png"
    local wood_name = "unilib:tree_" .. part_name .. "_wood"

    if group_table == nil then

        -- N.B. no utility_shelf = 1 in original code
        group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2, utility_shelf = 1}

    end

    if burnlevel ~= nil and burnlevel ~= 0 then

        burntime = unilib.global.tree_burn_table.utility_shelf[burnlevel]

    elseif burnlevel == 0 then

        burntime = 0
        group_table.flammable = nil

    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {wood_img, wood_img, wood_img, wood_img, shelf_img, shelf_img},
        groups = group_table,
        sounds = unilib.global.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",

        --[[
        can_dig = function(pos)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            return inv:is_empty("main")

        end,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            meta:set_string(
                "formspec",
                "size[8,8]" ..
                "list[context;main;0,0;8,3;]" ..
                "list[current_player;main;0,4;8,4;]" ..
                "listring[current_player;main]" ..
                "listring[context;main]"
            )
            meta:set_string("infotext", description)
            local inv = meta:get_inventory()
            inv:set_size("main", 24)

        end,

        on_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            -- N.B. Not in original code
            unilib.utils.log("action", player:get_player_name() ..
                   " moves items in utility shelf at " .. core.pos_to_string(pos))

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            -- N.B. Not in original code
            unilib.utils.log("action", player:get_player_name() ..
                   " moves items to utility shelf at " .. core.pos_to_string(pos))

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            -- N.B. Not in original code
            unilib.utils.log("action", player:get_player_name() ..
                   " takes items from utility shelf at " .. core.pos_to_string(pos))

        end,
        ]]--
    })
    unilib.register_craft({
        output = full_name,
        recipe = {
            {wood_name, wood_name, wood_name},
            {"group:vessel", "group:book", "group:vessel"},
            {wood_name, wood_name, wood_name},
        },
    })
    if burntime ~= 0 then

        unilib.register_craft({
            type = "fuel",
            recipe = full_name,
            burntime = burntime,
        })

    end

    -- N.B. Original code provided 3 rows of storage; here, it has been reduced to 2 rows to match
    --      bookshelves and vessels shelves
    unilib.furniture.convert_to_container(full_name, 2, description, "utility shelf")

    return full_name

end

function unilib.trees._register_empty_utility_shelf(data_table)

    -- Adapted from moreblocks:empty_shelf
    -- Creates an empty utility shelf for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    -- Empty shelves don't accept items (so they are purely decorative)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.global.tree_table
    --      orig_name (str): e.g. "moreblocks:empty_shelf"
    --
    -- data_table compulsory fields:
    --      replace_mode (str): e.g. "defer"
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global/global_variables.lua.
    --          If 0, the item is not flammable. If 1-5, overrides the value of "burntime"
    --      burntime (int): e.g. 22. If 0, the item is not flammable
    --      description (str): e.g. "Empty Utility Shelf (Aspen Wood)"
    --      group_table (table): Complete group table
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local burnlevel = data_table.burnlevel or nil
    local burntime = data_table.burntime or 22
    local description = data_table.description or S("Empty Wooden Utility Shelf")
    local group_table = data_table.group_table or nil

    local full_name = "unilib:furniture_shelf_utility_" .. part_name .. "_empty"
    local bookshelf_name = "unilib:furniture_shelf_bookshelf_" .. part_name
    local sweeper_name = "unilib:item_sweeper"
    local vessels_shelf_name = "unilib:furniture_shelf_vessel_" .. part_name
    local wood_img = "unilib_tree_" .. part_name .. "_wood.png"
    local shelf_img = wood_img .. "^unilib_furniture_shelf_utility_empty_overlay.png"
    local wood_name = "unilib:tree_" .. part_name .. "_wood"

    if group_table == nil then
        group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2}
    end

    if burnlevel ~= nil and burnlevel ~= 0 then

        burntime = unilib.global.tree_burn_table.utility_shelf[burnlevel]

    elseif burnlevel == 0 then

        burntime = 0
        group_table.flammable = nil

    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {wood_img, wood_img, wood_img, wood_img, shelf_img, shelf_img},
        groups = group_table,
        sounds = unilib.global.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",
    })
    -- (Craft recipe from xdecor)
    unilib.register_craft({
        output = full_name,
        recipe = {
            {wood_name, wood_name, wood_name},
            {"", "", ""},
            {wood_name, wood_name, wood_name},
        },
    })
    if unilib.global.pkg_executed_table["item_book_ordinary"] ~= nil then

        local book_name = "unilib:item_book_ordinary"

        -- (This recipe is in moreblocks)
        unilib.register_craft({
            type = "shapeless",
            output = bookshelf_name,
            recipe = {full_name, book_name, book_name, book_name},
        })

        if unilib.global.pkg_executed_table["item_sweeper"] ~= nil then

            unilib.register_craft({
                type = "shapeless",
                output = full_name,
                recipe = {sweeper_name, bookshelf_name},
                replacements = {{bookshelf_name, book_name .. " 3"}},
            })

        end

    end
    if unilib.global.pkg_executed_table["vessel_bottle_glass_empty"] ~= nil then

        local bottle_name = "unilib:vessel_bottle_glass_empty"

        -- (This recipe is not in moreblocks)
        unilib.register_craft({
            type = "shapeless",
            output = vessels_shelf_name,
            recipe = {full_name, bottle_name, bottle_name, bottle_name},
        })

        if unilib.global.pkg_executed_table["item_sweeper"] ~= nil then

            unilib.register_craft({
                type = "shapeless",
                output = full_name,
                recipe = {sweeper_name, vessels_shelf_name},
                replacements = {{vessels_shelf_name, bottle_name .. " 3"}},
            })

        end

    end
    if burntime ~= 0 then

        unilib.register_craft({
            type = "fuel",
            recipe = full_name,
            burntime = burntime,
        })

    end

    return full_name

end
