---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_framed_wood = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_framed_wood.init()

    return {
        description = "Glass with wooden frame",
        depends = {"glass_ordinary", "item_stick_ordinary"},
    }

end

function unilib.pkg.glass_framed_wood.exec()

    unilib.register_node("unilib:glass_framed_wood", "decoblocks:framed_glass", mode, {
        -- From farlands, decoblocks:framed_glass
        description = S("Glass with Wooden Frame"),
        tiles = {"unilib_glass_framed_wood.png", "unilib_glass_framed_wood_detail.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.glass,

        drawtype = "glasslike_framed_optional",
        is_ground_content = false,
        paramtype = "light",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- From farlands, decoblocks:framed_glass
        output = "unilib:glass_framed_wood",
        recipe = {
            {"", "unilib:item_stick_ordinary", ""},
            {"unilib:item_stick_ordinary", "unilib:glass_ordinary", "unilib:item_stick_ordinary"},
            {"", "unilib:item_stick_ordinary", ""},
        },
    })

    unilib.register_node("unilib:glass_framed_wood_broken", "decoblocks:broken_glass", mode, {
        -- From farlands, decoblocks:broken_glass
        description = S("Broken Glass with Wooden Frame"),
        tiles = {
            "unilib_glass_framed_wood_broken.png",
            "unilib_glass_framed_wood_broken_detail.png",
        },
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.glass,

        drawtype = "glasslike_framed_optional",
        is_ground_content = false,
        paramtype = "light",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- From farlands, decoblocks:broken_glass
        type = "shapeless",
        output = "unilib:glass_framed_wood_broken",
        recipe = {
            "unilib:glass_framed_wood",
            "unilib:glass_ordinary_fragments",
            "unilib:item_stick_ordinary",
        },
    })

end
