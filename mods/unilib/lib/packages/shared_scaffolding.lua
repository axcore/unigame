---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    scaffolding
-- Code:    CC-BY-SA-4.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_scaffolding = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.scaffolding.add_mode

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

function unilib.pkg.shared_scaffolding.build_platform(full_name, pos, itemstack)

    -- Builds a platform node on the first available horizontally adjacent tower node
    local pos_z = {'1', '0', '-1', '-1', '0', '0', '1', '1'}
    local pos_x = {'0', '-1',  '0', '0', '1', '1', '0', '0'}

    for count = 1, 8 do

        pos.z = pos.z + pos_z[count]
        pos.x = pos.x + pos_x[count]

        local current_node = core.get_node(pos)
        if current_node.name == "air" then

            core.set_node(pos, {name = full_name})
            itemstack:take_item(1)
            break

        end

    end

end

function unilib.pkg.shared_scaffolding.build_tower(full_name, pos, itemstack, player)

    -- Called when a tower node is build on top of another tower node. Limits the total height of
    --      the tower

    local height = 0

    -- Find the bottom of the scaffolding. Repeat until we find a non-scaffolding node
    repeat

        pos.y = pos.y - 1
        local current_node = core.get_node(pos)

    until current_node.name ~= full_name

    -- Find the height of the scaffolding. Rpeat until we find a non-scaffold node, up to the
    --      maximum height
    repeat

        pos.y = pos.y + 1
        height = height + 1
        local current_node = core.get_node(pos)

        if current_node.name == "air" then

            core.set_node(pos, {name = full_name})
            itemstack:take_item(1)
            player:set_wielded_item(itemstack)

        end

    until current_node.name ~= full_name or height >= unilib.pkg.shared_scaffolding.max_height

end

---------------------------------------------------------------------------------------------------
-- Shared functions (digging platforms)
---------------------------------------------------------------------------------------------------

local function do_dig(pos, platform_name, digger, x_offset, z_offset)

    local np = {x = pos.x + x_offset, y = pos.y, z = pos.z + z_offset}
    local nn = core.get_node(np)
    if nn.name == platform_name then
        core.node_dig(np, nn, digger)
    end

end

function unilib.pkg.shared_scaffolding.dig_platform(pos, platform_name, digger)

    if digger == nil then
        return
    end

    do_dig(pos, platform_name, digger, 1, 0)
    do_dig(pos, platform_name, digger, -1, 0)
    do_dig(pos, platform_name, digger, 0, 1)
    do_dig(pos, platform_name, digger, 0, -1)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_scaffolding.init()

    return {
        description = "Shared functions for scaffolding (from scaffolding)",
    }

end
