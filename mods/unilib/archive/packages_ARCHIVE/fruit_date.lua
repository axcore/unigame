---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
for _,suffix in ipairs({"f4"}) do
	local name
	if suffix == "f0" or suffix == "m0" then
		name = S("Date Flowers")
	elseif suffix == "n" or suffix == "fn" then
		name = S("Date Stem")
	else
		name = S("Dates")
	end
	local dropfn = suffix == "f4" and dates_drop or ""
	local datedef = {
		description = name,
		tiles = {"moretrees_dates_"..suffix..".png"},
		visual_scale = 2,
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		groups = { fleshy=3, dig_immediate=3, flammable=2, moretrees_dates=1 },
		inventory_image = "moretrees_dates_"..suffix..".png^[transformR0",
		wield_image = "moretrees_dates_"..suffix..".png^[transformR90",
		sounds = default.node_sound_defaults(),
		drop = dropfn,
		selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.3, -0.3, 0.3, 3.5, 0.3}
		},
		on_timer = dates_growfn,
		on_construct = (moretrees.dates_regrow_pollinated or moretrees.dates_regrow_unpollinated_percent > 0)
				and dates_starttimer,

	}
	minetest.register_node("moretrees:dates_"..suffix, datedef)
end

minetest.register_craftitem("moretrees:date", {
	description = S("Date"),
	inventory_image = "moretrees_date.png",
	on_use = minetest.item_eat(1),
})
]]--
