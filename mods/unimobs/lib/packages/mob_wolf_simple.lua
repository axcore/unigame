---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wildlife
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_wolf_simple = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.wildlife.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_wolf_simple.init()

    return {
        description = "Simple wolf mob",
        depends = {"brain_wolf_simple", "hqb_hunt"},
        optional = "mob_deer_simple",
    }

end

function unilib.pkg.mob_wolf_simple.exec()

    -- Setup
    local cbox = {-0.3, -0.01, -0.3, 0.3, 0.7, 0.3}
    local visual_size = {x = 1.3, y = 1.3}

    local mesh = "unilib_mob_wolf_simple.b3d"

    -- Register the entity
    unilib.register_entity("unilib:mob_wolf_simple", {
        -- From wildlife:wolf

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
            textures = {"unilib_mob_wolf_simple.png"},
            visual = "mesh",
            visual_size = visual_size,
        },

        -- Mobkit API propertiess
        animation_table = {
            stand = {range = {x = 1, y = 5}, speed = 1, loop = true},
            walk = {range = {x = 10, y = 29}, speed = 30, loop = true},
        },
--      armour_groups = nil,
        attack_table = {range = 0.5, damage_groups = {fleshy = 7}},
        bounciness = 0,
        brain_func = unilib.pkg.brain_wolf_simple.brain,
        buoyancy = 0.75,
        jump_height = 1.26,
        lung_capacity = 10,
        max_hp = 14,
        max_speed = 5,
--      physics_func = nil,
        sounds = {
            attack = "unilib_mob_wolf_simple_attack",
            warn = "unilib_mob_wolf_simple_warn",
        },
        timeout = 600,
        view_range = 24,

        -- Required callbacks

        get_staticdata = unimobs.mobkit_api.get_staticdata_callback,
        on_activate = unimobs.mobkit_api.on_activate_callback,
        on_step = unimobs.mobkit_api.on_step_callback,

        -- Optional callbacks

        on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)

            if unimobs.mobkit_api.is_object_alive(self) then

                local hvel = vector.multiply(vector.normalize({x = dir.x, y = 0, z = dir.z}), 4)
                self.object:set_velocity({x = hvel.x, y = 2, z = hvel.z})

                unimobs.mobkit_api.apply_damage(self, tool_capabilities.damage_groups.fleshy or 1)

                -- If hit by a player...
                if type(puncher) == "userdata" and puncher:is_player() then

                    -- ...abandon whatever the mob has been doing, and then get revenge
                    unimobs.mobkit_api.clear_high_level_queue(self)
                    unilib.pkg.hqb_hunt.add_to_queue(self, 10, puncher)

                end

            end

        end
    })

end
