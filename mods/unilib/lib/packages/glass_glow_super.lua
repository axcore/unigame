---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_glow_super = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_glow_super.init()

    return {
        description = "Super glow glass (with clean and trap variants)",
        depends = {"glass_ordinary", "mineral_mese", "torch_ordinary"},
        optional = {"glass_clean", "glass_glow", "item_sweeper"},
    }

end

function unilib.pkg.glass_glow_super.exec()

    unilib.register_node("unilib:glass_glow_super", "moreblocks:super_glow_glass", mode, {
        -- From moreblocks:super_glow_glass
        description = S("Super Glow Glass"),
        tiles = {
            "unilib_glass_ordinary.png^[colorize:#FFFF78",
            "unilib_glass_ordinary_detail.png^[colorize:#FFFF78",
        },
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.glass,

        drawtype = "glasslike_framed_optional",
        is_ground_content = false,
        light_source = unilib.light_max,
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        -- From moreblocks:super_glow_glass
        type = "shapeless",
        output = "unilib:glass_glow_super",
        recipe = {"unilib:torch_ordinary", "unilib:torch_ordinary", "unilib:glass_ordinary"},
    })
    if unilib.pkg_executed_table["glass_glow"] ~= nil then

        unilib.register_craft({
            -- From moreblocks:super_glow_glass
            type = "shapeless",
            output = "unilib:glass_glow_super",
            recipe = {"unilib:torch_ordinary", "unilib:glass_glow"},
        })

    end
    unilib.register_stairs("unilib:glass_glow_super", {
        glass_flag = true,
    })

    unilib.register_node("unilib:glass_glow_super_trap", "moreblocks:trap_super_glow_glass", mode, {
        -- From moreblocks:trap_super_glow_glass
        description = unilib.brackets(S("Super Glow Glass"), S("Trap")),
        tiles = {
            "unilib_glass_ordinary.png^[colorize:#FFFF78^unilib_trap_glass_box_overlay.png",
            "unilib_glass_ordinary_detail.png^[colorize:#FFFF78",
        },
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.glass,

        drawtype = "glasslike_framed_optional",
        is_ground_content = false,
        light_source = unilib.light_max,
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,
    })
    unilib.register_craft({
        -- From moreblocks:trap_super_glow_glass
        type = "shapeless",
        output = "unilib:glass_glow_super_trap",
        recipe = {
            "unilib:mineral_mese_crystal_fragment",
            "unilib:glass_ordinary",
            "unilib:torch_ordinary",
            "unilib:torch_ordinary",
        },
    })
    if unilib.pkg_executed_table["glass_glow"] ~= nil then

        unilib.register_craft({
            -- From moreblocks:trap_super_glow_glass
            type = "shapeless",
            output = "unilib:glass_glow_super_trap",
            recipe = {"unilib:mineral_mese_crystal_fragment", "unilib:glass_glow_super"},
        })

    end

    if unilib.pkg_executed_table["glass_clean"] ~= nil or
            unilib.pkg_executed_table["glass_glow"] ~= nil or
            unilib.pkg_executed_table["item_sweeper"] ~= nil then

        unilib.register_node(
            -- From moreblocks:clean_super_glow_glass
            "unilib:glass_glow_super_clean",
            "moreblocks:clean_super_glow_glass",
            mode,
            {
                description = S("Clean Super Glow Glass"),
                tiles = {
                    "unilib_glass_clean.png^[colorize:#FFFF78",
                    "unilib_glass_clean_detail.png^[colorize:#FFFF78",
                },
                groups = {cracky = 3, oddly_breakable_by_hand = 3},
                sounds = unilib.sound_table.glass,

                drawtype = "glasslike_framed_optional",
                is_ground_content = false,
                light_source = unilib.light_max,
                paramtype = "light",
                sunlight_propagates = true,
                use_texture_alpha = "clip",
            }
        )
        if unilib.pkg_executed_table["glass_clean"] ~= nil then

            unilib.register_craft({
                -- From moreblocks:clean_super_glow_glass
                type = "shapeless",
                output = "unilib:glass_glow_super_clean",
                recipe = {"unilib:torch_ordinary", "unilib:torch_ordinary", "unilib:glass_clean"},
            })

        end
        if unilib.pkg_executed_table["glass_glow"] ~= nil then

            unilib.register_craft({
                -- From moreblocks:clean_super_glow_glass
                type = "shapeless",
                output = "unilib:glass_glow_super_clean",
                recipe = {"unilib:torch_ordinary", "unilib:glass_glow_clean"},
            })

        end
        if unilib.pkg_executed_table["item_sweeper"] ~= nil then

            unilib.register_craft({
                -- From moreblocks:clean_super_glow_glass
                type = "shapeless",
                output = "unilib:glass_glow_super_clean",
                recipe = {"unilib:item_sweeper", "unilib:glass_glow_super"},
            })

        end
        unilib.register_stairs("unilib:glass_glow_super_clean", {
            glass_flag = true,
        })

        unilib.register_node(
            -- From moreblocks:trap_clean_super_glow_glass
            "unilib:glass_glow_super_clean_trap",
            "moreblocks:trap_clean_super_glow_glass",
            mode,
            {
                description = unilib.brackets(S("Clean Super Glow Glass"), S("Trap")),
                tiles = {
                    "unilib_glass_clean.png^[colorize:#FFFF78^unilib_trap_glass_box_overlay.png",
                    "unilib_glass_clean_detail.png^[colorize:#FFFF78",
                },
                groups = {cracky = 3, oddly_breakable_by_hand = 3},
                sounds = unilib.sound_table.glass,

                drawtype = "glasslike_framed_optional",
                is_ground_content = false,
                light_source = unilib.light_max,
                paramtype = "light",
                sunlight_propagates = true,
                use_texture_alpha = "clip",
                walkable = false,
            }
        )
        unilib.register_craft({
            -- From moreblocks:trap_clean_super_glow_glass
            type = "shapeless",
            output = "unilib:glass_glow_super_clean_trap",
            recipe = {"unilib:mineral_mese_crystal_fragment", "unilib:glass_glow_super_clean"},
        })
        if unilib.pkg_executed_table["glass_glow"] ~= nil then

            unilib.register_craft({
                -- From moreblocks:trap_clean_super_glow_glass
                type = "shapeless",
                output = "unilib:glass_glow_super_clean_trap",
                recipe = {
                    "unilib:mineral_mese_crystal_fragment",
                    "unilib:glass_glow_clean",
                    "unilib:torch_ordinary",
                },
            })

        end
        if unilib.pkg_executed_table["glass_clean"] ~= nil then

            unilib.register_craft({
                -- From moreblocks:trap_clean_super_glow_glass
                type = "shapeless",
                output = "unilib:glass_glow_super_clean_trap",
                recipe = {
                    "unilib:mineral_mese_crystal_fragment",
                    "unilib:glass_clean",
                    "unilib:torch_ordinary",
                    "unilib:torch_ordinary",
                },
            })

        end
        if unilib.pkg_executed_table["item_sweeper"] ~= nil then

            unilib.register_craft({
                -- From moreblocks:trap_clean_super_glow_glass
                type = "shapeless",
                output = "unilib:glass_glow_super_clean_trap",
                recipe = {"unilib:item_sweeper", "unilib:glass_glow_super_trap"},
            })

        end

    end

end
