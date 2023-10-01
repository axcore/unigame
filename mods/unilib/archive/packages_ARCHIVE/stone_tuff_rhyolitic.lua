---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("darkage:rhyolitic_tuff", {
	description = "Rhyolitic Tuff",
	tiles = {"darkage_rhyolitic_tuff.png"},
	is_ground_content = true,
	legacy_mineral = true,
	groups = {cracky = 3, stone = 1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player get tuff node if he is lucky :)
				items = {'darkage:rhyolitic_tuff'},
				rarity = 3,
			},
			{
				-- player will get rubble with 2/3 chance
				items = {'darkage:rhyolitic_tuff_rubble'},
			}

		}
	},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	type = "cooking",
	output = "darkage:rhyolitic_tuff",
	recipe = "darkage:rhyolitic_tuff_rubble",
})
minetest.register_craft({
	output = "darkage:rhyolitic_tuff 2",
	recipe = {
		{"darkage:gneiss", "default:desert_stone"},
		{"default:desert_stone", "darkage:gneiss"},
	}
})

minetest.register_node("darkage:rhyolitic_tuff_bricks", {
	description = "Rhyolitic Tuff Bricks",
	tiles = {"darkage_rhyolitic_tuff_bricks.png"},
	is_ground_content = false,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	output = "darkage:rhyolitic_tuff_bricks 4",
	recipe = {
		{"darkage:rhyolitic_tuff", "darkage:rhyolitic_tuff"},
		{"darkage:rhyolitic_tuff", "darkage:rhyolitic_tuff"},
	}
})

minetest.register_node("darkage:rhyolitic_tuff_rubble", {
	description = "Rhyolitic Tuff Rubble",
	tiles = {"darkage_rhyolitic_tuff_rubble.png"},
	groups = {crumbly = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),
})
]]--
