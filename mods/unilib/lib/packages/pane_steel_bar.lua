---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xpanes
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_steel_bar = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xpanes.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_steel_bar.init()

    return {
        description = "Steel bars as a pane",
        depends = "metal_steel",
    }

end

function unilib.pkg.pane_steel_bar.exec()

    unilib.register_pane({
        -- From xpanes:bar_flat. Creates unilib:pane_steel_bar_flat,
        --      unilib:pane_steel_bar_crossed
        part_name = "steel_bar",
        orig_name = {"xpanes:bar", "xpanes:bar_flat"},
        def_table = {
            description = S("Steel Bars"),
            textures = {"unilib_pane_steel_bar.png", "", "unilib_pane_steel_bar_top.png"},
            groups = {cracky = 2},
            sounds = unilib.global.sound_table.metal,

            inventory_image = "unilib_pane_steel_bar.png",
            recipe = {
                {
                    "unilib:metal_steel_ingot",
                    "unilib:metal_steel_ingot",
                    "unilib:metal_steel_ingot",
                },
                {
                    "unilib:metal_steel_ingot",
                    "unilib:metal_steel_ingot",
                    "unilib:metal_steel_ingot",
                },
            },
            wield_image = "unilib_pane_steel_bar.png",
        },

        replace_mode = mode,
    })

end
