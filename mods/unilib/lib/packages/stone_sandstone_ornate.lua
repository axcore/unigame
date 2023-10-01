---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_ornate = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_ornate.init()

    return {
        description = "Ornate sandstone",
        notes = "This is an unfinished package, which will be converted to unilib carvings in" ..
                " a future release. The nodes currently have no craft recipes",
    }

end

function unilib.pkg.stone_sandstone_ornate.exec()

    unilib.register_node("unilib:stone_sandstone_arch", "decoblocks:sandstone_arch", mode, {
        -- From farlands, decoblocks:sandstone_arch
        description = S("Sandstone Arch"),
        tiles = {"unilib_stone_sandstone_ordinary.png"},
        groups = {cracky = 1},
        -- (no sounds)

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.1875, 0.4375, -0.5, 0.1875, 0.5, 0.5},
                {-0.5, 0.375, -0.5, -0.1875, 0.5, 0.5},
                {0.1875, 0.375, -0.5, 0.5, 0.5, 0.5},
                {0.25, 0.3125, -0.5, 0.5, 0.375, 0.5},
                {-0.5, 0.3125, -0.5, -0.25, 0.375, 0.5},
                {-0.5, 0.1875, -0.5, -0.3125, 0.3125, 0.5},
                {0.3125, 0.1875, -0.5, 0.5, 0.3125, 0.5},
                {0.375, 0, -0.5, 0.5, 0.1875, 0.5},
                {-0.5, 0, -0.5, -0.375, 0.1875, 0.5},
                {0.4375, -0.5, -0.5, 0.5, 0, 0.5},
                {-0.5, -0.5, -0.5, -0.4375, 0, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })

    unilib.register_node("unilib:stone_sandstone_ledge", "decoblocks:sandstone_ledge", mode, {
        -- From farlands, decoblocks:sandstone_ledge
        description = S("Sandstone Ledge"),
        tiles = {"unilib_stone_sandstone_ordinary.png"},
        groups = {cracky = 1},
        -- (no sounds)

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                {-0.5, 0.3125, -0.5625, 0.5, 0.5, 0.5},
                {-0.5, 0.4375, -0.625, 0.5, 0.5, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })

    unilib.register_node(
        -- From farlands, decoblocks:sandstone_ledge_corner
        "unilib:stone_sandstone_ledge_corner",
        "decoblocks:sandstone_ledge_corner",
        mode,
        {
            description = S("Sandstone Ledge Corner"),
            tiles = {"unilib_stone_sandstone_ordinary.png"},
            groups = {cracky = 1},
            -- (no sounds)

            drawtype = "nodebox",
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                    {-0.5, 0.3125, -0.5625, 0.5625, 0.5, 0.5},
                    {-0.5, 0.4375, -0.625, 0.625, 0.5, 0.5},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
        }
    )

    unilib.register_node("unilib:stone_sandstone_pillar", "decoblocks:sandstone_pillar", mode, {
        -- From farlands, decoblocks:sandstone_pillar
        description = S("Sandstone Pillar"),
        tiles = {
            "unilib_stone_sandstone_pillar_top.png",
            "unilib_stone_sandstone_pillar_top.png",
            "unilib_stone_sandstone_pillar.png",
        },
        groups = {cracky = 3, stone = 2},
        sounds = unilib.sound_table.stone,

        paramtype2 = "facedir",

        on_place = minetest.rotate_node,
    })

    unilib.register_node(
        -- From farlands, decoblocks:sandstone_pillar_base
        "unilib:stone_sandstone_pillar_base",
        "decoblocks:sandstone_pillar_base",
        mode,
        {
            description = S("Sandstone Pillar Base"),
            tiles = {
                "unilib_stone_sandstone_pillar_top.png",
                "unilib_stone_sandstone_pillar_top.png",
                "unilib_stone_sandstone_pillar.png",
            },
            groups = {cracky = 3, stone = 2},
            sounds = unilib.sound_table.stone,

            drawtype = "nodebox",
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                    {-0.5625, -0.5, -0.5625, 0.5625, -0.3125, 0.5625},
                    {-0.625, -0.5, -0.625, 0.625, -0.4375, 0.625},
                }
            },
            paramtype = "light",
            paramtype2 = "facedir",

            on_place = minetest.rotate_node,
        }
    )

    unilib.register_node("unilib:stone_sandstone_rail", "decoblocks:sandstone_rail", mode, {
        -- From farlands, decoblocks:sandstone_rail
        description = S("Sandstone Rail"),
        tiles = {"unilib_stone_sandstone_ordinary.png"},
        groups = {cracky = 1},
        -- (no sounds)

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                {-0.5, -0.0625, -0.5625, 0.5, 0.125, 0.5},
                {-0.5, 0, -0.625, 0.5, 0.0625, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })

    unilib.register_node(
        -- From farlands, decoblocks:sandstone_rail_corner
        "unilib:stone_sandstone_rail_corner",
        "decoblocks:sandstone_rail_corner",
        mode,
        {
            description = S("Sandstone Rail Corner"),
            tiles = {"unilib_stone_sandstone_ordinary.png"},
            groups = {cracky = 1},
            -- (no sounds)

            drawtype = "nodebox",
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                    {-0.5625, -0.0625, -0.5625, 0.5, 0.125, 0.5},
                    {-0.625, 0, -0.625, 0.5, 0.0625, 0.5},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
        }
    )

    unilib.register_node("unilib:stone_sandstone_tile", "decoblocks:painted_sandstone_tile", mode, {
        -- From farlands, decoblocks:painted_sandstone_tile
        description = S("Painted Sandstone Tile"),
        tiles = {"unilib_stone_sandstone_ordinary.png^unilib_stone_tile_floor_overlay.png"},
        groups = {cracky = 3, stone = 2},
        sounds = unilib.sound_table.stone,

        paramtype2 = "facedir",
    })

    unilib.register_node("unilib:stone_sandstone_window", "decoblocks:sandstone_window", mode, {
        -- From farlands, decoblocks:sandstone_window
        description = S("Sandstone Window"),
        tiles = {"unilib_stone_sandstone_ordinary.png"},
        groups = {cracky = 1},
        -- (no sounds)

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
                {-0.5, 0.25, -0.5, 0.5, 0.5, 0.5},
                {0.25, -0.25, -0.5, 0.5, 0.25, 0.5},
                {-0.5, -0.25, -0.5, -0.25, 0.25, 0.5},
                {0.1875, 0.1875, -0.5, 0.25, 0.25, 0.5},
                {-0.25, 0.1875, -0.5, -0.1875, 0.25, 0.5},
                {-0.375, -0.375, -0.5625, 0.375, -0.25, 0.4375},
                {-0.1875, 0.25, -0.5625, 0.1875, 0.3125, -0.5},
                {-0.25, 0.1875, -0.5625, -0.1875, 0.25, -0.5},
                {0.1875, 0.1875, -0.5625, 0.25, 0.25, -0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })

end
