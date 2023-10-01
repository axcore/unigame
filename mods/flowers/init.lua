-- flowers/init.lua

-- Minetest 0.4 mod: default
-- See README.txt for licensing and other information.


-- Namespace for functions

flowers = {}

-- Load support for MT game translation.
local S = minetest.get_translator("flowers")


-- Map Generation

dofile(minetest.get_modpath("flowers") .. "/mapgen.lua")


--
-- Flowers
--


-- Flower registration

local function add_simple_flower(name, desc, box, f_groups)
    -- Common flowers' groups
    f_groups.snappy = 3
    f_groups.flower = 1
    f_groups.flora = 1
    f_groups.attached_node = 1

    minetest.register_node("flowers:" .. name, {
        description = desc,
        drawtype = "plantlike",
        waving = 1,
        tiles = {"flowers_" .. name .. ".png"},
        inventory_image = "flowers_" .. name .. ".png",
        wield_image = "flowers_" .. name .. ".png",
        sunlight_propagates = true,
        paramtype = "light",
        walkable = false,
        buildable_to = true,
        groups = f_groups,
        sounds = default.node_sound_leaves_defaults(),
        selection_box = {
            type = "fixed",
            fixed = box
        }
    })
end


--
-- Mushrooms
--


-- Mushroom spread and death

--[[
function flowers.mushroom_spread(pos, node)
    if minetest.get_node_light(pos, 0.5) > 3 then
        if minetest.get_node_light(pos, nil) == 15 then
            minetest.remove_node(pos)
        end
        return
    end
    local positions = minetest.find_nodes_in_area_under_air(
        {x = pos.x - 1, y = pos.y - 2, z = pos.z - 1},
        {x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
        {"group:soil", "group:tree"})
    if #positions == 0 then
        return
    end
    local pos2 = positions[math.random(#positions)]
    pos2.y = pos2.y + 1
    if minetest.get_node_light(pos2, 0.5) <= 3 then
        minetest.set_node(pos2, {name = node.name})
    end
end

minetest.register_abm({
    label = "Mushroom spread",
    nodenames = {"group:mushroom"},
    interval = 11,
    chance = 150,
    action = function(...)
        flowers.mushroom_spread(...)
    end,
})
]]--
