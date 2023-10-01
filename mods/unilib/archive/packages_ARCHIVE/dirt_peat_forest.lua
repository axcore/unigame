---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
aotearoa.peatlist = {
	{"forest_peat", "Forest Peat"}
}

for i in ipairs(aotearoa.peatlist) do
	local dirtname = aotearoa.peatlist[i][1]
	local dirtdesc = aotearoa.peatlist[i][2]

        minetest.register_node("aotearoa:"..dirtname, {
            description = dirtdesc,
            tiles = {
                "aotearoa_"..dirtname..".png",
                "aotearoa_peat.png",
                {name ="aotearoa_peat.png^aotearoa_"..dirtname.."_side.png",
                tileable_vertical = false}
            },
            groups = {crumbly = 3},
            drop = {
                max_items = 1,
                items = {
                    {items = {"default:iron_lump"}, rarity = 1000 },
                    {items = {"aotearoa:peat"} }
                }
            },
            sounds = default.node_sound_dirt_defaults({
                footstep = {name = "aotearoa_mud", gain = 0.4},
                dug = {name = "aotearoa_mud", gain = 0.4},
            }),
        })

end
]]--
