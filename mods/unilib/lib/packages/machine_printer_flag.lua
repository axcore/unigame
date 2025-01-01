---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    offend_flags
-- Code:    LGPL-3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_printer_flag = {}

local S = unilib.intllib
local FS = function(...) return core.formspec_escape(S(...)) end
local mode = unilib.global.imported_mod_table.offend_flags.add_mode

local flag_data_list = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function check_supplies(pos)

    -- Called by populate_output()
    -- Flags are only visible in the flag printer if the user has added ink cartridges and a flag
    --      mast
    --
    -- Return values:
    --      Returns true if flags can be displayed, false if they can't be displayed

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    local redcart = inv:get_stack("redcart", 1)
    local greencart = inv:get_stack("greencart", 1)
    local bluecart = inv:get_stack("bluecart", 1)
    local mast = inv:get_stack("mast", 1)

    if not redcart:to_table() or
            not greencart:to_table() or
            not bluecart:to_table() or
            not mast:to_table() then
        return false
    end

    local redcart_good = redcart:to_table().name == "unilib:item_cartridge_ink_red" and
            redcart:to_table().wear < unilib.pkg.shared_offend_flags.cartridge_max
    local greencart_good = greencart:to_table().name == "unilib:item_cartridge_ink_green" and
            greencart:to_table().wear < unilib.pkg.shared_offend_flags.cartridge_max
    local bluecart_good = bluecart:to_table().name == "unilib:item_cartridge_ink_blue" and
            bluecart:to_table().wear < unilib.pkg.shared_offend_flags.cartridge_max
    local mast_good = mast:to_table().name == unilib.pkg.shared_offend_flags.pole_name .. "_" ..
            unilib.pkg.shared_offend_flags.default_flag_type
    local good = redcart_good and greencart_good and bluecart_good and mast_good

    return good

end

local function consume_ink(pos, amount)

    -- Called by on_metadata_inventory_take()
    -- When the player takes an item from the flag printer's inventory into their own inventory,
    --      hence "printing" a flag, reduce the amount of available ink/the number of masts
    --      accordingly
    --
    -- Args:
    --      amount (int): The amount of ink needed to print the flag

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    local redcart = inv:get_stack("redcart", 1)
    local greencart = inv:get_stack("greencart", 1)
    local bluecart = inv:get_stack("bluecart", 1)
    local mast = inv:get_stack("mast", 1)

    redcart:add_wear(amount * unilib.pkg.shared_offend_flags.cartridge_min)
    greencart:add_wear(amount * unilib.pkg.shared_offend_flags.cartridge_min)
    bluecart:add_wear(amount * unilib.pkg.shared_offend_flags.cartridge_min)
    mast:take_item(1)

    inv:set_stack("redcart", 1, redcart)
    inv:set_stack("greencart", 1, greencart)
    inv:set_stack("bluecart", 1, bluecart)
    inv:set_stack("mast", 1, mast)

end

local function populate_output(pos)

    -- Called by several functions
    -- Displays (or updates) the formspec for the flag printer

    local typescount = unilib.pkg.shared_offend_flags.flag_count
    local pagesize = 8 * 5
    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    local page = meta:get_int("page")
    local maxpage = math.ceil(typescount / pagesize)

    inv:set_list("output", {})
    -- For aesthetic reasons, I prefer that the first page is a full 8x5 grid, even if all of the
    --      slots are empty. Later pages, however, can have exactly as many slots as they need
    if typescount > 40 then
        inv:set_size("output", typescount)
    else
        inv:set_size("output", 40)
    end

    if check_supplies(pos) then

        for k, v in pairs(flag_data_list) do
            inv:set_stack("output", k, v.name)
        end

    end

    meta:set_string("formspec", "size[11,10]" ..
        -- Cartridges
        "label[0,0;" .. FS("Red\nCartrige") .. "]" ..
        "list[current_name;redcart;1.5,0;1,1;]" ..
        "label[0,1;" .. FS("Green\nCartridge") .. "]" ..
        "list[current_name;greencart;1.5,1;1,1;]" ..
        "label[0,2;" .. FS("Blue\nCartridge") .. "]" ..
        "list[current_name;bluecart;1.5,2;1,1;]" ..
        -- Masts
        "label[0,3;" .. FS("Blank\nFlags") .. "]" ..
        "list[current_name;mast;1.5,3;1,1;]" ..
        -- List of flags
        "list[current_name;output;2.8,0;8,5;" .. tostring((page - 1) * pagesize) .. "]" ..
        -- Player inventory
        "list[current_player;main;1.5,6.25;8,4;]" ..
        -- Page buttons
        "button[5.5,5;1,1;prevpage;<<<]" ..
        "button[8.5,5;1,1;nextpage;>>>]" ..
        "label[6.75,5.25;" .. FS("Page @1 of @2", page, maxpage) .. "]" ..
        -- List rings
        "listring[current_player;main]" ..
        "listring[current_name;redcart]" ..
        "listring[current_player;main]" ..
        "listring[current_name;greencart]" ..
        "listring[current_player;main]" ..
        "listring[current_name;bluecart]" ..
        "listring[current_player;main]" ..
        "listring[current_name;mast]" ..
        "listring[current_player;main]"
    )
    meta:set_int("maxpage",maxpage)

