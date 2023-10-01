---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_on_generated(function(minp, maxp)

	if minp.y > -30 or maxp.y < -3000 then
		return
	end

	local bpos
	local coal = minetest.find_nodes_in_area_under_air(
			minp, maxp, "default:stone_with_coal")

	for n = 1, #coal do

		if random(2) == 1 then

			bpos = {x = coal[n].x, y = coal[n].y + 1, z = coal[n].z}

			if bpos.y > -3000 and bpos.y < -2000 then
				minetest.swap_node(bpos, {name = "ethereal:illumishroom3"})

			elseif bpos.y > -2000 and bpos.y < -1000 then
				minetest.swap_node(bpos, {name = "ethereal:illumishroom2"})

			elseif bpos.y > -1000 and bpos.y < -30 then
				minetest.swap_node(bpos, {name = "ethereal:illumishroom"})
			end
		end
	end
end)
]]--
