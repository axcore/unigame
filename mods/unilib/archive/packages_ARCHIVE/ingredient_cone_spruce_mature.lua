---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
        minetest.register_node("lib_ecology:fruit_spruce_cone", {
            description = S("Fruit - Spruce Cone"),
            drawtype = "plantlike",
            tiles = { "lib_ecology_fruit_spruce_cone.png" },
            visual_scale = 0.8,
            paramtype = "light",
            sunlight_propagates = true,
            is_ground_content = false,
            walkable = false,
            groups = {fleshy=3,dig_immediate=3,flammable=2, leafdecay = 1, leafdecay_drop = 1},
            sounds = default.node_sound_defaults(),
            drop = "lib_ecology:fruit_spruce_cone",
            selection_box = {
                type = "fixed",
                    fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
                },
            after_place_node = function(pos, placer, itemstack)
                if placer:is_player() then
                    minetest.set_node(pos, {name="lib_ecology:fruit_spruce_cone", param2=1})
                end
            end,
        })
]]--
