---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nettle
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_nettle_plant_nettle_place = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nettle.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_nettle_plant_nettle_place.init()

    return {
        description = "ABM to place nettles at suitable locations (from nettle)",
        notes = "Suitable locations are commonly cliff edges. To prevent nettle placement, don't" ..
                " include this package in your remix (and create an ordinary decoration package" ..
                " in its place)",
        depends = {"plant_nettle_cleavers", "plant_nettle_impatiens", "plant_nettle_normal"},
    }

end

function unilib.pkg.abm_nettle_plant_nettle_place.post()

    unilib.register_abm({
        -- From nettle/init.lua
        label = "Spawn nettles [abm_nettle_plant_nettle_place]",
        nodenames = {"group:spreading_dirt_type", "group:soil"},

        chance = 50,
        interval = 240,

        action = function(pos, node)

            local above = {x = pos.x, y = pos.y + 1, z = pos.z}
            if core.get_node(above).name ~= "air" then
                return
            end

            local dirts = 0
            local airs = 0
            for x_ = pos.x - 1, pos.x + 1 do

                for y_ = pos.y - 1, pos.y + 1 do

                    for z_ = pos.z - 1, pos.z + 1 do

                        local full_name = core.get_node({x = x_, y = y_, z = z_}).name

                        --[[
                        if full_name == "unilib:dirt_ordinary" or
                                full_name == "unilib:stone_ordinary" then
                            dirts = dirts + 1
                        end
                        ]]--
                        if core.get_item_group(full_name, "soil") > 0 or
                                core.get_item_group(full_name, "smoothstone") > 0 then
                            dirts = dirts + 1
                        end

                        if full_name == "air" or
                                core.get_item_group(full_name, "flora") > 0 then
                            airs = airs + 1
                        end

                    end
                end

            end

            if dirts < 14 and airs < 14 then
                return
            end

            if (
                core.get_node({x = pos.x, y = pos.y+2, z = pos.z}).name ~= "air" or
                        core.get_node_light(above, 0.5) < 8
            ) then
                core.set_node(above, {name = "unilib:plant_nettle_impatiens"})
            elseif core.get_node_light(above, 0.5) < 13 then
                core.set_node(above, {name = "unilib:plant_nettle_cleavers"})
            else
                core.set_node(above, {name = "unilib:plant_nettle_normal"})
            end
        end
    })

end
