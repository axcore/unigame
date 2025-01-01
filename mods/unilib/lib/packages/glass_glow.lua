---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_glow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_glow.init()

    return {
        description = "Glow glass (with clean and trap variants)",
        depends = {"glass_ordinary", "mineral_mese", "torch_ordinary"},
        optional = "item_sweeper",
    }

end

function unilib.pkg.glass_glow.exec()

    unilib.register_node("unilib:glass_glow", "moreblocks:glow_glass", mode, {
        -- From moreblocks:glow_glass
        description = S("Glow Glass"),
        tiles = {
            "unilib_glass_ordinary.png^[colorize:#E9CD61",
            "unilib_glass_ordinary_detail.png^[colorize:#E9CD61",
        },
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.glass,

        drawtype = "glasslike_framed_optional",
        is_ground_content = false,
        light_source = 11,
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        -- From moreblocks:glow_glass
        type = "shapeless",
        output = "unilib:glass_glow",
        recipe = {"unilib:torch_ordinary", "unilib:glass_ordinary"},
    })
    unilib.register_stairs("unilib:glass_glow", {
        glass_flag = true,
    })
    unilib.register_carvings("unilib:glass_glow", {
        millwork_flag = true,
    })

    unilib.register_node("unilib:glass_glow_trap", "moreblocks:trap_glow_glass", mode, {
        -- From moreblocks:trap_glow_glass
        description = unilib.utils.brackets(S("Glow Glass"), S("Trap")),
        tiles = {
            "unilib_glass_ordinary.png^[colorize:#E9CD61^unilib_trap_glass_box_overlay.png",
            "unilib_glass_ordinary_detail.png^[colorize:#E9CD61",
        },
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.glass,

        drawtype = "glasslike_framed_optional",
        is_ground_content = false,
        light_source = 11,
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,
    })
    unilib.register_craft({
        -- From moreblocks:trap_glow_glass
        type = "shapeless",
        output = "unilib:glass_glow_trap",
        recipe = {
            "unilib:mineral_mese_crystal_fragment",
            "unilib:glass_ordinary",
            "unilib:torch_ordinary",
        },
    })
    unilib.register_craft({
        -- From moreblocks:trap_glow_glass
        type = "shapeless",
        output = "unilib:glass_glow_trap",
        recipe = {"unilib:mineral_mese_crystal_fragment", "unilib:glass_glow"},
    })

    if unilib.global.pkg_executed_table["item_sweeper"] ~= nil then

        unilib.register_node("unilib:glass_glow_clean", "moreblocks:clean_glow_glass", mode, {
            -- From moreblocks:clean_glow_glass
            description = S("Clean Glow Glass"),
            tiles = {
                "unilib_glass_clean.png^[colorize:#E9CD61",
                "unilib_glass_clean_detail.png^[colorize:#E9CD61",
            },
            groups = {cracky = 3, oddly_breakable_by_hand = 3},
            sounds = unilib.global.sound_table.glass,

            drawtype = "glasslike_framed_optional",
            light_source = 11,
            is_ground_content = false,
            paramtype = "light",
            sunlight_propagates = true,
            use_texture_alpha = "clip",
        })
        unilib.register_craft({
            -- From moreblocks:clean_glow_glass
            type = "shapeless",
            output = "unilib:glass_glow_clean",
            recipe = {"unilib:torch_ordinary", "unilib:glass_clean"},
        })
        unilib.register_craft({
            -- From moreblocks:clean_glow_glass
            type = "shapeless",
            output = "unilib:glass_glow_clean",
            recipe = {"unilib:item_sweeper", "unilib:glass_glow"},
        })
        unilib.register_stairs("unilib:glass_glow_clean", {
            glass_flag = true,
        })
        unilib.register_carvings("unilib:glass_glow_clean", {
            millwork_flag = true,
        })

        unilib.register_node(
            -- From moreblocks:trap_clean_glow_glass
            "unilib:glass_glow_clean_trap",
            "moreblocks:trap_clean_glow_glass",
            mode,
            {
                description = unilib.utils.brackets(S("Clean Glow Glass"), S("Trap")),
                tiles = {
                    "unilib_glass_clean.png^[colorize:#E9CD61^unilib_trap_glass_box_overlay.png",
                    "unilib_glass_clean_detail.png^[colorize:#E9CD61",
                },
                groups = {cracky = 3, oddly_breakable_by_hand = 3},
                sounds = unilib.global.sound_table.glass,

                drawtype = "glasslike_framed_optional",
                is_ground_content = false,
                light_source = 11,
                paramtype = "light",
                sunlight_propagates = true,
                use_texture_alpha = "clip",
                walkable = false,
            }
        )
        unilib.register_craft({
            -- From moreblocks:trap_clean_glow_glass
            type = "shapeless",
            output = "unilib:glass_glow_clean_trap",
            recipe = {"unilib:mineral_mese_crystal_fragment", "unilib:glass_glow_clean"},
        })
        unilib.register_craft({
            -- From moreblocks:trap_clean_glow_glass
            type = "shapeless",
            output = "unilib:glass_glow_clean_trap",
            recipe = {
                "unilib:mineral_mese_crystal_fragment",
                "unilib:glass_clean",
                "unilib:torch_ordinary",
            },
        })
        unilib.register_craft({
            -- From moreblocks:trap_clean_glow_glass
            type = "shapeless",
            output = "unilib:glass_glow_clean_trap",
            recipe = {"unilib:item_sweeper", "unilib:glass_glow_trap"},
        })

    end

end
