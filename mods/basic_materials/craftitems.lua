local S = minetest.get_translator("basic_materials")

if minetest.get_modpath("hades_materials") then
	minetest.register_alias_force("basic_materials:plastic_sheet", "hades_materials:plastic_sheeting")
	minetest.register_alias_force("basic_materials:paraffin", "hades_materials:plastic_base")
	minetest.register_alias_force("basic_materials:silicon", "hades_materials:silicon")
end

