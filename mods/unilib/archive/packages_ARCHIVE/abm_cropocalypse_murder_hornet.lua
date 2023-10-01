---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if minetest.features.particlespawner_tweenable then
	minetest.register_abm({
		nodenames = { "group:decorative_plants" },
		interval = 1,
		chance = 1000,
		catch_up = false,
		action = function(pos, node)
			minetest.add_particlespawner({
				pos = { min = vector.add(pos, vector.new(-1.5, 0, -1.5)), max = vector.add(pos, vector.new(1.5, 1.5, 1.5)) },
				vel = { min = vector.new(0, 0, 0), max = vector.new( 0.1, 0.1, 0.1) },
				acc = { min = vector.new(-0.2, -0.1, -0.2), max = vector.new(0.2, 0.1, 0.2) },
				time = 1,
				amount = 1,
				exptime = 5,
				collisiondetection = true,
				collision_removal = true,
				glow = 0,
				texpool = {
					{ name = "particle_murder_hornet.png", alpha_tween = { 1, 1 }, scale = 0.5,
					animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1}},
				}
			})
		end
	})
end
]]--
