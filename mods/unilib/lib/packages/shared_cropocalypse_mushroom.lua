---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_cropocalypse_mushroom = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

local group_list = {}
local particle_table = {}
local neighbour_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_spread(pos, node)

    if minetest.get_node_light(pos, 0.5) > 10 then

        if minetest.get_node_light(pos, nil) >= 11 then
            minetest.remove_node(pos)
        end

        return

    end

    local pos_list = minetest.find_nodes_in_area_under_air(
        {x = pos.x - 75, y = pos.y - 50, z = pos.z - 75},
        {x = pos.x + 75, y = pos.y + 50, z = pos.z + 75},
        neighbour_table[node.name]
    )

    if #pos_list == 0 then
        return
    end

    local pos2 = pos_list[math.random(#pos_list)]
    pos2.y = pos2.y + 1
    if minetest.get_node_light(pos2, 0.5) <= 10 then
        minetest.set_node(pos2, {name = node.name})
    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_cropocalypse_mushroom.register_abms(
    part_name, group_name, neighbour_name
)
    table.insert(group_list, group_name)
    particle_table[group_name] = "unilib_particle_mushroom_" .. part_name .. ".png"
    neighbour_table["unilib:mushroom_" .. part_name] = neighbour_name

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_cropocalypse_mushroom.init()

    return {
        description = "Shared functions for cropocalypse mushrooms (from cropocalypse mod)",
        notes = "This package adds a shared mushroom-spreading ABM for each of several mushroom" ..
                " packages. The mushrooms spread on particular ores, in low light. In addition," ..
                " this package adds an individual particle-spawning ABM for each of the" ..
                " mushrooms. This package is optional; if it is not loaded, then the mushrooms" ..
                " spread on dirt as normal (and no extra ABMs are created)",
    }

end

function unilib.pkg.shared_cropocalypse_mushroom.post()

    unilib.register_abm({
        -- From cropocalypse/glowing_mushrooms.lua
        label = "Special mushroom spread [shared_cropocalypse_mushroom]",
        nodenames = group_list,

        chance = 75,
        interval = 11,

        action = function(...)
            do_spread(...)
        end,
    })

    if minetest.features.particlespawner_tweenable then

        for group_name, particle_img in pairs(particle_table) do

            unilib.register_abm({
                -- From cropocalypse/glowing_mushrooms.lua
                label = "Special mushroom particles [shared_cropocalypse_mushroom]",
                nodenames = {group_name},

                catch_up = false,
                chance = 3,
                interval = 1,

                action = function(pos, node)

                    minetest.add_particlespawner({
                        amount = 1,
                        time = 1,

                        acc = {
                            max = vector.new(0, 0.3, 0),
                            min = vector.new(0, 0.1, 0),
                        },
                        collision_removal = true,
                        collisiondetection = true,
                        exptime = 3,
                        glow = 14,
                        pos = {
                            max = vector.add(pos, vector.new(1.5, 1.5, 1.5)),
                            min = vector.add(pos, vector.new(-1.5, 0, -1.5)),
                        },
                        texpool = {
                            {
                                name = particle_img,
                                alpha_tween = {1, 0},
                                animation = {
                                    type = "vertical_frames",
                                    aspect_w = 16,
                                    aspect_h = 16,
                                    length = 1,
                                },
                                scale = 1,
                            },
                        },
                        vel = {
                            max = vector.new(0, 0.15, 0),
                            min = vector.new(0, 0, 0),
                        },
                    })

                end,
            })

        end

    end

end
