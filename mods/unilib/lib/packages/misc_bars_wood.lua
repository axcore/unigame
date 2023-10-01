---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_bars_wood = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_bars_wood.init()

    return {
        description = "Wooden bars",
    }

end

function unilib.pkg.misc_bars_wood.exec()

    unilib.register_node("unilib:misc_bars_wood", "darkage:wood_bars", mode, {
        -- From darkage:wood_bars
        description = S("Wooden Bars"),
        tiles = {"unilib_misc_bars_wood.png"},
        groups = {choppy = 2, snappy = 1},
        -- (In original code, unilib.sound_table.stone)
        sounds = unilib.sound_table.wood,

        drawtype = "glasslike",
        inventory_image = "unilib_misc_bars_wood.png",
        is_ground_content = false,
        paramtype = "light",
        sunlight_propagates = true,
        wield_image = "unilib_misc_bars_wood.png",
    })
    unilib.register_craft({
        -- From darkage:wood_bars
        output = "unilib:misc_bars_wood 2",
        recipe = {
            {"group:stick", "", "group:stick"},
            {"group:stick", "", "group:stick"},
            {"group:stick", "", "group:stick"},
        }
    })

end
