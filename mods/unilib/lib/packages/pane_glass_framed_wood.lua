---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_glass_framed_wood = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_glass_framed_wood.init()

    return {
        description = "Glass pane with wooden frame",
        depends = "glass_framed_wood",
    }

end

function unilib.pkg.pane_glass_framed_wood.exec()

    local c_glass = "unilib:glass_framed_wood"

    unilib.register_pane({
        -- From farlands, xpanes:framed_pane_flat. Creates unilib:pane_glass_framed_wood_flat,
        --      unilib:pane_glass_framed_wood_crossed
        part_name = "glass_framed_wood",
        orig_name = {"xpanes:framed_pane", "xpanes:framed_pane_flat"},
        def_table = {
            description = S("Glass Pane with Wooden Frame"),
            textures = {
                "unilib_glass_framed_wood.png",
                "unilib_pane_glass_framed_wood_half.png",
                "unilib_pane_glass_framed_wood_half_top.png",
            },
            groups = {cracky = 3, oddly_breakable_by_hand = 3, snappy = 2},
            sounds = unilib.global.sound_table.glass,

            inventory_image = "unilib_glass_framed_wood.png",
            recipe = {
                {c_glass, c_glass, c_glass},
                {c_glass, c_glass, c_glass},
            },
            wield_image = "unilib_glass_framed_wood.png",
        },
    })

end
