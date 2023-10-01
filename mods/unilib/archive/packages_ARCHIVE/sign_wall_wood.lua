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
register_sign("wood", S("Wooden Sign"), {
    sounds = default.node_sound_wood_defaults(),
    groups = {choppy = 2, attached_node = 1, flammable = 2, oddly_breakable_by_hand = 3}
})
minetest.register_craft({
    output = "default:sign_wall_wood 3",
    recipe = {
        {"group:wood", "group:wood", "group:wood"},
        {"group:wood", "group:wood", "group:wood"},
        {"", "group:stick", ""},
    }
})
minetest.register_craft({
    type = "fuel",
    recipe = "default:sign_wall_wood",
    burntime = 10,
})
]]--
