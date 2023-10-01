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
minetest.register_node("default:ladder_steel", {
    description = S("Steel Ladder"),
    drawtype = "signlike",
    tiles = {"default_ladder_steel.png"},
    inventory_image = "default_ladder_steel.png",
    wield_image = "default_ladder_steel.png",
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
    groups = {cracky = 2},
    sounds = default.node_sound_metal_defaults(),
})
minetest.register_craft({
    output = "default:ladder_steel 15",
    recipe = {
        {"default:steel_ingot", "", "default:steel_ingot"},
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        {"default:steel_ingot", "", "default:steel_ingot"},
    }
})
]]--
