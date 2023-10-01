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
minetest.register_node("default:ladder_wood", {
    description = S("Wooden Ladder"),
    drawtype = "signlike",
    tiles = {"default_ladder_wood.png"},
    inventory_image = "default_ladder_wood.png",
    wield_image = "default_ladder_wood.png",
    paramtype = "light",
    paramtype2 = "wallmounted",
    sunlight_propagates = true,
    walkable = false,
    climbable = true,
    is_ground_content = false,
    selection_box = {
        type = "wallmounted",
        --wall_top = = <default>
        --wall_bottom = = <default>
        --wall_side = = <default>
    },
    groups = {choppy = 2, oddly_breakable_by_hand = 3, flammable = 2},
    legacy_wallmounted = true,
    sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
    output = "default:ladder_wood 5",
    recipe = {
        {"group:stick", "", "group:stick"},
        {"group:stick", "group:stick", "group:stick"},
        {"group:stick", "", "group:stick"},
    }
})
minetest.register_craft({
    type = "fuel",
    recipe = "default:ladder_wood",
    burntime = 7,
})
]]--
