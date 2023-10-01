---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_tapestries
-- Code:    MIT
-- Media:   MIT/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_tapestry = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.castle_tapestries.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_tapestry.init()

    return {
        description = "Tapestries",
        notes = "Requires the unifieddyes mod so that it can be dyed with an airbrush",
        mod_optional = "unifieddyes",
        depends = {"item_stick_ordinary", "wool_basic"},
    }

end

function unilib.pkg.misc_tapestry.exec()

    if unilib.unifieddyes_update_flag then

        unilib.register_node("unilib:misc_tapestry_short", "castle_tapestries:tapestry", mode, {
            -- From castle_tapestries:tapestry
            description = unilib.hint(
                S("Short Tapestry"), S("can be used with a dye airbrush")
            ),
            tiles = {"unilib_misc_tapestry.png"},
            groups = {flammable = 3, oddly_breakable_by_hand = 3, ud_param2_colorable = 1},
            sounds = unilib.sound_table.node,

            drawtype = "mesh",
            inventory_image = "unilib_misc_tapestry_short_inv.png",
            mesh = "unilib_misc_tapestry_short.obj",
            palette = "unifieddyes_palette_colorwallmounted.png",
            paramtype = "light",
            paramtype2 = "colorwallmounted",
            selection_box = {
                type = "wallmounted",
                wall_side = {-0.5, -0.5, 0.4375, 0.5, 1.5, 0.5},
            },

            after_dig_node = unifieddyes.after_dig_node,
            after_place_node = unifieddyes.fix_rotation_nsew,
            on_rotate = unifieddyes.fix_after_screwdriver_nsew,
        })
        unilib.register_craft({
            -- From castle_tapestries:tapestry
            type = "shapeless",
            output = "unilib:misc_tapestry_short",
            recipe = {"unilib:wool_white", "unilib:item_stick_ordinary"},
        })

        unilib.register_node(
            -- From castle_tapestries:tapestry_long
            "unilib:misc_tapestry_medium",
            "castle_tapestries:tapestry_long",
            mode,
            {
                description = unilib.hint(
                    S("Medium Tapestry"), S("can be used with a dye airbrush")
                ),
                tiles = {"unilib_misc_tapestry.png"},
                groups = {flammable = 3, oddly_breakable_by_hand = 3, ud_param2_colorable = 1},
                sounds = unilib.sound_table.node,

                drawtype = "mesh",
                inventory_image = "unilib_misc_tapestry_medium_inv.png",
                mesh = "unilib_misc_tapestry_medium.obj",
                palette = "unifieddyes_palette_colorwallmounted.png",
                paramtype = "light",
                paramtype2 = "colorwallmounted",
                selection_box = {
                    type = "wallmounted",
                    wall_side = {-0.5, -0.5, 0.4375, 0.5, 2.5, 0.5},
                },

                after_dig_node = unifieddyes.after_dig_node,
                after_place_node = unifieddyes.fix_rotation_nsew,
                on_rotate = unifieddyes.fix_after_screwdriver_nsew
            }
        )
        unilib.register_craft({
            -- From castle_tapestries:tapestry_long
            type = "shapeless",
            output = "unilib:misc_tapestry_medium",
            recipe = {"unilib:wool_white", "unilib:misc_tapestry_short"},
        })

        unilib.register_node(
            -- From castle_tapestries:tapestry_very_long
            "unilib:misc_tapestry_long",
            "castle_tapestries:tapestry_very_long",
            mode,
            {
                description = unilib.hint(
                    S("Long Tapestry"), S("can be used with a dye airbrush")
                ),
                tiles = {"unilib_misc_tapestry.png"},
                groups = {flammable = 3, oddly_breakable_by_hand = 3, ud_param2_colorable = 1},
                sounds = unilib.sound_table.node,

                drawtype = "mesh",
                inventory_image = "unilib_misc_tapestry_long_inv.png",
                mesh = "unilib_misc_tapestry_long.obj",
                palette = "unifieddyes_palette_colorwallmounted.png",
                paramtype = "light",
                paramtype2 = "colorwallmounted",
                selection_box = {
                    type = "wallmounted",
                    wall_side = {-0.5, -0.5, 0.4375, 0.5, 3.5, 0.5},
                },

                after_dig_node = unifieddyes.after_dig_node,
                after_place_node = unifieddyes.fix_rotation_nsew,
                on_rotate = unifieddyes.fix_after_screwdriver_nsew
            }
        )
        unilib.register_craft({
            -- From castle_tapestries:tapestry_very_long
            type = "shapeless",
            output = "unilib:misc_tapestry_long",
            recipe = {"unilib:wool_white", "unilib:misc_tapestry_medium"},
        })

        unilib.register_node(
            -- From castle_tapestries:tapestry_top
            "unilib:misc_tapestry_hanger",
            "castle_tapestries:tapestry_top",
            mode,
            {
                description = S("Tapestry Hanger"),
                tiles = {"unilib_tree_apple_wood.png"},
                groups = {flammable = 3, oddly_breakable_by_hand = 3},
                sounds = unilib.sound_table.node,

                drawtype = "nodebox",
                node_box = {
                    type = "fixed",
                    fixed = {
                        {-0.6,-0.5,0.375,0.6,-0.375,0.5},
                    },
                },
                selection_box = {
                    type = "fixed",
                    fixed = {
                        {-0.6,-0.5,0.375,0.6,-0.375,0.5},
                    },
                },
                paramtype = "light",
                paramtype2 = "facedir",
                sunlight_propagates = true,
            }
        )
        unilib.register_craft({
            -- From castle_tapestries:tapestry_top
            type = "shapeless",
            output = "unilib:misc_tapestry_hanger",
            recipe = {"unilib:item_stick_ordinary"},
        })

    end

end
