---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/youngtrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_young_bamboo = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.youngtrees.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_young_bamboo.grow_func(pos)

    -- Original to unilib, based on the function in youngrees/init.lua

    local height = math.random(1, 3)
    local rotate = math.random(0, 3)

    local right_here = {x = pos.x, y = pos.y + 1, z = pos.z}
    if core.get_node(right_here).name == "air" then

        core.swap_node(right_here, {name = "unilib:tree_young_bamboo_top", param2 = rotate})
        if height > 1 then

            local above_right_here = {x = pos.x, y = pos.y + 2, z = pos.z}
            core.swap_node(
                above_right_here,
                {name = "unilib:tree_young_bamboo_top", param2 = rotate}
            )

            if height > 2 then

                local two_above_right_here = {x = pos.x, y = pos.y + 3, z = pos.z}
                core.swap_node(
                    two_above_right_here,
                    {name = "unilib:tree_young_bamboo_top", param2 = rotate}
                )

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_young_bamboo.init()

    return {
        description = "Young bamboo tree",
        notes = "The original code had a single node that didn't spawn anywhere. This package" ..
                " adds a decoration and growth function, that grows the \"tree\" up to three" ..
                " nodes in height",
        depends = "misc_twig_normal",
    }

end

function unilib.pkg.tree_young_bamboo.exec()

    unilib.register_node("unilib:tree_young_bamboo_top", "youngtrees:bamboo", mode, {
        -- From youngtrees:bamboo
        description = S("Young Bamboo Tree"),
        tiles = {"unilib_tree_young_bamboo.png"},
        groups = {flammable = 2, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        drop = "unilib:misc_twig_normal_1",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.058251, -0.500000, -0.413681, 0.066749, 0.500000, -0.282500},
                {-0.058251, -0.500000, -0.103123, 0.066749, 0.500000, 0.038672},
                {-0.058251, -0.500000, 0.181227, 0.066749, 0.500000, 0.342500},
            },
        },
        paramtype = "light",
        -- N.B. paramtype2 = "facedir" not in original code, it's required to make the function
        --      above work
        paramtype2 = "facedir",
        walkable = false,
    })

    unilib.register_decoration_convertable({
        -- Original to unilib. Creates generic definition "convert_tree_young_bamboo"
        part_name = "tree_young_bamboo",
        convert_func = unilib.pkg.tree_young_bamboo.grow_func,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = unilib.utils.convert_biome_lib({
                rarity = 100,
                rarity_fertility = 0.5,
                plantlife_limit = -0.3,
            }),
        },
    })

end
