---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_sawdust = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_sawdust.init()

    return {
        description = "Sawdust",
        mod_optional = "technic",
        depends = "item_stick_ordinary",
    }

end

function unilib.pkg.misc_sawdust.exec()

    unilib.register_node("unilib:misc_sawdust", "bbq:sawdust", mode, {
        -- From bbq:sawdust
        description = S("Sawdust"),
        tiles = {"unilib_misc_sawdust.png"},
        groups = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        inventory_image = "unilib_misc_sawdust.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        wield_image = "unilib_misc_sawdust.png",
    })
    if not core.get_modpath("technic") then

        unilib.register_craft({
            -- From bbq:sawdust
            type = "shapeless",
            output = "unilib:misc_sawdust",
            recipe = {"unilib:item_stick_ordinary"},
        })

    else

        -- Original to unilib
        technic.register_grinder_recipe({
            output = "unilib:misc_sawdust",
            input = {"unilib:item_stick_ordinary"},
        })

    end

end
