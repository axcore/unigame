---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nbea
-- Code:    WTFPL
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("nbea:nbox_003", {
	description = "Inner-Cube",
	tiles = {
		{image = "nbea_core1.png",
		backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 4.0
			},
		}
	},
	drawtype = "nodebox",
	paramtype = "light",
	light_source = 8,
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3},
	sounds = default.node_sound_metal_defaults({
		footstep = {name = "default_glass_footstep", gain = 0.5},
		dug = {name = "default_break_glass", gain = 1.0},
	}),
	node_box = {
		type = "fixed",
		fixed = {
			-- corner frame
			{-0.5, 0.4375, -0.4375, -0.4375, 0.5, 0.4375},
			{-0.5, -0.5, -0.4375, -0.4375, -0.4375, 0.4375},
			{-0.5, -0.5, -0.5, -0.4375, 0.5, -0.4375},
			{-0.5, -0.5, 0.4375, -0.4375, 0.5, 0.5},
			{-0.4375, 0.4375, -0.5, 0.4375, 0.5, -0.4375},
			{-0.4375, -0.5, -0.5, 0.4375, -0.4375, -0.4375},
			{-0.4375, 0.4375, 0.4375, 0.4375, 0.5, 0.5},
			{-0.4375, -0.5, 0.4375, 0.4375, -0.4375, 0.5},
			{0.4375, 0.4375, -0.5, 0.5, 0.5, 0.5},
			{0.4375, -0.5, -0.5, 0.5, -0.4375, 0.5},
			{0.4375, -0.4375, 0.4375, 0.5, 0.4375, 0.5},
			{0.4375, -0.4375, -0.5, 0.5, 0.4375, -0.4375},
			-- center mass 2px--0.0625 / 4px--0.125 / 6px--0.1875
			{-0.125, -0.125, -0.125, 0.125, 0.125, 0.125},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},
})

local nbea_rules = {
	{x=0,  y=0,  z=-1},
	{x=1,  y=0,  z=0},
	{x=-1, y=0,  z=0},
	{x=0,  y=0,  z=1},
	{x=1,  y=1,  z=0},
	{x=1,  y=-1, z=0},
	{x=-1, y=1,  z=0},
	{x=-1, y=-1, z=0},
	{x=0,  y=1,  z=1},
	{x=0,  y=-1, z=1},
	{x=0,  y=1,  z=-1},
	{x=0,  y=-1, z=-1},
	{x=0,  y=-1, z=0},
}

minetest.register_node("nbea:nbox_003_on", {
	description = "Inner-Cube",
	tiles = {
		{image = "nbea_core1.png",
		backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.25
			},
		}
	},
	use_texture_alpha = true,
	drawtype = "nodebox",
	paramtype = "light",
	light_source = 8,
	sunlight_propagates = true,
	is_ground_content = false,
    	drop = "nbea:nbox_003",
	groups = {cracky = 3, mesecon = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_metal_defaults({
		footstep = {name = "default_glass_footstep", gain = 0.5},
		dug = {name = "default_break_glass", gain = 1.0},
	}),
	node_box = {
		type = "fixed",
		fixed = {
			-- corner frame
			{-0.5, 0.4375, -0.4375, -0.4375, 0.5, 0.4375},
			{-0.5, -0.5, -0.4375, -0.4375, -0.4375, 0.4375},
			{-0.5, -0.5, -0.5, -0.4375, 0.5, -0.4375},
			{-0.5, -0.5, 0.4375, -0.4375, 0.5, 0.5},
			{-0.4375, 0.4375, -0.5, 0.4375, 0.5, -0.4375},
			{-0.4375, -0.5, -0.5, 0.4375, -0.4375, -0.4375},
			{-0.4375, 0.4375, 0.4375, 0.4375, 0.5, 0.5},
			{-0.4375, -0.5, 0.4375, 0.4375, -0.4375, 0.5},
			{0.4375, 0.4375, -0.5, 0.5, 0.5, 0.5},
			{0.4375, -0.5, -0.5, 0.5, -0.4375, 0.5},
			{0.4375, -0.4375, 0.4375, 0.5, 0.4375, 0.5},
			{0.4375, -0.4375, -0.5, 0.5, 0.4375, -0.4375},
			-- center mass 2px--0.0625 / 4px--0.125 / 6px--0.1875
			{-0.0625, -0.0625, -0.0625, 0.0625, 0.0625, 0.0625},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},
	mesecons = {effector = {
        rules = nbea_rules,
        action_off = function (pos, node)
            minetest.swap_node(pos, {name = "nbea:nbox_003", param2 = node.param2})
        end,
    }}
})

minetest.override_item("nbea:nbox_003", {
	light_source = 5,
	groups = {cracky = 3,  mesecon_effector_off = 1, mesecon = 3},
	mesecons = {effector = {
        rules = nbea_rules,
        action_on = function (pos, node)
            minetest.swap_node(pos, {name = "nbea:nbox_003_on", param2 = node.param2})
        end,
    }}
})

minetest.register_abm({
	nodenames = {"nbea:nbox_003_on"},
	interval = 1,
	chance = 1,
	catch_up = false,
	action = function(pos, node)
            local image_number = math.random(4)
            minetest.add_particlespawner({
                amount = 50,
                time = 1,
                minpos = {x=pos.x-0.15, y=pos.y-0.15, z=pos.z-0.15},
                maxpos = {x=pos.x+0.15, y=pos.y+0.15, z=pos.z+0.15},
                minvel = {x=-0.01, y=-0.02, z=-0.01},
                maxvel = {x=0.005,  y=0.005,  z=0.005},
                minacc = {x=-0.1,  y=-0.1,  z=-0.1},
                maxacc = {x=1.0, y=1.0, z=1.0},
                minexptime = 0.05,
                maxexptime = 0.15,
                minsize = 0.15,
                maxsize = 0.15,
                collisiondetection = true,
                collision_removal = true,
                glow = 10,
                texture = "nbea_core_particle.png",
            })
	end
})
]]--
