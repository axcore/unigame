---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_stalagmite_crystal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_stalagmite_crystal.init()

    return {
        description = "Cyrstal stalagmite",
        depends = "stone_ordinary",
    }

end

function unilib.pkg.misc_stalagmite_crystal.exec()

    unilib.register_node("unilib:misc_stalagmite_crystal", "mapgen:crystal", mode, {
        -- From farlands, mapgen:crystal
        description = S("Crystal Stalagmite"),
        tiles = {{
            name = "unilib_misc_stalagmite_crystal_animated.png",
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 1.00,
            },
        }},
        groups = {cracky = 2, dig_immediate = 3, flammable = 1},
        sounds = unilib.sound_table.glass,

        drawtype = "nodebox",
        light_source = 7,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.25, -0.5, -0.25, 0.25, 0.875, 0.25},
                {-0.1875, -0.5, -0.1875, 0.1875, 1.25, 0.1875},
                {-0.625, -0.5, -0.1875, -0.3125, 0.5, 0.125},
                {0.0625, -0.5, -0.625, 0.375, 0.3125, -0.3125},
                {0.3125, -0.5, 0.3125, 0.5625, 0.5, 0.5625},
                {-0.5625, -0.5, -0.125, -0.375, 0.4375, 0.0625},
                {0.125, -0.5, -0.5625, 0.3125, 0.25, -0.375},
                {0.375, -0.5, 0.375, 0.5, 0.4375, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "blend",
    })

    unilib.register_abm({
        -- From farlands, mapgen:crystal
        label = "Stalagmite particles [misc_stalagmite_crystal]",
        nodenames = {"unilib:misc_stalagmite_crystal"},

        chance = 1,
        interval = 5,

        action = function(pos, node)

            minetest.add_particle({
                acceleration = {x = 0, y = 0, z = 0},
                animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 1.00},
                collisiondetection = false,
                collisionremoval = false,
                expirationtime = 5,
                glow = 9,
                pos = {x = pos.x, y = pos.y + 0.5, z = pos.z},
                size = 25,
                texture = "unilib_misc_stalagmite_crystal_glow.png",
                velocity = {x = 0, y = 0, z = 0},
                vertical = true,
            })

        end,
    })

    unilib.register_node("unilib:misc_stalagmite_crystal_small", "mapgen:crystal_small", mode, {
        -- From farlands, mapgen:crystal_small
        description = S("Small Crystal Stalagmite"),
        tiles = {{
            name = "unilib_misc_stalagmite_crystal_animated.png",
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 1.00,
            },
        }},
        groups = {cracky = 2, dig_immediate = 3, flammable = 1},
        sounds = unilib.sound_table.glass,

        drawtype = "nodebox",
        light_source = 7,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.125, -0.5, -0.125, 0.125, 0.375, 0.125},
                {-0.0625, -0.5, -0.0625, 0.0625, 0.4375, 0.0625},
                {0, -0.5, 0.1875, 0.1875, 0.125, 0.375},
                {0.0625, -0.5, 0.25, 0.125, 0.0625, 0.3125},
                {-0.3125, -0.5, -0.375, -0.125, -0.0625, -0.1875},
                {-0.25, -0.5, -0.3125, -0.1875, -0.125, -0.25},
                {0.125, -0.5, -0.3125, 0.375, 0.125, -0.0625},
                {0.1875, -0.5, -0.25, 0.3125, 0.1875, -0.125},
                {-0.375, -0.5, 0.125, -0.1875, -0.1875, 0.3125},
                {-0.3125, -0.5, 0.1875, -0.25, -0.25, 0.25},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "blend",
    })

    unilib.register_abm({
        -- From farlands, mapgen/nodes.lua
        label = "Small stalagmite particles [misc_stalagmite_crystal]",
        nodenames = {"unilib:misc_stalagmite_crystal_small"},

        chance = 1,
        interval = 5,

        action = function(pos, node)

            minetest.add_particle({
                acceleration = {x = 0, y = 0, z = 0},
                animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 1.00},
                collisiondetection = false,
                collisionremoval = false,
                expirationtime = 5,
                glow = 9,
                pos = {x = pos.x, y = pos.y + 0.1, z = pos.z},
                size = 15,
                texture = "unilib_misc_stalagmite_crystal_glow.png",
                velocity = {x = 0, y = 0, z = 0},
                vertical = true,
            })

        end,
    })

    unilib.register_node("unilib:misc_stalagmite_crystal_block", "mapgen:crystal_block", mode, {
        -- From farlands, mapgen:crystal_block
        description = S("Crystal Stalagmite Block"),
        tiles = {{
            name = "unilib_misc_stalagmite_crystal_block.png",
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 1.00,
            },
        }},
        groups = {cracky = 2, dig_immediate = 3, flammable = 1},
        sounds = unilib.sound_table.glass,

        drawtype = "nodebox",
        light_source = 7,
        paramtype = "light",
        use_texture_alpha = "blend",
    })

    unilib.register_craftitem(
        -- From farlands, mapgen:crystal_shard
        "unilib:misc_stalagmite_crystal_shard",
        "mapgen:crystal_shard",
        mode,
        {
            description = S("Crystal Stalagmite Shard"),
            inventory_image = "unilib_misc_stalagmite_crystal_shard.png"
        }
    )
    unilib.register_craft({
        -- From farlands, mapgen:crystal_shard
        output = "unilib:misc_stalagmite_crystal_shard 4",
        recipe = {
            {"unilib:misc_stalagmite_crystal"},
        },
    })

    unilib.register_craft({
        -- From farlands, mapgen:crystal_shard
        output = "unilib:misc_stalagmite_crystal_shard 2",
        recipe = {
            {"unilib:misc_stalagmite_crystal_small"},
        },
    })

end

function unilib.pkg.misc_stalagmite_crystal.post()

    -- Add crystal stalagmites to suitable cave locations
    minetest.register_on_generated(function(minp, maxp)

        if maxp.y < -2000 or maxp.y > 1500 then
            return
        end

        local stone = minetest.find_nodes_in_area(minp, maxp, {"unilib:stone_ordinary"})

        for n = 1, #stone do

            if math.random(1, 150) == 1 then

                local pos = {x = stone[n].x, y = stone[n].y, z = stone[n].z}

                if minetest.get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name == "air" then

                    if math.random(1, 5) == 1 then

                        minetest.add_node(
                            {x = pos.x, y = pos.y + 1, z = pos.z},
                            {name = "unilib:misc_stalagmite_crystal_small"}
                        )

                    else

                        minetest.add_node(
                            {x = pos.x, y = pos.y + 1, z = pos.z},
                            {name = "unilib:misc_stalagmite_crystal"}
                        )

                    end

                end

            end

        end

    end)

end
