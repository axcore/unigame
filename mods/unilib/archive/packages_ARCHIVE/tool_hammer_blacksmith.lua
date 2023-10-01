---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    anvil
-- Code:    GPL-3.0-only
-- Media:   GPL-3.0-only
--
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_tool("cottages:hammer", {
        description = S("Steel hammer for repairing tools on the anvil"),
        image           = "glooptest_tool_steelhammer.png",
        inventory_image = "glooptest_tool_steelhammer.png",

        tool_capabilities = {
                full_punch_interval = 0.8,
                max_drop_level=1,
                groupcaps={
			-- about equal to a stone pick (it's not intended as a tool)
                        cracky={times={[2]=2.00, [3]=1.20}, uses=30, maxlevel=1},
                },
                damage_groups = {fleshy=6},
        }
})

minetest.register_craft({
	output = "cottages:hammer",
	recipe = {
                {cottages.craftitem_steel},
                {'cottages:anvil'},
                {cottages.craftitem_stick} }
})
]]--
