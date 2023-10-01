---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_glowworms = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.caverealms.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_glowworms.init()

    return {
        description = "Glowworms",
        notes = "Static glowing tendrils that hang from a ceiling",
    }

end

function unilib.pkg.misc_glowworms.exec()

    unilib.register_node("unilib:misc_glowworms_blue", "caverealms:glow_worm", mode, {
        -- From caverealms:glow_worm
        description = S("Blue Glowworms"),
        tiles = {"unilib_misc_glowworms_blue.png"},
        groups = {oddly_breakable_by_hand = 3},
        -- (no sounds)

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_misc_glowworms_blue.png",
        light_source = 9,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.5, 0.5},
        },
        visual_scale = 1.0,
        walkable = false,
        wield_image = "unilib_misc_glowworms_blue.png",
    })

    unilib.register_node("unilib:misc_glowworms_green", "caverealms:glow_worm_green", mode, {
        -- From caverealms_lite, caverealms:glow_worm_green
        description = S("Green Glowworms"),
        tiles = {"unilib_misc_glowworms_green.png"},
        groups = {oddly_breakable_by_hand = 3},
        -- (no sounds)

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_misc_glowworms_green.png",
        light_source = 9,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.5, 0.5},
        },
        visual_scale = 1.0,
        walkable = false,
        wield_image = "unilib_misc_glowworms_green.png",
    })

end
