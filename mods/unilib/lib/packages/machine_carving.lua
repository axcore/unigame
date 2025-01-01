---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    facade
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_carving = {}

local S = unilib.intllib
local FS = function(...) return core.formspec_escape(S(...)) end
local mode = unilib.global.imported_mod_table.facade.add_mode

-- The material used for buttons when no ingredient has been placed in the grid
local specimen_ingredient = "unilib:stone_ordinary"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function check_availability(ingredient)

    -- A simple check for compatible ingredients
    if core.registered_nodes[ingredient .. "_facade_bannerstone"] ~= nil or
            core.registered_nodes[ingredient .. "_column_centre"] ~= nil or
            core.registered_nodes[ingredient .. "_facade_bricks_corner"] ~= nil then
        return true
    else
        return false
    end

end

local function check_removability(pos, player)

    local meta = core.get_meta(pos)
    local owner = meta:set_string("owner")
    local pname = player:get_player_name()
    local inv = meta:get_inventory()

    -- The owner may always remove the machine
    if owner and owner ~= "" and pname and pname ~= "" and owner == pname then

        if inv:is_empty("source") and inv:is_empty("dest") then
            return true
        else
            return false
        end

    end

    if core.is_protected(pos, player:get_player_name()) then
        return false
    end

    if not inv:is_empty("source") or not inv:is_empty("dest") then
        return false
    else
        return true
    end

end

local function check_inventory_put(pos, listname, index, stack, player)

    -- Prevent the player from adding ingredients for which no carvings are available

    if unilib.setting.protect_machines_flag and
            core.is_protected(pos, player:get_player_name()) then
        return 0
    end

    if listname ~= "source" then
        return 0
    end

    local ingredient = stack:get_name()

    if check_availability(ingredient) then
        return(stack:get_count())
    else
        return 0
    end
end

local function check_inventory_move(pos, from_list, from_index, to_list, to_index, count, player)

    if unilib.setting.protect_machines_flag and
            core.is_protected(pos, player:get_player_name()) then
        return 0
    end

    return(stack:get_count())

end

local function check_inventory_take(pos, listname, index, stack, player)

    if unilib.setting.protect_machines_flag and
            core.is_protected(pos, player:get_player_name()) then
        return 0
    end

    if listname ~= "source" and listname ~= "dest" then
        return 0
    end

    return(stack:get_count())

end

local function form_handler(pos, formname, fields, sender)

    -- Convert the ingredient into the desired carving

    if unilib.setting.protect_machines_flag and
            core.is_protected(pos, sender:get_player_name()) then
        return
    end

    if fields.quit then
        return
    end

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()

    if inv:is_empty("source") then
        return
    end

    local inputstack = inv:get_stack("source", 1)
    local inputname = inputstack:get_name()

    for carving_type, _ in pairs(fields) do

        local result = inputname .. carving_type

        -- One can never be overly paranoid, unlike the quick check before, this one is precise
        if not core.registered_nodes[result] then
            return
        end

        -- Output quantities are adjusted to preserve roughly same mass of resulting products
        if unilib.global.carving_output_table[carving_type] then
            result = result .. " " .. unilib.global.carving_output_table[carving_type]
        end

        if not inv:room_for_item("dest", result) then
            return
        end

        inputstack:take_item(1)
        inv:set_stack("source", 1, inputstack)
        inv:add_item("dest", result)

    end

    return

end

