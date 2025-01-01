---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_skeleton_human = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_skeleton_human.init()

    return {
        description = "Decorative human skeleton",
        depends = {"item_bone", "mineral_diamond"},
    }

end

function unilib.pkg.misc_skeleton_human.exec()

    local c_bone = "unilib:item_bone"
    local c_diamond = "unilib:mineral_diamond_gem"

    unilib.register_node("unilib:misc_skeleton_human", "decoblocks:old_skeleton", mode, {
        -- From farlands, decoblocks:old_skeleton
        description = S("Decorative Human Skeleton"),
        tiles = {"unilib_misc_skeleton_human.png"},
        groups = {choppy = 1, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.wood,

        collision_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.0, 0.3}
        },
        drawtype = "mesh",
        -- N.B. Don't use the skull texture, as the original code does; the inventorycube looks fine
        --      anyway
--      inventory_image = "unilib_misc_skeleton_human_skull_inv.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        mesh = "unilib_misc_skeleton_human.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.0, 0.3}
        },
        use_texture_alpha = "clip",
        visual_scale = 0.5,
        -- N.B. Use an original texture here, because the inventorycube only partly visible
--      wield_image = "unilib_misc_skeleton_human_skull_inv.png",
--      wield_scale = {x = 1.0, y = 1.0, z = 1.0},
        wield_image = "unilib_misc_skeleton_human_inv.png",
    })
    -- N.B. No craft recipe in the original code. The use of diamonds here is intended to make
    --      crafting the skull expensive (because rendering the model is processor-intensive)
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:misc_skeleton_human",
        recipe = {
            {c_diamond, c_bone, c_diamond},
            {c_bone, c_bone, c_bone},
            {c_diamond, c_bone, c_diamond},
        },
    })

    unilib.register_node("unilib:misc_skeleton_human_old", "decoblocks:old_skeleton_alt", mode, {
        -- From farlands, decoblocks:old_skeleton_alt
        description = S("Decorative Old Human Skeleton"),
        tiles = {"unilib_misc_skeleton_human.png"},
        groups = {choppy = 1, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.wood,

        collision_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.0, 0.3}
        },
        drawtype = "mesh",
        -- N.B. Don't use the skull texture, as the original code does; the inventorycube looks fine
        --      anyway
--      inventory_image = "unilib_misc_skeleton_human_skull_inv.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        mesh = "unilib_misc_skeleton_human_old.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.0, 0.3},
        },
        use_texture_alpha = "clip",
        visual_scale = 0.5,
        -- N.B. Use an original texture here, because the inventorycube only partly visible
--      wield_image = "unilib_misc_skeleton_human_skull_inv.png",
--      wield_scale = {x = 1.0, y = 1.0, z = 1.0},
        wield_image = "unilib_misc_skeleton_human_inv.png",
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:misc_skeleton_human_old",
        recipe = {
            {c_diamond, c_bone, c_diamond},
            {c_bone, "", c_bone},
            {c_diamond, c_bone, c_diamond},
        },
    })

end
