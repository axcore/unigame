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
minetest.register_node("ethereal:sandy", {
	description = S("Sandy"),
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {
		crumbly = 3, falling_node = 1, sand = 1, not_in_creative_inventory = 1
	},
	drop = "default:sand",
	sounds = default.node_sound_sand_defaults()
})

minetest.register_abm({
	label = "Grow coral/seaweed",
	nodenames = {"ethereal:sandy"},
	neighbors = {"group:water"},
	interval = 15,
	chance = 10,
	catch_up = false,
	action = function(pos, node)

		local sel = math.random(6)

		pos.y = pos.y + 1

		local nod = minetest.get_node(pos).name

		if nod == "default:water_source"
		and sel == 6 then

			minetest.swap_node(pos, {name = "ethereal:sponge_wet"})

			return
		end

		if nod == "default:water_source"
		and sel > 1 then

			minetest.swap_node(pos, {name = "ethereal:coral" .. sel})

			return
		end

		if nod == "ethereal:seaweed"
		or sel == 1 then

			local height = 0
			local high = 14

			while height < high
			and minetest.get_node(pos).name == "ethereal:seaweed" do
				height = height + 1
				pos.y = pos.y + 1
			end

			if pos.y < 1
			and height < high
			and minetest.get_node(pos).name == "default:water_source" then

				minetest.swap_node(pos, {name = "ethereal:seaweed"})
			end
		end
	end
})
]]--
