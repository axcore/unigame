---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_window_ice = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_window_ice.init()

    return {
        description = "Ice window pane",
        depends = "window_ice",
    }

end

function unilib.pkg.pane_window_ice.exec()

    local img = "unilib_window_ice.png"

    unilib.register_pane({
        -- From mtg_plus mod, xpanes:ice_flat. Creates unilib:pane_window_ice_flat,
        --      unilib:pane_window_ice_crossed
        part_name = "window_ice",
        orig_name = {"xpanes:ice", "xpanes:ice_flat"},
        def_table = {
            description = S("Ice Window Pane"),
            textures = {img, img, img},
            groups = {cracky = 3, slippery = 3},
            sounds = unilib.global.sound_table.glass,

            inventory_image = img,
            recipe = {
                {"unilib:window_ice", "unilib:window_ice", "unilib:window_ice"},
                {"unilib:window_ice", "unilib:window_ice", "unilib:window_ice"},
            },
            wield_image = img,
        },

        replace_mode = mode,
    })

end
