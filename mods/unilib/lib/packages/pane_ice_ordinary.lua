---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_ice_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_ice_ordinary.init()

    return {
        description = "Ordinary ice pane",
        depends = "ice_ordinary",
    }

end

function unilib.pkg.pane_ice_ordinary.exec()

    unilib.register_pane({
        -- From farlands, xpanes:ice_flat. Creates unilib:pane_ice_ordinary_flat,
        --      unilib:pane_ice_ordinary_crossed
        part_name = "ice_ordinary",
        orig_name = {"xpanes:ice", "xpanes:ice_flat"},
        def_table = {
            description = S("Ordinary Ice Pane"),
            textures = {
                "unilib_pane_ice_ordinary.png",
                "unilib_pane_ice_ordinary_half.png",
                "unilib_pane_ice_ordinary_half.png",
            },
            -- N.B. No slippery in original code
            groups = {cracky = 3, oddly_breakable_by_hand = 3, slippery = 3, snappy = 2},
            sounds = unilib.global.sound_table.glass,

            inventory_image = "unilib_pane_ice_ordinary.png",
            recipe = {
                {"unilib:ice_ordinary", "unilib:ice_ordinary", "unilib:ice_ordinary"},
                {"unilib:ice_ordinary", "unilib:ice_ordinary", "unilib:ice_ordinary"},
            },
            use_texture_alpha = "blend",
            wield_image = "unilib_pane_ice_ordinary.png",
        },

        replace_mode = mode,
    })

end
