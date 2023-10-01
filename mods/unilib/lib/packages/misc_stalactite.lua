---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_stalactite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_stalactite.init()

    return {
        description = "Selection of stalactites",
        depends = "stone_ordinary",
    }

end

function unilib.pkg.misc_stalactite.exec()

    for i, orig_name in ipairs({
        "mapgen:stalagtite",
        "mapgen:stalagtite1",
        "mapgen:stalagtite2",
        "mapgen:stalagtite3",
    }) do
        unilib.register_node("unilib:misc_stalactite_" .. i, orig_name, mode, {
            description = S("Stalactite"),
            tiles = {"unilib_misc_stalagmite_" .. i .. ".png"},
            groups = {crumbly = 1, oddly_breakable_by_hand = 1},
            sounds = unilib.sound_table.stone,

            drawtype = "plantlike",
            inventory_image = "unilib_misc_stalagmite_" .. i .. ".png",
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.3, -0.2, -0.3, 0.3, 0.5, 0.3},
                },
            },
            sunlight_propagates = true,
            walkable = false,
        })

    end

end

function unilib.pkg.misc_stalactite.post()

    -- Add stalactites to suitable cave locations
    minetest.register_on_generated(function(minp, maxp)

        if maxp.y < -1000 or maxp.y > 10 then
            return
        end

        local dirt = minetest.find_nodes_in_area(minp, maxp, {"unilib:stone_ordinary"})

        for n = 1, #dirt do

            if math.random(1, 50) == 1 then

                local pos = {x = dirt[n].x, y = dirt[n].y, z = dirt[n].z}

                if minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name == "air" then

                    if math.random(1, 2) == 1 then

                        minetest.add_node(
                            {x = pos.x, y = pos.y - 1, z = pos.z},
                            {name = "unilib:misc_stalactite_1"}
                        )

                    elseif math.random(1, 2) == 1 then

                        minetest.add_node(
                            {x = pos.x, y = pos.y - 1, z = pos.z},
                            {name = "unilib:misc_stalactite_2"}
                        )

                    elseif math.random(1, 2) == 1 then

                        minetest.add_node(
                            {x = pos.x, y = pos.y - 1, z = pos.z},
                            {name = "unilib:misc_stalactite_3"}
                        )

                    else

                        minetest.add_node(
                            {x = pos.x, y = pos.y - 1, z = pos.z},
                            {name = "unilib:misc_stalactite_4"}
                        )

                    end

                end

            end

        end

    end)

end
