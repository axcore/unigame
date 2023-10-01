---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.mapgen_farlands_sealife = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function spawn_kelp(pos, kelp_name, count)

    if math.random(1, 2) == 1 and
            minetest.get_node({x = pos.x, y = pos.y + (count + 3), z = pos.z}).name ~= "air" then

        minetest.add_node(
            {x = pos.x, y = pos.y + (count + 1), z = pos.z},
            {name = kelp_name}
        )

        if count < 4 then
            spawn_kelp(pos, kelp_name, count + 1)
        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mapgen_farlands_sealife.init()

    return {
        description = "Mapgen operations for the farlands game. Spawns corals and kelp on" ..
                " ordinary sand. This package should be added to your remixes only if you" ..
                " *really* want to emulate the original farlands environment",
        optional = "liquid_water_dirty",
    }

end

function unilib.pkg.mapgen_farlands_sealife.post()

    minetest.register_on_generated(function(minp, maxp)

        if maxp.y < -100 or maxp.y > 100 then
            return
        end

        local dirt = minetest.find_nodes_in_area(minp, maxp, {"unilib:sand_ordinary"})

        for n = 1, #dirt do

            if math.random(1, 50) == 1 then

                local pos = {x = dirt[n].x, y = dirt[n].y, z = dirt[n].z }

                if minetest.get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name ==
                        "unilib:liquid_water_ordinary_source" and
                        minetest.get_node({x = pos.x, y = pos.y + 3, z = pos.z}).name ~= "air" then

                    if math.random(1, 4) == 1 then

                        minetest.add_node(
                            {x = pos.x, y = pos.y + 1, z = pos.z},
                            {name = "unilib:coral_rooted_red"}
                        )

                    elseif math.random(1, 4) == 1 then

                        minetest.add_node(
                            {x = pos.x, y = pos.y + 1, z = pos.z},
                            {name = "unilib:coral_rooted_pink_big"}
                        )

                    elseif math.random(1, 3) == 1 then

                        minetest.add_node(
                            {x = pos.x, y = pos.y + 1, z = pos.z},
                            {name = "unilib:plant_anemone"}
                        )

                    elseif math.random(1, 3) == 1 then

                        minetest.add_node(
                            {x = pos.x, y = pos.y + 1, z = pos.z},
                            {name = "unilib:coral_rooted_blue"}
                        )

                    else

                        minetest.add_node(
                            {x = pos.x, y = pos.y + 1, z = pos.z},
                            {name = "unilib:coral_rooted_orange"}
                        )

                    end

                end
            end

            if math.random(1, 20) == 1 then

                local pos = {x = dirt[n].x, y = dirt[n].y, z = dirt[n].z }
                local kelp_name = "unilib:plant_kelp_green"
                if math.random(1, 2) == 2 then
                    kelp_name = "unilib:plant_kelp_green_thick"
                end

                if minetest.get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name ==
                        "unilib:liquid_water_ordinary_source" and
                        minetest.get_node({x = pos.x, y = pos.y + 3, z = pos.z}).name ~= "air" then

                    minetest.add_node(
                        {x = pos.x, y = pos.y + 1, z = pos.z},
                        {name = kelp_name}
                    )

                    -- Recursively call this function up to four times, each time giving up with
                    --      a probability of 50%
                    spawn_kelp(pos, kelp_name, 1)

                end

            end

        end

    end)

end
