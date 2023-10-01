---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_glass_gold = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_glass_gold.init()

    return {
        description = "Gold glass pane",
        optional = {"glass_gold", "glass_ordinary", "metal_gold"},
    }

end

function unilib.pkg.pane_glass_gold.exec()

    local c_ingot = "unilib:metal_gold_ingot"

    if unilib.pkg_executed_table["glass_gold"] ~= nil then

        unilib.register_pane({
            -- From xpanes:goldglass_flat. Creates unilib:pane_glass_gold_flat,
            --      unilib:pane_glass_gold_crossed
            part_name = "glass_gold",
            orig_name = {"xpanes:goldglass", "xpanes:goldglass_flat"},
            def_table = {
                description = S("Gold Glass Pane"),
                textures = {
                    "unilib_glass_gold.png",
                    "unilib_pane_glass_gold_side",
                    "unilib_pane_glass_gold_top.png",
                },
                groups = {cracky = 3, oddly_breakable_by_hand = 2},
                sounds = unilib.sound_table.glass,

                inventory_image = "unilib_glass_gold.png",
                recipe = {
                    {"unilib:glass_gold", "unilib:glass_gold", "unilib:glass_gold"},
                    {"unilib:glass_gold", "unilib:glass_gold", "unilib:glass_gold"},
                },
                wield_image = "unilib_glass_gold.png",
            },

            replace_mode = mode,
        })

    end

    if unilib.pkg_executed_table["glass_ordinary"] ~= nil and
            unilib.pkg_executed_table["metal_gold"] ~= nil then

        unilib.register_pane({
            -- From xpanes:goldglass2_flat. Creates unilib:pane_glass_gold_framed_flat,
            --      unilib:pane_glass_gold_framed_crossed
            part_name = "glass_gold_framed",
            orig_name = {"xpanes:goldglass2", "xpanes:goldglass2_flat"},
            def_table = {
                description = S("Framed Gold Glass Pane"),
                textures = {
                    "unilib_glass_gold_framed.png",
                    "unilib_pane_glass_gold_side",
                    "unilib_pane_glass_gold_top.png",
                },
                groups = {cracky = 3, oddly_breakable_by_hand = 3},
                sounds = unilib.sound_table.glass,

                inventory_image = "unilib_glass_gold_framed.png",
                recipe = {
                    {c_ingot, c_ingot, c_ingot},
                    {c_ingot, "unilib:glass_ordinary", c_ingot},
                    {c_ingot, c_ingot, c_ingot},
                },
                wield_image = "unilib_glass_gold_framed.png",
            },

            replace_mode = mode,
        })

    end

end
