---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_snow_freezing = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.snow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_snow_freezing.init()

    return {
        description = "Freezes water",
        depends = {"ice_ordinary", "liquid_water_ordinary"},
    }

end

function unilib.pkg.abm_snow_freezing.exec()

    -- Water freezes when in contact with snow
    unilib.register_abm({
        label = "Freeze water in contact with snow [abm_snow_freezing]",
        nodenames = {"unilib:liquid_water_ordinary_source"},
        neighbors = {
            "unilib:snow_ordinary",
            "unilib:snow_ordinary_block",
            "unilib:snow_hard_brick",
            "group:icemaker",
        },

        chance = 4,
        interval = 20,

        action = function(pos)
            minetest.add_node(pos, {name = "unilib:ice_ordinary"})
        end,
    })

    -- Freeze ice according to its param2 value
    unilib.register_abm({
        label = "Freeze ice according to param2 value [abm_snow_freezing]",
        nodenames = {"unilib:ice_ordinary"},
        neighbors = {"default:water_source"},

        chance = 4,
        interval = 20,

        action = function(pos, node)

            if node.param2 == 0 then
                return
            end

            for l = 0, 1 do

                for i = -1, 1, 2 do

                    for _, p in pairs({
                        {x = pos.x + i, z = pos.z - l * i},
                        {x = pos.x + l * i, z = pos.z + i},
                    }) do
                        if math.random(2) == 2 then

                            p.y = pos.y
                            if minetest.get_node(p).name ==
                                    "unilib:liquid_water_ordinary_source" then

                                minetest.add_node(p, {
                                    name = "unilib:ice_ordinary",
                                    param2 = math.random(0, node.param2 - 1)
                                })

                            end

                        end

                    end

                end

            end

            if math.random(8) == 8 then

                minetest.add_node(pos, {name = "unilib:liquid_water_ordinary_source"})

            else

                node.param2 = 0
                minetest.add_node(pos, node)

            end

        end,
    })

end
