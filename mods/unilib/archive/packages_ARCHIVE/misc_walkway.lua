---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    factory_bridges
-- Code:    LGPL-2.1
-- Media:   LGPL-2.1
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

-- N.B. Models omitted for brevity

--[[
minetest.register_node(FB.NAME..":a01", {
	description = FB.LOCAL("a01"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.A01},
})
minetest.register_craft({output = FB.NAME..":a01",
	recipe ={
		{	"",			FB.NAME..":i01",	"",			},
		{	"",			FB.NAME..":i00",	"",			},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":a02", {
	description = FB.LOCAL("a02"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.A02},
})
minetest.register_craft({output = FB.NAME..":a02",
	recipe ={
		{	FB.NAME..":a01",	"",			FB.NAME..":a01",	},
		{	"",			"",			"",			},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":a03", {
	description = FB.LOCAL("a03"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.A03},
})
minetest.register_craft({output = FB.NAME..":a03",
	recipe ={
		{	FB.NAME..":a01",	"",			FB.NAME..":a01",	},
		{	"",			"",			"",			},
		{	"",			"",			FB.NAME..":a01",	},
	},
})

minetest.register_node(FB.NAME..":a04", {
	description = FB.LOCAL("a04"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.A04},
})
minetest.register_craft({output = FB.NAME..":a04",
	recipe ={
		{	FB.NAME..":a01",	"",			FB.NAME..":a01",	},
		{	"",			"",			"",			},
		{	FB.NAME..":a01",	"",			FB.NAME..":a01",	},
	},
})

minetest.register_node(FB.NAME..":a05", {
	description = FB.LOCAL("a05"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.A05},
})
minetest.register_craft({output = FB.NAME..":a05",
	recipe ={
		{	"",			FB.NAME..":i02",	"",			},
		{	FB.NAME..":i00",	"",			FB.NAME..":i00",	},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":a05dia", {
	description = FB.LOCAL("a05dia"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.A05DIA},
})
minetest.register_craft({output = FB.NAME..":a05dia",
	recipe ={
		{	FB.NAME..":a05",	"",					"",			},
		{	"",					FB.NAME..":a05",	"",	},
		{	"",					"",					FB.NAME..":a05",			},
	},
})

minetest.register_node(FB.NAME..":a06", {
	description = FB.LOCAL("a06"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.A06},
})
minetest.register_craft({output = FB.NAME..":a06",
	recipe ={
		{	"",			FB.NAME..":a05",	"",			},
		{	"",			"",			"",			},
		{	"",			"",			FB.NAME..":a01",	},
	},
})

minetest.register_node(FB.NAME..":a07", {
	description = FB.LOCAL("a07"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.A07},
})
minetest.register_craft({output = FB.NAME..":a07",
	recipe ={
		{	"",			FB.NAME..":a05",	"",			},
		{	"",			"",			"",			},
		{	FB.NAME..":a01",	"",			"",			},
	},
})

minetest.register_node(FB.NAME..":a08", {
	description = FB.LOCAL("a08"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.A08},
})
minetest.register_craft({output = FB.NAME..":a08",
	recipe ={
		{	"",			FB.NAME..":a05",	"",			},
		{	"",			"",			"",			},
		{	FB.NAME..":a01",	"",			FB.NAME..":a01",	},
	},
})

minetest.register_node(FB.NAME..":a09", {
	description = FB.LOCAL("a09"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.A09},
})
minetest.register_craft({output = FB.NAME..":a09",
	recipe ={
		{	"",			FB.NAME..":a05",	"",			},
		{	FB.NAME..":a05",	"",			"",			},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":a10", {
	description = "Steel railing",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.A10},
})
minetest.register_craft({output = FB.NAME..":a10",
	recipe ={
		{	"",			FB.NAME..":a05",	"",			},
		{	FB.NAME..":a05",	"",			"",			},
		{	"",			"",			FB.NAME..":a01",	},
	},
})

minetest.register_node(FB.NAME..":a11", {
	description = FB.LOCAL("a11"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.A11},
})
minetest.register_craft({output = FB.NAME..":a11",
	recipe ={
		{	"",			"",			"",			},
		{	FB.NAME..":a05",	"",			FB.NAME..":a05",	},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":a12", {
	description = FB.LOCAL("a12"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.A12},
})
minetest.register_craft({output = FB.NAME..":a12",
	recipe ={
		{	"",			FB.NAME..":a05",	"",			},
		{	FB.NAME..":a05",	"",			FB.NAME..":a05",	},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":a13", {
	description = FB.LOCAL("a13"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.A13},
})
minetest.register_craft({output = FB.NAME..":a13",
	recipe ={
		{	"",			FB.NAME..":i02",	FB.NAME..":i00",	},
		{	"",			FB.NAME..":i00",	"",			},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":a14", {
	description = FB.LOCAL("a14"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.A14},
})
minetest.register_craft({output = FB.NAME..":a14",
	recipe ={
		{	FB.NAME..":i00",	FB.NAME..":i02",	"",			},
		{	"",			FB.NAME..":i00",	"",			},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":a15", {
	description = FB.LOCAL("a15"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.A15},
})
minetest.register_craft({output = FB.NAME..":a15",
	recipe ={
		{	"",			"",			"",			},
		{	FB.NAME..":a13",	"",			FB.NAME..":a14",	},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":s00", {
	description = FB.LOCAL("s00"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	climbable = true,
	groups = {cracky = 2},
	tiles = {FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.S00},
})
minetest.register_craft({output = FB.NAME..":s00",
	recipe ={
		{	"",			FB.NAME..":i00",	"",			},
		{	FB.NAME..":i02",	"",			FB.NAME..":i02",	},
		{	"",			FB.NAME..":i00",	"",			},
	},
})

minetest.register_node(FB.NAME..":s01", {
	description = FB.LOCAL("s01"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	climbable = true,
	groups = {cracky = 2},
	tiles = {FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.S01},
})
minetest.register_craft({output = FB.NAME..":s01",
	recipe ={
		{	FB.NAME..":i02",	FB.NAME..":i02",	FB.NAME..":i02",	},
		{	FB.NAME..":i02",	FB.NAME..":s00",	FB.NAME..":i02",	},
		{	FB.NAME..":i02",	FB.NAME..":i02",	FB.NAME..":i02",	},
	},
})

minetest.register_node(FB.NAME..":s02", {
	description = FB.LOCAL("s02"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.S02},
})
minetest.register_craft({output = FB.NAME..":s02",
	recipe ={
		{	FB.NAME..":i02",	FB.NAME..":i02",	FB.NAME..":i02",	},
		{	FB.NAME..":i02",	"",			FB.NAME..":i02",	},
		{	FB.NAME..":i02",	FB.NAME..":i02",	FB.NAME..":i02",	},
	},
})

minetest.register_node(FB.NAME..":s03", {
	description = FB.LOCAL("s03"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	climbable = true,
	groups = {cracky = 2},
	tiles = {FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.S03},
})
minetest.register_craft({output = FB.NAME..":s03",
	recipe ={
		{	FB.NAME..":i02",	"",			"",			},
		{	FB.NAME..":i02",	FB.NAME..":s00",	"",			},
		{	FB.NAME..":i02",	FB.NAME..":i02",	"",			},
	},
})

minetest.register_node(FB.NAME..":s04", {
	description = FB.LOCAL("s04"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	climbable = true,
	groups = {cracky = 2},
	tiles = {FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.S04},
})
minetest.register_craft({output = FB.NAME..":s04",
	recipe ={
		{	"",			"",			FB.NAME..":i02",	},
		{	"",			FB.NAME..":s00",	FB.NAME..":i02",	},
		{	"",			FB.NAME..":i02",	FB.NAME..":i02",	},
	},
})

minetest.register_node(FB.NAME..":s05", {
	description = FB.LOCAL("s05"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	climbable = true,
	groups = {cracky = 2},
	tiles = {FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.S05},
})
minetest.register_craft({output = FB.NAME..":s05",
	recipe ={
		{	"",			"",			"",			},
		{	"",			FB.NAME..":s00",	"",			},
		{	FB.NAME..":i02",	"",			FB.NAME..":i02",	},
	},
})

minetest.register_node(FB.NAME..":b00", {
	description = FB.LOCAL("b00"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_01.png", FB.NAME.."_01.png", FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.B00},
})
minetest.register_craft({output = FB.NAME..":b00 10",
	recipe ={
		{	"default:steel_ingot",	"default:steel_ingot",	"default:steel_ingot",	},
	},
})

minetest.register_node(FB.NAME..":b01", {
	description = FB.LOCAL("b01"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_01.png", FB.NAME.."_01.png", FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.B01},
})
minetest.register_craft({output = FB.NAME..":b01",
	recipe ={
		{	FB.NAME..":a01",	"",			"",			},
		{	"",			FB.NAME..":b00",	"",			},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":b02", {
	description = FB.LOCAL("b02"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_01.png", FB.NAME.."_01.png", FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.B02},
})
minetest.register_craft({output = FB.NAME..":b02",
	recipe ={
		{	FB.NAME..":a01",	"",			FB.NAME..":a01",	},
		{	"",			FB.NAME..":b00",	"",			},
		{	"",			"",			"",			},
	},
})
minetest.register_craft({output = FB.NAME..":b02",
	recipe ={
		{	"",			FB.NAME..":a02",	"",			},
		{	"",			FB.NAME..":b00",	"",			},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":b03", {
	description = FB.LOCAL("b03"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_01.png", FB.NAME.."_01.png", FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.B03},
})
minetest.register_craft({output = FB.NAME..":b03",
	recipe ={
		{	FB.NAME..":a01",	"",			FB.NAME..":a01",	},
		{	"",			FB.NAME..":b00",	"",			},
		{	"",			"",			FB.NAME..":a01",	},
	},
})
minetest.register_craft({output = FB.NAME..":b03",
	recipe ={
		{	"",			FB.NAME..":a03",	"",			},
		{	"",			FB.NAME..":b00",	"",			},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":b04", {
	description = FB.LOCAL("b04"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_01.png", FB.NAME.."_01.png", FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.B04},
})
minetest.register_craft({output = FB.NAME..":b04",
	recipe ={
		{	FB.NAME..":a01",	"",			FB.NAME..":a01",	},
		{	"",			FB.NAME..":b00",	"",			},
		{	FB.NAME..":a01",	"",			FB.NAME..":a01",	},
	},
})
minetest.register_craft({output = FB.NAME..":b04",
	recipe ={
		{	"",			FB.NAME..":a04",	"",			},
		{	"",			FB.NAME..":b00",	"",			},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":b05", {
	description = FB.LOCAL("b05"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_01.png", FB.NAME.."_01.png", FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.B05},
})
minetest.register_craft({output = FB.NAME..":b05",
	recipe ={
		{	"",			FB.NAME..":a05",	"",			},
		{	"",			FB.NAME..":b00",	"",			},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":b06", {
	description = FB.LOCAL("b06"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_01.png", FB.NAME.."_01.png", FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.B06},
})
minetest.register_craft({output = FB.NAME..":b06",
	recipe ={
		{	"",			FB.NAME..":a05",	"",			},
		{	"",			FB.NAME..":b00",	"",			},
		{	"",			"",			FB.NAME..":a01",	},
	},
})
minetest.register_craft({output = FB.NAME..":b06",
	recipe ={
		{	"",			FB.NAME..":a06",	"",			},
		{	"",			FB.NAME..":b00",	"",			},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":b07", {
	description = FB.LOCAL("b07"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_01.png", FB.NAME.."_01.png", FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.B07},
})
minetest.register_craft({output = FB.NAME..":b07",
	recipe ={
		{	"",			FB.NAME..":a05",	"",			},
		{	"",			FB.NAME..":b00",	"",			},
		{	FB.NAME..":a01",	"",			"",			},
	},
})
minetest.register_craft({output = FB.NAME..":b07",
	recipe ={
		{	"",			FB.NAME..":a07",	"",			},
		{	"",			FB.NAME..":b00",	"",			},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":b08", {
	description = FB.LOCAL("b08"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_01.png", FB.NAME.."_01.png", FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.B08},
})
minetest.register_craft({output = FB.NAME..":b08",
	recipe ={
		{	"",			FB.NAME..":a05",	"",			},
		{	"",			FB.NAME..":b00",	"",			},
		{	FB.NAME..":a01",	"",			FB.NAME..":a01",	},
	},
})
minetest.register_craft({output = FB.NAME..":b08",
	recipe ={
		{	"",			FB.NAME..":a08",	"",			},
		{	"",			FB.NAME..":b00",	"",			},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":b09", {
	description = FB.LOCAL("b09"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_01.png", FB.NAME.."_01.png", FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.B09},
})
minetest.register_craft({output = FB.NAME..":b09",
	recipe ={
		{	"",			FB.NAME..":a05",	"",			},
		{	FB.NAME..":a05",	FB.NAME..":b00",	"",			},
		{	"",			"",			"",			},
	},
})
minetest.register_craft({output = FB.NAME..":b09",
	recipe ={
		{	"",			FB.NAME..":a09",	"",			},
		{	"",			FB.NAME..":b00",	"",			},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":b10", {
	description = FB.LOCAL("b10"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_01.png", FB.NAME.."_01.png", FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.B10},
})
minetest.register_craft({output = FB.NAME..":b10",
	recipe ={
		{	"",			FB.NAME..":a05",	"",			},
		{	FB.NAME..":a05",	FB.NAME..":b00",	"",			},
		{	"",			"",			FB.NAME..":a01",	},
	},
})
minetest.register_craft({output = FB.NAME..":b10",
	recipe ={
		{	"",			FB.NAME..":a10",	"",			},
		{	"",			FB.NAME..":b00",	"",			},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":b11", {
	description = FB.LOCAL("b11"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_01.png", FB.NAME.."_01.png", FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.B11},
})
minetest.register_craft({output = FB.NAME..":b11",
	recipe ={
		{	"",			"",			"",			},
		{	FB.NAME..":a05",	FB.NAME..":b00",	FB.NAME..":a05",	},
		{	"",			"",			"",			},
	},
})
minetest.register_craft({output = FB.NAME..":b11",
	recipe ={
		{	"",			FB.NAME..":a11",	"",			},
		{	"",			FB.NAME..":b00",	"",			},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":b12", {
	description = FB.LOCAL("b12"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_01.png", FB.NAME.."_01.png", FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.B12},
})
minetest.register_craft({output = FB.NAME..":b12",
	recipe ={
		{	"",			FB.NAME..":a05",	"",			},
		{	FB.NAME..":a05",	FB.NAME..":b00",	FB.NAME..":a05",	},
		{	"",			"",			"",			},
	},
})
minetest.register_craft({output = FB.NAME..":b12",
	recipe ={
		{	"",			FB.NAME..":a12",	"",			},
		{	"",			FB.NAME..":b00",	"",			},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":c00", {
	description = FB.LOCAL("c00"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_02.png", FB.NAME.."_02.png", FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.C00},
})
minetest.register_craft({output = FB.NAME..":c00 2",
	recipe ={
		{	FB.NAME..":i02",	FB.NAME..":b00",	"",			},
		{	FB.NAME..":b00",	FB.NAME..":i02",	"",			},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":c01", {
	description = FB.LOCAL("c01"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_02.png", FB.NAME.."_02.png", FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.C01},
})
minetest.register_craft({output = FB.NAME..":c01",
	recipe ={
		{	"",			"",			"",			},
		{	FB.NAME..":a13",	FB.NAME..":c00",	"",			},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":c02", {
	description = FB.LOCAL("c02"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_02.png", FB.NAME.."_02.png", FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.C02},
})
minetest.register_craft({output = FB.NAME..":c02",
	recipe ={
		{	"",			"",			"",			},
		{	"",			FB.NAME..":c00",	FB.NAME..":a14",	},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":c03", {
	description = FB.LOCAL("c03"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_02.png", FB.NAME.."_02.png", FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.C03},
})
minetest.register_craft({output = FB.NAME..":c03",
	recipe ={
		{	"",			"",			"",			},
		{	FB.NAME..":a13",	FB.NAME..":c00",	FB.NAME..":a14",	},
		{	"",			"",			"",			},
	},
})
minetest.register_craft({output = FB.NAME..":c03",
	recipe ={
		{	"",			FB.NAME..":a15",	"",			},
		{	"",			FB.NAME..":c00",	"",			},
		{	"",			"",			"",			},
	},
})

minetest.register_node(FB.NAME..":d00", {
	description = FB.LOCAL("d00"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	tiles = {FB.NAME.."_03.png", FB.NAME.."_03.png", FB.NAME.."_00.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.D00},
	on_rightclick = function(pos, node)
		minetest.set_node(pos, {name=FB.NAME..":d01", param2=node.param2})
	end,
})
minetest.register_craft({output = FB.NAME..":d00",
	recipe ={
		{	"",			FB.NAME..":i02",	"",			},
		{	FB.NAME..":i02",	FB.NAME..":b00",	FB.NAME..":i02",	},
		{	"",			FB.NAME..":i02",	"",			},
	},
})

minetest.register_node(FB.NAME..":d01", {
	description = FB.LOCAL("d01"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2, not_in_creative_inventory = 1},
	tiles = {FB.NAME.."_03.png"},
	node_box = {type = "fixed", fixed = FB.MODELS.D01},
	on_rightclick = function(pos, node)
		minetest.set_node(pos, {name=FB.NAME..":d00", param2=node.param2})
	end,
	drop = FB.NAME..":d00",
})

minetest.register_craftitem(FB.NAME..":i00", {
	description = FB.LOCAL("i00"),
	inventory_image = FB.NAME.."_i00.png",
	stack_max = 200,
})
minetest.register_craft({output = FB.NAME..":i00 200",
	recipe ={
		{	"",			"",			"default:steel_ingot",	},
		{	"",			"",	"",			},
		{	"default:steel_ingot",	"",			"",			},
	},
})

minetest.register_craftitem(FB.NAME..":i01", {
	description = FB.LOCAL("i01"),
	inventory_image = FB.NAME.."_i01.png",
	stack_max = 350,
})
minetest.register_craft({output = FB.NAME..":i01 350",
	recipe ={
		{	"default:steel_ingot",	"default:steel_ingot", "default:stick",			},
	},
})

minetest.register_craftitem(FB.NAME..":i02", {
	description = FB.LOCAL("i02"),
	inventory_image = FB.NAME.."_i02.png",
})
minetest.register_craft({output = FB.NAME..":i02",
	recipe ={
		{	FB.NAME..":i01",	FB.NAME..":i01",	FB.NAME..":i01",	},
	},
})
]]--