local function prepare_formspec(ingredient)

    -- Failsafe: if carvings are disabled, do nothing
    if unilib.setting.add_carvings_column_flag == false and
            unilib.setting.add_carvings_facade_flag == false and
            unilib.setting.add_carvings_millwork_flag == false and
            unilib.setting.add_carvings_farlands_flag == false then
        return ""
    end

    -- Set up the formspec
    local formspec = "size[8,10;]".. "label[0,0;" .. FS("Choose carving") .. ":" .. "]"

    if core.registered_nodes[ingredient .. "_facade_bannerstone"] ~= nil then

        formspec = formspec ..
        -- Row 1, blocky shapes
        "item_image_button[0,0.5;1,1;" .. ingredient ..
                "_facade_bannerstone;_facade_bannerstone;]" ..
        "item_image_button[1,0.5;1,1;" .. ingredient ..
                "_facade_bannerstone_corner;_facade_bannerstone_corner;]" ..
        "item_image_button[2,0.5;1,1;" .. ingredient ..
                "_facade_centrestone;_facade_centrestone;]" ..
        "item_image_button[3,0.5;1,1;" .. ingredient .. "_facade_swirl;_facade_swirl;]" ..
        "item_image_button[4,0.5;1,1;" .. ingredient ..
                "_facade_swirl_corner;_facade_swirl_corner;]" ..
        "item_image_button[5,0.5;1,1;" .. ingredient ..
                "_facade_column;_facade_column;]" ..
        "item_image_button[6,0.5;1,1;" .. ingredient ..
                "_facade_column_corner;_facade_column_corner;]" ..

        -- Row 2, corbel...
        "item_image_button[0,1.5;1,1;" .. ingredient ..
                "_facade_corbel;_facade_corbel;]" ..
        "item_image_button[1,1.5;1,1;" .. ingredient ..
                "_facade_corbel_corner_inner;_facade_corbel_corner_inner;]" ..
        "item_image_button[2,1.5;1,1;" .. ingredient ..
                "_facade_corbel_corner;_facade_corbel_corner;]" ..
        -- ...and fascia (cornice)
        "item_image_button[3,1.5;1,1;" .. ingredient ..
                "_facade_fascia;_facade_fascia;]" ..
        "item_image_button[4,1.5;1,1;" .. ingredient ..
                "_facade_fascia_corner_inner;_facade_fascia_corner_inner;]" ..
        "item_image_button[5,1.5;1,1;" .. ingredient ..
                "_facade_fascia_corner_outer;_facade_fascia_corner_outer;]"

    end

    -- Row 3, carvings from the columnia mod
    if core.registered_nodes[ingredient .. "_column_centre"] ~= nil then

        formspec = formspec ..
        "item_image_button[0,2.5;1,1;" .. ingredient .. "_column_centre;_column_centre;]" ..
        "item_image_button[1,2.5;1,1;" .. ingredient .. "_column_bottom;_column_bottom;]" ..
        "item_image_button[2,2.5;1,1;" .. ingredient .. "_column_crosslink;_column_crosslink;]" ..
        "item_image_button[3,2.5;1,1;" .. ingredient .. "_column_link;_column_link;]" ..
        "item_image_button[4,2.5;1,1;" .. ingredient .. "_column_downlink;_column_downlink;]" ..
        "item_image_button[5,2.5;1,1;" .. ingredient .. "_column_top;_column_top;]"

    end

    -- Row 4, carvings from the farlands modpack
    if core.registered_nodes[ingredient .. "_arch"] ~= nil then

        formspec = formspec ..
        "item_image_button[0,3.5;1,1;" .. ingredient .. "_arch;_arch;]" ..
        "item_image_button[1,3.5;1,1;" .. ingredient .. "_ledge;_ledge;]" ..
        "item_image_button[2,3.5;1,1;" .. ingredient .. "_ledge_corner;_ledge_corner;]" ..
        "item_image_button[3,3.5;1,1;" .. ingredient .. "_rail;_rail;]" ..
        "item_image_button[4,3.5;1,1;" .. ingredient .. "_rail_corner;_rail_corner;]" ..
        "item_image_button[5,3.5;1,1;" .. ingredient .. "_window;_window;]"

    end

    -- Shapes made of brick nodes, e.g. unilib:stone_ordinary_brick, are attached to the end of row
    --      2 (or the beginning of row 1)
    if core.registered_nodes[ingredient .. "_facade_bricks_corner"] ~= nil then

        if core.registered_nodes[ingredient .. "_facade_bannerstone"] ~= nil then

            formspec = formspec ..
            "item_image_button[6,1.5;1,1;" .. ingredient ..
                    "_facade_bricks_corner;_facade_bricks_corner;]"

        else

            formspec = formspec ..
            "item_image_button[0,0.5;1,1;" .. ingredient ..
                    "_facade_bricks_corner;_facade_bricks_corner;]"

        end

    end

    -- Inventory section
    formspec = formspec ..
    "label[0,4.5;" .. FS("In") .. ":" .. "]" ..
    "list[current_name;source;1,4.5;1,1;]" ..
    "label[3,5.5;" .. FS("Out") .. ":" .. "]" ..
    "list[current_name;dest;4,4.5;4,1;]" ..

    "list[current_player;main;0,6;8,4;]" ..
    "listring[current_name;dest]" ..
    "listring[current_player;main]" ..
    "listring[current_name;source]" ..
    "listring[current_player;main]"

    return formspec

