---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    scaffolding
-- Code:    CC-BY-SA-4.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.scaffold_wood = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.scaffolding.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.scaffold_wood.init()

    return {
        description = "Wooden scaffolding",
        notes = "Place tower nodes one on top of the other. They are climbable like a ladder. At" ..
                " the top, create a surrounding platform by right-clicking the tower with a." ..
                " platform. Dig the tower node at the bottom to collapse the structure. Use a" ..
                " wrench to reinforce tower/platform nodes so they don't collapse when punched",
        depends = {"item_stick_ordinary", "shared_scaffolding"},
        optional = "tree_apple"
    }

end

function unilib.pkg.scaffold_wood.exec()

    local c_stick = "unilib:item_stick_ordinary"
    -- N.B. in the original code, craft recipes require wood from the (default) apple tree
    local c_wood = "group:wood"

    unilib.register_node("unilib:scaffold_tower_wood", "scaffolding:scaffolding", mode, {
        -- From scaffolding:scaffolding
        description = S("Wooden Scaffolding Tower"),
        tiles = {
            "unilib_scaffold_wood_top.png",
            "unilib_scaffold_wood_top.png",
            "unilib_scaffold_wood.png",
        },
        groups = {cracky = 3, oddly_breakable_by_hand = 3, snappy = 2},
        sounds = unilib.sound_table.wood,

        climbable = true,
        drawtype = "nodebox",
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
            unilib.dig_up(pos, node, digger)
        end,

        on_punch = function(pos, node, puncher)

            local tool = puncher:get_wielded_item():get_name()
            if tool and tool == "unilib:item_wrench_scaffold" then

                node.name = "unilib:scaffold_tower_wood_reinforced"
                minetest.set_node(pos, node)
                -- N.B. Removed as it produces infinite scaffolding
--              puncher:get_inventory():add_item("main", ItemStack("unilib:scaffold_tower_wood"))

            end

        end,

        on_rightclick = function(pos, node, player, itemstack, pointed_thing)

            -- Punch with wooden platform
            if itemstack:get_name() == "unilib:scaffold_platform_wood" then

                node = "unilib:scaffold_platform_wood"
                unilib.pkg.shared_scaffolding.build_platform(node, pos, itemstack)

            -- Punch with iron platform
            elseif itemstack:get_name() == "unilib:scaffold_platform_iron" then

                node = "unilib:scaffold_platform_iron"
                unilib.pkg.shared_scaffolding.build_platform(node, pos, itemstack)

            -- Punch with wooden tower
            elseif itemstack:get_name() == "unilib:scaffold_tower_wood" then

                node = "unilib:scaffold_tower_wood"
                local name = minetest.get_node(pos).name
                unilib.pkg.shared_scaffolding.build_tower(node, pos, itemstack, player)

            end

        end,
    })
    unilib.register_craft({
        -- From scaffolding:scaffolding
        output = "unilib:scaffold_tower_wood 12",
        recipe = {
            {c_wood, c_wood, c_wood},
            {c_stick, "", c_stick},
            {c_wood, c_wood, c_wood},
        }
    })
    unilib.register_craft({
        -- From scaffolding:scaffolding
        output = "unilib:scaffold_tower_wood 4",
        recipe = {
            {c_wood},
            {c_stick},
            {c_wood},
        }
    })
    unilib.register_craft({
        -- From scaffolding:scaffolding
        output = "unilib:scaffold_tower_wood",
        recipe = {
            {"unilib:scaffold_platform_wood"},
            {"unilib:scaffold_platform_wood"},
        }
    })
    if unilib.pkg_executed_table["tree_apple"] ~= nil then

        -- N.B. this is the only recipe that follows the original code, in that it uses a specific
        --      type of wood, rather than group:wood
        unilib.register_craft({
            -- From scaffolding:platform
            output = "unilib:tree_apple_wood",
            recipe = {
                {"unilib:scaffold_tower_wood", "unilib:scaffold_tower_wood"},
            }
        })

    end

    unilib.register_node(
        -- From scaffolding:reinforced_scaffolding
        "unilib:scaffold_tower_wood_reinforced",
        "scaffolding:reinforced_scaffolding",
        mode,
        {
            description = S("Wooden Scaffolding Tower"),
            tiles = {"unilib_scaffold_wood.png^unilib_scaffold_reinforced_overlay.png"},
            -- N.B. not_in_creative_inventory not in original code
            groups = {
                cracky = 3, not_in_creative_inventory = 1, oddly_breakable_by_hand = 3, snappy = 2,
            },
            sounds = unilib.sound_table.wood,

            climbable = true,
            drawtype = "nodebox",
            drop = "unilib:scaffold_tower_wood",
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

                    node.name = "unilib:scaffold_tower_wood"
                    minetest.set_node(pos, node)
                    -- N.B. Removed as it produces infinite scaffolding
                    --[[
                    puncher:get_inventory():add_item(
                        "main", ItemStack("unilib:scaffold_tower_wood")
                    )
                    ]]--

                end

            end,

            on_rightclick = function(pos, node, player, itemstack, pointed_thing)

                -- Punch with wooden platform
                if itemstack:get_name() == "unilib:scaffold_platform_wood" then

                    node = "unilib:scaffold_platform_wood"
                    unilib.pkg.shared_scaffolding.build_platform(node, pos, itemstack)

                -- Punch with iron platform
                elseif itemstack:get_name() == "unilib:scaffold_platform_iron" then

                    node = "unilib:scaffold_platform_iron"
                    unilib.pkg.shared_scaffolding.build_platform(node, pos, itemstack)

                end

            end,
        }
    )

    unilib.register_node("unilib:scaffold_platform_wood", "scaffolding:platform", mode, {
        -- From scaffolding:platform
        description = S("Wooden Scaffolding Platform"),
        tiles = {
            "unilib_scaffold_wood_top.png",
            "unilib_scaffold_wood_top.png",
            "unilib_scaffold_wood.png^unilib_scaffold_platform_overlay.png",
        },
        groups = {cracky = 3, oddly_breakable_by_hand = 3, snappy = 2},
        sounds = unilib.sound_table.wood,

        climbable = false,
        drawtype = "nodebox",
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

            unilib.pkg.shared_scaffolding.dig_horizontal_x(pos, node, digger)
            unilib.pkg.shared_scaffolding.dig_horizontal_x2(pos, node, digger)
            unilib.pkg.shared_scaffolding.dig_horizontal_z(pos, node, digger)
            unilib.pkg.shared_scaffolding.dig_horizontal_z2(pos, node, digger)

        end,

        on_punch = function(pos, node, puncher)

            local tool = puncher:get_wielded_item():get_name()
            if tool and tool == "unilib:item_wrench_scaffold" then

                node.name = "unilib:scaffold_platform_wood_reinforced"
                minetest.set_node(pos, node)

            end

        end,
    })
    unilib.register_craft({
        -- From scaffolding:platform
        output = "unilib:scaffold_platform_wood 2",
        recipe = {
            {"unilib:scaffold_tower_wood"},
        }
    })
    unilib.register_craft({
        -- From scaffolding:platform
        output = "unilib:scaffold_platform_wood 6",
        recipe = {
            {
                "unilib:scaffold_tower_wood",
                "unilib:scaffold_tower_wood",
                "unilib:scaffold_tower_wood",
            },
        }
    })

    unilib.register_node(
        -- From scaffolding:reinforced_platform
        "unilib:scaffold_platform_wood_reinforced",
        "scaffolding:reinforced_platform",
        mode,
        {
            description = S("Wooden Scaffolding Platform"),
            tiles = {
                "unilib_scaffold_wood.png^unilib_scaffold_reinforced_overlay.png",
                "unilib_scaffold_wood.png^unilib_scaffold_reinforced_overlay.png",
                "unilib_scaffold_wood.png^unilib_scaffold_platform_overlay.png",
            },
            -- N.B. not_in_creative_inventory not in original code
            groups = {
                cracky = 3, not_in_creative_inventory = 1, oddly_breakable_by_hand = 3, snappy = 2,
            },
            sounds = unilib.sound_table.wood,

            climbable = false,
            drawtype = "nodebox",
            drop = "unilib:scaffold_platform_wood",
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

                    node.name = "unilib:scaffold_platform_wood"
                    minetest.set_node(pos, node)

                end

            end,
        }
    )

end
