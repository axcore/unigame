---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.meta_farlands_underground = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.meta_farlands_underground.init()

    return {
        description = "Places stalactites, stalagmites and crystals in ordinary stone caves",
        notes = "Generates stalactites and/or stalagmites in ordinary stone caves. The" ..
                " generation code appears in this separate package, so that the nodes can be" ..
                " used separately, if required",
        at_least_one = {"misc_stalactite", "misc_stalagmite", "misc_stalagmite_crystal"},
    }

end

function unilib.pkg.meta_farlands_underground.exec()

    -- Add stalactites/stalagmites to suitable cave locations
    core.register_on_generated(function(minp, maxp)

        if unilib.global.pkg_executed_table["misc_stalactite"] ~= nil and
                maxp.y >= -1000 and
                maxp.y <= 10 then

            local node_list = core.find_nodes_in_area(minp, maxp, {"unilib:stone_ordinary"})

            for n = 1, #node_list do

                if math.random(1, 50) == 1 then

                    local pos = {x = node_list[n].x, y = node_list[n].y, z = node_list[n].z}

                    if core.get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name == "air" then

                        if math.random(1, 2) == 1 then

                            core.add_node(
                                {x = pos.x, y = pos.y - 1, z = pos.z},
                                {name = "unilib:misc_stalactite_1"}
                            )

                        elseif math.random(1, 2) == 1 then

                            core.add_node(
                                {x = pos.x, y = pos.y - 1, z = pos.z},
                                {name = "unilib:misc_stalactite_2"}
                            )

                        elseif math.random(1, 2) == 1 then

                            core.add_node(
                                {x = pos.x, y = pos.y - 1, z = pos.z},
                                {name = "unilib:misc_stalactite_3"}
                            )

                        else

                            core.add_node(
                                {x = pos.x, y = pos.y - 1, z = pos.z},
                                {name = "unilib:misc_stalactite_4"}
                            )

                        end

                    end

                end

            end

        end

        if unilib.global.pkg_executed_table["misc_stalagmite"] ~= nil and
                maxp.y >= -1000 and
                maxp.y <= 20 then

            local node_list = core.find_nodes_in_area(minp, maxp, {"unilib:stone_ordinary"})

            for n = 1, #node_list do

                if math.random(1, 50) == 1 then

                    local pos = {x = node_list[n].x, y = node_list[n].y, z = node_list[n].z }

                    if core.get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name == "air" and
                            pos.y >= -100 then

                        -- N.B. Only three variants in the original code, so only three variants
                        --      spawn
                        if math.random(1, 2) == 1 then

                            core.add_node(
                                {x = pos.x, y = pos.y + 1, z = pos.z},
                                {name = "unilib:misc_stalagmite_1"}
                            )

                        elseif math.random(1, 2) == 1 then

                            core.add_node(
                                {x = pos.x, y = pos.y + 1, z = pos.z},
                                {name = "unilib:misc_stalagmite_4"}
                            )

                        else

                            core.add_node(
                                {x = pos.x, y = pos.y + 1, z = pos.z},
                                {name = "unilib:misc_stalagmite_3"}
                            )

                        end

                    end

                end

            end

        end

        if unilib.global.pkg_executed_table["misc_stalagmite_crystal"] ~= nil and
                maxp.y >= -2000 and
                maxp.y <= 1500 then

            local node_list = core.find_nodes_in_area(minp, maxp, {"unilib:stone_ordinary"})

            for n = 1, #node_list do

                if math.random(1, 150) == 1 then

                    local pos = {x = node_list[n].x, y = node_list[n].y, z = node_list[n].z}

                    if core.get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name == "air" then

                        if math.random(1, 5) == 1 then

                            core.add_node(
                                {x = pos.x, y = pos.y + 1, z = pos.z},
                                {name = "unilib:misc_stalagmite_crystal_small"}
                            )

                        else

                            core.add_node(
                                {x = pos.x, y = pos.y + 1, z = pos.z},
                                {name = "unilib:misc_stalagmite_crystal"}
                            )

                        end

                    end

                end

            end

        end

    end)

end
