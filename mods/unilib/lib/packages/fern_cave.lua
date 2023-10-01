---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.fern_cave = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fern_cave.init()

    return {
        description = "Cave ferns",
        depends = "stone_ordinary",
    }

end

function unilib.pkg.fern_cave.exec()

    unilib.register_node("unilib:fern_cave_small", "mapgen:cavefern1", mode, {
        -- From farlands, mapgen:cavefern1
        description = S("Small Cave Fern"),
        tiles = {"unilib_fern_cave_small.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_fern_cave_small.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, 0.1, -0.5, 0.5, 0.5, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
    })
    -- (not compatible with flowerpots)

    unilib.register_node("unilib:fern_cave_large", "mapgen:cavefern2", mode, {
        -- From farlands, mapgen:cavefern2
        description = S("Large Cave Fern"),
        tiles = {"unilib_fern_cave_large.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_fern_cave_large.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, 0.1, -0.5, 0.5, 0.5, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
    })
    -- (not compatible with flowerpots)

end

function unilib.pkg.fern_cave.post()

    -- Add ferns to suitable cave locations
    minetest.register_on_generated(function(minp, maxp)

        if maxp.y < -500 or maxp.y > 100 then
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
                            {name = "unilib:fern_cave_small"}
                        )

                    else

                        minetest.add_node(
                            {x = pos.x, y = pos.y - 1, z = pos.z},
                            {name = "unilib:fern_cave_large"}
                        )

                    end

                end

            end

        end

    end)

end
