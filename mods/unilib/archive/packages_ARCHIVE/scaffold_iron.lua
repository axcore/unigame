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
    minetest.register_node("scaffolding:iron_scaffolding", {
        description = "Iron Scaffolding",
        drawtype = "nodebox",
        tiles = {"scaffolding_iron_scaffolding_top.png", "scaffolding_iron_scaffolding_top.png", "scaffolding_iron_scaffolding.png",
        "scaffolding_iron_scaffolding.png", "scaffolding_iron_scaffolding.png", "scaffolding_iron_scaffolding.png"},
        paramtype = "light",
        paramtype2 = "facedir",
        climbable = true,
        walkable = false,
        is_ground_content = true,
        groups = {snappy=2,cracky=3},
        sounds = default.node_sound_wood_defaults(),
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
        on_punch = function(pos, node, puncher)
        local tool = puncher:get_wielded_item():get_name()
            if tool and tool == "scaffolding:scaffolding_wrench" then
                node.name = "scaffolding:reinforced_iron_scaffolding"
                minetest.env:set_node(pos, node)
                puncher:get_inventory():add_item("main", ItemStack("scaffolding:scaffolding"))
            end
        end,
        on_rightclick = function(pos, node, player, itemstack, pointed_thing)
            -- if user hits scaffolding with platform Iron scaffolding then --
            if itemstack:get_name() == "scaffolding:iron_platform" then
                node = "scaffolding:iron_platform";
                buildPlatform(node, pos, itemstack)
            end
            -- if user hits scaffolding with platform Wooden scaffolding then --
            if itemstack:get_name() == "scaffolding:platform" then
                node = "scaffolding:platform";
                buildPlatform(node, pos, itemstack)
            end
            -- if user hits scaffolding with scaffolding then --
            if itemstack:get_name() == "scaffolding:iron_scaffolding" then
                node = "scaffolding:iron_scaffolding";
                local name = minetest.get_node(pos).name                                    -- get loacation of node
                buildScaffolding(node, pos, itemstack, player)
            end

        end,
    after_dig_node = function(pos, node, metadata, digger)
        default.dig_up(pos, node, digger)
    end,
    })
minetest.register_craft({
    output = "scaffolding:iron_scaffolding 12",
    recipe = {
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        {"default:stick", "", "default:stick"},
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
    }
})
minetest.register_craft({
    output = "scaffolding:iron_scaffolding 4",
    recipe = {
        {"default:steel_ingot"},
        {"default:stick"},
        {"default:steel_ingot"},
    }
})
minetest.register_craft({
    output = "scaffolding:iron_scaffolding",
    recipe = {
        {"scaffolding:iron_platform"},
        {"scaffolding:iron_platform"},
    }
})
minetest.register_craft({
    output = "default:steel_ingot",
    recipe = {
        {"scaffolding:iron_scaffolding", "scaffolding:iron_scaffolding"},
    }
})

    minetest.register_node("scaffolding:reinforced_iron_scaffolding", {
        description = "Iron Scaffolding",
        drawtype = "nodebox",
        tiles = {"scaffolding_iron_scaffolding.png^scaffolding_reinforced.png", "scaffolding_iron_scaffolding.png^scaffolding_reinforced.png",
        "scaffolding_iron_scaffolding.png^scaffolding_reinforced.png"},
        drop = "scaffolding:iron_scaffolding",
        paramtype = "light",
        paramtype2 = "facedir",
        climbable = true,
        walkable = false,
        light_source = 14,
        is_ground_content = true,
        groups = {snappy=2,cracky=3},
        sounds = default.node_sound_wood_defaults(),
        on_punch = function(pos, node, puncher)
        local tool = puncher:get_wielded_item():get_name()
            if tool and tool == "scaffolding:scaffolding_wrench" then
                node.name = "scaffolding:iron_scaffolding"
                minetest.env:set_node(pos, node)
                puncher:get_inventory():add_item("main", ItemStack("scaffolding:scaffolding"))
            end
        end,
        on_rightclick = function(pos, node, player, itemstack, pointed_thing)
            -- if user hits scaffolding with platform Iron scaffolding then --
            if itemstack:get_name() == "scaffolding:iron_platform" then
                node = "scaffolding:iron_platform";
                buildPlatform(node, pos, itemstack)
            end
            -- if user hits scaffolding with platform Wooden scaffolding then --
            if itemstack:get_name() == "scaffolding:platform" then
                node = "scaffolding:platform";
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

    minetest.register_node("scaffolding:iron_platform", {
        description = "Iron Platform",
        drawtype = "nodebox",
        tiles = {"scaffolding_iron_scaffolding_top.png", "scaffolding_iron_scaffolding_top.png", "scaffolding_iron_scaffolding.png^scaffolding_platform.png"},
        paramtype = "light",
        paramtype2 = "facedir",
        climbable = false,
        walkable = true,
        is_ground_content = true,
        groups = {snappy=2,cracky=3},
        sounds = default.node_sound_wood_defaults(),
        on_punch = function(pos, node, puncher)
        local tool = puncher:get_wielded_item():get_name()
            if tool and tool == "scaffolding:scaffolding_wrench" then
                node.name = "scaffolding:reinforced_iron_platform"
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
    output = "scaffolding:iron_platform 2",
    recipe = {
        {"scaffolding:iron_scaffolding"},
    }
})
minetest.register_craft({
    output = "scaffolding:iron_platform 6",
    recipe = {
        {"scaffolding:iron_scaffolding", "scaffolding:iron_scaffolding", "scaffolding:iron_scaffolding"},
    }
})

    minetest.register_node("scaffolding:reinforced_iron_platform", {
        description = "Iron Platform",
        drawtype = "nodebox",
        tiles = {"scaffolding_iron_scaffolding.png^scaffolding_reinforced.png", "scaffolding_iron_scaffolding.png^scaffolding_reinforced.png", "scaffolding_iron_scaffolding.png^scaffolding_platform.png"},
        drop = "scaffolding:iron_platform",
        paramtype = "light",
        paramtype2 = "facedir",
        climbable = false,
        walkable = true,
        light_source = 14,
        is_ground_content = true,
        groups = {snappy=2,cracky=3},
        sounds = default.node_sound_wood_defaults(),
        on_punch = function(pos, node, puncher)
        local tool = puncher:get_wielded_item():get_name()
            if tool and tool == "scaffolding:scaffolding_wrench" then
                node.name = "scaffolding:iron_platform"
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
