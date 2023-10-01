---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_jungle = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.mtg_plus.add_mode

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
        fictional_flag = true,
        grinder_flag = false,
        hardness = 1,
        no_smooth_flag = true,
    })

    -- (no smoothstone/block/brick variants)

    unilib.register_node("unilib:stone_jungle_cobble", "mtg_plus:jungle_cobble", mode, {
        -- From mtg_plus:jungle_cobble
        description = S("Jungle Cobblestone"),
        tiles = {"unilib_stone_jungle_cobble.png"},
        -- N.B cobble = 1 not in original code
        groups = {cobble = 1, cracky = 3, stone = 1},
        sounds = unilib.sound_table.stone,

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
    -- N.B. Because of the lack of a smoothstone, we can't call
    --      unilib.register_stone_smooth_cuttings() here
    if unilib.super_stone_table["jungle"] ~= nil then

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

end
