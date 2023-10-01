---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    thirsty
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_fountain_drinking = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.thirsty.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_fountain_drinking.init()

    return {
        description = "Drinking fountain",
        notes = "Right-click to increase your hydration. Can also be used with canteens. If" ..
                " hydration is not enabled, then this item is merely decorative",
        depends = "stone_ordinary",
    }

end

function unilib.pkg.misc_fountain_drinking.exec()

    unilib.register_node("unilib:misc_fountain_drinking", "thirsty:drinking_fountain", mode, {
        -- From thirsty:drinking_fountain
        description = S("Drinking fountain"),
        tiles = {
            "unilib_misc_fountain_drinking_top.png",
            "unilib_misc_fountain_drinking_bottom.png",
            "unilib_misc_fountain_drinking_side.png",
            "unilib_misc_fountain_drinking_side.png",
            "unilib_misc_fountain_drinking_side.png",
            "unilib_misc_fountain_drinking_side.png",
        },
        groups = {cracky = 2},
        -- (no sounds)

        collision_box = {
            type = "regular",
        },
        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-3/16, -8/16, -3/16, 3/16, 3/16, 3/16},
                {-8/16, 3/16, -8/16, 8/16, 6/16, 8/16},
                {-8/16, 6/16, -8/16, 8/16, 8/16, -6/16},
                {-8/16, 6/16, 6/16, 8/16, 8/16, 8/16},
                {-8/16, 6/16, -6/16, -6/16, 8/16, 6/16},
                {6/16, 6/16, -6/16, 8/16, 8/16, 6/16},
            },
        },
        paramtype = "light",
        selection_box = {
            type = "regular",
        },
    })
    unilib.hydration_enable_static_drinking("unilib:misc_fountain_drinking", 30)

end

function unilib.pkg.misc_fountain_drinking.post()

    unilib.register_craft({
        -- From thirsty:drinking_fountain
        output = "unilib:misc_fountain_drinking",
        recipe = {
            {"unilib:stone_ordinary", "group:potable_bucket", "unilib:stone_ordinary"},
            {"", "unilib:stone_ordinary", ""},
            {"", "unilib:stone_ordinary", ""},
        },
    })

end
