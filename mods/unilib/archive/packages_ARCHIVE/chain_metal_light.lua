---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
morelights.register_variants({
    {
        name = "morelights:chain_l",
        description = S("Metal Chain (@1)", S("light")),
        tiles = {"morelights_metal_light_32.png"},
        inventory_image = "morelights_chain_l_inv.png",
        wield_image = "morelights_chain_l_inv.png",

        on_place = function(itemstack, placer, pointed_thing)
            return morelights.on_place_hanging(itemstack, placer,
                pointed_thing, "morelights:chain_ceiling_l")
        end
    }
},
{
    drawtype = "mesh",
    mesh = "morelights_chain.obj",
    collision_box = {
        type = "fixed",
        fixed = {-1/16, -1/2, -1/16, 1/16, 1/2, 1/16}
    },
    selection_box = {
        type = "fixed",
        fixed = {-1/16, -1/2, -1/16, 1/16, 1/2, 1/16}
    },
    paramtype = "light",
    sunlight_propagates = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 3, handy = 1,
              mounted_ceiling = 1},
    _mcl_hardness = 0.2,
    sounds = morelights.sounds.metal
})
minetest.register_craft({
    output = "morelights:chain_l",
    recipe = {
        {a.dye_light, a.steel, ""},
        {"", "", ""},
        {"", a.steel, ""}
    }
})

morelights.register_variants({
    {
        name = "morelights:chain_ceiling_l",
        tiles = {"morelights_metal_light_32.png"},
        drop = "morelights:chain_l"
    }
},
{
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
    paramtype = "light",
    sunlight_propagates = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 3, handy = 1,
              mounted_ceiling = 1, not_in_creative_inventory = 1},
    _mcl_hardness = 0.2,
    sounds = morelights.sounds.metal
})
]]--
