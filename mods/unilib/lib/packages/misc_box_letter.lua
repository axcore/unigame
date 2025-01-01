---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_box_letter = {}

local S = unilib.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions (general)
---------------------------------------------------------------------------------------------------

local function get_img(img)

    if not img then return end
    local img_name = img:match("(.*)%.png")

    if img_name then
        return img_name .. ".png"
    end

end

local function img_col(stack)

    local def_table = core.registered_items[stack]
    if def_table == nil then
        return ""
    end

    if def_table.inventory_image ~= "" then

        local img = get_img(def_table.inventory_image)
        if img then
            return img
        end

    end

    if def_table.tiles then

        local tile, img = def_table.tiles[1]
        if type(tile) == "table" then
            img = get_img(tile.name)
        elseif type(tile) == "string" then
            img = get_img(tile)
        end

        if img then
            return img
        end

    end

    return ""

end

local function get_formspec(pos, owner, is_owner)

    local spos = pos.x .. "," .. pos.y .. "," .. pos.z
    local meta = core.get_meta(pos)
    local giver, img = "", ""

    if is_owner then

        for i = 1, 7 do

            local giving = meta:get_string("giver" .. i)
            if giving ~= "" then

                local stack = meta:get_string("stack" .. i)
                local giver_name = giving:sub(1, 12)
                local stack_name = stack:match("[%w_:]+")
                local stack_count = stack:match("%s(%d+)") or 1

                giver = giver .. "#FFFF00," .. giver_name .. "," .. i .. ",#FFFFFF,x " ..
                        stack_count .. ","

                img = img .. i .. "=" .. img_col(stack_name) .. "^\\[resize:16x16,"

            end

        end

        -- N.B. Tweaked the layout to keep everything lined up
        return "size[9.5,9]" ..
            "label[0,0;" .. FS("Letter Box") .. "]" ..
            "label[6,0;" .. FS("Recent contributors") .. "]" ..
--            "box[6,0.72;3.3,3.5;#555555]" ..
            "box[6,0.72;3.3,3.9;#555555]" ..
            "listring[current_player;main]" ..
            "list[current_player;main;0.75,5.25;8,4;]" ..
            "tableoptions[background=#00000000;highlight=#00000000;border=false]" ..
            "tablecolumns[color;text;image," .. img .. "0;color;text]" ..
            "table[6,0.75;3.3,4;givers;" .. F(giver) .. "]" ..
            "list[nodemeta:" .. spos .. ";letterbox;0,0.75;6,4;]" ..
            "listring[nodemeta:" .. spos .. ";letterbox]" ..
            unilib.misc.get_hotbar_bg(0.75, 5.25)

    end

    return "size[8,5]" ..
            "list[current_player;main;0,1.25;8,4;]" ..
            "label[0,0;" .. FS(
                "Send your items to\n@1",
                (unilib.utils.emphasise(owner) or owner)
            ) .. "]" ..
            "list[nodemeta:" .. spos .. ";drop;3.5,0;1,1;]" ..
            unilib.misc.get_hotbar_bg(0, 1.25)

end

---------------------------------------------------------------------------------------------------
-- Local functions (callbacks)
---------------------------------------------------------------------------------------------------

local function after_place_node(pos, placer)

    local meta = core.get_meta(pos)
    local player_name = placer:get_player_name()

    meta:set_string("owner", player_name)
    meta:set_string("infotext", S("@1's Letter Box", player_name))

    local inv = meta:get_inventory()
    inv:set_size("letterbox", 6 * 4)
    inv:set_size("drop", 1)

end

local function allow_metadata_inventory_move(pos)
    return 0
end

local function allow_metadata_inventory_take(pos, listname, index, stack, player)

    local meta = core.get_meta(pos)

    if player:get_player_name() ~= meta:get_string("owner") then
        return 0
    end

    return stack:get_count()

end

local function allow_metadata_inventory_put(pos, listname, _, stack, player)

    if listname == "drop" then

        local inv = core.get_meta(pos):get_inventory()
        if inv:room_for_item("letterbox", stack) then
            return -1
        else
            core.chat_send_player(player:get_player_name(), S("The letter box is full"))
        end

    end

    return 0

end

local function can_dig(pos, player)

    local meta = core.get_meta(pos)
    local owner = meta:get_string("owner")
    local player_name = player and player:get_player_name()
    local inv = meta:get_inventory()

    return inv:is_empty("letterbox") and player_name == owner

end

local function on_metadata_inventory_put(pos, listname, _, stack, player)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()

    if listname == "drop" and inv:room_for_item("letterbox", stack) then

        inv:set_list("drop", {})
        inv:add_item("letterbox", stack)

        for i = 7, 2, -1 do

            meta:set_string("giver" .. i, meta:get_string("giver" .. (i - 1)))
            meta:set_string("stack" .. i, meta:get_string("stack" .. (i - 1)))

        end

        meta:set_string("giver1", player:get_player_name())
        meta:set_string("stack1", stack:to_string())

    end

end

local function on_rightclick(pos, node, clicker, itemstack, pointed_thing)

    local meta = core.get_meta(pos)
    local player = clicker:get_player_name()
    local owner = meta:get_string("owner")

    core.show_formspec(
        player,
        "unilib:misc_box_letter",
        get_formspec(pos, owner, (player == owner))
    )

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_box_letter.init()

    return {
        description = "Letter box",
        notes = "Allows players to leave behind items for the letter box's owner",
        depends = {"dye_basic", "item_paper_ordinary", "metal_steel"},
        optional = "shared_screwdriver",
    }

end

function unilib.pkg.misc_box_letter.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:misc_box_letter", "xdecor:mailbox", mode, {
        -- From xdecor:mailbox
        description = S("Letter Box"),
        tiles = {
            "unilib_misc_box_letter_top.png",
            "unilib_misc_box_letter_bottom.png",
            "unilib_misc_box_letter_side.png",
            "unilib_misc_box_letter_side.png",
            "unilib_misc_box_letter.png",
            "unilib_misc_box_letter.png",
        },
        groups = {cracky = 3, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.node,

        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype2 = "facedir",

        after_place_node = after_place_node,
        allow_metadata_inventory_move = allow_metadata_inventory_move,
        allow_metadata_inventory_put = allow_metadata_inventory_put,
        allow_metadata_inventory_take = allow_metadata_inventory_take,
        can_dig = can_dig,
        on_metadata_inventory_put = on_metadata_inventory_put,
        on_rightclick = on_rightclick,
    })
    unilib.register_craft({
        -- From xdecor:mailbox
        output = "unilib:misc_box_letter",
        recipe = {
            {c_ingot, c_ingot, c_ingot},
            {"unilib:dye_red", "unilib:item_paper_ordinary", "unilib:dye_red"},
            {c_ingot, c_ingot, c_ingot},
        },
    })
    if unilib.global.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:misc_box_letter", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

end
