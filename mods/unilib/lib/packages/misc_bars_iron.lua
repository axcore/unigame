---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_bars_iron = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_bars_iron.init()

    return {
        description = "Iron bars",
        depends = "item_stick_iron",
    }

end

function unilib.pkg.misc_bars_iron.exec()

    unilib.register_node("unilib:misc_bars_iron", "darkage:iron_bars", mode, {
        -- From darkage:iron_bars
        description = S("Iron Bars"),
        tiles = {"unilib_misc_bars_iron.png"},
        groups = {cracky = 3},
        -- (In original code, unilib.global.sound_table.stone)
        sounds = unilib.global.sound_table.metal,

        drawtype = "glasslike",
        inventory_image = "unilib_misc_bars_iron.png",
        is_ground_content = false,
        paramtype = "light",
        sunlight_propagates = true,
        wield_image = "unilib_misc_bars_iron.png",
    })
    unilib.register_craft({
        -- From darkage:iron_bars
        output = "unilib:misc_bars_iron 2",
        recipe = {
            {"unilib:item_stick_iron", "", "unilib:item_stick_iron"},
            {"unilib:item_stick_iron", "", "unilib:item_stick_iron"},
            {"unilib:item_stick_iron", "", "unilib:item_stick_iron"},
        },
    })

end
