---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_leaves_autumn = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_leaves_autumn.init()

    return {
        description = "Autumn leaves",
        notes = "This item is currently not used by anything (and was not used even in the" ..
                " original GLEMr4 code). It might be useful for anyone who wants to modify" ..
                " a tree's leaves with an autumnal variant",
    }

end

function unilib.pkg.misc_leaves_autumn.exec()

    local drop = "unilib:misc_leaves_autumn"
    if unilib.setting.leaves_drop_sticks_flag then

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:item_stick_ordinary"}, rarity = 20},
                {items = {"unilib:misc_leaves_autumn"}},
            },
        }

    end

    local inv_img = unilib.flora.filter_leaves_img("unilib_misc_leaves_autumn.png")
    unilib.register_node("unilib:misc_leaves_autumn", "lib_ecology:tree_leaves_autumn", mode, {
        -- Texture from GLEMr4, lib_ecology_tree_leaves_autumn.png. Original code
        description = S("Autumn Leaves"),
        tiles = {"unilib_misc_leaves_autumn.png"},
        groups = {flammable = 2, leafdecay = 3, leaves = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = unilib.global.leaves_drawtype,
        drop = drop,
        inventory_image = inv_img,
        is_ground_content = false,
        paramtype = "light",
        visual_scale = unilib.global.leaves_visual_scale,
        walkable = unilib.setting.walkable_leaves_flag,
        waving = 1,
        wield_img = inv_img,

        after_place_node = unilib.flora.after_place_leaves,
    })
    unilib.register_tree_leaves_compacted("unilib:misc_leaves_autumn", mode)

end
