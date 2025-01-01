---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_tuff_rhyolitic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_tuff_rhyolitic.init()

    return {
        description = "Rhyolitic tuff",
        optional = {"stone_desert", "stone_gneiss_white"},
    }

end

function unilib.pkg.stone_tuff_rhyolitic.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "tuff_rhyolitic",
        description = S("Rhyolitic Tuff"),

        category = "extrusive",
        colour = "#DE8A69",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 3)
        hardness = 1,
        hardness_real = 3,
    })

    -- (preserve original cracky values for smoothstone and blocks)

    unilib.register_node("unilib:stone_tuff_rhyolitic", "darkage:rhyolitic_tuff", mode, {
        -- From darkage:rhyolitic_tuff
        description = S("Rhyolitic Tuff"),
        tiles = {"unilib_stone_tuff_rhyolitic.png"},
        groups = {cracky = 3, smoothstone = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:stone_tuff_rhyolitic"}, rarity = 3},
                {items = {"unilib:stone_tuff_rhyolitic_rubble"}},
            },
        },
    })
    unilib.register_craft({
        -- From darkage:rhyolitic_tuff
        type = "cooking",
        output = "unilib:stone_tuff_rhyolitic",
        recipe = "unilib:stone_tuff_rhyolitic_rubble",
    })
    if unilib.global.pkg_executed_table["stone_desert"] ~= nil and
            unilib.global.pkg_executed_table["stone_gneiss_white"] ~= nil then

        unilib.register_craft({
            -- From darkage:rhyolitic_tuff
            output = "unilib:stone_tuff_rhyolitic 2",
            recipe = {
                {"unilib:stone_gneiss_white", "unilib:stone_desert"},
                {"unilib:stone_desert", "unilib:stone_gneiss_white"},
            },
        })

    end
    --[[
    unilib.register_stairs("unilib:stone_tuff_rhyolitic", {
        drop_name = "unilib:stone_tuff_rhyolitic_rubble",
        group_type = "smooth",
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "tuff_rhyolitic",

        drop_name = "unilib:stone_tuff_rhyolitic_rubble",
    })

    unilib.register_node(
        -- From darkage:rhyolitic_tuff_bricks
        "unilib:stone_tuff_rhyolitic_brick",
        "darkage:rhyolitic_tuff_bricks",
        mode,
        {
            description = S("Rhyolitic Tuff Bricks"),
            tiles = {"unilib_stone_tuff_rhyolitic_brick.png"},
            -- N.B. stone = 1 not in original code
            groups = {cracky = 2, stone = 1, stonebrick = 1},
            sounds = unilib.global.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft_2x2x4({
        -- From darkage:rhyolitic_tuff_bricks
        output = "unilib:stone_tuff_rhyolitic_brick",
        ingredient = "unilib:stone_tuff_rhyolitic",
    })
    --[[
    unilib.register_stairs("unilib:stone_tuff_rhyolitic_brick", {
        img_rotate_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "tuff_rhyolitic",
    })
    -- N.B. Walls made from stone brick are a novelty restricted to this stone type
    unilib.register_wall({
        -- From darkage:rhyolitic_tuff_bricks
        orig_name = "darkage:rhyolitic_tuff_bricks",
        ingredient = "unilib:stone_tuff_rhyolitic_brick",

        replace_mode = mode,
        description = S("Rhyolitic Tuff Brick Wall"),
        sound_name = "stone",
        img_list = {"unilib_stone_tuff_rhyolitic_brick.png"},
    })
    unilib.utils.set_auto_rotate(
        "unilib:stone_tuff_rhyolitic_brick", unilib.setting.auto_rotate_brick_flag
    )

    -- N.B. .is_ground_content probably not set to false so that the
    --      "ore_darkage_stone_tuff_rhyolitic" package can use it as an ore)
    unilib.register_node(
        -- From darkage:rhyolitic_tuff_rubble
        "unilib:stone_tuff_rhyolitic_rubble",
        "darkage:rhyolitic_tuff_rubble",
        mode,
        {
            description = S("Rhyolitic Tuff Rubble"),
            tiles = {"unilib_stone_tuff_rhyolitic_rubble.png"},
            groups = {crumbly = 2, falling_node = 1, rubble = 1},
            sounds = unilib.global.sound_table.gravel,
        }
    )
    unilib.register_stone_rubble_cuttings({
        part_name = "tuff_rhyolitic",
    })

    unilib.register_stone_rubble_compressed({
        -- Original to unilib. Creates unilib:stone_tuff_rhyolitic_rubble_compressed
        part_name = "tuff_rhyolitic",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Rhyolitic Tuff Rubble"),
    })

    unilib.register_stone_rubble_condensed({
        -- Original to unilib. Creates unilib:stone_tuff_rhyolitic_rubble_condensed
        part_name = "tuff_rhyolitic",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Rhyolitic Tuff Rubble"),
    })

end
