---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    scaffolding
-- Code:    CC-BY-SA-4.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.scaffold_iron = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.scaffolding.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.scaffold_iron.init()

    return {
        description = "Iron scaffolding",
        notes = "Place a tower node on the ground, then right-click it with more tower nodes" ..
                " (while standing at the bottom) to increase the height of the tower. Once" ..
                " placed, tower nodes are climbed like a ladder. At the top, create a" ..
                " surrounding platform by right-clicking the tower with platform nodes. When" ..
                " it's time to remove the structure, dig one platform node to remove the" ..
                " adjoining platform nodes; then dig the tower node at the bottom to remove" ..
                " the whole tower. Use a wrench to reinforce tower/platform nodes so they don't" ..
                " collapse when nodes below are dug. These nodes must be dug with a tool," ..
                " whereas wooden scaffolding can be dug by hand",
        depends = {"item_stick_ordinary", "metal_steel", "shared_scaffolding"},
    }

end

function unilib.pkg.scaffold_iron.exec()

    local c_stick = "unilib:item_stick_ordinary"
    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:scaffold_tower_iron", "scaffolding:iron_scaffolding", mode, {
        -- From scaffolding:iron_scaffolding
        description = S("Iron Scaffolding Tower"),
        tiles = {
            "unilib_scaffold_iron_top.png",
            "unilib_scaffold_iron_top.png",
            "unilib_scaffold_iron.png",
        },
        groups = {cracky = 3, snappy = 2},
        sounds = unilib.global.sound_table.wood,

        climbable = true,
        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },
        use_texture_alpha = "clip",
        walkable = false,

        after_dig_node = function(pos, node, metadata, digger)

            unilib.misc.dig_up(pos, node, digger)
            if unilib.setting.scaffolding_quick_remove_flag then

                unilib.pkg.shared_scaffolding.dig_platform(
                    pos, "unilib:scaffold_platform_iron", digger
                )

            end

        end,

        on_punch = function(pos, node, puncher)

            local tool = puncher:get_wielded_item():get_name()
            if tool and tool == "unilib:item_wrench_scaffold" then

                node.name = "unilib:scaffold_tower_iron_reinforced"
                core.set_node(pos, node)
                -- N.B. Removed as it produces infinite scaffolding
