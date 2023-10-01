---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_cavern_icicle = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.caverealms.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_cavern_icicle.init()

    return {
        description = "Cavern icicle",
    }

end

function unilib.pkg.misc_cavern_icicle.exec()

    unilib.register_node("unilib:misc_cavern_icicle", "caverealms:icicle_up", mode, {
        -- From caverealms:icicle_up
        description = S("Cavern Icicle"),
        tiles = {"unilib_misc_cavern_icicle.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.glass,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_misc_cavern_icicle.png",
        is_ground_content = true,
        light_source = 8,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
        },
        visual_scale = 1.0,
        walkable = false,
        wield_image = "unilib_misc_cavern_icicle.png",
    })

    unilib.register_node("unilib:misc_cavern_icicle_hanging", "caverealms:icicle_down", mode, {
        -- From caverealms:icicle_down
        description = S("Hanging Cavern Icicle"),
        tiles = {"unilib_misc_cavern_icicle_hanging.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.glass,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_misc_cavern_icicle_hanging.png",
        light_source = 8,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
        },
        visual_scale = 1.0,
        walkable = false,
        wield_image = "unilib_misc_cavern_icicle_hanging.png",
    })

end
