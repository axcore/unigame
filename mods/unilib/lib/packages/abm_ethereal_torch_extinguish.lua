---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_ethereal_torch_extinguish = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_ethereal_torch_extinguish.init()

    return {
        description = "Replacment \"torch_extinguish\" ABM",
        notes = "Currently, the ABM created by this package is identical to the one in" ..
                " ../lib/system/abms.lua, but it might change in the future. This ABM does" ..
                " not act on other types of torch (yet)",
        depends = "torch_ordinary",
    }

end

function unilib.pkg.abm_ethereal_torch_extinguish.post()

    unilib.abm_replace_table.torch_extinguish = function()

        unilib.register_abm({
            -- From ethereal-ng/water.lua
            label = "Drop torch in water [abm_ethereal_torch_extinguish]",
            nodenames = {
                "unilib:torch_ordinary",
                "unilib:torch_ordinary_wall",
                "unilib:torch_ordinary_ceiling",
            },
            neighbors = {"group:water"},

            catch_up = false,
            chance = 1,
            interval = 5,

            action = function(pos, node)

                local num = #minetest.find_nodes_in_area(
                    {x = pos.x - 1, y = pos.y, z = pos.z},
                    {x = pos.x + 1, y = pos.y, z = pos.z},
                    {"group:water"}
                )

                if num == 0 then

                    num = num + #minetest.find_nodes_in_area(
                        {x = pos.x, y = pos.y, z = pos.z - 1},
                        {x = pos.x, y = pos.y, z = pos.z + 1},
                        {"group:water"}
                    )

                end

                if num == 0 then

                    num = num + #minetest.find_nodes_in_area(
                        {x = pos.x, y = pos.y + 1, z = pos.z},
                        {x = pos.x, y = pos.y + 1, z = pos.z},
                        {"group:water"}
                    )

                end

                if num > 0 then

                    minetest.set_node(pos, {name = "air"})

                    minetest.sound_play(
                        "unilib_extinguish_flame",
                        {pos = pos, gain = 0.2, max_hear_distance = 10}
                    )

                    minetest.add_item(pos, {name = "unilib:torch_ordinary"})

                end

            end
        })

    end

end
