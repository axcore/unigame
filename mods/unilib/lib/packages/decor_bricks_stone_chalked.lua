---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_bricks_stone_chalked = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_bricks_stone_chalked.init()

    return {
        description = "Decorative chalked bricks",
        depends = {"stone_chalk_white", "stone_ordinary"},
        optional = "shared_darkage"
    }

end

function unilib.pkg.decor_bricks_stone_chalked.exec()

    local c_powder = "unilib:stone_chalk_white_powder"

    unilib.register_node("unilib:decor_bricks_stone_chalked", "darkage:chalked_bricks", mode, {
        -- From darkage:chalked_bricks
        description = S("Decorative Chalked Bricks"),
        tiles = {"unilib_decor_bricks_stone_chalked.png"},
        groups = {cracky = 2, stone = 1},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From darkage:chalked_bricks
        output = "unilib:decor_bricks_stone_chalked 4",
        recipe = {
            {"unilib:stone_ordinary", "unilib:stone_ordinary", c_powder},
            {c_powder, c_powder, c_powder},
            {"unilib:stone_ordinary", c_powder, "unilib:stone_ordinary"},
        }
    })
    unilib.register_stairs("unilib:decor_bricks_stone_chalked", {
        img_rotate_flag = true,
    })
    unilib.set_auto_rotate("unilib:decor_bricks_stone_chalked", unilib.auto_rotate_brick_flag)

end
