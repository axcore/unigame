---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_extras
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("morelights_extras:stairlight", {
    description = S("Stair Light (place on stairs)"),
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {-1/4, -13/16, -1/16, 1/4, -11/16, 0}
    },
    selection_box = {
        type = "fixed",
        fixed = {-1/4, -13/16, -1/16, 1/4, -11/16, 0}
    },
    walkable = false,
    tiles = {"morelights_metal_dark.png"},
    overlay_tiles = {"", "morelights_extras_stairlight.png",
            "", "", "morelights_extras_stairlight.png"},
    inventory_image = "morelights_extras_stairlight_inv.png",
    wield_image = "morelights_extras_stairlight_inv.png",
    paramtype = "light",
    paramtype2 = "facedir",
    light_source = 10,
    sunlight_propagates = true,
    groups = {cracky = 2, oddly_breakable_by_hand = 3, handy = 1,
              attached_node = 1},
    _mcl_hardness = 0.15,
    node_placement_prediction = "",
    sounds = morelights.sounds.glass,

    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" then
            return itemstack
        end

        -- See builtin/game/item.lua.
        local node = minetest.get_node(pointed_thing.under)

        if placer and not placer:get_player_control().sneak then
            local def = minetest.registered_nodes[node.name]
            if def and def.on_rightclick then
                return def.on_rightclick(pointed_thing.under, node, placer,
                        itemstack, pointed_thing) or itemstack
            end
        end

        if node.param2 < 4
                and (node.name:match("^stairs:stair_")
                  or node.name:match("^mcl_stairs:stair_")) then
            -- Set `above` to the node actually above the stair, since that's
            -- where the node is placed.
            pointed_thing.above =
                    vector.add(pointed_thing.under, vector.new(0, 1, 0))
            return minetest.item_place_node(itemstack, placer, pointed_thing,
                    node.param2)
        end

        return itemstack
    end,

    on_rotate = screwdriver.rotate_simple
})
minetest.register_craft({
    output = "morelights_extras:stairlight",
    recipe = {
        {a.steel, "morelights:bulb", a.steel}
    }
})
]]--
