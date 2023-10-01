---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    maptools
-- Code:    zlib
-- Media:   zlib
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_node_invisible = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.maptools.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_node_invisible.init()

    return {
        description = "Admin invisible nodes",
        depends = "shared_maptools",
    }

end

function unilib.pkg.admin_node_invisible.exec()

    -- Invisible, non-pointable block that blocks players and entities
    unilib.pkg.shared_maptools.register_node(
        -- From maptools:playerclip
        "unilib:admin_node_invisible_barrier",
        "maptools:playerclip",
        mode,
        {
            description = unilib.hint(S("Invisible Barrier"), S("blocks players and entities")),
            -- (no tiles)
            -- N.B. not_in_creative_inventory not in original code
            groups = {not_in_creative_inventory = unilib.show_admin_item_group},
            -- (no sounds)

            drawtype = "airlike",
            inventory_image = "unilib_metal_steel_block.png^unilib_dye_green.png",
            paramtype = "light",
            pointable = false,
            sunlight_propagates = true,
        }
    )

    -- Invisible, pointable block that blocks players and entities
    unilib.pkg.shared_maptools.register_node(
        -- From maptools:fullclip
        "unilib:admin_node_invisible_barrier_pointable",
        "maptools:fullclip",
        mode,
        {
            description = unilib.hint(
                S("Invisible Wall"), S("blocks players and entities, pointable")
            ),
            -- (no tiles)
            -- N.B. not_in_creative_inventory not in original code
            groups = {not_in_creative_inventory = unilib.show_admin_item_group},
            -- (no sounds)

            drawtype = "airlike",
            inventory_image = "unilib_metal_steel_block.png^unilib_dye_blue.png",
            paramtype = "light",
            sunlight_propagates = true,
        }
    )

    -- Invisible block, pointable in one direction only, that blocks players and entities
    unilib.pkg.shared_maptools.register_node(
        -- From maptools:fullclip_face
        "unilib:admin_node_invisible_barrier_face",
        "maptools:fullclip_face",
        mode,
        {
            description = unilib.hint(
                S("Invisible Wall"), S("blocks players and entities, pointable on one face")
            ),
            tiles = {"unilib_admin_invisible.png"},
            -- N.B. not_in_creative_inventory not in original code
            groups = {
                fall_damage_add_percent = -100,
                not_in_creative_inventory = unilib.show_admin_item_group,
            },
            -- (no sounds)

            drawtype = "nodebox",
            inventory_image = "unilib_metal_steel_block.png^unilib_dye_white.png",
            node_box = {
                type = "fixed",
                fixed = {-0.5, -0.5, -0.5, 0.5, -0.4999, 0.5},
            },
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = true,
            use_texture_alpha = "clip",
        }
    )

    -- Invisible, non-pointable block that allows players and entities to pass, but blocks building
    unilib.pkg.shared_maptools.register_node(
        -- From maptools:fake_walkable
        "unilib:admin_node_invisible_space",
        "maptools:fake_walkable",
        mode,
        {
            description = unilib.hint(S("Invisible Space"), S("prevents building")),
            -- (no tiles)
            -- N.B. not_in_creative_inventory not in original code
            groups = {not_in_creative_inventory = unilib.show_admin_item_group},
            -- (no sounds)

            drawtype = "airlike",
            -- N.B. switched duplicate dye texture in original code
            inventory_image = "unilib_metal_steel_block.png^unilib_dye_green_dark.png",
            node_box = {
                type = "fixed",
                fixed = {
                    {0, 0, 0, 0, 0, 0},
                },
            },
            paramtype = "light",
            pointable = false,
            sunlight_propagates = true,
        }
    )

    -- Invisible, pointable block that allows players and entities to pass, but blocks building
    unilib.pkg.shared_maptools.register_node(
        -- From maptools:fake_walkable_pointable
        "unilib:admin_node_invisible_space_pointable",
        "maptools:fake_walkable_pointable",
        mode,
        {
            description = unilib.hint(S("Invisible Space"), S("prevents building, pointable")),
            -- (no tiles)
            -- N.B. not_in_creative_inventory not in original code
            groups = {not_in_creative_inventory = unilib.show_admin_item_group},
            -- (no sounds)

            drawtype = "airlike",
            -- N.B. switched duplicate dye texture in original code
            inventory_image = "unilib_metal_steel_block.png^unilib_dye_grey.png",
            node_box = {
                type = "fixed",
                fixed = {
                    {0, 0, 0, 0, 0, 0},
                },
            },
            paramtype = "light",
            sunlight_propagates = true,
        }
    )

    -- Invisible, non-pointable block that inhibits building
    unilib.pkg.shared_maptools.register_node(
        -- From maptools:nobuild
        "unilib:admin_node_invisible_cube_nobuild",
        "maptools:nobuild",
        mode,
        {
            description = unilib.hint(S("Invisible Cube"), S("inhibits building")),
            -- (no tiles)
            -- N.B. not_in_creative_inventory not in original code
            groups = {not_in_creative_inventory = unilib.show_admin_item_group},
            -- (no sounds)

            drawtype = "airlike",
            inventory_image = "unilib_metal_steel_block.png^unilib_mineral_flint_lump.png",
            paramtype = "light",
            pointable = false,
            sunlight_propagates = true,
            walkable = false,
        }
    )

    -- Invisible, non-pointable block that inhibits interaction
    unilib.pkg.shared_maptools.register_node(
        -- From maptools:nointeract
        "unilib:admin_node_invisible_cube_nointeract",
        "maptools:nointeract",
        mode,
        {
            description = unilib.hint(S("Invisible Cube"), S("inhibits interact")),
            -- (no tiles)
            -- N.B. not_in_creative_inventory not in original code
            groups = {not_in_creative_inventory = unilib.show_admin_item_group},
            -- (no sounds)

            drawtype = "airlike",
            inventory_image = "unilib_metal_steel_block.png^unilib_bush_ordinary_stem.png",
            paramtype = "light",
            sunlight_propagates = true,
            walkable = false,
        }
    )

end
