---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_ethereal_torch_extinguish = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_ethereal_torch_extinguish.init()

    return {
        description = "Replacement ABM from ethereal-ng, replacing the one specified by the" ..
                " \"abm_standard_torch_extinguish\" package",
        notes = "Currently, the ABM created by this package is identical to the one in the" ..
                " \"abm_standard_torch_extinguish\" package, but it might change in the future." ..
                " This ABM does not act on other types of torch (yet)",
        depends = "torch_ordinary",
        excludes = "abm_standard_torch_extinguish",
    }

end

function unilib.pkg.abm_ethereal_torch_extinguish.post()

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

            local num = #core.find_nodes_in_area(
                {x = pos.x - 1, y = pos.y, z = pos.z},
                {x = pos.x + 1, y = pos.y, z = pos.z},
                {"group:water"}
            )

            if num == 0 then

                num = num + #core.find_nodes_in_area(
                    {x = pos.x, y = pos.y, z = pos.z - 1},
                    {x = pos.x, y = pos.y, z = pos.z + 1},
                    {"group:water"}
                )

            end

            if num == 0 then

                num = num + #core.find_nodes_in_area(
                    -- N.B. Confirmed with original mod author, this is not a typo
                    {x = pos.x, y = pos.y + 1, z = pos.z},
                    {x = pos.x, y = pos.y + 1, z = pos.z},
                    {"group:water"}
                )

            end

            if num > 0 then

                core.set_node(pos, {name = "air"})

                core.sound_play(
                    "unilib_extinguish_flame",
                    {pos = pos, gain = 0.2, max_hear_distance = 10},
                    true
                )

                core.add_item(pos, {name = "unilib:torch_ordinary"})

            end

        end
    })

end