--              puncher:get_inventory():add_item("main", ItemStack("unilib:scaffold_tower_iron"))

            end

        end,

        on_rightclick = function(pos, node, player, itemstack, pointed_thing)

            local wielded_name = itemstack:get_name()

            -- Punch with iron platform
            if wielded_name == "unilib:scaffold_platform_iron" then

                unilib.pkg.shared_scaffolding.build_platform(
                    "unilib:scaffold_platform_iron", pos, itemstack
                )

            -- Punch with wooden platform
            elseif wielded_name == "unilib:scaffold_platform_wood" then

                unilib.pkg.shared_scaffolding.build_platform(
                    "unilib:scaffold_platform_wood", pos, itemstack
                )

            -- Punch with iron tower
            elseif wielded_name == "unilib:scaffold_tower_iron" then

                unilib.pkg.shared_scaffolding.build_tower(
                    "unilib:scaffold_tower_iron", pos, itemstack, player
                )

            end

        end,
    })
    unilib.register_craft({
        -- From scaffolding:iron_scaffolding
        output = "unilib:scaffold_tower_iron 12",
        recipe = {
            {c_ingot, c_ingot, c_ingot},
            {c_stick, "", c_stick},
            {c_ingot, c_ingot, c_ingot},
        },
    })
    unilib.register_craft({
        -- From scaffolding:iron_scaffolding
        output = "unilib:scaffold_tower_iron 4",
        recipe = {
            {c_ingot},
            {c_stick},
            {c_ingot},
        },
    })
    unilib.register_craft({
        -- From scaffolding:iron_scaffolding
        output = "unilib:scaffold_tower_iron",
        recipe = {
            {"unilib:scaffold_platform_iron"},
            {"unilib:scaffold_platform_iron"},
        },
    })
    unilib.register_craft({
        -- From scaffolding:iron_platform
        output = c_ingot,
        recipe = {
            {"unilib:scaffold_tower_iron", "unilib:scaffold_tower_iron"},
        },
    })

    unilib.register_node(
        -- From scaffolding:reinforced_iron_scaffolding
        "unilib:scaffold_tower_iron_reinforced",
        "scaffolding:reinforced_iron_scaffolding",
        mode,
        {
            description = S("Iron Scaffolding Tower"),
            tiles = {"unilib_scaffold_iron.png^unilib_scaffold_reinforced_overlay.png"},
            -- N.B. not_in_creative_inventory not in original code
            groups = {cracky = 3, not_in_creative_inventory = 1, snappy = 2},
            sounds = unilib.global.sound_table.wood,

            climbable = true,
            drawtype = "nodebox",
            drop = "unilib:scaffold_tower_iron",
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            light_source = unilib.pkg.shared_scaffolding.light_source,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                },
            },
            use_texture_alpha = "clip",
            walkable = false,

            on_punch = function(pos, node, puncher)

                local tool = puncher:get_wielded_item():get_name()
                if tool and tool == "unilib:item_wrench_scaffold" then

                    node.name = "unilib:scaffold_tower_iron"
                    core.set_node(pos, node)
                    -- N.B. Removed as it produces infinite scaffolding
                    --[[
                    puncher:get_inventory():add_item(
                        "main", ItemStack("unilib:scaffold_tower_iron")
                    )
                    ]]--

                end

            end,

            on_rightclick = function(pos, node, player, itemstack, pointed_thing)

                local wielded_name = itemstack:get_name()

                -- Punch with iron platform
                if wielded_name == "unilib:scaffold_platform_iron" then

                    unilib.pkg.shared_scaffolding.build_platform(
                        "unilib:scaffold_platform_iron", pos, itemstack
                    )

                -- Punch with wooden platform
                elseif wielded_name == "unilib:scaffold_platform_wood" then

                    unilib.pkg.shared_scaffolding.build_platform(
                        "unilib:scaffold_platform_wood", pos, itemstack
                    )

                end

            end,
        }
    )

    unilib.register_node("unilib:scaffold_platform_iron", "scaffolding:iron_platform", mode, {
        -- From scaffolding:iron_platform
        description = S("Iron Scaffolding Platform"),
        tiles = {
            "unilib_scaffold_iron_top.png",
            "unilib_scaffold_iron_top.png",
            "unilib_scaffold_iron.png^unilib_scaffold_platform_overlay.png",
        },
        groups = {cracky = 3, snappy = 2},
        sounds = unilib.global.sound_table.wood,

        climbable = false,
        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.3, -0.5, 0.5, 0.1, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.3, -0.5, 0.5, 0.1, 0.5},
            },
        },
        use_texture_alpha = "clip",
        walkable = true,

        after_dig_node = function(pos, node, metadata, digger)
            unilib.pkg.shared_scaffolding.dig_platform(pos, "unilib:scaffold_platform_iron", digger)
        end,

        on_punch = function(pos, node, puncher)

            local tool = puncher:get_wielded_item():get_name()
            if tool and tool == "unilib:item_wrench_scaffold" then

                node.name = "unilib:scaffold_platform_iron_reinforced"
                core.set_node(pos, node)

            end

        end,
    })
    unilib.register_craft({
        -- From scaffolding:iron_platform
        output = "unilib:scaffold_platform_iron 2",
        recipe = {
            {"unilib:scaffold_tower_iron"},
        },
    })
    unilib.register_craft({
        -- From scaffolding:iron_platform
        output = "unilib:scaffold_platform_iron 6",
        recipe = {
            {
                "unilib:scaffold_tower_iron",
                "unilib:scaffold_tower_iron",
                "unilib:scaffold_tower_iron",
            },
        },
    })

    unilib.register_node(
        -- From scaffolding:reinforced_iron_platform
        "unilib:scaffold_platform_iron_reinforced",
        "scaffolding:reinforced_iron_platform",
        mode,
        {
            description = S("Iron Scaffolding Platform"),
            tiles = {
                "unilib_scaffold_iron.png^unilib_scaffold_reinforced_overlay.png",
                "unilib_scaffold_iron.png^unilib_scaffold_reinforced_overlay.png",
                "unilib_scaffold_iron.png^unilib_scaffold_platform_overlay.png",
            },
            -- N.B. not_in_creative_inventory not in original code
            groups = {cracky = 3, not_in_creative_inventory = 1, snappy = 2},
            sounds = unilib.global.sound_table.wood,

            climbable = false,
            drawtype = "nodebox",
            drop = "unilib:scaffold_platform_iron",
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            light_source = unilib.pkg.shared_scaffolding.light_source,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.3, -0.5, 0.5, 0.1, 0.5},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.3, -0.5, 0.5, 0.1, 0.5},
                },
            },
            use_texture_alpha = "clip",
            walkable = true,

            on_punch = function(pos, node, puncher)

                local tool = puncher:get_wielded_item():get_name()
                if tool and tool == "unilib:item_wrench_scaffold" then

                    node.name = "unilib:scaffold_platform_iron"
                    core.set_node(pos, node)

                end

            end,
        }
    )

end
