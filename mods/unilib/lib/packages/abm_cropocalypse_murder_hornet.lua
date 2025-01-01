---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_cropocalypse_murder_hornet = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_cropocalypse_murder_hornet.init()

    return {
        description = "ABM to add murder hornet effect to certain decorative plants (from" ..
                " cropocalypse)",
    }

end

function unilib.pkg.abm_cropocalypse_murder_hornet.post()

    if core.features.particlespawner_tweenable then

        unilib.register_abm({
            -- From cropocalypse/decorative_plants.lua
            label = "Add murder hornets to decorative plants [abm_cropocalypse_murder_hornet]",
            nodenames = {"group:decorative_plants"},

            catch_up = false,
            chance = 1000,
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
                    glow = 0,
                    pos = {
                        max = vector.add(pos, vector.new(1.5, 1.5, 1.5)),
                        min = vector.add(pos, vector.new(-1.5, 0, -1.5)),
                    },
                    texpool = {
                        {
                            name = "unilib_particle_murder_hornet.png",
                            alpha_tween = {1, 1},
                            animation = {
                                type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1,
                            },
                            scale = 0.5,
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
