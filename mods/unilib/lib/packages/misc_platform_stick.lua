---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_platform_stick = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_platform_stick.init()

    return {
        description = "Weaved stick platform",
        notes = "Mud rooves are typically made using the brush platform, with cob on top",
        depends = "item_stick_ordinary",
        optional = "roof_thatch",
    }

end

function unilib.pkg.misc_platform_stick.exec()

    local c_platform = "unilib:misc_platform_stick"
    local c_stick = "unilib:item_stick_ordinary"

    unilib.register_node(c_platform, "earthbuild:stick_platform", mode, {
        -- From earthbuild:stick_platform
        description = S("Weaved Stick Platform"),
        tiles = {
            "unilib_misc_platform_stick_top.png",
            "unilib_misc_platform_stick_top.png",
            "unilib_misc_platform_stick_side.png",
            "unilib_misc_platform_stick_side.png",
            "unilib_misc_platform_stick_side.png",
            "unilib_misc_platform_stick_side.png",
        },
        groups = {choppy = 2, flammable = 1, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, 0.375, -0.5, 0.5, 0.501, 0.5},
            },
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, 0.375, -0.5, 0.5, 0.501, 0.5},
            },
        },
        use_texture_alpha = "clip",
    })
    -- N.B. Original code uses group:stick; here we use a specific stick, so that the reverse
    --      craft recipe can be added
    -- N.B. Modified craft recipe conflicts with recipe in "pane_lattice_stick" package
    --[[
    unilib.register_craft({
        -- From earthbuild:stick_platform
        output = c_platform,
        recipe = {
            {c_stick, "", c_stick},
            {"", c_stick, ""},
            {c_stick, "", c_stick},
        },
    })
    ]]--
    unilib.register_craft({
        -- From earthbuild:stick_platform
        output = c_platform,
        recipe = {
            {"", c_stick, ""},
            {c_stick, "", c_stick},
            {"", c_stick, ""},
        },
    })
    unilib.register_craft({
        -- From earthbuild:stick_platform
        output = c_stick .. " 5",
        recipe = {
            {c_platform},
        },
    })
    unilib.register_craft({
        -- From earthbuild:stick_platform
        type = "fuel",
        recipe = c_platform,
        burntime = 1.5,
    })

    if unilib.global.pkg_executed_table["roof_thatch"] ~= nil then

        unilib.register_node(
            -- From earthbuild:stick_platform_with_brush
            "unilib:misc_platform_stick_with_brush",
            "earthbuild:stick_platform_with_brush",
            mode,
            {
                description = S("Weaved Stick Platform with Brush"),
                tiles = {
                    "unilib_roof_thatch.png",
                    "unilib_misc_platform_stick_with_brush.png",
                    "unilib_misc_platform_stick_with_brush_side.png",
                    "unilib_misc_platform_stick_with_brush_side.png",
                    "unilib_misc_platform_stick_with_brush_side.png",
                    "unilib_misc_platform_stick_with_brush_side.png",
                },
                groups = {choppy = 2, flammable = 1, oddly_breakable_by_hand = 2},
                sounds = unilib.global.sound_table.wood,

                drawtype = "nodebox",
                -- N.B. is_ground_content = false not in original code
                is_ground_content = false,
                node_box = {
                    type = "fixed",
                    fixed = {
                        {-0.5, 0.25, -0.5, 0.5, 0.5, 0.5},
                    },
                },
                paramtype = "light",
                selection_box = {
                    type = "fixed",
                    fixed = {
                        {-0.5, 0.25, -0.5, 0.5, 0.5, 0.5},
                    },
                },
                use_texture_alpha = "clip",
            }
        )
        unilib.register_craft({
            -- From earthbuild:stick_platform_with_brush
            output = "unilib:misc_platform_stick_with_brush 6",
            recipe = {
                {"", "unilib:roof_thatch", ""},
                {c_platform, c_platform, c_platform},
                {c_platform, c_platform, c_platform},
            },
        })
        unilib.register_craft({
            -- From earthbuild:stick_platform_with_brush
            output = c_platform,
            recipe = {
                {"unilib:misc_platform_stick_with_brush"},
            },
        })
        unilib.register_craft({
            -- From earthbuild:stick_platform_with_brush
            type = "fuel",
            recipe = "unilib:misc_platform_stick_with_brush",
            burntime = 3,
        })

    end

end
