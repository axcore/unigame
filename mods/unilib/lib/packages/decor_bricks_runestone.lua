---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_bricks_runestone = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_bricks_runestone.init()

    return {
        description = "Decorative runestone bricks",
        depends = "stone_ordinary",
    }

end

function unilib.pkg.decor_bricks_runestone.exec()

    local c_stone = "unilib:stone_ordinary"

    unilib.register_node("unilib:decor_bricks_runestone", "xdecor:stone_rune", mode, {
        -- From xdecor:stone_rune
        description = S("Decorative Runestone Bricks"),
        tiles = {"unilib_decor_bricks_runestone.png"},
        groups = {cracky = 1},
        sounds = unilib.sound_table.stone,

        -- N.B. Not in original code
        is_ground_content = false,
    })
    -- N.B. Original craft recipe conflicts with recipe in "machine_furnace_ordinary" package
    --[[
    unilib.register_craft({
        -- From xdecor:stone_rune
        output = "unilib:decor_bricks_runestone 4",
        recipe = {
            {c_stone, c_stone, c_stone},
            {c_stone, "", c_stone},
            {c_stone, c_stone, c_stone},
        },
    })
    ]]--
    unilib.register_craft({
        -- From xdecor:stone_rune
        output = "unilib:decor_bricks_runestone 4",
        recipe = {
            {c_stone, c_stone, c_stone},
            {c_stone, "unilib:stone_ordinary_cobble", c_stone},
            {c_stone, c_stone, c_stone},
        },
    })
    unilib.set_auto_rotate("unilib:decor_bricks_runestone", unilib.auto_rotate_brick_flag)

end
