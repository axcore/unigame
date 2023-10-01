---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_vintage
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("morelights_vintage:chain_b", {
    description = S("Brass Chain"),
    drawtype = "mesh",
    mesh = "morelights_chain.obj",
    collision_box = {
        type = "fixed",
        fixed = {-1/16, -8/16, -1/16, 1/16, 8/16, 1/16}
    },
    selection_box = {
        type = "fixed",
        fixed = {-1/16, -8/16, -1/16, 1/16, 8/16, 1/16}
    },
    tiles = {"morelights_vintage_brass_32.png"},
    inventory_image = "morelights_vintage_chain_b_inv.png",
    wield_image = "morelights_vintage_chain_b_inv.png",
    paramtype = "light",
    sunlight_propagates = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 3, handy = 1,
              mounted_ceiling = 1},
    _mcl_hardness = 0.2,
    sounds = morelights.sounds.metal,

    on_place = function(itemstack, placer, pointed_thing)
        return morelights.on_place_hanging(itemstack, placer, pointed_thing,
            "morelights_vintage:chain_ceiling_b")
    end
})
minetest.register_craft({
    output = "morelights_vintage:chain_b",
    recipe = {
        {"", a.brass, ""},
        {"", "", ""},
        {"", a.brass, ""}
    }
})

minetest.register_node("morelights_vintage:chain_ceiling_b", {
    drawtype = "mesh",
    mesh = "morelights_chain_ceiling.obj",
    collision_box = {
        type = "fixed",
        fixed = {
            {-3/16, 7/16, -3/16, 3/16, 1/2, 3/16},
            {-1/16, -1/2, -1/16, 1/16, 7/16, 1/16}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-3/16, 7/16, -3/16, 3/16, 1/2, 3/16},
            {-1/16, -1/2, -1/16, 1/16, 7/16, 1/16}
        }
    },
    tiles = {"morelights_vintage_brass_32.png"},
    drop = "morelights_vintage:chain_b",
    paramtype = "light",
    sunlight_propagates = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 3, handy = 1,
              mounted_ceiling = 1, mounted_ceiling = 1},
    _mcl_hardness = 0.2,
    sounds = morelights.sounds.metal
})
]]--
