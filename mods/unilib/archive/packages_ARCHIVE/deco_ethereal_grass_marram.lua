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
if minetest.registered_nodes["default:marram_grass_1"] then

	add_node({"default:sand"}, 0.25, {"sandclay"}, 3, 4, {"default:marram_grass_1",
		"default:marram_grass_2", "default:marram_grass_3"}, nil, nil, nil,
		ethereal.sandclay)
else
	add_node({"default:sand"}, 0.25, {"sandclay"}, 3, 4, {"default:grass_2",
		"default:grass_3"}, nil, nil, nil, ethereal.sandclay)
end
]]--
