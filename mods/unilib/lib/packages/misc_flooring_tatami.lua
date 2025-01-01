---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_flooring_tatami = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_flooring_tatami.init()

    return {
        description = "Tatami mat",
        depends = "crop_wheat",
    }

end

function unilib.pkg.misc_flooring_tatami.exec()

    unilib.register_node("unilib:misc_flooring_tatami", "xdecor:tatami", mode, {
        -- From xdecor:tatami
        description = S("Tatami Mat"),
        tiles = {"unilib_misc_flooring_tatami.png"},
        groups = {flammable = 3, snappy = 3},
        sounds = unilib.global.sound_table.node,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        wield_image = "unilib_misc_flooring_tatami.png",
    })
    unilib.register_craft({
        -- From xdecor:tatami
        output = "unilib:misc_flooring_tatami",
        recipe = {
            {"unilib:crop_wheat_harvest", "unilib:crop_wheat_harvest", "unilib:crop_wheat_harvest"},
        },
    })

end
