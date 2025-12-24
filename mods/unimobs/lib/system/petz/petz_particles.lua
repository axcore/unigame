---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_particles.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Table of data for standard particles, used by calls to unimobs.petz_api.show_standard_particles()
local particle_table = {
    dreamcatcher = {
        interval = 1.5,
        max_size = 2.0,
        min_size = 1.0,
        particles_amount = 15,
        texture_name = "unilib_particle_petz_dreamcatcher.png",
    },
    fire = {
        interval = 1.5,
        max_size = 4.0,
        min_size = 2.0,
        particles_amount = 50,
        texture_name = "unilib_particle_petz_fire.png",
    },
    heart = {
        interval = 1.5,
        max_size = 1.5,
        min_size = 1.0,
        particles_amount = 10,
        texture_name = "unilib_particle_petz_heart.png",
    },
    hungry = {
        interval = 1.5,
        max_size = 2.0,
        min_size = 1.0,
        -- (N.B. Original code does not provide a default texture for this effect)
        particles_amount = 3,
        texture_name = "unilib_crop_wheat_harvest.png",
    },
    pollen = {
        interval = 1.5,
        max_size = 1.0,
        min_size = 0.5,
        particles_amount = 15,
        texture_name = "unilib_misc_pollen_normal.png",
    },
    pregnant = {
        -- (N.B. Original code does not provide a default texture for this effect)
        interval = 1.5,
        max_size = 6.0,
        min_size = 5.0,
        -- N.B. particles_amount = 10 in original code
        particles_amount = 3,
        texture_name = "unilib_particle_petz_pregnant.png",
    },
    pumpkin = {
        interval = 1.5,
        max_size = 4.0,
        min_size = 2.0,
        particles_amount = 10,
        texture_name = "unilib_particle_petz_pumpkin.png",
    },
    sleep = {
        interval = 1.5,
        max_size = 2.0,
        min_size = 1.0,
        particles_amount = 3,
        texture_name = "unilib_particle_petz_sleep.png",
    },
    star = {
        interval = 1.5,
        max_size = 1.5,
        min_size = 1.0,
        particles_amount = 20,
        texture_name = "unilib_particle_petz_star.png",
    },
}

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_particles.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.show_standard_particles(pos, particle_type, override_texture_name)

    -- From petz.do_particles_effect()
    -- Produces the specified set of standard particles (as defined by the table above)
    -- "particle_type" must be one of the values "dreamcatcher", "fire", "heart", "hungry",
    --      "pollen", "pregnant", "pumpkin", "sleep" or "star"
    -- In a change to the original code, the "override_texture_name" can now be specified for any
    --      "particle_type"; if not specified, a generic texture is used

    local min_pos = {x = pos.x, y = pos.y, z = pos.z}
    local max_pos = {x = min_pos.x + 0.4, y = min_pos.y - 0.5, z = min_pos.z + 0.4}
    local mini_table = particle_table[particle_type]
    if mini_table == nil then
        return
    end

    core.add_particlespawner({
        amount = mini_table.particles_amount,
        time = mini_table.interval,
        texture = override_texture_name or mini_table.texture_name,

        collisiondetection = false,
        glow = 14,
        maxexptime = 1,
        minexptime = 1,
        maxpos = max_pos,
        minpos = min_pos,
        maxsize = mini_table.max_size,
        minsize = mini_table.min_size,
        vertical = false,
    })

end

function unimobs.petz_api.show_blood_particles(self)

    -- From petz.blood()
    -- Displays blood particles around the specified mob, if permitted

    if not unimobs.petz_setting.show_blood_on_punch_mob_flag or self.no_blood then
        return
    end

    local pos = self.object:get_pos()
    local texture
    if self.blood_texture then
        texture = self.blood_texture
    else
        texture = "unilib_particle_petz_blood.png"
    end

    local gravity = unimobs.constant.gravity
    core.add_particlespawner({
        amount = 5,
        time = 0.25,
        texture = texture,

        glow = 0,
        maxacc = {x = 0, y = gravity, z = 0},
        minacc = {x = 0, y = gravity, z = 0},
        maxexptime = 1,
        minexptime = 0.1,
        maxpos = pos,
        minpos = pos,
        maxsize = 1,
        minsize = 0.5,
        maxvel = {x = 1, y = 1, z = 1},
        minvel = {x = -1, y = -1, z = -1},
    })

end

function unimobs.petz_api.show_death_particles(self)

    -- Adapted from code in petz.on_die()
    -- Displays death particles around the specified mob, if permitted

    if unimobs.petz_setting.enable_death_particles_flag then

        local pos = self.object:get_pos()

        core.add_particlespawner({
            amount = 20,
            time = 0.001,
            texture = "unilib_particle_petz_smoke.png",

            collisiondetection = false,
            maxacc = {x = 0, y = 0, z = 0},
            minacc = {x = 0, y = 0, z = 0},
            maxexptime = 1.5,
            minexptime = 1.1,
            maxpos = pos,
            minpos = pos,
            maxsize = 2,
            minsize = 1,
            maxvel = vector.new(2, 2, 2),
            minvel = vector.new(-2, -2, -2),
            vertical = false,
        })

    end

end
