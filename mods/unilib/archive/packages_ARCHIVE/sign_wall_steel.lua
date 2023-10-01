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
register_sign("steel", S("Steel Sign"), {
    sounds = default.node_sound_metal_defaults(),
    groups = {cracky = 2, attached_node = 1}
})
minetest.register_craft({
    output = "default:sign_wall_steel 3",
    recipe = {
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        {"", "group:stick", ""},
    }
})
]]--
