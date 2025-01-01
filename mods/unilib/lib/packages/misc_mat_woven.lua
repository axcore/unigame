---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_mat_woven = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_mat_woven.init()

    return {
        description = "Woven mat",
    }

end

function unilib.pkg.misc_mat_woven.exec()

    unilib.register_node("unilib:misc_mat_woven", "earthbuild:woven_mat", mode, {
        -- From earthbuild:woven_mat
        description = S("Woven Mat"),
        tiles = {"unilib_misc_mat_woven.png"},
        groups = {flammable = 3, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5,  0.5, -0.48, 0.5},
            },
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5,  0.5, -0.48, 0.5},
            },
        },
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        -- From earthbuild:woven_mat
        output = "unilib:misc_mat_woven",
        recipe = {
            {"", "", ""},
            {"", "", ""},
            {"group:leaves", "group:leaves", "group:leaves"},
        },
    })

    unilib.register_craft({
        -- From earthbuild:woven_mat
        output = "unilib:misc_mat_woven",
        recipe = {
            {"", "", ""},
            {"", "", ""},
            {"group:grass", "group:grass", "group:grass"},
        },
    })
    unilib.register_craft({
        -- From earthbuild:woven_mat
        output = "unilib:misc_mat_woven",
        recipe = {
            {"", "", ""},
            {"", "", ""},
            {"group:dry_grass", "group:dry_grass", "group:dry_grass"},
        },
    })
    unilib.register_craft({
        -- From earthbuild:woven_mat
        output = "unilib:misc_mat_woven",
        recipe = {
            {"", "", ""},
            {"", "", ""},
            {"group:junglegrass", "group:junglegrass", "group:junglegrass"},
        },
    })
    unilib.register_craft({
        -- From earthbuild:woven_mat
        type = "fuel",
        recipe = "unilib:misc_mat_woven",
        burntime = 1,
    })

end
