---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.furniture_cushion_simple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.furniture_cushion_simple.init()

    return {
        description = "Simple cushion",
        notes = "Can be sat on, like a chair. Can also be used to break falls",
        depends = "wool_basic",
    }

end

function unilib.pkg.furniture_cushion_simple.exec()

    unilib.register_node("unilib:furniture_cushion_simple", "xdecor:cushion", mode, {
        -- From xdecor:cushion
        description = S("Simple Cushion"),
        tiles = {"unilib_furniture_cushion_simple.png"},
        groups = {fall_damage_add_percent = -50, flammable = 3, snappy = 3},
        sounds = unilib.sound_table.node,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        paramtype = "light",
        paramtype2 = "facedir",

        can_dig = unilib.pkg.shared_xdecor.can_dig_chair,

        on_place = minetest.rotate_node,

        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

            -- Sitting position
            pos.y = pos.y + 0
            unilib.pkg.shared_xdecor.do_sit(pos, node, clicker, pointed_thing)
            return itemstack

        end,
    })
    unilib.register_craft({
        -- From xdecor:cushion
        output = "unilib:furniture_cushion_simple 3",
        recipe = {
            {"unilib:wool_red", "unilib:wool_red", "unilib:wool_red"}
        },
    })

    unilib.register_node("unilib:furniture_cushion_simple_block", "xdecor:cushion_block", mode, {
        -- From xdecor:cushion_block
        description = S("Simple Cushion Block"),
        tiles = {"unilib_furniture_cushion_simple.png"},
        -- N.B. removed not_in_creative_inventory = 1 from original code
        --[[
        groups = {
            fall_damage_add_percent = -75, flammable = 3, not_in_creative_inventory = 1, snappy = 3,
        },
        ]]--
        groups = {fall_damage_add_percent = -75, flammable = 3, snappy = 3},
        sounds = unilib.sound_table.node,

        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From xdecor:cushion_block
        output = "unilib:furniture_cushion_simple_block",
        recipe = {
            {"unilib:furniture_cushion_simple"},
            {"unilib:furniture_cushion_simple"},
        },
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:furniture_cushion_simple 2",
        recipe = {
            {"unilib:furniture_cushion_simple_block"},
        },
    })

end
