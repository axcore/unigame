---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_jungle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_jungle.init()

    return {
        description = "Jungle cobblestone",
        depends = {"stone_ordinary", "tree_jungle"},
    }

end

function unilib.pkg.stone_jungle.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "jungle",
        description = S("Jungle Stone"),

        category = "other",
        colour = "#5A6D49",
        fictional_flag = true,
        grinder_flag = false,
        hardness = 1,
        no_smooth_flag = true,
    })

    unilib.register_stone_smooth({
        -- Original to unilib. Creates unilib:stone_jungle
        part_name = "jungle",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "cobble",
        description = S("Jungle Stone"),
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_jungle_block
        part_name = "jungle",
        orig_name = nil,

        replace_mode = mode,
        description = S("Jungle Stone Block"),
        img_list = {"unilib_stone_jungle.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_jungle_brick
        part_name = "jungle",
        orig_name = nil,

        replace_mode = mode,
        description = S("Jungle Stone Bricks"),
        img_list = {"unilib_stone_jungle.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_node("unilib:stone_jungle_cobble", "mtg_plus:jungle_cobble", mode, {
        -- From mtg_plus:jungle_cobble
        description = S("Jungle Cobblestone"),
        tiles = {"unilib_stone_jungle_cobble.png"},
        -- N.B cobble = 1 not in original code
        groups = {cobble = 1, cracky = 3, stone = 1},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From mtg_plus:jungle_cobble
        type = "shapeless",
        output = "unilib:stone_jungle_cobble",
        recipe = {
            "unilib:tree_jungle_leaves",
            "unilib:tree_jungle_leaves",
            "unilib:stone_ordinary_cobble",
        },
    })
    unilib.register_craft({
        -- From mtg_plus:jungle_cobble
        type = "shapeless",
        output = "unilib:stone_jungle_cobble",
        recipe = {"unilib:tree_jungle_leaves", "unilib:stone_ordinary_cobble_mossy"},
    })
    unilib.register_craft({
        -- From mtg_plus:jungle_cobble
        type = "cooking",
        output = "unilib:stone_ordinary",
        recipe = "unilib:stone_jungle_cobble",
    })
    if unilib.global.super_stone_table["jungle"] ~= nil then

        unilib.register_stairs("unilib:stone_jungle_cobble", {
            group_type = "cobble",
        })
        unilib.register_wall({
            -- From mtg_plus:wall_jungle_cobble
            orig_name = "mtg_plus:wall_jungle_cobble",
            ingredient = "unilib:stone_jungle_cobble",

            replace_mode = mode,
            description = S("Jungle Cobblestone Wall"),
            sound_name = "stone",
            img_list = {"unilib_stone_jungle_cobble.png"},
        })

    end

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_jungle_cobble_compressed
        part_name = "jungle",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Jungle Cobblestone"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_jungle_cobble_condensed
        part_name = "jungle",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Jungle Cobblestone"),
    })

end
