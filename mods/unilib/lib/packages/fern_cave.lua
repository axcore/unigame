---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.fern_cave = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_place(itemstack, placer, pointed_thing)

    local dir = core.dir_to_wallmounted(
        vector.subtract(pointed_thing.under, pointed_thing.above)
    )

    if dir == 0 then
        core.item_place(itemstack, placer, pointed_thing, 1)
    end

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fern_cave.init()

    return {
        description = "Cave ferns",
        notes = "Spawns naturally on cave ceilings. When placed manually, can only be placed" ..
                " on ceilings",
        depends = "stone_ordinary",
    }

end

function unilib.pkg.fern_cave.exec()

    -- N.B. The original code allows cave ferns to be placed on the ground (only), but they are
    --      orientated in the wrong direction
    -- To fix this problem, we remove the "attached_node" group, and add .paramtype2 and
    --      .on_place() fields. The nodes can now be placed on ceilings (only)

    unilib.register_node("unilib:fern_cave_small", "mapgen:cavefern1", mode, {
        -- From farlands, mapgen:cavefern1
        description = S("Small Cave Fern"),
        tiles = {"unilib_fern_cave_small.png"},
        -- N.B. removed attached_node = 1 from original code
--      groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        groups = {flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_fern_cave_small.png",
        paramtype = "light",
        -- N.B. no .paramtype2 in original code
        paramtype2 = "wallmounted",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, 0.1, -0.5, 0.5, 0.5, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,

        -- N.B. no .on_place() in original code
        on_place = on_place,
    })
    -- (not compatible with flowerpots)

    unilib.register_node("unilib:fern_cave_large", "mapgen:cavefern2", mode, {
        -- From farlands, mapgen:cavefern2
        description = S("Large Cave Fern"),
        tiles = {"unilib_fern_cave_large.png"},
        -- N.B. removed attached_node = 1 from original code
--      groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        groups = {flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_fern_cave_large.png",
        paramtype = "light",
        -- N.B. no .paramtype2 in original code
        paramtype2 = "wallmounted",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, 0.1, -0.5, 0.5, 0.5, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,

        -- N.B. no .on_place() in original code
        on_place = on_place,
    })
    -- (not compatible with flowerpots)

end

function unilib.pkg.fern_cave.post()

    -- Add ferns to suitable cave locations
    core.register_on_generated(function(minp, maxp)

        if maxp.y < -500 or maxp.y > 100 then
            return
        end

        -- N.B. default:stone in original code
        local dirt = core.find_nodes_in_area(minp, maxp, {"group:smoothstone"})

        for n = 1, #dirt do

            if math.random(1, 50) == 1 then

                local pos = {x = dirt[n].x, y = dirt[n].y, z = dirt[n].z}

                if core.get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name == "air" then

                    -- N.B. param2 = 1 not in original code
                    if math.random(1, 2) == 1 then

                        core.add_node(
                            {x = pos.x, y = pos.y - 1, z = pos.z},
                            {name = "unilib:fern_cave_small", param2 = 1}
                        )

                    else

                        core.add_node(
                            {x = pos.x, y = pos.y - 1, z = pos.z},
                            {name = "unilib:fern_cave_large", param2 = 1}
                        )

                    end

                end

            end

        end

    end)

end
