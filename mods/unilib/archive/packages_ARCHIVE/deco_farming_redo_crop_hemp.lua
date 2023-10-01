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
if farming.hemp then
    minetest.register_decoration({
        deco_type = "simple",
        place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
        sidelen = 16,
        noise_params = {
            offset = 0,
            scale = tonumber(farming.hemp) or farming.rarety,
            spread = {x = 100, y = 100, z = 100},
            seed = 420,
            octaves = 3,
            persist = 0.6
        },
        y_min = 3,
        y_max = 45,
        decoration = "farming:hemp_7",
        spawn_by = "group:tree",
        num_spawn_by = 1
    })
end
]]--
