---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local fish = {
	{"Blue Fin", "bluefin", 2},
	{"Blue Ram", "blueram", 2},
	{"Catfish", "catfish", 2},
	{"Clownfish", "clownfish", 2},
	{"Pike", "pike", 2},
	{"Flathead", "flathead", 2},
	{"Plaice", "plaice", 2},
	{"Pufferfish", "pufferfish", -2},
	{"Coy", "coy", 2},
	{"Salmon", "salmon", 2},
	{"Cichlid", "cichlid", 2},
	{"Angler", "angler", 2},
	{"Jellyfish", "jellyfish", 0},
	{"Seahorse", "seahorse", 0},
	{"Piranha", "piranha", 2},
	{"Trout", "trout", 2}
}

for n = 1, #fish do

	local usage
	local groups

	if fish[n][3] > 0 then
		usage = minetest.item_eat(fish[n][3])
		groups = {food_fish_raw = 1, ethereal_fish = 1}
	end

	minetest.register_craftitem("ethereal:fish_" .. fish[n][2], {
		description = S(fish[n][1]),
		inventory_image = "ethereal_fish_" .. fish[n][2] .. ".png",
		on_use = usage,
		groups = groups
	})
end

local junk_items = {
	"ethereal:bowl",
	"default:stick",
	"farming:string",
	"default:papyrus",
	"dye:black",
	{"ethereal:bamboo", "bamboo"}
}

local bonus_items = {
	"mobs:nametag",
	"mobs:saddle",
	"flowers:waterlily",
	"default:book",
	{"ethereal:crystal_spike", "frost"},
	{"ethereal:banana_bunch", "grove"}
}
]]--
