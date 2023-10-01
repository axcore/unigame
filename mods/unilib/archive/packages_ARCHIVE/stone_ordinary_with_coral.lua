---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("australia:coral_stone_brain", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_cluster_green", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_cluster_orange", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_cluster_purple", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_hammer", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_seafan", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_tube_sponge", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_cauliflower_brown", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_cauliflower_green", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_cauliflower_pink", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_staghorn_blue", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_staghorn_pink", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_staghorn_purple", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_staghorn_yellow", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_abm({
    nodenames = {"australia:coral_stone_brain"},
    interval = 15,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
        if (minetest.get_node(yp).name == "default:water_source" or
        minetest.get_node(yp).name == "australia:water_source") then
            pos.y = pos.y + 1
            minetest.add_node(pos, {name = "australia:brain_coral"}) else
            return
        end
    end
})

minetest.register_abm({
    nodenames = {"australia:coral_stone_cauliflower_brown"},
    interval = 15,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
        if (minetest.get_node(yp).name == "default:water_source" or
        minetest.get_node(yp).name == "australia:water_source") then
            pos.y = pos.y + 1
            minetest.add_node(pos, {name = "australia:cauliflower_coral_brown"}) else
            return
        end
    end
})

minetest.register_abm({
    nodenames = {"australia:coral_stone_cauliflower_green"},
    interval = 15,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
        if (minetest.get_node(yp).name == "default:water_source" or
        minetest.get_node(yp).name == "australia:water_source") then
            pos.y = pos.y + 1
            minetest.add_node(pos, {name = "australia:cauliflower_coral_green"}) else
            return
        end
    end
})

minetest.register_abm({
    nodenames = {"australia:coral_stone_cauliflower_pink"},
    interval = 15,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
        if (minetest.get_node(yp).name == "default:water_source" or
        minetest.get_node(yp).name == "australia:water_source") then
            pos.y = pos.y + 1
            minetest.add_node(pos, {name = "australia:cauliflower_coral_pink"}) else
            return
        end
    end
})

minetest.register_abm({
    nodenames = {"australia:coral_stone_cluster_green"},
    interval = 15,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
        if (minetest.get_node(yp).name == "default:water_source" or
        minetest.get_node(yp).name == "australia:water_source") then
            pos.y = pos.y + 1
            minetest.add_node(pos, {name = "australia:cluster_coral_green"}) else
            return
        end
    end
})

minetest.register_abm({
    nodenames = {"australia:coral_stone_cluster_orange"},
    interval = 15,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
        if (minetest.get_node(yp).name == "default:water_source" or
        minetest.get_node(yp).name == "australia:water_source") then
            pos.y = pos.y + 1
            minetest.add_node(pos, {name = "australia:cluster_coral_orange"}) else
            return
        end
    end
})

minetest.register_abm({
    nodenames = {"australia:coral_stone_cluster_purple"},
    interval = 15,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
        if (minetest.get_node(yp).name == "default:water_source" or
        minetest.get_node(yp).name == "australia:water_source") then
            pos.y = pos.y + 1
            minetest.add_node(pos, {name = "australia:cluster_coral_purple"}) else
            return
        end
    end
})

minetest.register_abm({
    nodenames = {"australia:coral_stone_hammer"},
    interval = 15,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
        if (minetest.get_node(yp).name == "default:water_source" or
        minetest.get_node(yp).name == "australia:water_source") then
            pos.y = pos.y + 1
            minetest.add_node(pos, {name = "australia:hammer_coral"}) else
            return
        end
    end
})

minetest.register_abm({
    nodenames = {"australia:coral_stone_seafan"},
    interval = 15,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
        if (minetest.get_node(yp).name == "default:water_source" or
        minetest.get_node(yp).name == "australia:water_source") then
            pos.y = pos.y + 1
            minetest.add_node(pos, {name = "australia:seafan_coral"}) else
            return
        end
    end
})

minetest.register_abm({
    nodenames = {"australia:coral_stone_staghorn_blue"},
    interval = 15,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
        if (minetest.get_node(yp).name == "default:water_source" or
        minetest.get_node(yp).name == "australia:water_source") then
            pos.y = pos.y + 1
            minetest.add_node(pos, {name = "australia:staghorn_coral_blue"}) else
            return
        end
    end
})

minetest.register_abm({
    nodenames = {"australia:coral_stone_staghorn_pink"},
    interval = 15,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
        if (minetest.get_node(yp).name == "default:water_source" or
        minetest.get_node(yp).name == "australia:water_source") then
            pos.y = pos.y + 1
            minetest.add_node(pos, {name = "australia:staghorn_coral_pink"}) else
            return
        end
    end
})

minetest.register_abm({
    nodenames = {"australia:coral_stone_staghorn_purple"},
    interval = 15,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
        if (minetest.get_node(yp).name == "default:water_source" or
        minetest.get_node(yp).name == "australia:water_source") then
            pos.y = pos.y + 1
            minetest.add_node(pos, {name = "australia:staghorn_coral_purple"}) else
            return
        end
    end
})

minetest.register_abm({
    nodenames = {"australia:coral_stone_staghorn_yellow"},
    interval = 15,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
        if (minetest.get_node(yp).name == "default:water_source" or
        minetest.get_node(yp).name == "australia:water_source") then
            pos.y = pos.y + 1
            minetest.add_node(pos, {name = "australia:staghorn_coral_yellow"}) else
            return
        end
    end
})

minetest.register_abm({
    nodenames = {"australia:coral_stone_tube_sponge"},
    interval = 15,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
        if (minetest.get_node(yp).name == "default:water_source" or
        minetest.get_node(yp).name == "australia:water_source") then
            pos.y = pos.y + 1
            minetest.add_node(pos, {name = "australia:tube_sponge"}) else
            return
        end
    end
})

minetest.register_abm({
    nodenames = {"group:coral"},
    interval = 3,
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
        local yyp = {x = pos.x, y = pos.y + 2, z = pos.z}
        if ((minetest.get_node(yp).name == "default:water_source" or
        minetest.get_node(yp).name == "australia:water_source") and
        (minetest.get_node(yyp).name == "default:water_source" or
        minetest.get_node(yyp).name == "australia:water_source")) then
            local objs = minetest.get_objects_inside_radius(pos, 2)
            for k, obj in pairs(objs) do
                obj:set_hp(obj:get_hp()+ 1)
            end
        else
        return
        end
    end
})
]]--
