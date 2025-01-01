---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_ordinary_pillar = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_ordinary_pillar.init()

    return {
        description = "Ordinary sandstone pillar",
        depends = {"item_stick_ordinary", "stone_sandstone_ordinary"},
    }

end

function unilib.pkg.stone_sandstone_ordinary_pillar.exec()

    local c_stick = "unilib:item_stick_ordinary"

    unilib.register_node(
        -- From farlands, decoblocks:sandstone_pillar
        "unilib:stone_sandstone_ordinary_pillar",
        "decoblocks:sandstone_pillar",
        mode,
        {
            description = S("Ordinary Sandstone Pillar"),
            tiles = {
                "unilib_stone_sandstone_ordinary_pillar_top.png",
                "unilib_stone_sandstone_ordinary_pillar_top.png",
                "unilib_stone_sandstone_ordinary_pillar.png",
            },
            groups = {cracky = 3, stone = 2},
            sounds = unilib.global.sound_table.stone,

            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            paramtype2 = "facedir",

            on_place = core.rotate_node,
        }
    )
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:stone_sandstone_ordinary_pillar",
        recipe = {
            {"", c_stick, ""},
            {c_stick, "unilib:stone_sandstone_ordinary", c_stick},
            {"", c_stick, ""},
        },
    })
    unilib.register_craft({
        -- Original to unilib
        type = "shapeless",
        output = "unilib:stone_sandstone_ordinary_pillar",
        recipe = {"unilib:stone_sandstone_ordinary_pillar_base"},
    })

    unilib.register_node(
        -- From farlands, decoblocks:sandstone_pillar_base
        "unilib:stone_sandstone_ordinary_pillar_base",
        "decoblocks:sandstone_pillar_base",
        mode,
        {
            description = S("Ordinary Sandstone Pillar Base"),
            tiles = {
                "unilib_stone_sandstone_ordinary_pillar_top.png",
                "unilib_stone_sandstone_ordinary_pillar_top.png",
                "unilib_stone_sandstone_ordinary_pillar.png",
            },
            groups = {cracky = 3, stone = 2},
            sounds = unilib.global.sound_table.stone,

            drawtype = "nodebox",
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                    {-0.5625, -0.5, -0.5625, 0.5625, -0.3125, 0.5625},
                    {-0.625, -0.5, -0.625, 0.625, -0.4375, 0.625},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",

            on_place = core.rotate_node,
        }
    )
    unilib.register_craft({
        -- Original to unilib
        type = "shapeless",
        output = "unilib:stone_sandstone_ordinary_pillar_base",
        recipe = {"unilib:stone_sandstone_ordinary_pillar"},
    })

end

