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
-- loop through active abm's
for _, ab in pairs(minetest.registered_abms) do

	local label = ab.label or ""
	local node1 = ab.nodenames and ab.nodenames[1] or ""
	local node2 = ab.nodenames and ab.nodenames[2] or ""
	local neigh = ab.neighbors and ab.neighbors[1] or ""

	if label == "Flower spread"
	or node1 == "group:flora" then

		--ab.interval = 1
		ab.chance = 96 -- back to original chance from 300
		ab.nodenames = {"group:flora"}
		ab.neighbors = {"group:soil"}
		ab.action = flower_spread

	-- find grow papyrus abm and change to grow_papyrus function
	elseif label == "Grow papyrus"
	or node1 == "default:papyrus" then

		--ab.interval = 2
		--ab.chance = 1
		ab.nodenames = {"default:papyrus", "ethereal:bamboo"}
		ab.neighbors = {"group:soil"}
		ab.action = grow_papyrus

	elseif label == "Mushroom spread" then

		--ab.interval = 1
		ab.chance = 50 -- back to original chance from 150
		ab.nodenames = {"group:mushroom"}
	end
end
]]--
