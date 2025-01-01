---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lantern_iron = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lantern_iron.init()

    return {
        description = "Iron lantern",
        depends = {"glass_ordinary", "pane_steel_bar", "torch_ordinary"},
    }

end

function unilib.pkg.light_lantern_iron.exec()

    unilib.register_node("unilib:light_lantern_iron", "xdecor:iron_lightbox", mode, {
        -- From xdecor:iron_lightbox
        description = S("Iron Lantern"),
        tiles = {"unilib_light_lantern_iron.png"},
        groups = {choppy = 3, cracky = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.glass,

        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        light_source = 13,
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From xdecor:iron_lightbox
        output = "unilib:light_lantern_iron",
        recipe = {
            {"unilib:pane_steel_bar_flat", "unilib:torch_ordinary", "unilib:pane_steel_bar_flat"},
            {"unilib:pane_steel_bar_flat", "unilib:glass_ordinary", "unilib:pane_steel_bar_flat"},
            {"unilib:pane_steel_bar_flat", "unilib:torch_ordinary", "unilib:pane_steel_bar_flat"},
        },
    })

end
