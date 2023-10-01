---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fire
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- Basic flame node
local flame_fire_node = table.copy(fire_node)
flame_fire_node.description = S("Fire")
flame_fire_node.groups.not_in_creative_inventory = 1
flame_fire_node.on_timer = function(pos)
	if not minetest.find_node_near(pos, 1, {"group:flammable"}) then
		minetest.remove_node(pos)
		return
	end
	-- Restart timer
	return true
end
flame_fire_node.on_construct = function(pos)
	minetest.get_node_timer(pos):start(math.random(30, 60))
end

minetest.register_node("fire:basic_flame", flame_fire_node)
]]--
