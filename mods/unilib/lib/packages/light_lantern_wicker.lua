---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lantern_wicker = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lantern_wicker.init()

    return {
        description = "Wicker lantern",
        depends = "torch_ordinary",
    }

end

function unilib.pkg.light_lantern_wicker.exec()

    unilib.register_node("unilib:light_lantern_wicker", "darkage:lamp", mode, {
        -- From darkage:lamp
        description = S("Wooden Lantern"),
        tiles = {"unilib_light_lantern_wicker.png"},
        groups = {
            cracky = 3, flammable = 1, oddly_breakable_by_hand = 3, snappy = 2,
        },
        sounds = unilib.sound_table.glass,

        light_source = unilib.light_max - 1,
        paramtype = "light",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- From darkage:lamp
        output = "unilib:light_lantern_wicker",
        recipe = {
            {"group:stick",    "", "group:stick"},
            {"", "unilib:torch_ordinary", ""},
            {"group:stick",    "", "group:stick"},
        }
    })

end
