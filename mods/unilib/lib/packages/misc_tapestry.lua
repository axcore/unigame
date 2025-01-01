---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_tapestries
-- Code:    MIT
-- Media:   MIT/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_tapestry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.castle_tapestries.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function update_for_dyes(full_name)

    if unilib.setting.unifieddyes_update_flag then

        -- Make compatible with unifieddyes mod
        unilib.override_item(full_name, {
            palette = "unifieddyes_palette_colorwallmounted.png",
            paramtype2 = "colorwallmounted",

            after_dig_node = unifieddyes.after_dig_node,
            after_place_node = unifieddyes.fix_rotation_nsew,
            on_rotate = unifieddyes.fix_after_screwdriver_nsew,
        })

    elseif unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        -- Make compatible with the "dye_basic" package
        unilib.override_item(full_name, {
            palette = "unilib_palette_dye_basic.png",
            paramtype2 = "colorwallmounted",

            after_place_node = unilib.dyes.item_after_place_node,

            on_punch = unilib.dyes.item_on_punch,

            on_rotate = unilib.dyes.item_on_rotate,
        })

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_tapestry.init()

    return {
        description = "Tapestries",
        notes = "Can be coloured using dyes, or with an airbrush (if the unifieddyes mod is" ..
                " available)",
        mod_optional = "unifieddyes",
        depends = {"item_stick_ordinary", "wool_basic"},
        optional = "dye_basic",
    }

end

function unilib.pkg.misc_tapestry.exec()

    local c_stick = "unilib:item_stick_ordinary"

    local hint = S("can be coloured with dyes")
    if unilib.setting.unifieddyes_update_flag then
        hint = S("can be coloured using a dye airbrush")
    end

    unilib.register_node("unilib:misc_tapestry_short", "castle_tapestries:tapestry", mode, {
        -- From castle_tapestries:tapestry
        description = unilib.utils.hint(S("Short Tapestry"), hint),
        tiles = {"unilib_misc_tapestry.png"},
        groups = {flammable = 3, oddly_breakable_by_hand = 3, ud_param2_colorable = 1},
        sounds = unilib.global.sound_table.node,

        drawtype = "mesh",
        inventory_image = "unilib_misc_tapestry_short_inv.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        mesh = "unilib_misc_tapestry_short.obj",
--      palette = "unifieddyes_palette_colorwallmounted.png",
        paramtype = "light",
--      paramtype2 = "colorwallmounted",
        selection_box = {
            type = "wallmounted",
            wall_side = {-0.5, -0.5, 0.4375, 0.5, 1.5, 0.5},
        },

--      after_dig_node = unifieddyes.after_dig_node,
--      after_place_node = unifieddyes.fix_rotation_nsew,
--      on_rotate = unifieddyes.fix_after_screwdriver_nsew,
    })
    unilib.register_craft({
        -- From castle_tapestries:tapestry
        type = "shapeless",
        output = "unilib:misc_tapestry_short",
        recipe = {"unilib:wool_white", c_stick},
    })
    update_for_dyes("unilib:misc_tapestry_short")

    unilib.register_node("unilib:misc_tapestry_medium", "castle_tapestries:tapestry_long", mode, {
        -- From castle_tapestries:tapestry_long
        description = unilib.utils.hint(S("Medium Tapestry"), hint),
        tiles = {"unilib_misc_tapestry.png"},
        groups = {flammable = 3, oddly_breakable_by_hand = 3, ud_param2_colorable = 1},
        sounds = unilib.global.sound_table.node,

        drawtype = "mesh",
        inventory_image = "unilib_misc_tapestry_medium_inv.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        mesh = "unilib_misc_tapestry_medium.obj",
--      palette = "unifieddyes_palette_colorwallmounted.png",
        paramtype = "light",
--      paramtype2 = "colorwallmounted",
        selection_box = {
            type = "wallmounted",
            wall_side = {-0.5, -0.5, 0.4375, 0.5, 2.5, 0.5},
        },

--      after_dig_node = unifieddyes.after_dig_node,
--      after_place_node = unifieddyes.fix_rotation_nsew,
--      on_rotate = unifieddyes.fix_after_screwdriver_nsew,
    })
    unilib.register_craft({
        -- From castle_tapestries:tapestry_long
        type = "shapeless",
        output = "unilib:misc_tapestry_medium",
        recipe = {"unilib:wool_white", "unilib:misc_tapestry_short"},
    })
    update_for_dyes("unilib:misc_tapestry_medium")

    unilib.register_node(
        -- From castle_tapestries:tapestry_very_long
        "unilib:misc_tapestry_long",
        "castle_tapestries:tapestry_very_long",
        mode,
        {
            description = unilib.utils.hint(S("Long Tapestry"), hint),
            tiles = {"unilib_misc_tapestry.png"},
            groups = {flammable = 3, oddly_breakable_by_hand = 3, ud_param2_colorable = 1},
            sounds = unilib.global.sound_table.node,

            drawtype = "mesh",
            inventory_image = "unilib_misc_tapestry_long_inv.png",
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            mesh = "unilib_misc_tapestry_long.obj",
--          palette = "unifieddyes_palette_colorwallmounted.png",
            paramtype = "light",
--          paramtype2 = "colorwallmounted",
            selection_box = {
                type = "wallmounted",
                wall_side = {-0.5, -0.5, 0.4375, 0.5, 3.5, 0.5},
            },

--          after_dig_node = unifieddyes.after_dig_node,
--          after_place_node = unifieddyes.fix_rotation_nsew,
--          on_rotate = unifieddyes.fix_after_screwdriver_nsew,
        }
    )
    unilib.register_craft({
        -- From castle_tapestries:tapestry_very_long
        type = "shapeless",
        output = "unilib:misc_tapestry_long",
        recipe = {"unilib:wool_white", "unilib:misc_tapestry_medium"},
    })
    update_for_dyes("unilib:misc_tapestry_long")

    unilib.register_node(
        -- From castle_tapestries:tapestry_top
        "unilib:misc_tapestry_hanger",
        "castle_tapestries:tapestry_top",
        mode,
        {
            description = S("Tapestry Hanger"),
            tiles = {"unilib_tree_apple_wood.png"},
            groups = {flammable = 3, oddly_breakable_by_hand = 3},
            sounds = unilib.global.sound_table.node,

            drawtype = "nodebox",
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
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
    -- N.B. Original craft recipe conflicts with recipe in "misc_sawdust" package
    --[[
    unilib.register_craft({
        -- From castle_tapestries:tapestry_top
        type = "shapeless",
        output = "unilib:misc_tapestry_hanger",
        recipe = {"unilib:item_stick_ordinary"},
    })
    ]]--
    unilib.register_craft({
        -- From castle_tapestries:tapestry_top
        output = "unilib:misc_tapestry_hanger 2",
        recipe = {
            {c_stick, c_stick, c_stick},
        },
    })

end
