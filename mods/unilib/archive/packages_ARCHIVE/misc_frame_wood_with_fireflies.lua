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
minetest.register_node("nbea:nbox_008", {
	description = "Fireflies",
	inventory_image = "nbea_fireflies_inv.png",
	wield_image = "nbea_fireflies_inv.png",
	tiles = {"nbea_frame_wood.png"},
	use_texture_alpha = true,
	drawtype = "nodebox",
	paramtype = "light",
	light_source = 3,
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {oddly_breakable_by_hand=3, choppy = 3},
	sounds = default.node_sound_wood_defaults({
		footstep = {name = "default_glass_footstep", gain = 0.5},
		dug = {name = "default_break_glass", gain = 1.0},
	}),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, 0.4375, 0.4375, 0.4375, 0.5, 0.5},
			{-0.4375, -0.5, 0.4375, 0.4375, -0.4375, 0.5},
			{-0.5, -0.5, 0.4375, -0.4375, 0.5, 0.5},
			{0.4375, -0.5, 0.4375, 0.5, 0.5, 0.5},
			{-0.5, 0.4375, -0.4375, -0.4375, 0.5, 0.4375},
			{-0.5, -0.5, -0.4375, -0.4375, -0.4375, 0.4375},
			{0.4375, 0.4375, -0.4375, 0.5, 0.5, 0.4375},
			{0.4375, -0.5, -0.4375, 0.5, -0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, -0.4375},
			{-0.5, -0.5, -0.5, 0.5, -0.4375, -0.4375},
			{0.4375, -0.4375, -0.5, 0.5, 0.4375, -0.4375},
			{-0.5, -0.4375, -0.5, -0.4375, 0.4375, -0.4375},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},
	after_destruct = function(pos)
		minetest.add_particle({
			pos = {x=pos.x, y=pos.y, z=pos.z},
			vel ={x=0.25, y=0.05, z=0.25},
			acc ={x=0.010, y=0.025, z=0.010},
			expirationtime = 5,
			minsize = 1,
			maxsize = 2,
            collisiondetection = true,
            glow = 8,
			texture = "nbea_particle_1.png"
		})
	end
})

minetest.register_abm({
	nodenames = {"nbea:nbox_008"},
	interval = 1,
	chance = 3,
	catch_up = false,
	action = function(pos, node)
            local image_number = math.random(4)
            minetest.add_particlespawner({
                amount = 6,
                time = 3,
                minpos = {x=pos.x-0.175, y=pos.y-0.350, z=pos.z-0.175},
                maxpos = {x=pos.x+0.175, y=pos.y+0.350, z=pos.z+0.175},
                minvel = {x=-0.01, y=-0.02, z=-0.01},
                maxvel = {x=0.001,  y=0.001,  z=0.001},
                minacc = {x=-0.125,  y=-0.15,  z=-0.125},
                maxacc = {x=0.015, y=0.05, z=0.015},
                minexptime = 1.0,
                maxexptime = 1.75,
                minsize = 0.5,
                maxsize = 1.5,
                collisiondetection = true,
                collision_removal = true,
                glow = 8,
                texture = "nbea_particle_"..image_number..".png",
            })
	end
})
]]--
