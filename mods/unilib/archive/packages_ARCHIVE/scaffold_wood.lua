---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    scaffolding
-- Code:    CC-BY-SA-4.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("scaffolding:scaffolding", {
        description = "Wooden Scaffolding",
        drawtype = "nodebox",
        tiles = {"scaffolding_wooden_scaffolding_top.png", "scaffolding_wooden_scaffolding_top.png", "scaffolding_wooden_scaffolding.png",
        "scaffolding_wooden_scaffolding.png", "scaffolding_wooden_scaffolding.png", "scaffolding_wooden_scaffolding.png"},
        paramtype = "light",
        paramtype2 = "facedir",
        climbable = true,
        walkable = false,
        is_ground_content = true,
        groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
        sounds = default.node_sound_wood_defaults(),
        on_punch = function(pos, node, puncher)
        local tool = puncher:get_wielded_item():get_name()
            if tool and tool == "scaffolding:scaffolding_wrench" then
                node.name = "scaffolding:reinforced_scaffolding"
                minetest.env:set_node(pos, node)
                puncher:get_inventory():add_item("main", ItemStack("scaffolding:scaffolding"))
            end
        end,
        on_rightclick = function(pos, node, player, itemstack, pointed_thing)
            -- if user hits scaffolding with platform Wooden scaffolding then --
            if itemstack:get_name() == "scaffolding:platform" then
                node = "scaffolding:platform";
                buildPlatform(node, pos, itemstack)
            end
            -- if user hits scaffolding with platform Iron scaffolding then --
            if itemstack:get_name() == "scaffolding:iron_platform" then
                node = "scaffolding:iron_platform";
                buildPlatform(node, pos, itemstack)
            end
            -- if user hits scaffolding with scaffolding then --
            if itemstack:get_name() == "scaffolding:scaffolding" then
                node = "scaffolding:scaffolding";
                local name = minetest.get_node(pos).name                                    -- get loacation of node
                buildScaffolding(node, pos, itemstack, player)
            end
        end,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },
        after_dig_node = function(pos, node, metadata, digger)
        default.dig_up(pos, node, digger)
    end,
    })
minetest.register_craft({
    output = 'scaffolding:scaffolding 12',
    recipe = {
        {'default:wood', 'default:wood', 'default:wood'},
        {'default:stick', '', 'default:stick'},
        {'default:wood', 'default:wood', 'default:wood'},
    }
})
minetest.register_craft({
    output = 'scaffolding:scaffolding 4',
    recipe = {
        {'default:wood'},
        {'default:stick'},
        {'default:wood'},
    }
})
minetest.register_craft({
    output = "scaffolding:scaffolding",
    recipe = {
        {"scaffolding:platform"},
        {"scaffolding:platform"},
    }
})
minetest.register_craft({
    output = "default:wood",
    recipe = {
        {"scaffolding:scaffolding", "scaffolding:scaffolding"},
    }
})

minetest.register_node("scaffolding:reinforced_scaffolding", {
        description = "Wooden Scaffolding",
        drawtype = "nodebox",
        tiles = {"scaffolding_wooden_scaffolding.png^scaffolding_reinforced.png", "scaffolding_wooden_scaffolding.png^scaffolding_reinforced.png",
        "scaffolding_wooden_scaffolding.png^scaffolding_reinforced.png"},
        drop = "scaffolding:scaffolding",
        paramtype = "light",
        light_source = 14,
        paramtype2 = "facedir",
        climbable = true,
        walkable = false,
        is_ground_content = true,
        groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
        sounds = default.node_sound_wood_defaults(),
        on_punch = function(pos, node, puncher)
        local tool = puncher:get_wielded_item():get_name()
            if tool and tool == "scaffolding:scaffolding_wrench" then
                node.name = "scaffolding:scaffolding"
                minetest.env:set_node(pos, node)
                puncher:get_inventory():add_item("main", ItemStack("scaffolding:scaffolding"))
            end
        end,
        on_rightclick = function(pos, node, player, itemstack, pointed_thing)
            -- if user hits scaffolding with platform Wooden scaffolding then --
            if itemstack:get_name() == "scaffolding:platform" then
                node = "scaffolding:platform";
                buildPlatform(node, pos, itemstack)
            end
            -- if user hits scaffolding with platform Iron scaffolding then --
            if itemstack:get_name() == "scaffolding:iron_platform" then
                node = "scaffolding:iron_platform";
                buildPlatform(node, pos, itemstack)
            end
        end,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },
    })

    minetest.register_node("scaffolding:platform", {
        description = "Wooden Platform",
        drawtype = "nodebox",
        tiles = {"scaffolding_wooden_scaffolding_top.png", "scaffolding_wooden_scaffolding_top.png", "scaffolding_wooden_scaffolding.png^scaffolding_platform.png"},
        paramtype = "light",
        paramtype2 = "facedir",
        climbable = false,
        walkable = true,
        is_ground_content = true,
        groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
        sounds = default.node_sound_wood_defaults(),
        on_punch = function(pos, node, puncher)
        local tool = puncher:get_wielded_item():get_name()
            if tool and tool == "scaffolding:scaffolding_wrench" then
                node.name = "scaffolding:reinforced_platform"
                minetest.env:set_node(pos, node)
            end
        end,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.3, -0.5, 0.5, 0.1, 0.5},
            },
        },
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.3, -0.5, 0.5, 0.1, 0.5},
            },
        },
        after_dig_node = function(pos, node, metadata, digger)
        default.dig_horx(pos, node, digger)
        default.dig_horx2(pos, node, digger)
        default.dig_horz(pos, node, digger)
        default.dig_horz2(pos, node, digger)
    end,
    })
minetest.register_craft({
    output = "scaffolding:platform 2",
    recipe = {
        {"scaffolding:scaffolding"},
    }
})
minetest.register_craft({
    output = "scaffolding:platform 6",
    recipe = {
        {"scaffolding:scaffolding", "scaffolding:scaffolding", "scaffolding:scaffolding"},
    }
})

    minetest.register_node("scaffolding:reinforced_platform", {
        description = "Wooden Platform",
        drawtype = "nodebox",
        light_source = 14,
        tiles = {"scaffolding_wooden_scaffolding.png^scaffolding_reinforced.png", "scaffolding_wooden_scaffolding.png^scaffolding_reinforced.png", "scaffolding_wooden_scaffolding.png^scaffolding_platform.png"},
        drop = "scaffolding:platform",
        paramtype = "light",
        paramtype2 = "facedir",
        climbable = false,
        walkable = true,
        is_ground_content = true,
        groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
        sounds = default.node_sound_wood_defaults(),
        on_punch = function(pos, node, puncher)
        local tool = puncher:get_wielded_item():get_name()
            if tool and tool == "scaffolding:scaffolding_wrench" then
                node.name = "scaffolding:platform"
                minetest.env:set_node(pos, node)
            end
        end,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.3, -0.5, 0.5, 0.1, 0.5},
            },
        },
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.3, -0.5, 0.5, 0.1, 0.5},
            },
        },
    })
]]--
