---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_framed_wood_connecting = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_framed_wood_connecting.init()

    return {
        description = "Glass with connecting wooden frame",
        notes = "Unlike the item in the \"glass_framed_wood\" package, several of these items" ..
                " can be placed together to create a larger frame",
        depends = "glass_ordinary",
    }

end

function unilib.pkg.glass_framed_wood_connecting.exec()

    unilib.register_node("unilib:glass_framed_wood_connecting", "xdecor:woodframed_glass", mode, {
        -- From xdecor:woodframed_glass
        description = S("Glass with Connecting Wooden Frame"),
        tiles = {
            "unilib_glass_framed_wood_connecting.png",
            "unilib_glass_framed_wood_connecting_detail.png",
        },
        groups = {cracky = 2, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.glass,

        drawtype = "glasslike_framed",
        -- N.B. is_ground_content = false not in original code; added to match other glass items
        is_ground_content = false,
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        -- From xdecor:woodframed_glass
        output = "unilib:glass_framed_wood_connecting",
        recipe = {
            {"group:stick", "group:stick", "group:stick"},
            {"group:stick", "unilib:glass_ordinary", "group:stick"},
            {"group:stick", "group:stick", "group:stick"},
        },
    })

end
