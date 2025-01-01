---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_glass_artisanal_clear = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_glass_artisanal_clear.init()

    return {
        description = "Clear glass pane",
        depends = "glass_artisanal_clear",
    }

end

function unilib.pkg.pane_glass_artisanal_clear.exec()

    local img = "unilib_glass_artisanal_clear.png"
    local c_glass = "unilib:glass_artisanal_clear"

    unilib.register_pane({
        -- Original to unilib. Creates unilib:pane_glass_artisanal_clear_flat,
        --      unilib:pane_glass_artisanal_clear_crossed
        part_name = "glass_artisanal_clear",
        orig_name = {},
        def_table = {
            description = S("Clear Artisanal Glass Pane"),
            textures = {img, "", "unilib_pane_glass_ordinary_edge.png^[colorize:#000000"},
            groups = {cracky = 3},
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
