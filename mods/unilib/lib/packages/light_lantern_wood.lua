---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lantern_wood = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lantern_wood.init()

    return {
        description = "Wooden lantern",
        depends = {"glass_ordinary", "torch_ordinary"},
    }

end

function unilib.pkg.light_lantern_wood.exec()

    unilib.register_node("unilib:light_lantern_wood_cross", "xdecor:wooden_lightbox", mode, {
        -- From xdecor:wooden_lightbox
        description = S("Cross-Framed Wooden Lantern"),
        tiles = {"unilib_light_lantern_wood_cross.png"},
        groups = {choppy = 3, cracky = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.glass,

        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        light_source = 13,
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From xdecor:wooden_lightbox
        output = "unilib:light_lantern_wood_cross",
        recipe = {
            {"group:stick", "unilib:torch_ordinary", "group:stick"},
            {"group:stick", "unilib:glass_ordinary", "group:stick"},
            {"group:stick", "unilib:torch_ordinary", "group:stick"},
        },
    })

    unilib.register_node("unilib:light_lantern_wood_square", "xdecor:wooden2_lightbox", mode, {
        -- From xdecor:wooden2_lightbox
        description = S("Square-Framed Wooden Lantern"),
        tiles = {"unilib_light_lantern_wood_square.png"},
        groups = {choppy = 3, cracky = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.glass,

        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        light_source = 13,
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From xdecor:wooden2_lightbox
        type = "shapeless",
        output = "unilib:light_lantern_wood_square",
        recipe = {"unilib:light_lantern_wood_cross"},
    })

end
