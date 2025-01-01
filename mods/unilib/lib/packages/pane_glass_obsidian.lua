---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xpanes
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_glass_obsidian = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xpanes.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_glass_obsidian.init()

    return {
        description = "Obsidian glass pane",
        depends = "glass_obsidian",
    }

end

function unilib.pkg.pane_glass_obsidian.exec()

    unilib.register_pane({
        -- From xpanes:obsidian_pane_flat. Creates unilib:pane_glass_obsidian_flat,
        --      unilib:pane_glass_obsidian_crossed
        part_name = "glass_obsidian",
        orig_name = {"xpanes:obsidian_pane", "xpanes:obsidian_pane_flat"},
        def_table = {
            description = S("Obsidian Glass Pane"),
            textures = {"unilib_glass_obsidian.png", "", "unilib_pane_glass_obsidian_edge.png"},
            groups = {cracky = 3, snappy = 2},
            sounds = unilib.global.sound_table.glass,

            inventory_image = "unilib_glass_obsidian.png",
            recipe = {
                {"unilib:glass_obsidian", "unilib:glass_obsidian", "unilib:glass_obsidian"},
                {"unilib:glass_obsidian", "unilib:glass_obsidian", "unilib:glass_obsidian"},
            },
            wield_image = "unilib_glass_obsidian.png",
        },

        replace_mode = mode,
    })

end
