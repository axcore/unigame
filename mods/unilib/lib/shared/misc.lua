---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- misc.lua
--      Set up miscellaneous shared functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Check user is allowed to interact with a node
---------------------------------------------------------------------------------------------------

function unilib.can_interact_with_node(player, pos)

    -- Adapted from default/functions.lua, and called by the "container_chest_ordinary" package
    -- Notes from default:
    -- This method is not an official part of the API yet. This method may change in the future

    if player and player:is_player() then

        if minetest.check_player_privs(player, "protection_bypass") then
            return true
        end

    else

        return false

    end

    local meta = minetest.get_meta(pos)
    local owner = meta:get_string("owner")

    if not owner or owner == "" or owner == player:get_player_name() then
        return true
    end

    -- Is player wielding the right key?
    local item = player:get_wielded_item()
    if minetest.get_item_group(item:get_name(), "key") == 1 then

        local key_meta = item:get_meta()

        if key_meta:get_string("secret") == "" then

            local key_oldmeta = item:get_metadata()
            if key_oldmeta == "" or not minetest.parse_json(key_oldmeta) then
                return false
            end

            key_meta:set_string("secret", minetest.parse_json(key_oldmeta).secret)
            item:set_metadata("")

        end

        return meta:get_string("key_lock_secret") == key_meta:get_string("secret")

    end

    return false

end

---------------------------------------------------------------------------------------------------
-- Get the hotbar background
---------------------------------------------------------------------------------------------------

function unilib.get_hotbar_bg(x, y)

    -- Adapted from default/init.lua
    -- Make sure that the hotbar background is available for code that needs it (e.g. the
    --      ordinary furnace), in case default isn't available
    --
    -- N.B. All six GUI textures from default have been imported into unilib's textures folder,
    --      though some of them aren't actually used

    local out = ""

    for i = 0, 7 do
        out = out .. "image[" .. x + i .. "," .. y .. ";1,1;unilib_gui_hb_bg.png]"
    end

    return out

end

---------------------------------------------------------------------------------------------------
-- Optimised function to put all items from an inventory into a drops list
---------------------------------------------------------------------------------------------------

function unilib.get_inventory_drops(pos, inventory, drops)

    -- Adapted from default/functions.lua, and called by various minetest_game mods
    -- In unilib, called by unilib.register_bookshelf()

    local inv = minetest.get_meta(pos):get_inventory()
    local n = #drops

    for i = 1, inv:get_size(inventory) do

        local stack = inv:get_stack(inventory, i)
        if stack:get_count() > 0 then

            drops[n+1] = stack:to_table()
            n = n + 1

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Dig upwards (mostly used by plants, but also used by scaffolding)
---------------------------------------------------------------------------------------------------

function unilib.dig_up(pos, node, digger)

    -- Adapted from default/functions.lua
    -- e.g. for papyrus, digging the base node auto-digs papyrus nodes above it

    if digger == nil then
        return
    end

    local np = {x = pos.x, y = pos.y + 1, z = pos.z}
    local nn = minetest.get_node(np)
    if nn.name == node.name then
        minetest.node_dig(np, nn, digger)
    end

end

function unilib.dig_up_multiple(pos, full_name_list, digger)

    -- Adapted from aotearoa/functions.lua
    -- Unlike the function above, "node_list" is a list of full node names, e.g.
    --      {"unilib:plant_raupo", "unilib:plant_raupo_with_flowers"}

    if digger == nil then
        return
    end

    local np = {x = pos.x, y = pos.y + 1, z = pos.z}

    for _, full_name in ipairs(full_name_list) do

        local nn = minetest.get_node(np)
        if nn.name == full_name then
          minetest.node_dig(np, nn, digger)
        end

    end

end

---------------------------------------------------------------------------------------------------
-- Auto-rotate node after placing
---------------------------------------------------------------------------------------------------

function unilib.rotate_and_place(itemstack, placer, pointed_thing, lookup)

    -- Adapted from morelights, was morelights.rotate_and_place()
    -- An .on_place() callback, called when a suitable node is placed in the world
    -- For example, used by ceiling lights to make sure they're orientated the right way up
    --      (see the "light_lamp_ceiling_normal" package for some example calling code)

    local dir = minetest.dir_to_wallmounted(
        vector.subtract(pointed_thing.under, pointed_thing.above)
    )
    local fdirs = lookup or {[0] = 20, 0, 16, 12, 8, 4}

    minetest.item_place(itemstack, placer, pointed_thing, fdirs[dir] or 0)
    return itemstack

end
