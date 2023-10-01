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
cottages.register_roof( 'straw',
		{cottages.straw_texture, cottages.straw_texture,
		 cottages.straw_texture, cottages.straw_texture,
		 cottages.straw_texture, cottages.straw_texture},
		'cottages:straw_mat', nil );
cottages.register_roof( 'reet',
		{"cottages_reet.png","cottages_reet.png",
		"cottages_reet.png","cottages_reet.png",
		"cottages_reet.png","cottages_reet.png"},
		cottages.craftitem_papyrus, nil );
cottages.register_roof( 'wood',
		{cottages.textures_roof_wood, cottages.texture_roof_sides,
		cottages.texture_roof_sides,  cottages.texture_roof_sides,
		cottages.texture_roof_sides,  cottages.textures_roof_wood},
		cottages.craftitem_wood, nil);
cottages.register_roof( 'black',
		{"cottages_homedecor_shingles_asphalt.png", cottages.texture_roof_sides,
		cottages.texture_roof_sides, cottages.texture_roof_sides,
		cottages.texture_roof_sides, "cottages_homedecor_shingles_asphalt.png"},
		'homedecor:shingles_asphalt', cottages.craftitem_coal_lump);
cottages.register_roof( 'red',
		{"cottages_homedecor_shingles_terracotta.png", cottages.texture_roof_sides,
		cottages.texture_roof_sides, cottages.texture_roof_sides,
		cottages.texture_roof_sides, "cottages_homedecor_shingles_terracotta.png"},
		'homedecor:shingles_terracotta', cottages.craftitem_clay_brick);
cottages.register_roof( 'brown',
		{"cottages_homedecor_shingles_wood.png", cottages.texture_roof_sides,
		cottages.texture_roof_sides, cottages.texture_roof_sides,
		cottages.texture_roof_sides, "cottages_homedecor_shingles_wood.png"},
		'homedecor:shingles_wood', cottages.craftitem_dirt);
cottages.register_roof( 'slate',
		{"cottages_slate.png", cottages.texture_roof_sides,
		"cottages_slate.png", "cottages_slate.png",
		cottages.texture_roof_sides,"cottages_slate.png"},
		cottages.craftitem_stone, nil);
]]--
