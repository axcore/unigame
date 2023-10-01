---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.candle_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.candle_normal.init()

    return {
        description = "Normal candle",
        depends = "torch_ordinary",
    }

end

function unilib.pkg.candle_normal.exec()

    unilib.register_node("unilib:candle_normal", "xdecor:candle", mode, {
        -- From xdecor:candle
        description = S("Normal Candle"),
        tiles = {
            {
                name = "unilib_candle_normal_floor.png",
                animation = {type="vertical_frames", length = 1.5}
            },
            {
                name = "unilib_candle_normal_hanging.png",
                animation = {type="vertical_frames", length = 1.5}
            },
            {
                name = "unilib_candle_normal_wall.png",
                animation = {type="vertical_frames", length = 1.5}
            }
        },
        groups = {attached_node = 1, dig_immediate = 3},
        sounds = unilib.sound_table.node,

        drawtype = "torchlike",
        inventory_image = "unilib_candle_normal_inv.png",
        light_source = 12,
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "wallmounted",
            wall_top = {-0.25, -0.3, -0.25, 0.25, 0.5, 0.25},
            wall_bottom = {-0.25, -0.5, -0.25, 0.25, 0.1, 0.25},
            wall_side = {-0.5, -0.35, -0.15, -0.15, 0.4, 0.15}
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_candle_normal_wield.png",
    })
    unilib.register_craft({
        -- From xdecor:candle
        output = "unilib:candle_normal",
        recipe = {
            {"unilib:torch_ordinary"}
        }
    })

end
