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
minetest.register_craftitem("aotearoa:kauri_gum", {
	description = "Kauri Gum",
	inventory_image = "aotearoa_kauri_gum.png",
})
minetest.register_craft({
	type = "fuel",
	recipe = "aotearoa:kauri_gum",
	burntime = 3,
})
minetest.register_craft({
	output = 'default:torch 4',
	recipe = {
		{'aotearoa:kauri_gum'},
		{'group:stick'},
	}
})
minetest.register_craft({
	output = "dye:black 4",
  recipe = {
    {'aotearoa:kauri_gum'},
    {'default:torch'},
  },
  replacements = {{"default:torch", "default:torch"}}
})
]]--
