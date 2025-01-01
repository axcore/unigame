---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_skeleton_human_skull = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_skeleton_human_skull.init()

    return {
        description = "Decorative human skull",
        depends = {"item_bone", "mineral_diamond"},
    }

end

function unilib.pkg.misc_skeleton_human_skull.exec()

    unilib.register_node("unilib:misc_skeleton_human_skull", "decoblocks:human_skull", mode, {
        -- From farlands, decoblocks:human_skull
        description = S("Decorative Human Skull"),
        tiles = {"unilib_misc_skeleton_human_skull.png"},
        groups = {choppy = 1, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.wood,

        collision_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.0, 0.3},
        },
        drawtype = "mesh",
        inventory_image = "unilib_misc_skeleton_human_skull_inv.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        mesh = "unilib_misc_skeleton_human_skull.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.0, 0.3},
        },
        use_texture_alpha = "clip",
        visual_scale = 0.5,
        wield_image = "unilib_misc_skeleton_human_skull_inv.png",
        wield_scale = {x = 1.0, y = 1.0, z = 1.0},
    })
    -- N.B. No craft recipe in the original code. The use of diamonds here is intended to make
    --      crafting the skull expensive (because rendering the model is processor-intensive)
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:misc_skeleton_human_skull",
        recipe = {
            {"unilib:item_bone", "unilib:mineral_diamond_gem"},
            {"unilib:mineral_diamond_gem", "unilib:item_bone"},
        },
    })

end
