---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_stalagmite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_stalagmite.init()

    return {
        description = "Selection of stalagmites",
        depends = "stone_ordinary",
    }

end

function unilib.pkg.misc_stalagmite.exec()

    unilib.register_node("unilib:misc_stalagmite_1", "mapgen:stalagmite0", mode, {
        -- From farlands, mapgen:stalagmite0
        description = S("Stalagmite"),
        tiles = {"unilib_misc_stalagmite_1.png^[transformFY"},
        groups = {crumbly = 1, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.stone,

        drawtype = "plantlike",
        inventory_image = "unilib_misc_stalagmite_1.png^[transformFY",
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

    unilib.register_node("unilib:misc_stalagmite_2", "mapgen:stalagmite1", mode, {
        -- From farlands, mapgen:stalagmite1
        description = S("Stalagmite"),
        tiles = {"unilib_misc_stalagmite_4.png^[transformFY"},
        groups = {crumbly = 1, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.stone,

        drawtype = "plantlike",
        inventory_image = "unilib_misc_stalagmite_4.png^[transformFY",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.3, -0.2, -0.3, 0.3, 0.5, 0.3},
            },
        },
        sunlight_propagates = true,
        visual_scale = 2,
        walkable = false,
    })

    unilib.register_node("unilib:misc_stalagmite_3", "mapgen:stalagmite2", mode, {
        -- From farlands, mapgen:stalagmite2
        description = S("Stalagmite"),
        tiles = {"unilib_misc_stalagmite_3.png^[transformFY"},
        groups = {crumbly = 1, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.stone,

        drawtype = "plantlike",
        inventory_image = "unilib_misc_stalagmite_3.png^[transformFY",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.3, -0.2, -0.3, 0.3, 0.5, 0.3},
            },
        },
        sunlight_propagates = true,
        visual_scale = 1.5,
        walkable = false,
    })

end

function unilib.pkg.misc_stalagmite.post()

    -- Add stalagmites to suitable cave locations
    minetest.register_on_generated(function(minp, maxp)

        if maxp.y < -1000 or maxp.y > 20 then
            return
        end

        local dirt = minetest.find_nodes_in_area(minp, maxp, {"unilib:stone_ordinary"})

        for n = 1, #dirt do

            if math.random(1, 50) == 1 then

                local pos = {x = dirt[n].x, y = dirt[n].y, z = dirt[n].z }

                if minetest.get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name == "air" and
                        pos.y >= -100 then

                    if math.random(1, 2) == 1 then

                        minetest.add_node(
                            {x = pos.x, y = pos.y + 1, z = pos.z},
                            {name = "unilib:misc_stalagmite_1"}
                        )

                    elseif math.random(1, 2) == 1 then

                        minetest.add_node(
                            {x = pos.x, y = pos.y + 1, z = pos.z},
                            {name = "unilib:misc_stalagmite_2"}
                        )

                    else

                        minetest.add_node(
                            {x = pos.x, y = pos.y + 1, z = pos.z},
                            {name = "unilib:misc_stalagmite_3"}
                        )

                    end

                end

            end

        end

    end)

end
