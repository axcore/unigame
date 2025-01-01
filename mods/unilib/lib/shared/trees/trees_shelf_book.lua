---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- trees_shelf_book.lua
--      Registry functions for bookshelves
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local bookshelf_formspec =
        "size[8,7;]" ..
        "list[context;books;0,0.3;8,2;]" ..
        "list[current_player;main;0,2.85;8,1;]" ..
        "list[current_player;main;0,4.08;8,3;8]" ..
        "listring[context;books]" ..
        "listring[current_player;main]" ..
        unilib.misc.get_hotbar_bg(0, 2.85)

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function update_bookshelf(pos)

    -- Adapted from default:bookshelf

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    local invlist = inv:get_list("books")

    local formspec = bookshelf_formspec
    -- Inventory slots overlay
    local bx, by = 0, 0.3
    local n_written, n_empty = 0, 0

    -- (Bookshelf has room for 16 books)
    for i = 1, 16 do

        if i == 9 then

            bx = 0
            by = by + 1

        end

        local stack = invlist[i]
        if stack:is_empty() then

            formspec = formspec ..
                "image[" .. bx .. "," .. by .. ";1,1;unilib_furniture_shelf_bookshelf_slot.png]"

        else

            local metatable = stack:get_meta():to_table() or {}
            if metatable.fields and metatable.fields.text then
                n_written = n_written + stack:get_count()
            else
                n_empty = n_empty + stack:get_count()
            end

        end

        bx = bx + 1

    end

    meta:set_string("formspec", formspec)
    if n_written + n_empty == 0 then
        meta:set_string("infotext", S("Empty Bookshelf"))
    else
        meta:set_string("infotext", S("Bookshelf (@1 written, @2 empty books)", n_written, n_empty))
    end

end

---------------------------------------------------------------------------------------------------
-- Registry functions for bookshelves
---------------------------------------------------------------------------------------------------

function unilib.trees._register_bookshelf(data_table)

    -- Adapted from default:bookshelf
    -- Creates a bookshelf for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.global.tree_table
    --      orig_name (str): e.g. "default:bookshelf"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global/global_variables.lua.
    --          If 0, the item is not flammable. If 1-5, overrides the value of "burntime"
    --      burntime (int): e.g. 22. If 0, the item is not flammable
    --      description (str): e.g. "Bookshelf (Aspend Wood)"
    --      group_table (table): Complete group table
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local burnlevel = data_table.burnlevel or nil
    local burntime = data_table.burntime or 30
    local description = data_table.description or S("Wooden Bookshelf")
    local group_table = data_table.group_table or nil

    local full_name = "unilib:furniture_shelf_bookshelf_" .. part_name
    local book_name = "unilib:item_book_ordinary"
    local ingredient = "unilib:tree_" .. part_name .. "_wood"
    local shelf_img = "unilib_tree_" .. part_name .. "_wood.png" ..
            "^unilib_furniture_shelf_bookshelf_overlay.png"
    local wood_img = "unilib_tree_" .. part_name .. "_wood.png"

    if group_table == nil then

        -- N.B. no bookshelf = 1 in original code
        group_table = {bookshelf = 1, choppy = 3, flammable = 3, oddly_breakable_by_hand = 2}

    end

    if burnlevel ~= nil and burnlevel ~= 0 then

        burntime = unilib.global.tree_burn_table.bookshelf[burnlevel]

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

        allow_metadata_inventory_put = function(pos, listname, index, stack)

            if core.get_item_group(stack:get_name(), "book") ~= 0 then
                return stack:get_count()
            end

            return 0

        end,

        can_dig = function(pos,player)

            local inv = core.get_meta(pos):get_inventory()
            return inv:is_empty("books")

        end,

        on_blast = function(pos)

            local drops = {}
            unilib.misc.get_inventory_drops(pos, "books", drops)
            drops[#drops+1] = full_name
            core.remove_node(pos)
            return drops

        end,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            inv:set_size("books", 8 * 2)
            update_bookshelf(pos)

        end,

        --[[
        on_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            unilib.utils.log("action", player:get_player_name() ..
                    " moves items in bookshelf at " .. core.pos_to_string(pos))
            update_bookshelf(pos)

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            unilib.utils.log("action", player:get_player_name() ..
                    " puts items to bookshelf at " .. core.pos_to_string(pos))
            update_bookshelf(pos)

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            unilib.utils.log("action", player:get_player_name() ..
                    " takes items from bookshelf at " .. core.pos_to_string(pos))
            update_bookshelf(pos)

        end,
        ]]--

        on_metadata_inventory_move = function(pos)
            update_bookshelf(pos)
        end,

        on_metadata_inventory_put = function(pos)
            update_bookshelf(pos)
        end,

        on_metadata_inventory_take = function(pos)
            update_bookshelf(pos)
        end,
    }
    unilib.utils.set_inventory_action_loggers(def_table, "bookshelf")
    unilib.register_node(full_name, orig_name, replace_mode, def_table)

    unilib.register_craft({
        output = full_name,
        recipe = {
            {ingredient, ingredient, ingredient},
            {book_name, book_name, book_name},
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
