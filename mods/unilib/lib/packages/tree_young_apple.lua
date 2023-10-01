---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/youngtrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_young_apple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.youngtrees.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_register(part_name, orig_name)

    local img = "unilib_tree_young_apple_" .. part_name .. ".png"

    unilib.register_node("unilib:tree_young_apple_" .. part_name, orig_name, mode, {
        description = S("Young Apple Tree"),
        tiles = {img},
        groups = {attached_node = 1, flammable = 2, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        drop = "unilib:item_twig_normal_1",
        inventory_image = img,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
        },
        walkable = false,
        wield_image = img,
    })

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_young_apple.grow_func(pos)

    local height = math.random(1, 3)
    local right_here = {x = pos.x, y = pos.y + 1, z = pos.z}
    local above_right_here = {x = pos.x, y = pos.y + 2, z = pos.z}

    -- N.B. Original code checks for both air and jungle grass. This seems to be a copy-paste error,
    --      because the original code doesn't spawn this tree and jungle grass in the same biomes
    if minetest.get_node(right_here).name == "air" then

        if height == 1 then
            minetest.swap_node(right_here, {name = "unilib:tree_young_apple_top"})
        end

        if height == 2 then

            minetest.swap_node(right_here, {name = "unilib:tree_young_apple_bottom"})
            minetest.swap_node(above_right_here, {name = "unilib:tree_young_apple_top"})

        end

        if height == 3 then

            local two_above_right_here = {x = pos.x, y = pos.y + 3, z = pos.z}
            minetest.swap_node(right_here, {name = "unilib:tree_young_apple_bottom"})
            minetest.swap_node(above_right_here, {name = "unilib:tree_young_apple_middle"})
            minetest.swap_node(two_above_right_here, {name = "unilib:tree_young_apple_top"})

        end
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_young_apple.init()

    return {
        description = "Young apple tree",
        notes = "Currently, does not grow into a full apple tree",
        depends = "item_twig_normal",
    }

end

function unilib.pkg.tree_young_apple.exec()

    -- From youngtrees:youngtree_top, creates unilib:tree_young_apple_top
    do_register("top", "youngtrees:youngtree_top")
    -- From youngtrees:youngtree_middle, creates unilib:tree_young_apple_middle
    do_register("middle", "youngtrees:youngtree_middle")
    -- From youngtrees:youngtree_young, creates unilib:tree_young_apple_young
    do_register("bottom", "youngtrees:youngtree_bottom")

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_young_apple"
        part_name = "tree_young_apple",
        convert_func = unilib.pkg.tree_young_apple.grow_func,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = unilib.convert_biome_lib({
                rarity = 100,
                rarity_fertility = 0.5,
                plantlife_limit = -0.3,
            }),
        },
    })

end
