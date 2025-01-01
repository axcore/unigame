---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wattle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wattle.init()

    return {
        description = "Wattle door",
        depends = "material_wattle",
    }

end

function unilib.pkg.door_wattle.exec()

    unilib.register_door({
        -- From doors:door_wattle. Creates unilib:door_wattle_closed_left, etc
        part_name = "wattle",
        orig_name_list = {
            "doors:door_wattle_a",
            "doors:door_wattle_b",
            "doors:door_wattle_c",
            "doors:door_wattle_d",
        },
        def_table = {
            description = S("Wattle Door"),
            tiles = {{name = "unilib_door_wattle.png", backface_culling = true}},
            groups = {choppy = 2, flammable = 1, oddly_breakable_by_hand = 2},
            -- (no sounds)

            inventory_image = "unilib_door_wattle_inv.png",
            recipe = {
                {"unilib:material_wattle", "unilib:material_wattle"},
                {"unilib:material_wattle", "unilib:material_wattle"},
                {"unilib:material_wattle", "unilib:material_wattle"},
            },
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:door_wattle",
    })
    unilib.register_craft({
        -- From doors:door_wattle
        type = "fuel",
        recipe = "unilib:door_wattle",
        burntime = 3,
    })

end
