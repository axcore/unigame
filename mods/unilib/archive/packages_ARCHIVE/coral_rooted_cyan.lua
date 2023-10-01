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
minetest.register_node("default:coral_cyan", {
    description = S("Cyan Coral"),
    drawtype = "plantlike_rooted",
    waving = 1,
    paramtype = "light",
    tiles = {"default_coral_skeleton.png"},
    special_tiles = {{name = "default_coral_cyan.png", tileable_vertical = true}},
    inventory_image = "default_coral_cyan.png",
    wield_image = "default_coral_cyan.png",
    groups = {snappy = 3},
    selection_box = {
        type = "fixed",
        fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                {-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
        },
    },
    node_dig_prediction = "default:coral_skeleton",
    node_placement_prediction = "",
    sounds = default.node_sound_stone_defaults({
        dig = {name = "default_dig_snappy", gain = 0.2},
        dug = {name = "default_grass_footstep", gain = 0.25},
    }),

    on_place = coral_on_place,

    after_destruct  = function(pos, oldnode)
        minetest.set_node(pos, {name = "default:coral_skeleton"})
    end,
})
]]--
