---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if farming.artichoke then
    minetest.register_decoration({
        deco_type = "simple",
        place_on = {"default:dirt_with_grass"},
        sidelen = 16,
        noise_params = {
            offset = 0,
            scale = tonumber(farming.artichoke) or farming.rarety,
            spread = {x = 100, y = 100, z = 100},
            seed = 448,
            octaves = 3,
            persist = 0.6
        },
        y_min = 1,
        y_max = 13,
        decoration = {"farming:artichoke_5"},
        spawn_by = "group:tree",
        num_spawn_by = 1,
    })
end
]]--
