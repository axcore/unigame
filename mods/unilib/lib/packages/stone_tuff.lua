---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_tuff = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_tuff.init()

    return {
        description = "Tuff",
        optional = "stone_gneiss_white",
    }

end

function unilib.pkg.stone_tuff.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "tuff",
        description = S("Tuff"),

        category = "extrusive",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 3)
        hardness = 1,
        hardness_real = 3,
    })

    -- (preserve original cracky values for smoothstone and blocks)

    unilib.register_node("unilib:stone_tuff", "darkage:tuff", mode, {
        -- From darkage:tuff
        description = S("Tuff"),
        tiles = {"unilib_stone_tuff.png"},
        groups = {cracky = 3, smoothstone = 1, stone = 1},
        sounds = unilib.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:stone_tuff"}, rarity = 3},
                {items = {"unilib:stone_tuff_rubble"}}
            }
        },
    })
    unilib.register_craft({
        -- From darkage:tuff
        type = "cooking",
        output = "unilib:stone_tuff",
        recipe = "unilib:stone_tuff_rubble",
    })
    unilib.register_craft({
        -- From darkage:tuff
        type = "cooking",
        output = "unilib:stone_tuff",
        recipe = "unilib:stone_tuff_brick_old",
    })
    if unilib.pkg_executed_table["stone_gneiss_white"] ~= nil then

        unilib.register_craft({
            -- From darkage:tuff
            output = "unilib:stone_tuff 2",
            recipe = {
                {"unilib:stone_gneiss_white", "unilib:stone_ordinary"},
                {"unilib:stone_ordinary", "unilib:stone_gneiss_white"},
            }
        })

    end
    --[[
    unilib.register_stairs("unilib:stone_tuff", {
        drop_name = "unilib:stone_tuff_rubble",
        group_type = "smooth",
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "tuff",

        drop_name = "unilib:stone_tuff_rubble",
    })

    unilib.register_node("unilib:stone_tuff_brick", "darkage:tuff_bricks", mode, {
        -- From darkage:tuff_bricks
        description = S("Tuff Bricks"),
        tiles = {"unilib_stone_tuff_brick.png"},
        -- N.B. stone = 1 not in original code
        groups = {cracky = 2, stone = 1, stonebrick = 1},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From darkage:tuff_bricks
        output = "unilib:stone_tuff_brick",
        ingredient = "unilib:stone_tuff",
    })
    --[[
    unilib.register_stairs("unilib:stone_tuff_brick", {
        img_rotate_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "tuff",
    })
    -- N.B. Walls made from stone brick are a novelty restricted to this stone type
    unilib.register_wall({
        -- From darkage:tuff_bricks
        orig_name = "darkage:tuff_bricks",
        ingredient = "unilib:stone_tuff_brick",

        replace_mode = mode,
        description = S("Tuff Brick Wall"),
        sound_name = "stone",
        img_list = {"unilib_stone_tuff_brick.png"},
    })
    unilib.set_auto_rotate("unilib:stone_tuff_brick", unilib.auto_rotate_brick_flag)

    unilib.register_node("unilib:stone_tuff_brick_old", "darkage:old_tuff_bricks", mode, {
        -- From darkage:old_tuff_bricks
        description = S("Old Tuff Bricks"),
        tiles = {"unilib_stone_tuff_brick_old.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
    })
    if unilib.super_stone_table["tuff"] then

        unilib.register_stairs("unilib:stone_tuff_brick_old", {
            group_type = "brick",
            img_rotate_flag = true,
        })

    end
    -- N.B. Walls made from stone brick are a novelty for this stone type
    unilib.register_wall({
        -- From darkage:old_tuff_bricks
        orig_name = "darkage:old_tuff_bricks",
        ingredient = "unilib:stone_tuff_brick_old",

        replace_mode = mode,
        description = S("Old Tuff Brick Wall"),
        sound_name = "stone",
        img_list = {"unilib_stone_tuff_brick_old.png"},
    })
    unilib.set_auto_rotate("unilib:stone_tuff_brick_old", unilib.auto_rotate_brick_flag)

    -- (is_ground_content was probably not set to false so that code now in the
    --      "ore_darkage_stone_tuff" package could use it as an ore)
    unilib.register_node("unilib:stone_tuff_rubble", "darkage:tuff_rubble", mode, {
        -- From darkage:tuff_rubble
        description = S("Tuff Rubble"),
        tiles = {"unilib_stone_tuff_rubble.png"},
        groups = {crumbly = 2, falling_node = 1, rubble = 1},
        sounds = unilib.sound_table.gravel,
    })
    unilib.register_stone_rubble_cuttings({
        part_name = "tuff"
    })

    -- Notes from darkage:
    -- ABM to turn tuff bricks to old tuff bricks if water is nearby
    unilib.register_abm({
        label = "Convert tuff bricks [stone_tuff]",
        nodenames = {"unilib:stone_tuff_brick"},
        neighbors = {"group:water"},

        catch_up = false,
        chance = 200,
        interval = 16,

        -- N.B. preservation of param2 missing in original code
        action = function(pos, node)
            minetest.set_node(pos, {name = "unilib:stone_tuff_brick_old", param2 = node.param2})
        end
    })

end
