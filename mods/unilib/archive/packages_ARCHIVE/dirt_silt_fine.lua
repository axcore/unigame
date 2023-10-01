---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- Idem for silty dirt that contains silt without beeing pure silt
register_dirts("Silty")

local function register_dirts(readname)
	local name = readname:lower()
	local itemstr_dirt = "valleys_c:dirt_" .. name
    
	minetest.register_node(itemstr_dirt, {
		description = readname .. " Dirt",
		tiles = {tilestr},
		is_ground_content = true,
		groups = {crumbly=3,soil=1},
		sounds = default.node_sound_dirt_defaults(),
	})

end
]]--
