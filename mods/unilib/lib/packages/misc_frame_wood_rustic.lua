---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_frame_wood_rustic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_frame_wood_rustic.init()

    return {
        description = "Rustic wooden frame",
        depends = "glass_ordinary",
    }

end

function unilib.pkg.misc_frame_wood_rustic.exec()

    unilib.register_node("unilib:misc_frame_wood_rustic", "darkage:wood_frame", mode, {
        -- From darkage:wood_frame
        description = S("Rustic Wooden Frame"),
        tiles = {"unilib_misc_frame_wood_rustic.png"},
        groups = {choppy = 2, oddly_breakable_by_hand = 3, snappy = 1},
        -- (In original code, unilib.sound_table.stone)
        sounds = unilib.sound_table.wood,

        drawtype = "glasslike_framed",
        inventory_image = "unilib_misc_frame_wood_rustic.png",
        is_ground_content = false,
        paramtype = "light",
        sunlight_propagates = true,
        wield_image = "unilib_misc_frame_wood_rustic.png",
    })
    unilib.register_craft({
        -- From darkage:wood_frame
        output = "unilib:misc_frame_wood_rustic",
        recipe = {
            {"group:stick",    "", "group:stick"},
            {"", "unilib:glass_ordinary", ""},
            {"group:stick",    "", "group:stick"},
        }
    })
    unilib.register_craft({
        -- From darkage:wood_frame
        type = "cooking",
        output = "unilib:glass_ordinary",
        recipe = "unilib:misc_frame_wood_rustic",
    })

end
