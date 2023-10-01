---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ldm32
-- Code:    LGPL 2.1+
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("ldm32:casing", {
    description = "Laser Distance Meter",
    inventory_image = "ldm32_inventory.png",
    drawtype = "mesh",
    mesh = "ldm32_casing.obj",
    tiles = {"ldm32_casing2.png",
             "ldm32_casing.png",},
    selection_box = {
        type = "fixed",
        fixed = {{-0.07, -0.5, -0.5, 0.07, -0.25, 0.5},}
    },
    collision_box = {
        type = "fixed",
        fixed = {{-0.07, -0.5, -0.5, 0.07, -0.25, 0.5},}
    },
    stack_max = 1,
    is_ground_content = true,
    paramtype2 = "facedir",
    groups = {snappy = 3, dig_immediate = 3},
    on_place = minetest.rotate_node,

    on_timer = function(pos)
        local meta = minetest.get_meta(pos)
        local node = minetest.get_node(pos)
        local timer = minetest.get_node_timer(pos)
        local is_not_beam = false
        local is_air = false

        if meta:get_string("is_on") == "true" then
            if laser_check(pos, node.param2, meta:get_int("range")) then
                laser_off(pos, node.param2, meta:get_int("range"))
                laser_on(pos, node.param2, laser_range)
            end
            if meta:get_int("facedir") ~= node.param2 and meta:get_string("is_on") then
                laser_off(pos, meta:get_int("facedir"), laser_range)
                laser_on(pos, node.param2, laser_range)
                meta:set_int("facedir", node.param2)
            end
        end
        timer:start(1)
    end,

    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        local node = minetest.get_node(pos)
        meta:set_string("infotext","Off")
        meta:set_string("is_on", "false")
        meta:set_int("facedir", node.param2)
    end,

    after_destruct = function(pos, oldnode, oldmetadata)
        local meta = minetest.get_meta(pos)
        laser_off(pos, oldnode.param2, laser_range)
        meta:set_string("infotext", "Off")
        meta:set_string("is_on", "false")
    end,

    after_dig_node = function(pos, oldnode)
        local meta = minetest.get_meta(pos)
        laser_off(pos, oldnode.param2, laser_range)
        meta:set_string("infotext", "Off")
        meta:set_string("is_on", "false")
    end,

    on_rightclick = function(pos, node, player, itemstack, pointed_thing)
        local meta = minetest.get_meta(pos)
        local node = minetest.get_node(pos)
        local timer = minetest.get_node_timer(pos)

        if meta:get_string("is_on") == "false" then
            laser_on(pos, node.param2, laser_range)
            meta:set_string("is_on", "true")
            timer:start(1)
        else
            laser_off(pos, node.param2, meta:get_int("range"))
            meta:set_string("infotext", "Off")
            meta:set_string("is_on", "false")
            timer:stop()
        end
    end,
})
]]--
