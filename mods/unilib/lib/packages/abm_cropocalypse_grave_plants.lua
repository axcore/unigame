---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_cropocalypse_grave_plants = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_cropocalypse_grave_plants.init()

    return {
        description = "ABMs to add particle effect to certain decorative plants (from" ..
                " cropocalypse)",
    }

end

function unilib.pkg.abm_cropocalypse_grave_plants.post()

    if core.features.particlespawner_tweenable then

        -- Wisp particle effect
        unilib.register_abm({
            -- From cropocalypse/grave_plants.lua
            label = "Grave plant particles [abm_cropocalypse_grave_plants]",
            nodenames = {"group:grave_plants"},

            catch_up = false,
            chance = 500,
            interval = 1,

            action = function(pos, node)

                core.add_particlespawner({
                    amount = 1,
                    time = 1,

                    acc = {
                        max = vector.new(0.2, 0.1, 0.2),
                        min = vector.new(-0.2, -0.1, -0.2),
                    },
                    collision_removal = true,
                    collisiondetection = true,
                    exptime = 5,
                    glow = 7,
                    pos = {
                        max = vector.add(pos, vector.new(1.5, 1.5, 1.5)),
                        min = vector.add(pos, vector.new(-1.5, 0, -1.5)),
                    },
                    texpool = {
                        {
                            name = "unilib_particle_grave_wisp.png",
                            alpha_tween = {1, 1},
                            animation = {
                                type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1,
                            },
                            scale = 2,
                        },
                    },
                    vel = {
                        max = vector.new(0.1, 0.1, 0.1),
                        min = vector.new(0, 0, 0),
                    },
                })

            end,
        })

        -- Bat particle effect
        unilib.register_abm({
            -- From cropocalypse/grave_plants.lua
            nodenames = {"group:grave_plants"},

            catch_up = false,
            chance = 1000,
            interval = 1,

            action = function(pos, node)

                core.add_particlespawner({
                    amount = 1,
                    time = 1,

                    acc = {
                        max = vector.new(0.4, 0.1, 0.4),
                        min = vector.new(-0.4, 0, -0.4),
                    },
                    collision_removal = true,
                    collisiondetection = true,
                    exptime = 5,
                    glow = 0,
                    pos = {
                        max = vector.add(pos, vector.new(1.5, 3.5, 1.5)),
                        min = vector.add(pos, vector.new(-1.5, 3, -1.5)),
                    },
                    texpool = {
                        {
                            name = "unilib_particle_grave_bat.png",
                            alpha_tween = {1, 1},
                            scale = 2,
                            animation = {
                                type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1,
                            },
                        },
                    },
                    vel = {
                        max = vector.new(0.1, 0.1, 0.1),
                        min = vector.new(0, 0, 0),
                    },
                })

            end,
        })

        -- Mist particle effect
        unilib.register_abm({
            -- From cropocalypse/grave_plants.lua
            nodenames = {"group:grave_plants"},

            catch_up = false,
            chance = 100,
            interval = 1,

            action = function(pos, node)

                core.add_particlespawner({
                    amount = 1,
                    time = 1,

                    acc = {
                        max = vector.new(0.2, 0, 0.2),
                        min = vector.new(-0.2, 0, -0.2),
                    },
                    collision_removal = true,
                    collisiondetection = true,
                    exptime = 5,
                    glow = 0,
                    pos = {
                        max = vector.add(pos, vector.new(1.5, 1.5, 1.5)),
                        min = vector.add(pos, vector.new(-1.5, 0, -1.5)),
                    },
                    texpool = {
                        {
                            name = "unilib_particle_grave_mist.png",
                            alpha_tween = {1, 0},
                            scale = 50,
                            animation = {
                            type = "vertical_frames", aspect_w = 48, aspect_h = 48, length = 1},
                        },
                    },
                    vel = {
                        max = vector.new(0.1, 0.1, 0.1),
                        min = vector.new(0, 0, 0),
                    },
                })

            end,
        })

    end

end
