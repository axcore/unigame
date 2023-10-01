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
minetest.register_node("australia:kelp_giant_brown", {
	description = "Giant Kelp ",
	drawtype = "plantlike",
	tiles = {"aus_kelp_giant_brown.png"},
	inventory_image = "aus_kelp_giant_brown.png",
	wield_image = "aus_kelp_giant_brown.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3}
	},
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {snappy=3, seaplants=1, sea=1},
	sounds = default.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(1)
})

minetest.register_node("australia:kelp_giant_brown_middle", {
	description = "Giant Kelp middle",
	drawtype = "plantlike",
	tiles = {"aus_kelp_giant_brown_middle.png"},
	inventory_image = "aus_kelp_giant_brown_middle.png",
	wield_image = "aus_kelp_giant_brown_middle.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {snappy=3, seaplants=1, sea=1},
	drop = "australia:kelp_giant_brown",
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_abm({
    nodenames = {"australia:stone_kelp_giant_brown"},
    interval = 12,
    chance = 10,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
        if (minetest.get_node(yp).name == "default:water_source" or
        minetest.get_node(yp).name == "australia:water_source") then
            pos.y = pos.y + 1
            minetest.add_node(pos, {name = "australia:kelp_giant_brown"}) else
            return
        end
    end
})

minetest.register_abm({
    nodenames = {"australia:kelp_giant_brown"},
    interval = 6,
    chance = 3,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
        local yyp = {x = pos.x, y = pos.y + 2, z = pos.z}
        local yyyp = {x = pos.x, y = pos.y + 3, z = pos.z}
        if minetest.get_node(pos).name == "australia:kelp_giant_brown" and
            (minetest.get_node(yp).name == "default:water_source" or
            minetest.get_node(yp).name == "australia:water_source") then
                if (minetest.get_node(yyp).name == "default:water_source" or
                minetest.get_node(yyp).name == "australia:water_source") then
                    if (minetest.get_node(yyyp).name == "default:water_source" or
                    minetest.get_node(yyyp).name == "australia:water_source") then
                        minetest.add_node(pos, {name = "australia:kelp_giant_brown_middle"}) 
                        pos.y = pos.y + 1
                        minetest.add_node(pos, {name = "australia:kelp_giant_brown"}) 
                    else
                    return
                end
            end
        end
    end
})
]]--
