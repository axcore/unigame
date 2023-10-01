---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/ferns
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_fern_giant = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ferns.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_fern_giant.grow_func(pos)

    -- N.B. Original code's ABM subtracted one from y, before calling this function
    pos = {x = pos.x, y = pos.y - 1, z = pos.z}

    local pos_aux = {x = pos.x, y = pos.y + 1, z = pos.z}
    local name = minetest.get_node(pos_aux).name
    if name ~= "air" and
            name ~= "unilib:tree_fern_giant_sapling" and
            name ~= "unilib:grass_jungle" then
        return
    end

    -- Notes from ferns:
    -- Minimum range is >= 4
    local size = math.random(12, 16)

    local leafchecks = {
        {
            direction = 3,
            positions = {
                {x = pos.x + 1, y = pos.y + size - 1, z = pos.z},
                {x = pos.x + 2, y = pos.y + size, z = pos.z},
                {x = pos.x + 3, y = pos.y + size - 1, z = pos.z},
                {x = pos.x + 4, y = pos.y + size - 2, z = pos.z}
            }
        },
        {
            direction = 1,
            positions = {
                {x = pos.x - 1, y = pos.y + size - 1, z = pos.z},
                {x = pos.x - 2, y = pos.y + size, z = pos.z},
                {x = pos.x - 3, y = pos.y + size - 1, z = pos.z},
                {x = pos.x - 4, y = pos.y + size - 2, z = pos.z}
            }
        },
        {
            direction = 2,
            positions = {
                {x = pos.x, y = pos.y + size - 1, z = pos.z + 1},
                {x = pos.x, y = pos.y + size, z = pos.z + 2},
                {x = pos.x, y = pos.y + size - 1, z = pos.z + 3},
                {x = pos.x, y = pos.y + size - 2, z = pos.z + 4}
            }
        },
        {
            direction = 0,
            positions = {
                {x = pos.x, y = pos.y + size - 1, z = pos.z - 1},
                {x = pos.x, y = pos.y + size, z = pos.z - 2},
                {x = pos.x, y = pos.y + size - 1, z = pos.z - 3},
                {x = pos.x, y = pos.y + size - 2, z = pos.z - 4}
            }
        }
    }

    local break_flag = false
    for i = 1, (size - 3) do

        pos_aux.y = pos.y + i
        local name = minetest.get_node(pos_aux).name
        if not (name == "air" or (i == 1 and name == "unilib:tree_fern_giant_sapling")) then

            break_flag = true
            break

        end

        minetest.swap_node(
            {x = pos.x, y = pos.y + i, z = pos.z},
            {name = "unilib:tree_fern_giant_trunk"}
        )

    end

    if not break_flag then

        minetest.swap_node(
            {x = pos.x, y = pos.y + size-2, z = pos.z},
            {name = "unilib:tree_fern_giant_trunk_apex"}
        )

        minetest.swap_node(
            {x = pos.x, y = pos.y + size-1, z = pos.z},
            {name = "unilib:tree_fern_giant_crown_start"}
        )

        -- Notes from ferns:
        -- The air checks below prevent some ugly bugs (incomplete trunks of neighbouring trees),
        --      it's a bit slower, but worth the result
        for i = 1, 4 do

            local positions = leafchecks[i].positions
            local rot = leafchecks[i].direction
            -- If the loop below adds all intermediate leaves then the "terminating" leaf will be at
            --      positions[4]
            local endpos = 4

            -- Add leaves so long as the destination nodes are air
            for j = 1, 3 do

                if minetest.get_node(positions[j]).name == "air" then

                    minetest.swap_node(positions[j], {name = "unilib:tree_fern_giant_crown_middle"})

                else

                    endpos = j
                    break

                end

            end

            -- Add the terminating leaf if required and possible
            if endpos == 4 and minetest.get_node(positions[endpos]).name == "air" then

                minetest.swap_node(
                    positions[endpos],
                    {name="unilib:tree_fern_giant_crown_end", param2 = rot}
                )

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_fern_giant.init()

    return {
        description = "Giant fern tree",
    }

