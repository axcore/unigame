---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    doors
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.trapdoor_wood_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.doors.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.trapdoor_wood_ordinary.init()

    return {
        description = "Ordinary wooden trapdoor",
    }

end

function unilib.pkg.trapdoor_wood_ordinary.exec()

    unilib.register_trapdoor({
        -- From doors:trapdoor. Creates unilib:trapdoor_wood_ordinary
        part_name = "wood_ordinary",
        orig_name = {"doors:trapdoor", "doors:trapdoor_open"},
        def_table = {
            description = S("Ordinary Wooden Trapdoor"),
            -- (no tiles)
            groups = {choppy = 2, door = 1, flammable = 2, oddly_breakable_by_hand = 2},
            -- (no sounds)

            gain_close = 0.13,
            gain_open = 0.06,
            inventory_image = "unilib_trapdoor_wood_ordinary.png",
            tile_front = "unilib_trapdoor_wood_ordinary.png",
            tile_side = "unilib_trapdoor_wood_ordinary_side.png",
            wield_image = "unilib_trapdoor_wood_ordinary.png",
        },

        replace_mode = mode,
    })
    unilib.register_craft({
        -- From doors:trapdoor
        output = "unilib:trapdoor_wood_ordinary 2",
        recipe = {
            {"group:wood", "group:wood", "group:wood"},
            {"group:wood", "group:wood", "group:wood"},
            {"", "", ""},
        }
    })
    unilib.register_craft({
        -- From doors:trapdoor
        type = "fuel",
        recipe = "unilib:trapdoor_wood_ordinary",
        burntime = 7,
    })

end
