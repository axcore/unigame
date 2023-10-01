---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    boats
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("boats:boat", {
    description = S("Boat"),
    inventory_image = "boats_inventory.png",
    wield_image = "boats_wield.png",
    wield_scale = {x = 2, y = 2, z = 1},
    liquids_pointable = true,
    groups = {flammable = 2},

    on_place = function(itemstack, placer, pointed_thing)
        local under = pointed_thing.under
        local node = minetest.get_node(under)
        local udef = minetest.registered_nodes[node.name]
        if udef and udef.on_rightclick and
                not (placer and placer:is_player() and
                placer:get_player_control().sneak) then
            return udef.on_rightclick(under, node, placer, itemstack,
                pointed_thing) or itemstack
        end

        if pointed_thing.type ~= "node" then
            return itemstack
        end
        if not is_water(pointed_thing.under) then
            return itemstack
        end
        pointed_thing.under.y = pointed_thing.under.y + 0.5
        boat = minetest.add_entity(pointed_thing.under, "boats:boat")
        if boat then
            if placer then
                boat:set_yaw(placer:get_look_horizontal())
            end
            local player_name = placer and placer:get_player_name() or ""
            if not minetest.is_creative_enabled(player_name) then
                itemstack:take_item()
            end
        end
        return itemstack
    end,
})
minetest.register_craft({
    output = "boats:boat",
    recipe = {
        {"",           "",           ""          },
        {"group:wood", "",           "group:wood"},
        {"group:wood", "group:wood", "group:wood"},
    },
})
minetest.register_craft({
    type = "fuel",
    recipe = "boats:boat",
    burntime = 20,
})
]]--
