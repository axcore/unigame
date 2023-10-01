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
register_sapling("ethereal:big_tree", "Big", "ethereal_big_tree_sapling", 7)

function ethereal.grow_big_tree(pos)
	add_tree(pos, 4, 0, 4, ethereal.bigtree)
end

minetest.register_craft({
	recipe = {{"default:sapling", "default:sapling",  "default:sapling"}},
	output = "ethereal:big_tree_sapling"
})

add_schem({"default:dirt_with_grass"}, 0.001, {"jumble"}, 1, 100,
	ethereal.bigtree, ethereal.jumble, nil,
	"default:dirt_with_grass", 8)
]]--
