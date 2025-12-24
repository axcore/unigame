---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wildlife
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_deer_simple = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.wildlife.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_deer_simple.init()

    return {
        description = "Simple deer mob",
        depends = "brain_deer_simple",
        optional = "mob_wolf_simple",
    }

end

function unilib.pkg.mob_deer_simple.exec()

    -- Setup
    local cbox = {-0.35, -0.19, -0.35, 0.35, 0.65, 0.35}
    local visual_size = {x = 1.3, y = 1.3}

    local mesh = "unilib_mob_deer_simple.b3d"

    -- Register the entity
    unilib.register_entity("unilib:mob_deer_simple", {
        -- From wildlife:deer

        -- Base properties (original to unimobs)
        petz_compat_flag = false,

        -- Common properties
        initial_properties = {
--          backface_culling = false,
            collide_with_objects = true,
            collisionbox = cbox,
            makes_footstep_sound = true,
            mesh = mesh,
            physical = true,
            -- N.B. No .selectionbox in original code
            selectionbox = cbox,
            static_save = true,
            stepheight = 0.1,
            textures = {"unilib_mob_deer_simple.png"},
            visual = "mesh",
            visual_size = visual_size,
        },

        -- Mobkit API properties
        animation_table = {
            stand = {range = {x = 1, y = 5}, speed = 1, loop = true},
            walk = {range = {x = 10, y = 29}, speed = 30, loop = true},
        },
--      armour_groups = nil,
        attack_table = {range = 0.5, damage_groups = {fleshy = 3}},
        bounciness = 0,
        brain_func = unilib.pkg.brain_deer_simple.brain,
        buoyancy = 0.9,
        jump_height = 1.26,
        lung_capacity = 10,
        max_hp = 10,
        max_speed = 5,
--      physics_func = nil,
        sounds = {
            hurt = "unilib_mob_deer_simple_hurt",
            scared = "unilib_mob_deer_simple_scared",
        },
        timeout = 600,
        view_range = 24,

        -- Required callbacks

        get_staticdata = unimobs.mobkit_api.get_staticdata_callback,
        on_activate = unimobs.mobkit_api.on_activate_callback,
        on_step = unimobs.mobkit_api.on_step_callback,

        -- Optional callbacks

        on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)

            local hvel = vector.multiply(vector.normalize({x = dir.x, y = 0, z = dir.z}), 4)
            self.object:set_velocity({x = hvel.x, y = 2, z = hvel.z})
            unimobs.mobkit_api.do_entity_sound(self, "unilib_mob_deer_simple_hurt")
            unimobs.mobkit_api.apply_damage(self, tool_capabilities.damage_groups.fleshy or 1)

        end,
    })

end
