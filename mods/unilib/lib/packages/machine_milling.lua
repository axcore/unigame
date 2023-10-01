---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mymillwork
-- Code:    DWYWPL
-- Media:   DWYWPL
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_milling = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.mymillwork.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function check_removability(pos, player)

    -- Updated with code from facade/shapre.lua

    local meta = minetest.get_meta(pos)
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

    if minetest.is_protected(pos, player:get_player_name()) then
        return false
    end

    if not inv:is_empty("source") or not inv:is_empty("dest") then
        return false
    else
        return true
    end

end

local function form_handler(pos, formname, fields, sender)

    -- Updated with code from facade/shapre.lua
    -- Convert the ingredient into the desired carving

    if unilib.protect_machines_flag and minetest.is_protected(pos, sender:get_player_name()) then
        return
    end

    if fields.quit then
        return
    end

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()

    if inv:is_empty("source") then
        return
    end

    local inputstack = inv:get_stack("source", 1)
    local inputname = inputstack:get_name()

    for carving_type, _ in pairs(fields) do

        local result = inputname .. carving_type

        -- One can never be overly paranoid, unlike the quick check before, this one is precise
        if not minetest.registered_nodes[result] then
            return
        end

        -- Output quantities are adjusted to preserve roughly same mass of resulting products
        if unilib.carving_output_table[carving_type] then
            result = result .. " " .. unilib.carving_output_table[carving_type]
        end

        if not inv:room_for_item("dest", result) then
            return
        end

        inputstack:take_item(1)
        inv:set_stack("source", 1, inputstack)
        inv:add_item("dest", result)

    end

end

local function prepare_formspec()

      local formspec =

    "size[10,11;]" ..
    "background[-0.15,-0.25;10.40,11.75;unilib_mill_bg.png]" ..
    "list[current_name;source;7,5.5.5;1,1;]" ..
    "list[current_name;dest;8.5,5.5;1,1;]" ..
    "label[7,5;" .. S("Input") .. ":]" ..
    "label[8.5,5;" .. S("Output") .. ":]" ..
    "label[0,0;" .. S("Choose Millwork") .. ":]" ..

    "label[0.5,0.5;" .. S("Crown Mould") .. "]"..
    "image_button[0.5,1;1,1;unilib_mill_crownmould.png;_mill_crownmould;]" ..
    "image_button[1.5,1;1,1;unilib_mill_crownmould_corner_inner.png;" ..
            "_mill_crownmould_corner_inner;]" ..
    "image_button[2.5,1;1,1;unilib_mill_crownmould_corner_outer.png;" ..
            "_mill_crownmould_corner_outer;]" ..
    "image_button[3.5,1;1,1;unilib_mill_crownmould_beam.png;_mill_crownmould_beam;]" ..

    "label[0.5,2;" .. S("Columns") .. "]" ..
    "image_button[0.5,2.5;1,1;unilib_mill_column.png;_mill_column;]" ..
    "image_button[1.5,2.5;1,1;unilib_mill_column_base.png;_mill_column_base;]" ..
    "image_button[2.5,2.5;1,1;unilib_mill_column_half.png;_mill_column_half;]" ..
    "image_button[3.5,2.5;1,1;unilib_mill_column_half_base.png;_mill_column_half_base;]" ..
    "image_button[4.5,2.5;1,1;unilib_mill_column_half_base_beam.png;" ..
            "_mill_column_half_base_beam;]" ..
    "image_button[5.5,2.5;1,1;unilib_mill_column_quarter.png;_mill_column_quarter;]" ..
    "image_button[6.5,2.5;1,1;unilib_mill_column_quarter_base.png;_mill_column_quarter_base;]" ..
    "image_button[7.5,2.5;1,1;unilib_mill_column_quarter_base_board.png;" ..
            "_mill_column_quarter_base_board;]" ..
    "image_button[8.5,2.5;1,1;unilib_mill_column_quarter_bace_fancy.png;" ..
            "_mill_column_quarter_base_fancy;]" ..

    "label[0.5,3.5;" .. S("Ceiling and Beams") .. "]"..
    "image_button[0.5,4;1,1;unilib_mill_ceiling.png;_mill_ceiling;]" ..
    "image_button[1.5,4;1,1;unilib_mill_ceiling_post.png;_mill_ceiling_post;]" ..
    "image_button[2.5,4;1,1;unilib_mill_beam.png;_mill_beam;]" ..
    "image_button[3.5,4;1,1;unilib_mill_beam_t.png;_mill_beam_t;]" ..
    "image_button[4.5,4;1,1;unilib_mill_ceiling_beam_t.png;_mill_ceiling_beam_t;]" ..

    "label[0.5,5;" .. S("Bases") .. "]" ..
    "image_button[0.5,5.5;1,1;unilib_mill_base.png;_mill_base;]" ..
    "image_button[1.5,5.5;1,1;unilib_mill_base_corner_inner.png;_mill_base_corner_inner;]" ..
    "image_button[2.5,5.5;1,1;unilib_mill_base_corner_outer.png;_mill_base_corner_outer;]" ..
    "image_button[3.5,5.5;1,1;unilib_mill_base_fancy.png;_mill_base_fancy;]" ..
    "image_button[4.5,5.5;1,1;unilib_mill_base_fancy_corner_inner.png;" ..
            "_mill_base_fancy_corner_inner;]" ..
    "image_button[5.5,5.5;1,1;unilib_mill_base_fancy_corner_outer.png;" ..
            "_mill_base_fancy_corner_outer;]" ..
    "list[current_player;main;1,7;8,4;]"

    return formspec

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_milling.init()

    return {
        description = "Milling Machine",
        notes = "Creates carvings from the \"millwork\" group, if enabled in Minetest settings",
        depends = "metal_steel",
    }

