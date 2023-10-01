---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    screwdriver
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_screwdriver = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.screwdriver.add_mode

unilib.pkg.shared_screwdriver.rotate_face = 1
unilib.pkg.shared_screwdriver.rotate_axis = 2

local facedir_tbl = {
    [unilib.pkg.shared_screwdriver.rotate_face] = {
        [0] = 1, [1] = 2, [2] = 3, [3] = 0,
        [4] = 5, [5] = 6, [6] = 7, [7] = 4,
        [8] = 9, [9] = 10, [10] = 11, [11] = 8,
        [12] = 13, [13] = 14, [14] = 15, [15] = 12,
        [16] = 17, [17] = 18, [18] = 19, [19] = 16,
        [20] = 21, [21] = 22, [22] = 23, [23] = 20,
    },
    [unilib.pkg.shared_screwdriver.rotate_axis] = {
        [0] = 4, [1] = 4, [2] = 4, [3] = 4,
        [4] = 8, [5] = 8, [6] = 8, [7] = 8,
        [8] = 12, [9] = 12, [10] = 12, [11] = 12,
        [12] = 16, [13] = 16, [14] = 16, [15] = 16,
        [16] = 20, [17] = 20, [18] = 20, [19] = 20,
        [20] = 0, [21] = 0, [22] = 0, [23] = 0,
    },
}

local wallmounted_tbl = {
    [unilib.pkg.shared_screwdriver.rotate_face] = {
        [2] = 5, [3] = 4, [4] = 2, [5] = 3, [1] = 0, [0] = 1,
    },
    [unilib.pkg.shared_screwdriver.rotate_axis] = {
        [2] = 5, [3] = 4, [4] = 2, [5] = 1, [1] = 0, [0] = 3,
    }
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function check_attached_node(pos, rotation)

    -- Notes from screwdriver:
    -- For attached wallmounted nodes: returns true if rotation is valid

    local d = minetest.wallmounted_to_dir(rotation)
    local p2 = vector.add(pos, d)
    local n = minetest.get_node(p2).name
    local def2 = minetest.registered_nodes[n]
    if def2 and not def2.walkable then
        return false
    end
    return true

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_screwdriver.disallow(pos, node, user, mode, new_param2)

    -- Adapted from screwdriver.disallow()
    -- Not called by anything in the screwdriver mod, but available for other mods to call

    return false

end

function unilib.pkg.shared_screwdriver.rotate_simple(pos, node, user, mode, new_param2)

    -- Adapted from screwdriver.rotate.simple()
    -- Not called by anything in the screwdriver mod, but available for other mods to call

    if mode ~= unilib.pkg.shared_screwdriver.rotate_face then
        return false
    end

end

function unilib.pkg.shared_screwdriver.rotate_facedir(pos, node, mode)

    -- Adapted from screwdriver.rotate.facedir()

    -- (Get first 5 bits)
    local rotation = node.param2 % 32
    local other = node.param2 - rotation
    rotation = facedir_tbl[mode][rotation] or 0

    return rotation + other

end

function unilib.pkg.shared_screwdriver.rotate_colour_facedir(pos, node, mode)

    -- Adapted from screwdriver.rotate.colorfacedir()

    return unilib.pkg.shared_screwdriver.rotate_facedir(pos, node, mode)

end

function unilib.pkg.shared_screwdriver.rotate_wallmounted(pos, node, mode)

    -- Adapted from screwdriver.rotate.wallmounted()

    -- (Get first 3 bits)
    local rotation = node.param2 % 8
    local other = node.param2 - rotation
    rotation = wallmounted_tbl[mode][rotation] or 0

    if minetest.get_item_group(node.name, "attached_node") ~= 0 then

        -- Find an acceptable orientation
        for i = 1, 5 do

            if not check_attached_node(pos, rotation) then
                rotation = wallmounted_tbl[mode][rotation] or 0
            else
                break
            end

        end

    end

    return rotation + other

end

function unilib.pkg.shared_screwdriver.rotate_colour_wallmounted(pos, node, mode)

    -- Adapted from screwdriver.rotate.colorwallmounted()

    return unilib.pkg.shared_screwdriver.rotate_wallmountedr(pos, node, mode)

end

function unilib.pkg.shared_screwdriver.handler(itemstack, user, pointed_thing, mode, uses)

    -- Adapted from screwdriver.handler()
    -- Handles rotation

    if pointed_thing.type ~= "node" then
        return
    end

    local pos = pointed_thing.under
    local player_name = user and user:get_player_name() or ""

    if minetest.is_protected(pos, player_name) then

        minetest.record_protection_violation(pos, player_name)
        return

    end

    local node = minetest.get_node(pos)
    local ndef = minetest.registered_nodes[node.name]
    if not ndef then
        return itemstack
    end

    -- Can we rotate this paramtype2?
    local fn = screwdriver.rotate[ndef.paramtype2]
    if not fn and not ndef.on_rotate then
        return itemstack
    end

    local should_rotate = true
    local new_param2
    if fn then
        new_param2 = fn(pos, node, mode)
    else
        new_param2 = node.param2
    end

    -- Node provides a handler, so let the handler decide instead if the node can be rotated
    if ndef.on_rotate then

        -- Copy pos and node because callback can modify it
        local result = ndef.on_rotate(
            vector.new(pos),
            {name = node.name, param1 = node.param1, param2 = node.param2},
            user,
            mode,
            new_param2
        )

        if result == false then -- Disallow rotation
            return itemstack
        elseif result == true then
            should_rotate = false
        end

    elseif ndef.on_rotate == false then

        return itemstack

    elseif ndef.can_dig and not ndef.can_dig(pos, user) then

        return itemstack

    end

    if should_rotate and new_param2 ~= node.param2 then

        node.param2 = new_param2
        minetest.swap_node(pos, node)
        minetest.check_for_falling(pos)

    end

    if not unilib.is_creative(player_name) then
        itemstack:add_wear(65535 / ((uses or 200) - 1))
    end

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_screwdriver.init()

    return {
        description = "Shared functions for screwdrivers (from screwdriver mod)",
        notes = "Code from the \"item_screwdriver_ordinary\" package has been moved here, for" ..
                " the benefit of third-party packages that might need to call it",
    }

end