end

local function update_formspec_put(pos, listname, index, stack, player)

    -- Update the buttons to show carvings made from the actual ingredient

    if unilib.setting.protect_machines_flag and
            core.is_protected(pos, player:get_player_name()) then
        return
    end

    if listname ~= "source" then
        return
    end

    local meta = core.get_meta(pos)
    local ingredient = stack:get_name()

    if check_availability(ingredient) then
        meta:set_string("formspec", prepare_formspec(ingredient))
    else
        return
    end

end

local function update_formspec_take(pos, listname, index, stack, player)

    -- Update the buttons to show shapes made from speciment ingredient, if the actual ingredient
    --      has been removed

    if unilib.setting.protect_machines_flag and
            core.is_protected(pos, player:get_player_name()) then
        return
    end

    if listname ~= "source" then
        return
    end

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()

    if inv:is_empty("source") then
        meta:set_string("formspec", prepare_formspec(specimen_ingredient))
    end

    return

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_carving.init()

    return {
        description = "Carving machine",
        notes = "Creates carvings from the \"column\" and/or \"facade\" groups, if enabled in" ..
                " Minetest settings",
        depends = {"metal_steel", "mineral_diamond", "stone_ordinary"},
    }

end

function unilib.pkg.machine_carving.exec()

    unilib.register_node("unilib:machine_carving", "facade:shaper", mode, {
        -- From facade:shaper
        description = "Carving Machine",
        tiles = {
            "unilib_machine_carving_top.png",
            "unilib_machine_carving_bottom.png",
            "unilib_machine_carving_right.png",
            "unilib_machine_carving_left.png",
            "unilib_machine_carving_back.png",
            "unilib_machine_carving_front.png",
        },
        groups = {cracky = 3, dig_immediate = 1, oddly_breakable_by_hand = 2},
        -- (no sounds)

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-1/2, -1/2, -1/2, 1/2, -14/32, 1/2},
                {-8/32, -1/2, 12/32, 8/32, 1/2, 16/32},
                {-8/32, -4/32, -16/32, 8/32, 4/32, 16/32},
                {-16/32, -4/32, 12/32, 16/32, 4/32, 16/32},
                {-8/32, -14/32, -12/32, 8/32, -4/32, -16/32},
                {-4/32, 16/32, -8/32, 4/32, 12/32, 12/32},
                {-2/32, 7/32, -2/32, 2/32, 14/32, 2/32},
                {-1/128, 6/32, -1/32, 1/128, 7/32, 1/32},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-1/2, -1/2, -1/2, 1/2, 1/2, 1/2},
            },
        },

        after_place_node = function(pos, placer)

            local meta = core.get_meta(pos)
            local owner = placer and placer:get_player_name() or ""
            meta:set_string("owner", owner)
            if owner then
                meta:set_string("infotext", ("Carving Machine (owned by %s)"):format(owner))
            else
                meta:set_string("infotext", "Carving Machine")
            end

        end,

        allow_metadata_inventory_put = check_inventory_put,

        allow_metadata_inventory_take = check_inventory_take,

        allow_metadata_inventory_move = check_inventory_move,

        can_dig = check_removability,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            meta:set_string("formspec", prepare_formspec(specimen_ingredient))
            local inv = meta:get_inventory()
            inv:set_size("source", 1)
            inv:set_size("dest", 4)

        end,

        on_metadata_inventory_put = update_formspec_put,

        on_metadata_inventory_take = update_formspec_take,

        on_receive_fields = form_handler,
    })
    unilib.register_craft({
        -- From facade:shaper
        output = "unilib:machine_carving",
        recipe = {
            {"", "unilib:mineral_diamond_gem", ""},
            {"unilib:metal_steel_ingot", "unilib:metal_steel_block", "unilib:metal_steel_ingot"},
            {"", "unilib:metal_steel_block", ""},
        },
    })

end
