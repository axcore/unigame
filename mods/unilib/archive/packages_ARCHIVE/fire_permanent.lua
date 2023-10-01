---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fire
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
function underch.functions.make_permanent_fire(pos, igniter)
	local flame_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
	if minetest.get_node(flame_pos).name == "air" then
		minetest.set_node(flame_pos, {name = "fire:permanent_flame"})
	end
end

function underch.functions.remove_permanent_fire(pos, oldnode)
	pos.y = pos.y + 1
	if minetest.get_node(pos).name == "fire:permanent_flame" then
		minetest.remove_node(pos)
	end
end

-- Permanent flame node
local permanent_fire_node = table.copy(fire_node)
permanent_fire_node.description = S("Permanent Fire")

minetest.register_node("fire:permanent_flame", permanent_fire_node)
]]--
