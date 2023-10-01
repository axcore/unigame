---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- let's hope "tub" is the correct english word for "bottich"
minetest.register_node("cottages:tub", {
        description = S("tub"),
        paramtype = "light",
        drawtype = "mesh",
				mesh = "cottages_tub.obj",
        tiles = {"cottages_barrel.png" },
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5,-0.1, 0.5},
			}},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5,-0.1, 0.5},
			}},
        groups = { tree = 1, snappy = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2
        },
		is_ground_content = false,
})
]]--
