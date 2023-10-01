---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    scaffolding
-- Code:    CC-BY-SA-4.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_scaffolding = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.scaffolding.add_mode

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

-- N.B. 14 in the original code
unilib.pkg.shared_scaffolding.light_source = 11
-- Maximum height of a tower
unilib.pkg.shared_scaffolding.max_height = 32

---------------------------------------------------------------------------------------------------
-- Shared functions (build platforms/towers)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_scaffolding.build_platform(node, pos, itemstack)

    -- Builds a platform node on the first available horizontally adjacent tower node
    local pos_z = {'1', '0', '-1', '-1', '0', '0', '1', '1'}
    local pos_x = {'0', '-1',  '0', '0', '1', '1', '0', '0'}

    for count = 1, 8 do

        pos.z = pos.z + pos_z[count]
        pos.x = pos.x + pos_x[count]

        local current_node = minetest.get_node(pos)
        if current_node.name == "air" then

            minetest.set_node(pos, {name = node})
            itemstack:take_item(1)
            break

        end

    end

end

function unilib.pkg.shared_scaffolding.build_tower(node, pos, itemstack, player)

    -- Called when a tower node is build on top of another tower node. Limits the total height of
    --      the tower

    local height = 0

    -- Find the bottom of the scaffolding. Repeat until we find a non-scaffolding node
    repeat

        pos.y = pos.y - 1
        local current_node = minetest.get_node(pos)

    until current_node.name ~= node

    -- Find the height of the scaffolding. Rpeat until we find a non-scaffold node, up to the
    --      maximum height
    repeat

        pos.y = pos.y + 1
        height = height + 1
        local current_node = minetest.get_node(pos)

        if current_node.name == "air" then

            minetest.set_node(pos, {name = node})
            itemstack:take_item(1)
            player:set_wielded_item(itemstack)

        end

    until current_node.name ~= node or height >= unilib.pkg.shared_scaffolding.max_height

end

---------------------------------------------------------------------------------------------------
-- Shared functions (digging horizontally)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_scaffolding.dig_horizontal_x(pos, node, digger)

    if digger == nil then
        return
    end

    local np = {x = pos.x + 1, y = pos.y, z = pos.z}
    local nn = minetest.get_node(np)
    if nn.name == node.name then
        minetest.node_dig(np, nn, digger)
    end

end

function unilib.pkg.shared_scaffolding.dig_horizontal_x2(pos, node, digger)

    if digger == nil then
        return
    end

    local np = {x = pos.x - 1, y = pos.y, z = pos.z}
    local nn = minetest.get_node(np)
    if nn.name == node.name then
        minetest.node_dig(np, nn, digger)
    end

end

function unilib.pkg.shared_scaffolding.dig_horizontal_z(pos, node, digger)

    if digger == nil then
        return
    end

    local np = {x = pos.x, y = pos.y, z = pos.z + 1}
    local nn = minetest.get_node(np)
    if nn.name == node.name then
        minetest.node_dig(np, nn, digger)
    end

end

function unilib.pkg.shared_scaffolding.dig_horizontal_z2(pos, node, digger)

    if digger == nil then
        return
    end

    local np = {x = pos.x , y = pos.y, z = pos.z - 1}
    local nn = minetest.get_node(np)
    if nn.name == node.name then
        minetest.node_dig(np, nn, digger)
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_scaffolding.init()

    return {
        description = "Shared functions for scaffolding (from scaffolding)",
    }

end
