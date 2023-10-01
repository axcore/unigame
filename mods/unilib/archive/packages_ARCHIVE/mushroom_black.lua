---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
function underch.mushrooms.register_mushroom(id, name, texture, heal, box)
	minetest.register_node(id, {
		description = name,
		tiles = {texture},
		inventory_image = texture,
		wield_image = texture,
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, attached_node = 1, flammable = 1},
		sounds = default.node_sound_leaves_defaults(),
		on_use = minetest.item_eat(heal),
		selection_box = {
			type = "fixed",
			fixed = box,
		}
	})
end

underch.mushrooms.register_mushroom("underch:black_mushroom", "Black Mushroom", "underch_black_mushroom.png", 0, {-4 / 16, -0.5, -4 / 16, 4 / 16, 1 / 16, 4 / 16});
]]--
