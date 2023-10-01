---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- Added to change dirt_with_snow to dirt if covered with blocks that don't let
-- light through (sunlight_propagates) or have a light paramtype and
-- liquidtype combination. ~ LazyJ, 2014_03_08

minetest.register_abm({
	nodenames = {"default:dirt_with_snow"},
	interval = 2,
	chance = 20,
	action = function(pos)
		local name = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name
		local nodedef = minetest.registered_nodes[name]
		if name ~= "ignore"
		and nodedef
		and not (
			(nodedef.sunlight_propagates or nodedef.paramtype == "light")
			and nodedef.liquidtype == "none"
		) then
			minetest.set_node(pos, {name = "default:dirt"})
		end
	end
})
]]--
