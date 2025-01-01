---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    glass_stained
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_steel_spiked = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glass_stained.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_steel_spiked.init()

    return {
        description = "Spiked steel railing (as a pane)",
        notes = "This item looks (almost) identical to the one in the" ..
                " \"decor_sheet_steel_spiked\" package",
        depends = "metal_steel",
    }

end

function unilib.pkg.pane_steel_spiked.exec()

    local c_ingot = "unilib:metal_steel_ingot"
    local img = "unilib_pane_steel_spiked.png"

    unilib.register_pane({
        -- From glass_stained, xpanes:bar_top_flat. Creates unilib:pane_steel_spiked_flat,
        --      unilib:pane_steel_spiked_crossed
        part_name = "steel_spiked",
        orig_name = {"xpanes:bar_top", "xpanes:bar_top_flat"},
        def_table = {
            description = S("Spiked Steel Railing"),
            -- N.B. The second texture in the original code does not exist, so removed it
            textures = {
                img,
                "",
                "unilib_pane_steel_spiked_edge.png",
            },
            groups = {cracky = 2},
            sounds = unilib.global.sound_table.metal,

            inventory_image = img,
            recipe = {
                {"", c_ingot, ""},
                {c_ingot, c_ingot, c_ingot},
                {c_ingot, c_ingot, c_ingot},
            },
            wield_image = img,
        },

        replace_mode = mode,
    })

end
