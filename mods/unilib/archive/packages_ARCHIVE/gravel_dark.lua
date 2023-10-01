---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decoblocks
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("default:gravel", {
	description = "Gravel",
	tiles = {"default_gravel.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get flint with 1/15 chance
				items = {'default:flint'},
				rarity = 15,
			},
			{
				-- player will get plain old gravel otherwise
				items = {'default:gravel'},
			}
		}
	},
    sounds = {
		footstep = {name="default_gravelstep"},
		dig = {name="default_dirttool"},
		place = {name="default_stoneplace"},
    },
})
]]--
