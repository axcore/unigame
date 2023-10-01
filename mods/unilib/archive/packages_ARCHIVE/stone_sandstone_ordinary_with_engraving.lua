---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tsm_pyramids
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local img = {
	"eye", "men", "sun",
	"ankh", "scarab", "cactus"
}
local desc = {
	S("Sandstone with Eye Engraving"), S("Sandstone with Man Engraving"), S("Sandstone with Sun Engraving"),
	S("Desert Sandstone with Ankh Engraving"), S("Desert Sandstone with Scarab Engraving"), S("Desert Sandstone with Cactus Engraving")
}

local decodesc = ""
if minetest.get_modpath("doc_items") then
	decodesc = doc.sub.items.temp.deco
end

for i=1, #img do
	local sandstone_img, basenode
	if i > 3 then
		sandstone_img = "default_desert_sandstone.png"
		basenode = "default:desert_sandstone"
	else
		sandstone_img = "default_sandstone.png"
		basenode = "default:sandstone"
	end
	minetest.register_node("tsm_pyramids:deco_stone"..i, {
		description = desc[i],
		_doc_items_longdesc = decodesc,
		is_ground_content = false,
		tiles = {sandstone_img, sandstone_img, sandstone_img.."^tsm_pyramids_"..img[i]..".png"},
		groups = minetest.registered_nodes[basenode].groups,
		sounds = minetest.registered_nodes[basenode].sounds,
	})
end
]]--
