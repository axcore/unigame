---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("default:meselamp", {
    description = S("Mese Lamp"),
    drawtype = "glasslike",
    tiles = {"default_meselamp.png"},
    paramtype = "light",
    sunlight_propagates = true,
    is_ground_content = false,
    groups = {cracky = 3, oddly_breakable_by_hand = 3},
    sounds = default.node_sound_glass_defaults(),
    light_source = default.LIGHT_MAX,
})
minetest.register_craft({
    output = "default:meselamp",
    recipe = {
        {"default:glass"},
        {"default:mese_crystal"},
    }
})
]]--