end

function unilib.pkg.tree_fern_giant.exec()

    -- (no burnlevel)
    local sci_name = "Dicksonia"

    unilib.register_tree({
        -- Original to unilib
        part_name = "fern_giant",
        description = S("Giant Fern Tree Wood"),

        not_super_flag = true,
    })

    unilib.register_node("unilib:tree_fern_giant_trunk", "ferns:fern_trunk_big", mode, {
        -- From ferns:fern_trunk_big
        description = S("Giant Fern Tree Trunk"),
        tiles = {
            "unilib_tree_fern_giant_trunk_top.png",
            "unilib_tree_fern_giant_trunk_top.png",
            "unilib_tree_fern_giant_trunk.png"
        },
        groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, tree = 1, wood = 1},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
        },
        paramtype = "light",
        sci_name = sci_name,
        selection_box = {
            type = "fixed",
            fixed = {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
        },
        use_texture_alpha = "clip",

        after_destruct = function(pos, oldnode)

            local node = minetest.get_node({x = pos.x, y = pos.y + 1, z = pos.z})
            if node.name == "unilib:tree_fern_giant_trunk" or
                    node.name == "unilib:tree_fern_giant_trunk_apex" then

                minetest.dig_node({x = pos.x, y = pos.y + 1, z = pos.z})
                minetest.add_item(pos, "unilib:tree_fern_giant_trunk")

            end

        end,
    })

    unilib.register_node("unilib:tree_fern_giant_trunk_apex", "ferns:fern_trunk_big_top", mode, {
        -- From ferns:fern_trunk_big_top
        description = S("Giant Fern Tree Trunk"),
        tiles = {
            "unilib_tree_fern_giant_trunk_top.png^unilib_tree_fern_giant_trunk_apex_overlay.png",
            "unilib_tree_fern_giant_trunk_top.png^unilib_tree_fern_giant_trunk_apex_overlay.png",
            "unilib_tree_fern_giant_trunk.png"
        },
        groups = {
            choppy = 2,
            flammable = 3,
            -- N.B. leafdecay = 3 in original code
            leafdecay = 1,
            not_in_creative_inventory = 1,
            oddly_breakable_by_hand = 2,
            tree = 1,
            wood = 1,
        },
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        drop = "unilib:tree_fern_giant_trunk",
        node_box = {
            type = "fixed",
            fixed = {
                {-1/2,  33/64, -1/2, 1/2, 33/64, 1/2},
                {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
            }
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
        },
        use_texture_alpha = "clip",
    })

    unilib.register_node(
        -- From ferns:tree_fern_leaves_giant
        "unilib:tree_fern_giant_crown_start",
        "ferns:tree_fern_leaves_giant",
        mode,
        {
            description = S("Giant Fern Tree Crown"),
            tiles = {"unilib_tree_fern_giant_crown_start.png"},
            groups = {attached_node = 1, flammable = 2, not_in_creative_inventory = 1, snappy = 3},
            sounds = unilib.sound_table.leaves,

            drawtype = "plantlike",
            -- Notes from ferns mod:
            -- Occasionally, drop a second sapling instead of leaves
            -- (Extra saplings can also be obtained by replanting and reharvesting leaves)
            drop = {
                max_items = 2,
                items = {
                    {
                        items = {"unilib:tree_fern_giant_sapling"},
                        rarity = 10,
                    },
                    {
                        items = {"unilib:tree_fern_giant_sapling"},
                    },
                    {
                        items = {"unilib:tree_fern_giant_crown_start"},
                    },
                },
            },
            inventory_image = "unilib_tree_fern_crown.png",
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
            },
            visual_scale = math.sqrt(11),
            walkable = false,
            wield_scale = {x = 0.175, y = 0.175, z = 0.175},
        }
    )

    unilib.register_node("unilib:tree_fern_giant_crown_middle", "ferns:tree_fern_leave_big", mode, {
        -- From ferns:tree_fern_leave_big
        description = S("Giant Fern Tree Crown"),
        tiles = {"unilib_tree_fern_giant_crown_middle.png"},
        groups = {attached_node = 1, flammable = 2, not_in_creative_inventory = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "raillike",
        drop = "",
        paramtype = "light",
        walkable = false,

        after_destruct = function(pos, oldnode)

            for _, d in pairs(
                {{x = -1, z = 0}, {x = 1, z = 0}, {x = 0, z = -1}, {x = 0, z = 1}}
            ) do
                local node = minetest.get_node({x = pos.x + d.x, y = pos.y + 1, z = pos.z + d.z})
                if node.name == "unilib:tree_fern_giant_crown_middle" then
                    minetest.dig_node({x = pos.x + d.x, y = pos.y + 1, z = pos.z + d.z})
                end

            end

        end,
    })

    unilib.register_node(
        -- From ferns:tree_fern_leave_big_end
        "unilib:tree_fern_giant_crown_end",
        "ferns:tree_fern_leave_big_end",
        mode,
        {
            description = S("Giant Fern Tree Crown"),
            tiles = {"unilib_tree_fern_giant_crown_end.png"},
            groups = {attached_node = 1, flammable = 2, not_in_creative_inventory = 1, snappy = 3},
            sounds = unilib.sound_table.leaves,

            drawtype = "nodebox",
            drop = "",
            node_box = {
                type = "fixed",
                fixed = {-1/2, -1/2,   1/2, 1/2,   33/64, 1/2},
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {-1/2, -1/2,   1/2, 1/2,   33/64, 1/2},
            },
            use_texture_alpha = "clip",
            walkable = false,
        }
    )

    unilib.register_node("unilib:tree_fern_giant_sapling", "ferns:sapling_giant_tree_fern", mode, {
        -- From ferns:sapling_giant_tree_fern
        description = S("Giant Fern Tree Sapling"),
        tiles = {"unilib_tree_fern_giant_sapling.png"},
        -- N.B. removed flora = 1 to prevent spreading
        groups = {attached_node = 1, flammable = 2, sapling = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_tree_fern_giant_sapling.png",
        paramtype = "light",
        sci_name = sci_name,
        selection_box = {
            type = "fixed",
            fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
        },
        walkable = false,
    })
    unilib.register_tree_sapling_custom({
        part_name = "fern_giant",
        grow_func = unilib.pkg.tree_fern_giant.grow_func,
    })

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_fern_giant_in_jungle"
        part_name = "tree_fern_giant_in_jungle",
        convert_func = unilib.pkg.tree_fern_giant.grow_func,
        replace_mode = mode,

        climate_table = {
            humidity_max = unilib.convert_biome_lib_temp(-1.0),
            humidity_min = unilib.convert_biome_lib_temp(0.4),
            temp_max = unilib.convert_biome_lib_temp(-0.5),
            temp_min = unilib.convert_biome_lib_temp(0.13),
        },
        generic_def_table = {
            fill_ratio = unilib.convert_biome_lib({
                rarity = 85,
                plantlife_limit = -0.9,
            }),
        },
        space_table = {
            height = 17,
            width = 7,
            sub_name = "unilib:tree_fern_giant_sapling",
        },
    })
    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_fern_giant_on_sand"
        part_name = "tree_fern_giant_on_sand",
        convert_func = unilib.pkg.tree_fern_giant.grow_func,
        replace_mode = mode,

        climate_table = {
            humidity_max = unilib.convert_biome_lib_temp(-1.0),
            humidity_min = unilib.convert_biome_lib_temp(1.0),
            temp_max = unilib.convert_biome_lib_temp(-1.0),
            temp_min = unilib.convert_biome_lib_temp(1.0),
        },
        generic_def_table = {
            fill_ratio = unilib.convert_biome_lib({
                rarity = 90,
                plantlife_limit = -0.9,
            }),
        },
        space_table = {
            height = 17,
            width = 7,
            sub_name = "unilib:tree_fern_giant_sapling",
        },
    })

end
