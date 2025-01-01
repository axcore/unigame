---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_glass_clean_round = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_glass_clean_round.init()

    return {
        description = "Clean round glass pane",
        depends = "glass_clean_round",
    }

end

function unilib.pkg.pane_glass_clean_round.exec()

    local img = "unilib_glass_clean_round.png"
    local c_glass = "unilib:glass_clean_round"

    unilib.register_pane({
        -- Original to unilib. Creates unilib:pane_glass_clean_round_flat,
        --      unilib:pane_glass_clean_round_crossed
        part_name = "glass_clean_round",
        orig_name = {},
        def_table = {
            description = S("Clean Round Glass Pane"),
            textures = {img, "", "unilib_pane_glass_ordinary_edge.png^[colorize:#000000"},
            groups = {cracky = 3, oddly_breakable_by_hand = 3},
            sounds = unilib.global.sound_table.glass,

            inventory_image = img,
            recipe = {
                {c_glass, c_glass, c_glass},
                {c_glass, c_glass, c_glass},
            },
            wield_image = img,
        },

        replace_mode = mode,
    })

end