end

---------------------------------------------------------------------------------------------------
-- Callbacks
---------------------------------------------------------------------------------------------------

local function allow_metadata_inventory_put(pos, listname, index, stack, player)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    local stack_name = stack:get_name()
    local stack_count = stack:get_count()
    local player_inv = player:get_inventory()
    local move_flag

    local ink_refund = 0
    local redcart = inv:get_stack("redcart", 1)
    local greencart = inv:get_stack("greencart", 1)
    local bluecart = inv:get_stack("bluecart", 1)

    local mast_refund = 0
    local mast = inv:get_stack("mast", 1)

    -- Deal with the right node in the right slot
    if listname == "redcart" and stack_name == "unilib:item_cartridge_ink_red" then
        return 1
    elseif listname == "greencart" and stack_name == "unilib:item_cartridge_ink_green" then
        return 1
    elseif listname == "bluecart" and stack_name == "unilib:item_cartridge_ink_blue" then
        return 1
    elseif listname == "mast" and stack_name ==
            unilib.pkg.shared_offend_flags.pole_name .. "_" ..
            unilib.pkg.shared_offend_flags.default_flag_type then
        return stack_count
    end

    if listname == "redcart" and stack_name == "unilib:dye_red" then

        if redcart:get_name() == "unilib:item_cartridge_ink_red" then

            redcart:set_wear(0)
            inv:set_stack("redcart", 1, redcart)
            stack:set_count(2)
            player_inv:remove_item("main", stack)
            stack:set_count(0)
            populate_output(pos)

        end

        return 0

    elseif listname == "greencart" and stack_name == "unilib:dye_green" then

        if greencart:get_name() == "unilib:item_cartridge_ink_green" then

            greencart:set_wear(0)
            inv:set_stack("greencart", 1, greencart)
            stack:set_count(2)
            player_inv:remove_item("main", stack)
            stack:set_count(0)
            populate_output(pos)

        end

        return 0

    elseif listname == "bluecart" and stack_name == "unilib:dye_blue" then

        if bluecart:get_name() == "unilib:item_cartridge_ink_blue" then

            bluecart:set_wear(0)
            inv:set_stack("bluecart", 1, bluecart)
            stack:set_count(2)
            player_inv:remove_item("main", stack)
            stack:set_count(0)
            populate_output(pos)

        end

        return 0

    elseif listname == "main" then

        local player_inv = player:get_inventory()
        if player_inv:room_for_item("main", stack) then
            return stack:get_count()
        else
            return 0
        end

    end

    -- Cannot rely on the listring to put the right type of cartridge into the right slot; a green
    --      cartridge would be put into the red cartridge slot
    -- The workaround is to move the green cartridge into the green slot directly
    if stack_name == "unilib:item_cartridge_ink_green" and inv:is_empty("greencart") then

        if player_inv:remove_item("main", stack) then

            inv:add_item("greencart", stack)
            move_flag = true

        end

    elseif stack_name == "unilib:item_cartridge_ink_blue" and inv:is_empty("bluecart") then

        if player_inv:remove_item("main", stack) then

            inv:add_item("bluecart", stack)
            move_flag = true

        end

    elseif stack_name == unilib.pkg.shared_offend_flags.pole_name .. "_" ..
            unilib.pkg.shared_offend_flags.default_flag_type and
            inv:is_empty("mast") then

        if player_inv:remove_item("main", stack) then

            inv:add_item("mast", stack)
            move_flag = true

        end

    end

    -- In this situation, the list of printable flags is not updated automatically
    if move_flag then
        populate_output(pos)
    end

    -- Having put the green cartridge in the green slot, don't put the green cartridge in the red
    --      slot (etc), as well
    return 0

