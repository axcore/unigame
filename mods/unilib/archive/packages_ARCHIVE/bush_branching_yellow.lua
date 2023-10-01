---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/bushes
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local BushBranchCenter			= { {1,1}, {3,2} }
for i in pairs(BushBranchCenter) do
	local Num		= BushBranchCenter[i][1]
	local TexNum	= BushBranchCenter[i][2]
	minetest.register_node("bushes:bushbranches"..Num, {
		description = S("Bush Branches @1", Num),
		drawtype = "nodebox",
		tiles = {
			"bushes_leaves_"..TexNum..".png",
			"bushes_branches_center_"..TexNum..".png"
		},
		node_box = {
			type = "fixed",
			fixed = {
				{0, -1/2, -1/2, -1/4, 1/2, 1/2},
				{0, -1/2, -1/2, 1/4, 1/2, 1/2}
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {-1/2, -1/2, -1/2, 1/2, 1/2, 1/2},
		},
		inventory_image = "bushes_branches_center_"..TexNum..".png",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = {
		--	tree=1, -- MM: disabled because some recipes use group:tree for trunks
			snappy=3,
			flammable=2,
			leaves=1,
			attached_node=1
		},
		sounds = default.node_sound_leaves_defaults(),
		drop = 'default:stick 4'
	})
end

local BushBranchSide			= { {2,1}, {4,2} }
for i in pairs(BushBranchSide) do
	local Num		= BushBranchSide[i][1]
	local TexNum	= BushBranchSide[i][2]
	minetest.register_node("bushes:bushbranches"..Num, {
		description = S("Bush Branches @1", Num),
		drawtype = "nodebox",
		tiles = {
            "bushes_leaves_"..TexNum..".png",
            "bushes_branches_center_"..TexNum..".png",
           	"bushes_branches_left_"..TexNum..".png",
          	"bushes_branches_right_"..TexNum..".png", -- MM: We could also mirror the previous here,
          	"bushes_branches_center_"..TexNum..".png",--		 unless U really want 'em 2 B different
           	"bushes_branches_right_"..TexNum..".png"
		},
		node_box = {
			type = "fixed",
			fixed = {
--				{ left	 , bottom	, front, right	 , top		 , back		}
				{0.137748,-0.491944, 0.5	,-0.125000,-0.179444,-0.007790}, --NodeBox 1
				{0.262748,-0.185995, 0.5	,-0.237252, 0.126505,-0.260269}, --NodeBox 2
				{0.500000, 0.125000, 0.5	,-0.500000, 0.500000,-0.500000}, --NodeBox 3
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {-1/2, -1/2, -1/2, 1/2, 1/2, 1/2},
		},
		inventory_image = "bushes_branches_right_"..TexNum..".png",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		groups = {
		--	tree=1, -- MM: disabled because some recipes use group:tree for trunks
			snappy=3,
			flammable=2,
			leaves=1,
			attached_node=1
		},
		sounds = default.node_sound_leaves_defaults(),
		drop = 'default:stick 3'
	})
end

local BushLeafNode			= { {1}, {2}}
for i in pairs(BushLeafNode) do
	local Num = BushLeafNode[i][1]
	minetest.register_node("bushes:BushLeaves"..Num, {
		description = S("Bush Leaves @1", Num),
		drawtype = "allfaces_optional",
		tiles = {"bushes_leaves_"..Num..".png"},
		paramtype = "light",
		groups = {	-- MM: Should we add leafdecay?
			snappy=3,
			flammable=2,
			attached_node=1
		},
		sounds = default.node_sound_leaves_defaults(),
	})
end

biome_lib.register_on_generate({
		surface = {
			"default:dirt_with_grass",
			"stoneage:grass_with_silex",
			"sumpf:peat",
			"sumpf:sumpf"
		},
		rarity = bushes_youngtrees_rarity,
		rarity_fertility = bushes_youngtrees_rarity_fertility,
		plantlife_limit = bushes_youngtrees_fertility,
		min_elevation = 1, -- above sea level
	},
	abstract_bushes.grow_youngtree2
)
]]--
