---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_glass_glow_round = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_glass_glow_round.init()

    return {
        description = "Round glow glass pane",
        depends = "glass_glow_round",
    }

end

function unilib.pkg.pane_glass_glow_round.exec()

    local img = "unilib_glass_glow_round.png"
    local c_glass = "unilib:glass_glow_round"

    unilib.register_pane({
        -- Original to unilib. Creates unilib:pane_glass_glow_round_flat,
        --      unilib:pane_glass_glow_round_crossed
        part_name = "glass_glow_round",
        orig_name = {},
        def_table = {
            description = S("Round Glow Glass Pane"),
            textures = {img, "", "unilib_pane_glass_obsidian_edge.png"},
            groups = {cracky = 3, oddly_breakable_by_hand = 3},
            sounds = unilib.sound_table.glass,

            inventory_image = img,
            light_source = unilib.light_max - 3,
            recipe = {
                {c_glass, c_glass, c_glass},
                {c_glass, c_glass, c_glass},
            },
            wield_image = img,
        },

        replace_mode = mode,
    })

end
