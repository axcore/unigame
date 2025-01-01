---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    glass_stained
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_sheet_steel_spiked = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glass_stained.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_sheet_steel_spiked.init()

    return {
        description = "Decorative spiked steel railing sheet",
        notes = "This item looks (almost) identical to the one in the \"pane_steel_spiked\"" ..
                " package",
        depends = {"pane_steel_spiked", "shared_glass_stained"},
    }

end

function unilib.pkg.decor_sheet_steel_spiked.exec()

    -- N.B. We don't call unilib.pkg.shared_glass_stained.register_sheet() for these items because
    --      of the different craft recipes, and because we don't need all six variants

    unilib.register_node(
        -- From glass_stained:pane_bar_top_pane_single
        "unilib:decor_sheet_steel_spiked_single",
        "glass_stained:pane_bar_top_pane_single",
        mode,
        {
            description = unilib.utils.brackets(S("Spiked Steel Railing Sheet"), S("Single")),
            tiles = {"blank.png", "blank.png", "unilib_pane_steel_spiked.png"},
            groups = {cracky = 3, oddly_breakable_by_hand = 3},
            sounds = unilib.global.sound_table.metal,

            drawtype = "nodebox",
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.03125, 0.5, 0.5, 0.03125},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.25, 0.5, 0.5, 0.25},
                },
            },
            sunlight_propagates = true,
            use_texture_alpha = "clip",
            wield_image = "unilib_pane_steel_spiked.png",
        }
    )
    unilib.register_craft({
        -- From glass_stained:pane_bar_top_pane_single
        output = "unilib:decor_sheet_steel_spiked_single",
        recipe = {
            {"unilib:pane_steel_spiked_flat"},
        },
    })
    unilib.register_craft({
        -- From glass_stained:pane_bar_top_pane_single
        output = "unilib:decor_sheet_steel_spiked_single",
        recipe = {
            {"unilib:decor_sheet_steel_spiked_offset"},
        },
    })

    unilib.register_node(
        -- From glass_stained:pane_bar_top_pane_offset
        "unilib:decor_sheet_steel_spiked_offset",
        "glass_stained:pane_bar_top_pane_offset",
        mode,
        {
            description = unilib.utils.brackets(S("Spiked Steel Railing Sheet"), S("Offset")),
            tiles = {"blank.png", "blank.png", "unilib_pane_steel_spiked.png"},
            groups = {cracky = 3, oddly_breakable_by_hand = 3},
            sounds = unilib.global.sound_table.metal,

            drawtype = "nodebox",
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, 0.96875, 0.5, 0.5, 1.03125},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, 0.75, 0.5, 0.5, 1.25},
                },
            },
            sunlight_propagates = true,
            use_texture_alpha = "clip",
            wield_image = "unilib_pane_steel_spiked.png",
        }
    )
    unilib.register_craft({
        -- From glass_stained:pane_bar_top_pane_offset
        output = "unilib:decor_sheet_steel_spiked_offset",
        recipe = {
            {"unilib:decor_sheet_steel_spiked_single"},
        },
    })

end
