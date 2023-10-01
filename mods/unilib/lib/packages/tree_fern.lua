---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/ferns
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_fern = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ferns.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_fern.grow_func(pos)

    -- N.B. Original code's ABM subtracted one from y, before calling this function
    pos = {x = pos.x, y = pos.y - 1, z = pos.z}

    local pos_aux = {x = pos.x, y = pos.y + 1, z = pos.z}
    local name = minetest.get_node(pos_aux).name
    if name ~= "air" and name ~= "unilib:tree_fern_sapling" and name ~= "unilib:grass_jungle" then
        return
    end

    local size = math.random(1, 4) + math.random(1, 4)
    if (size > 5) then
        size = 10 - size
    end

    size = size + 1
    local crown = ({
        "unilib:tree_fern_crown_large",
        "unilib:tree_fern_crown_small",
    })[math.random(1, 2)]

    local i = 1
    local break_flag = false
    while (i < size) do

        pos_aux.y = pos.y + i
        name = minetest.get_node(pos_aux).name
        if not (name == "air" or (i == 1 and name == "unilib:tree_fern_sapling")) then

            break_flag = true
            break

        end

        minetest.swap_node(
            {x = pos.x, y = pos.y + i, z = pos.z},
            {name = "unilib:tree_fern_trunk"}
        )

        i = i + 1

    end

    if not break_flag then
        minetest.swap_node({x = pos.x, y = pos.y + i - 1, z = pos.z}, {name = crown})
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_fern.init()

    return {
        description = "Fern tree",
        notes = "Provides ordinary fern tubers, if other packages are loaded",
        optional = "grass_jungle",
    }

end

function unilib.pkg.tree_fern.exec()

    -- (no burnlevel)
    local sci_name = "Dicksonia"

    unilib.register_tree({
        -- Original to unilib
        part_name = "fern",
        description = S("Fern Tree Wood"),

        not_super_flag = true,
    })

    unilib.register_node("unilib:tree_fern_trunk", "ferns:fern_trunk", mode, {
        -- From ferns:fern_trunk
        description = unilib.annotate(S("Fern Tree Trunk"), sci_name),
        tiles = {
            "unilib_tree_fern_trunk_top.png",
            "unilib_tree_fern_trunk_top.png",
            "unilib_tree_fern_trunk.png"
        },
        groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, tree = 1, wood = 1},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
        },
        use_texture_alpha = "clip",

        after_destruct = function(pos, oldnode)

            local node = minetest.get_node({x = pos.x, y = pos.y + 1, z = pos.z})
            if node.name == "unilib:tree_fern_trunk" then

                minetest.dig_node({x = pos.x, y = pos.y + 1, z = pos.z})
                minetest.add_item(pos, "unilib:tree_fern_trunk")

            end

        end,
    })

    -- Fern trees randomly have one of two crowns; the smaller one drops the medium one
    unilib.register_node("unilib:tree_fern_crown_large", "ferns:tree_fern_leaves", mode, {
        -- From ferns:tree_fern_leaves
        description = S("Fern Tree Crown"),
        tiles = {"unilib_tree_fern_crown.png"},
        groups = {attached_node = 1, flammable = 2, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        -- Notes from ferns mod:
        -- Occasionally, drop a second sapling instead of leaves
        -- (Extra saplings can also be obtained by replanting and reharvesting leaves)
        drop = {
            max_items = 2,
            items = {
                {
                    items = {"unilib:tree_fern_sapling"},
                    rarity = 10,
                },
                {
                    items = {"unilib:tree_fern_sapling"},
                },
                {
                    items = {"unilib:tree_fern_crown_large"},
                },
            },
        },
        inventory_image = "unilib_tree_fern_crown_inv.png",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
        },
        visual_scale = math.sqrt(8),
        walkable = false,
    })

    unilib.register_node("unilib:tree_fern_crown_small", "ferns:tree_fern_leaves_02", mode, {
        -- From ferns:tree_fern_leaves_02
        -- (no description)
        tiles = {"unilib_tree_fern_crown_small.png"},
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
                    items = {"unilib:tree_fern_sapling"},
                    rarity = 10,
                },
                {
                    items = {"unilib:tree_fern_sapling"},
                },
                {
                    items = {"unilib:tree_fern_crown_large"},
                }
            }
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
        },
        visual_scale = math.sqrt(8),
        walkable = false,
    })

    unilib.register_node("unilib:tree_fern_sapling", "ferns:sapling_tree_fern", mode, {
        -- From ferns:sapling_tree_fern
        description = S("Fern Tree Sapling"),
        tiles = {"unilib_tree_fern_sapling.png"},
        groups = {attached_node = 1, flammable = 2, flora = 1, sapling = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_tree_fern_sapling.png",
        paramtype = "light",
        paramtype2 = "facedir",
        sci_name = sci_name,
        selection_box = {
            type = "fixed",
            fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
        },
        walkable = false,
    })
    unilib.register_tree_sapling_custom({
        part_name = "fern",
        grow_func = unilib.pkg.tree_fern.grow_func,
    })

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_fern_in_jungle"
        part_name = "tree_fern_in_jungle",
        convert_func = unilib.pkg.tree_fern.grow_func,
        replace_mode = mode,

        climate_table = {
            humidity_max = unilib.convert_biome_lib_temp(-1.0),
            humidity_min = unilib.convert_biome_lib_temp(0.4),
            temp_max = unilib.convert_biome_lib_temp(-0.5),
            temp_min = unilib.convert_biome_lib_temp(0.13),
        },
        generic_def_table = {
            fill_ratio = unilib.convert_biome_lib({
                rarity = 50,
                plantlife_limit = -0.9,
            }),
        },
        space_table = {
            height = 5,
            width = 1,
            sub_name = "unilib:tree_fern_sapling",
        },
    })
    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_fern_on_sand"
        part_name = "tree_fern_on_sand",
        convert_func = unilib.pkg.tree_fern.grow_func,
        replace_mode = mode,

        climate_table = {
            humidity_max = unilib.convert_biome_lib_temp(-1.0),
            humidity_min = unilib.convert_biome_lib_temp(1.0),
            temp_max = unilib.convert_biome_lib_temp(-1.0),
            temp_min = unilib.convert_biome_lib_temp(1.0),
        },
        generic_def_table = {
            fill_ratio = unilib.convert_biome_lib({
                rarity = 50,
                plantlife_limit = -0.9,
            }),
        },
        space_table = {
            height = 5,
            width = 1,
            sub_name = "unilib:tree_fern_sapling",
        },
    })

end
