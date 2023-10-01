---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.trapdoor_wattle = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.trapdoor_wattle.init()

    return {
        description = "Wattle trapdoor",
        depends = "material_wattle",
    }

end

function unilib.pkg.trapdoor_wattle.exec()

    unilib.register_trapdoor({
        -- From earthbuild:trapdoor_wattle. Creates unilib:trapdoor_wattle
        part_name = "wattle",
        orig_name = {"earthbuild:trapdoor_wattle", "earthbuild:trapdoor_wattle_open"},
        def_table = {
            description = S("Wattle Trapdoor"),
            -- (no tiles)
            groups = {choppy = 2, door = 1, flammable = 1, oddly_breakable_by_hand = 2},
            -- (no sounds)

            inventory_image = "unilib_trapdoor_wattle.png",
            tile_front = "unilib_trapdoor_wattle.png",
            tile_side = "unilib_trapdoor_wattle_side.png",
            wield_image = "unilib_trapdoor_wattle.png",
        },

        replace_mode = mode,
    })
    unilib.register_craft({
        -- From earthbuild:trapdoor_wattle
        output = "unilib:trapdoor_wattle 2",
        recipe = {
            {"unilib:material_wattle", "unilib:material_wattle", ""},
            {"unilib:material_wattle", "unilib:material_wattle", ""},
            {"", "", ""},
        }
    })
    unilib.register_craft({
        -- From earthbuild:trapdoor_wattle
        type = "fuel",
        recipe = "unilib:trapdoor_wattle",
        burntime = 3,
    })

end
