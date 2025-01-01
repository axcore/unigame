---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_tiled_coal_checker = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_tiled_coal_checker.init()

    return {
        description = "Decorative checkered coal tile",
        depends = {"mineral_coal", "stone_ordinary"},
    }

end

function unilib.pkg.decor_tiled_coal_checker.exec()

    local stone_img = "unilib_stone_ordinary.png"
    local overlay_img = "unilib_decor_tiled_coal_checker_overlay.png"

    unilib.register_node("unilib:decor_tiled_coal_checker", "moreblocks:coal_checker", mode, {
        -- From moreblocks:coal_checker
        description = S("Decorative Checkered Coal Tile"),
        tiles = {
            stone_img .. "^" .. overlay_img,
            stone_img .. "^" .. overlay_img,
            stone_img .. "^" .. overlay_img,
            stone_img .. "^" .. overlay_img,
            stone_img .. "^" .. overlay_img .. "^[transformR90",
            stone_img .. "^" .. overlay_img .. "^[transformR90",
        },
        groups = {cracky = 3, stone = 1},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From moreblocks:coal_checker
        output = "unilib:decor_tiled_coal_checker 4",
        recipe = {
            {"unilib:stone_ordinary", "unilib:mineral_coal_lump"},
            {"unilib:mineral_coal_lump", "unilib:stone_ordinary"},
        },
    })
    unilib.register_craft({
        -- From moreblocks:coal_checker
        output = "unilib:decor_tiled_coal_checker 4",
        recipe = {
            {"unilib:mineral_coal_lump", "unilib:stone_ordinary"},
            {"unilib:stone_ordinary", "unilib:mineral_coal_lump"},
        },
    })
    unilib.register_stairs("unilib:decor_tiled_coal_checker", {
        img_rotate_flag = true,
    })

end
