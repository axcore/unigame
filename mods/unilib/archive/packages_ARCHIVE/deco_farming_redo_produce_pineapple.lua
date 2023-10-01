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
if farming.pineapple then

    tmp1 = {"default:dirt_with_dry_grass", "default:dry_dirt_with_dry_grass"}
    tmp2 = nil
    tmp3 = -1

    if mg_name == "v6" then
        tmp1 = {"default:dirt_with_grass"}
        tmp2 = "default:desert_sand"
        tmp3 = 1
    end

    minetest.register_decoration({
        deco_type = "simple",
        place_on = tmp1,
        sidelen = 16,
        noise_params = {
            offset = 0,
            scale = tonumber(farming.pineapple) or farming.rarety,
            spread = {x = 100, y = 100, z = 100},
            seed = 917,
            octaves = 3,
            persist = 0.6
        },
        y_min = 18,
        y_max = 30,
        decoration = {"farming:pineapple_8"},
        spawn_by = tmp2,
        num_spawn_by = tmp3
    })
end
]]--
