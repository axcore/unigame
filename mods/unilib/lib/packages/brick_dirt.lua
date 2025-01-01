---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_dirt = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_dirt.init()

    return {
        description = "Dirt bricks",
        depends = "dirt_ordinary",
    }

end

function unilib.pkg.brick_dirt.exec()

    unilib.register_node("unilib:brick_dirt_soft", "mtg_plus:dirtbrick", mode, {
        -- From mtg_plus:dirtbrick
        description = S("Soft Dirt Brick"),
        tiles = {"unilib_brick_dirt_soft.png"},
        groups = {crumbly = 2, soil = 1},
        sounds = unilib.global.sound_table.dirt,

        drop = "unilib:dirt_ordinary",
        is_ground_content = false,
    })
    unilib.register_craft({
        -- From mtg_plus:dirtbrick
        output = "unilib:brick_dirt_soft 4",
        recipe = {
            {"unilib:dirt_ordinary", "unilib:dirt_ordinary"},
            {"unilib:dirt_ordinary", "unilib:dirt_ordinary"},
        },
    })
    unilib.utils.set_auto_rotate("unilib:brick_dirt_soft", unilib.setting.auto_rotate_brick_flag)

    unilib.register_node("unilib:brick_dirt_hard", "mtg_plus:harddirtbrick", mode, {
        -- From mtg_plus:harddirtbrick
        description = S("Hardened Dirt Brick"),
        tiles = {"unilib_brick_dirt_hard.png"},
        groups = {crumbly = 1, level = 1, soil = 1},
        sounds = unilib.global.sound_table.dirt,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From mtg_plus:harddirtbrick
        type = "cooking",
        output = "unilib:brick_dirt_hard",
        recipe = "unilib:brick_dirt_soft",
        cooktime = 5,
    })
    unilib.register_stairs("unilib:brick_dirt_hard")
    unilib.utils.set_auto_rotate("unilib:brick_dirt_hard", unilib.setting.auto_rotate_brick_flag)

end
