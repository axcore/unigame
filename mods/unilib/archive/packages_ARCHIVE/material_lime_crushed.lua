---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
--
-- From:    plaster
-- Code:    CC BY-SA 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[

(from aotearoa mod)

minetest.register_craftitem("aotearoa:crushed_lime", {
	description = "Crushed Lime",
	inventory_image = "aotearoa_crushed_lime.png",
})
minetest.register_craft({
	output = "aotearoa:crushed_lime",
  recipe = {
		{'default:steel_ingot'},
    {'aotearoa:limestone'},
    {'default:steel_ingot'},
  },
  replacements = {
		{"default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot"}
	}
})
minetest.register_craft({
	output = "aotearoa:crushed_lime",
	recipe = {
		{'default:steel_ingot'},
    {'aotearoa:coquina_limestone'},
    {'default:steel_ingot'},
  },
  replacements = {
		{"default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot"}
	}
})
]]--

--[[

(from plaster mod)

minetest.register_node("plaster:lime", {
	description = "Lime",
	inventory_image = "plaster_lime.png",
})
minetest.register_craft({
	type = "shapeless",
	output = "plaster:lime 6",
	recipe = {"default:coral_skeleton"},
})
]]--
