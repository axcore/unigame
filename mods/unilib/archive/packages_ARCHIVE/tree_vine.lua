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
add_schem({"default:dirt_with_grass"}, 0.02, {"swamp"}, 1, 100,
	ethereal.vinetree, ethereal.swamp)
    
-- compatibility check for new mt version with leafdecay function
if minetest.registered_nodes["default:dirt_with_rainforest_litter"] then

    default.register_leafdecay({
        trunks = {"default:tree"},
        leaves = {
            "ethereal:vine"
        },
        radius = 3
    })

end
]]--
