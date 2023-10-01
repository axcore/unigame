---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
--
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local vessels_shelf_formspec =
    "size[8,7;]" ..
    "list[context;vessels;0,0.3;8,2;]" ..
    "list[current_player;main;0,2.85;8,1;]" ..
    "list[current_player;main;0,4.08;8,3;8]" ..
    "listring[context;vessels]" ..
    "listring[current_player;main]" ..
    default.get_hotbar_bg(0, 2.85)

local function update_vessels_shelf(pos)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local invlist = inv:get_list("vessels")

    local formspec = vessels_shelf_formspec
    -- Inventory slots overlay
    local vx, vy = 0, 0.3
    local n_items = 0
    for i = 1, 16 do
        if i == 9 then
            vx = 0
            vy = vy + 1
        end
        if not invlist or invlist[i]:is_empty() then
            formspec = formspec ..
                "image[" .. vx .. "," .. vy .. ";1,1;vessels_shelf_slot.png]"
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

minetest.register_node("vessels:shelf", {
    description = S("Vessels Shelf"),
    tiles = {"default_wood.png", "default_wood.png", "default_wood.png",
        "default_wood.png", "vessels_shelf.png", "vessels_shelf.png"},
    paramtype2 = "facedir",
    is_ground_content = false,
    groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
    sounds = default.node_sound_wood_defaults(),

    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        update_vessels_shelf(pos)
        local inv = meta:get_inventory()
        inv:set_size("vessels", 8 * 2)
    end,
    can_dig = function(pos,player)
        local inv = minetest.get_meta(pos):get_inventory()
        return inv:is_empty("vessels")
    end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        if minetest.get_item_group(stack:get_name(), "vessel") ~= 0 then
            return stack:get_count()
        end
        return 0
    end,
    on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
        minetest.log("action", player:get_player_name() ..
               " moves stuff in vessels shelf at ".. minetest.pos_to_string(pos))
        update_vessels_shelf(pos)
    end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
        minetest.log("action", player:get_player_name() ..
               " moves stuff to vessels shelf at ".. minetest.pos_to_string(pos))
        update_vessels_shelf(pos)
    end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
        minetest.log("action", player:get_player_name() ..
               " takes stuff from vessels shelf at ".. minetest.pos_to_string(pos))
        update_vessels_shelf(pos)
    end,
    on_blast = function(pos)
        local drops = {}
        default.get_inventory_drops(pos, "vessels", drops)
        drops[#drops + 1] = "vessels:shelf"
        minetest.remove_node(pos)
        return drops
    end,
})
]]--
