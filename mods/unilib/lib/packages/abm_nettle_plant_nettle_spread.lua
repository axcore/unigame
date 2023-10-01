---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nettle
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_nettle_plant_nettle_spread = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nettle.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function count_nodes(pos, name)

    -- Adapted from nettle/init.lua

    local result = 0
    for x_ = pos.x - 1, pos.x + 1 do

        for y_ = pos.y - 1, pos.y + 1 do

            for z_ = pos.z - 1, pos.z + 1 do

                if minetest.get_node({x = x_, y = y_, z = z_}).name == name then
                    result = result + 1
                end

            end

        end

    end

    return result

end

local function has_neighbour(pos, name)

    local result = 0
    for x_ = pos.x - 1, pos.x + 1 do

        for y_ = pos.y - 1, pos.y + 1 do

            for z_ = pos.z - 1, pos.z + 1 do

                if minetest.get_node({x = x_, y = y_, z = z_}).name == name then
                    return true
                end

            end

        end

    end

    return false

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_nettle_plant_nettle_spread.init()

    return {
        description = "ABM to handle spread of nettles. To prevent that behaviour, don't include" ..
                " this package in your remix (packages like \"plant_nettle_carduus\" will" ..
                " instead spread using the normal flora mechanism)",
        depends = {
            "plant_nettle_carduus",
            "plant_nettle_cleavers",
            "plant_nettle_hogweed_giant",
            "plant_nettle_impatiens",
            "plant_nettle_normal",
            "plant_nettle_scotch_broom",
        },
    }

end

function unilib.pkg.abm_nettle_plant_nettle_spread.exec()

    unilib.register_abm({
        label = "Nettle spread [abm_nettle_plant_nettle_spread]",
        nodenames = {"group:nettle_weed"},

        chance = 10,
        interval = 120,

        action = function(pos, node)

            if node.name == "unilib:plant_nettle_normal" then

                if count_nodes(pos, "unilib:plant_nettle_normal") >= 4 then

                    minetest.set_node(pos, {name = "unilib:plant_nettle_carduus"})
                    return

                end

                if has_neighbour(pos, "unilib:plant_nettle_impatiens") then

                    minetest.set_node(pos, {name = "unilib:plant_nettle_impatiens"})
                    return

                end

                if has_neighbour(pos, "unilib:plant_nettle_scotch_broom") then

                    minetest.set_node(pos, {name = "unilib:plant_nettle_cleavers"})
                    return

                end

            elseif node.name == "unilib:plant_nettle_carduus" then

                if count_nodes(pos, "unilib:plant_nettle_carduus") >= 2 then

                    minetest.set_node(pos, {name = "unilib:plant_nettle_scotch_broom"})
                    return

                end

            elseif node.name == "unilib:plant_nettle_cleavers" then

                if count_nodes(pos, "unilib:plant_nettle_cleavers") >= 4 then

                    minetest.set_node(pos, {name = "unilib:plant_nettle_giant_hogweed"})
                    return

                end

                if has_neighbour(pos, "unilib:plant_nettle_normal") then

                    minetest.set_node(pos, {name = "unilib:plant_nettle_normal"})
                    return

                end

                if has_neighbour(pos, "unilib:plant_nettle_giant_hogweed") then

                    minetest.set_node(pos, {name = "unilib:plant_nettle_impatiens"})
                    return

                end

            elseif node.name == "unilib:plant_nettle_impatiens" then

                if has_neighbour(pos, "unilib:plant_nettle_cleavers") then

                    minetest.set_node(pos, {name = "unilib:plant_nettle_cleavers"})
                    return

                end

                if has_neighbour(pos, "unilib:plant_nettle_carduus") then

                    minetest.set_node(pos, {name = "unilib:plant_nettle_normal"})
                    return

                end

            elseif node.name == "unilib:plant_nettle_scotch_broom" then

                local above = {x = pos.x, y = pos.y + 1, z = pos.z}
                if minetest.get_node(above).name ~= "air" then
                    return
                end

                for x_ = pos.x - 1, pos.x + 1 do

                    for z_ = pos.z - 1, pos.z + 1 do

                        if minetest.get_node({x = x_, y = pos.y, z = z_}).name == "air" then
                            return
                        end
                    end

                end

                minetest.set_node(above, {name = "unilib:plant_nettle_scotch_broom"})

            end

        end
    })

end