end

function unilib.pkg.machine_milling.exec()

    unilib.register_node("unilib:machine_milling", "mymillwork:machine", mode, {
        -- From mymillwork:machine
        description = "Millwork Machine",
        tiles = {
            "unilib_machine_milling_top.png",
            "unilib_machine_milling_bottom.png",
            "unilib_machine_milling_side2.png",
            "unilib_machine_milling_side1.png",
            "unilib_machine_milling_back.png",
            "unilib_machine_milling_front.png"
        },
        groups = {cracky = 3, dig_immediate = 1, oddly_breakable_by_hand = 2},
        -- (no sounds)

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.1875, -0.5, 0.5, -0.0625, 0.5},
                {-0.5, -0.5, -0.5, -0.3125, -0.1875, -0.3125},
                {-0.5, -0.5, 0.3125, -0.3125, -0.1875, 0.5},
                {0.3125, -0.5, 0.3125, 0.5, -0.1875, 0.5},
                {0.3125, -0.5, -0.5, 0.5, -0.1875, -0.3125},
                {0, -0.0625, 0.25, 0.0625, 0.375, 0.5},
                {-0.125, -0.0625, 0.25, -0.0625, 0.375, 0.5},
                {-0.1875, 0.125, -0.3125, 0.125, 0.5, 0.0625},
                {-0.125, 0.375, 0.0625, 0.0625, 0.5, 0.5},
                {-0.0625, 0.0625, -0.3125, 0, 0.125, 0.0625},
                {-0.0625, 0, -0.25, 0, 0.125, 0},
            }
        },
        paramtype = "light",
        paramtype2 = "facedir",

        after_place_node = function(pos, placer)

            local meta = minetest.get_meta(pos)
            local owner = placer and placer:get_player_name() or ""
            meta:set_string("owner", owner)
            if owner then
                meta:set_string("infotext", ("Milling Machine (owned by %s)"):format(owner))
            else
                meta:set_string("infotext", "Milling Machine")
            end

        end,

        can_dig = check_removability,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            meta:set_string("formspec", prepare_formspec())
            meta:set_string("infotext", "Milling Machine")
            local inv = meta:get_inventory()
            inv:set_size("source", 1)
            inv:set_size("dest", 1)

        end,

        on_receive_fields = form_handler,
    })

    unilib.register_craft({
        -- From mymillwork:machine
        output = "unilib:machine_milling",
        recipe = {
            {"", "unilib:metal_steel_ingot", ""},
            {"unilib:metal_steel_block", "unilib:metal_steel_block", "unilib:metal_steel_block"},
            {"unilib:metal_steel_ingot", "" , "unilib:metal_steel_ingot"},
        },
    })

end