end

local function can_dig(pos)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()

    return (
        inv:is_empty("redcart") and
                inv:is_empty("greencart") and
                inv:is_empty("bluecart") and
                inv:is_empty("mast")
    )

end

local function on_construct(pos)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()

    meta:set_int("page", 1)
    meta:set_int("maxpage", 1)

    inv:set_size("redcart", 1)
    inv:set_size("greencart", 1)
    inv:set_size("bluecart", 1)
    inv:set_size("mast", 1)

    populate_output(pos)

end

local function on_metadata_inventory_put(pos)

    populate_output(pos)

end

local function on_metadata_inventory_take(pos, listname, index, stack, player)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    local input_stack = inv:get_stack(listname,  index)

    if listname == "output" then

        local cost = flag_data_list[index].ink_needed
        consume_ink(pos, cost)

        if not input_stack:is_empty() and input_stack:get_name() ~= stack:get_name() then

            local player_inv = player:get_inventory()
            if player_inv:room_for_item("main", input_stack) then

                -- If there is room in the player's inventory, the item is moved
                player_inv:add_item("main", input_stack)

            else

                -- if there is no room, the item is dropped
                core.item_drop(input_stack, player, pos)

            end

        end

    end

    populate_output(pos)

end

local function on_receive_fields(pos, formname, fields, sender)

    local meta = core.get_meta(pos)
    local page = meta:get_int("page")
    local maxpage = meta:get_int("maxpage")

    if fields.prevpage then

        -- User has clicked the previous button
        page = page - 1
        if page < 1 then
            page = maxpage
        end

        meta:set_int("page",page)

    elseif fields.nextpage then

        -- User has clicked the next button
        page = page + 1
        if page > maxpage then
            page = 1
        end

        meta:set_int("page",page)

    end

    -- In all cases, redraw the list of flags
    populate_output(pos)

end

local function allow_metadata_inventory_move(
    pos, from_list, from_index, to_list, to_index, count, player
)
    return 0

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_printer_flag.init()

    return {
        description = "Flag-printing machine",
        depends = {
            "dye_basic",
            "item_cartridge_ink",
            "item_paper_ordinary",
            "material_plastic",
            "metal_bronze",
            "metal_copper",
            "metal_steel",
            "metal_tin",
            "shared_offend_flags",
        },
    }

end

function unilib.pkg.machine_printer_flag.exec()

    local c_paper = "unilib:item_paper_ordinary"
    local c_plastic = "unilib:material_plastic_sheet"

    for _, flag_type in pairs(unilib.pkg.shared_offend_flags.flag_type_list) do

        -- N.B. The .category field is a holdover from source mods, no longer used for anything
        table.insert(
            flag_data_list,
            {
                category = "default",
                name = unilib.pkg.shared_offend_flags.pole_name .. "_" .. flag_type,
                ink_needed = 10,
            }
        )

    end

    unilib.register_node("unilib:machine_printer_flag", "offend_flags:flag_printer", mode, {
        -- From offend_flags:flag_printer
        description = S("Flag-Printing Machine"),
        tiles = {
            "unilib_machine_printer_flag_top.png",
            "unilib_machine_printer_flag_side.png",
            "unilib_machine_printer_flag_side.png",
            "unilib_machine_printer_flag_side.png",
            "unilib_machine_printer_flag_side.png",
            "unilib_machine_printer_flag_front.png",
        },
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",
        walkable = true,

        allow_metadata_inventory_move = allow_metadata_inventory_move,
        allow_metadata_inventory_put = allow_metadata_inventory_put,
        can_dig = can_dig,
        on_construct = on_construct,
        on_metadata_inventory_put = on_metadata_inventory_put,
        on_metadata_inventory_take = on_metadata_inventory_take,
        on_receive_fields = on_receive_fields,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:machine_printer_flag",
        recipe = {
            {c_paper, "unilib:metal_steel_ingot", c_paper},
            {"unilib:metal_bronze_ingot", "unilib:metal_copper_ingot", "unilib:metal_tin_ingot"},
            {c_plastic, "unilib:metal_steel_ingot", c_plastic},
        },
    })

end
