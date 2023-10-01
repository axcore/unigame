---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    maptools
-- Code:    zlib
-- Media:   zlib
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
maptools.drop_msg = function(itemstack, player)
	local name = player:get_player_name()
	minetest.chat_send_player(name, S("[maptools] tools/nodes do not drop!"))
end

function maptools.register_node(name, def)
	-- Increase the interaction range when holding Map Tools nodes to make building easier.
	def.range = 12
	def.stack_max = 65535
	def.drop = ""
	if def.groups then
		if not def.groups.dig_immediate then
			def.groups.unbreakable = 1
		end
		def.groups.not_in_creative_inventory = maptools.creative
	else
		def.groups = {unbreakable = 1, not_in_creative_inventory = maptools.creative}
	end
	def.on_drop = maptools.drop_msg
	-- Prevent Map Tools nodes from being exploded by TNT.
	def.on_blast = function() end
	minetest.register_node(name, def)
end
]]--
