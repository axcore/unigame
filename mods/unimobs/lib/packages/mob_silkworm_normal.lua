---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_silkworm_normal = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local random = math.random

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function convert_to_cocoon(self)

    -- From petz.init_convert_to_chrysalis()
    -- Called periodically by the silkworm's .on_activate() callback, and then by this function
    --      recursively, to convert the silkworm to a cocoon (which later becomes a moth)

    core.after(
        random(
            unimobs.petz_api.get_custom_msetting("silkworm_normal", "cocoon_min_time"),
            unimobs.petz_api.get_custom_msetting("silkworm_normal", "cocoon_max_time")
        ),
        function()

            if not unimobs.mobkit_api.is_object_alive(self) then
                return
            end

            local pos = self.object:get_pos()
            local air_pos = core.find_node_near(pos, 1, {"air"}, true)
            if air_pos then

                core.set_node(air_pos, {name = "unilib:misc_cocoon_silkworm"})
                unimobs.kitz_api.remove_mob(self)

            else

                -- If conversion fails, call this function recursively in order to try again later
                convert_to_cocoon(self)

            end

        end,
        self
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_silkworm_normal.init()

    return {
        description = "Normal silkworm",
        depends = {"brain_herbivore", "misc_cocoon_silkworm"},
    }

end

function unilib.pkg.mob_silkworm_normal.exec()

    -- Setup
    local p1 = {x = -0.125, y = -0.5, z = -0.3125}
    local p2 = {x = 0.0625, y = -0.25, z = 0.3125}
    local scale_factor = 0.75

    local cbox = unimobs.petz_api.get_standard_collisionbox(p1, p2, scale_factor, nil)
    local visual_size = unimobs.petz_api.get_standard_visual_size(scale_factor)

    local mesh = "unilib_mob_silkworm_normal.b3d"

    local skin_init_list = {
        -- Normal skins
        {"red", S("Red"), 1},
        {"green", S("Green"), 0.5},
        {"white", S("White"), 0.1},
        {"yellow", S("Yellow"), 0.1},
    }
    -- N.B. No genetic traits because of non-standard breeding system
    local genetic_init_list = {}

    local brain_func = unilib.pkg.brain_herbivore.brain
    local description = unilib.utils.brackets(S("Silkworm"), S("Normal"))
    local insertion_table = {
        subject = T(S("silkworm#subject")),
        subject_an = T(S("a silkworm#subject")),
        subject_the = T(S("the silkworm#subject")),
        object = T(S("silkworm#object")),
        object_an = T(S("a silkworm#object")),
        object_the = T(S("the silkworm#object")),
    }
    local is_wild_flag = false
    local sci_name = "Bombyx mori"
    local version = 1

    -- Initialise the .custom_table field of unimobs.petz_msetting, if the remix CSV has not
    --      already initialised it
    unimobs.petz_api.initialise_custom_msetting("silkworm_normal", "cocoon_max_time", 1500)
    unimobs.petz_api.initialise_custom_msetting("silkworm_normal", "cocoon_min_time", 1200)
    unimobs.petz_api.initialise_custom_msetting(
        "silkworm_normal", "lay_egg_on_node", "group:leaves"
    )

    -- Register the entity
    unilib.register_entity("unilib:mob_silkworm_normal", {
        -- From petz:silkworm

        -- Base properties (original to unimobs)
        petz_compat_flag = true,
        class_type = "silkworm",
        -- (Was .type = "silkworm")
        mob_type = "silkworm_normal",
        generic_type = "silkworm_normal",

        description = description,
        sci_name = sci_name,

        -- Common properties
        initial_properties = {
--          backface_culling = false,
            collide_with_objects = true,
            collisionbox = cbox,
--          makes_footstep_sound = false,
            mesh = mesh,
            physical = true,
            selectionbox = cbox,
            static_save = true,
            stepheight = 0.1,
            textures = unimobs.petz_api.compile_texture_list("silkworm_normal", skin_init_list),
            visual = unimobs.petz_const.visual,
            visual_size = visual_size,
        },

        -- Mobkit API properties
        animation_table = {
            run = {range = {x = 0, y = 12}, speed = 10, loop = true},
            stand = {
                {range = {x = 12, y = 24}, speed = 5, loop = true},
                {range = {x = 24, y = 31}, speed = 5, loop = true},
            },
            walk = {range = {x = 0, y = 12}, speed = 10, loop = true},
        },
--      armour_groups = nil,
        attack_table = {range = 0.5, damage_groups = {fleshy = 3}},
        bounciness = 0,
        brain_func = brain_func,
        buoyancy = 0.5,
        jump_height = 1.0,
        lung_capacity = 10,
        max_hp = 2,
        max_speed = 0.25,
--      physics_func = nil,
--      sounds = nil
--      timeout = nil,
        view_range = 10,

        -- Petz non-dynamic properties
--      avoid_players_flag = false,
--      baby_type_list = nil,
--      can_alight_flag = false,
--      can_breed_flag = false,
--      can_climb_trees_flag = false,
--      can_clutch_flag = false,
--      can_fly_flag = false,
        can_groom_flag = false,
--      can_herd_flag = false,
--      can_jump_flag = false,
--      can_perch_flag = false,
--      can_pluck_flag = false,
--      can_swim_flag = false,
        capture_type = "bug_net",
        default_rotation = unimobs.petz_const.rotate,
--      die_in_daylight_flag = false,
--      drop_list = nil,
--      dung_name = nil,
        -- N.B. Silkworm eggs, laid by moths, are handled in the "mob_moth_normal" package, so there
        --      is no need to set .egg_name
--      egg_name = nil,
        has_tamagotchi_mode_flag = false,
--      head_prop_table = nil,
--      hostile_to_players_flag = false,
--      igniter_immunity_flag = false,
--      is_baby_flag = nil,
--      is_boss_flag = false,
--      is_male_flag = nil,
--      is_mammal_flag = false,
--      is_milkable_flag = false,
--      is_monster_flag = false,
--      is_mountable_flag = false,
        is_pet_flag = false,
        is_wild_flag = is_wild_flag,
--      jump_chance = nil,
--      jump_impulse = nil,
--      max_roam_height = nil,
--      nest_empty_name = nil,
--      nest_full_name = nil,
        obeys_orders_flag = false,
--      parent_type_list = nil,
--      sleep_in_day_flag = false,
--      sleep_in_night_flag = false,
--      sleep_ratio = nil,
--      spawn_max_light = nil,
--      spawn_min_light = nil,
        spawn_max_height =
                unimobs.petz_api.get_custom_msetting("silkworm_normal", "spawn_max_height"),
        spawn_min_height =
                unimobs.petz_api.get_custom_msetting("silkworm_normal", "spawn_min_height"),
--      straggle_type_list = nil,

        -- Petz baby properties
--      collisionbox_baby = nil,
--      selectionbox_baby = nil,
--      visual_size_baby = nil,

        -- Petz replace properties (N.B. .replace_offset has been removed)
        replace_data_list = {
            {"group:leaves", "air", -1},
        },
        replace_rate = 10,
        replace_turf_flag = false,
--      replace_turf_offset = 0,

        -- Petz mob-specific properties

        -- Required callbacks

        get_staticdata = unimobs.mobkit_api.get_staticdata_callback,

        on_activate = function(self, staticdata, dtime_s)

            unimobs.mobkit_api.on_activate_callback(self, staticdata, dtime_s)
            unimobs.petz_api.set_mob_initial_properties(self, staticdata, dtime_s)
            convert_to_cocoon(self)

        end,

        on_step = function(self, dtime)

            unimobs.mobkit_api.on_step_callback(self, dtime)
            unimobs.petz_api.on_step_callback(self, dtime)

        end,

        -- Petz callbacks

        on_deactivate = function(self)
            unimobs.petz_api.on_deactivate_callback(self)
        end,

        on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)

            unimobs.petz_api.on_punch_callback(
                self, puncher, time_from_last_punch, tool_capabilities, dir
            )

        end,

        on_rightclick = function(self, clicker)
            unimobs.petz_api.on_rightclick_callback(self, clicker)
        end,
    })

    if unimobs.petz_api.register_mob({
        mob_type = "silkworm_normal",
        mob_name = "unilib:mob_silkworm_normal",
        description = description,
        insertion_table = insertion_table,

        collisionbox = cbox,
        genetic_init_list = genetic_init_list,
        insertion_table = insertion_table,
        mesh = mesh,
        skin_init_list = skin_init_list,
        version = version,
        visual_size = visual_size,
    }) then

        unimobs.petz_api.register_spawnegg({
            -- From petz:silkworm_set. Creates unilib:spawnegg_silkworm_normal
            mob_type = "silkworm_normal",
            orig_name = "petz:silkworm_set",

            replace_mode = mode,
            description = description,
            img = "unilib_spawnegg_silkworm_normal.png",
            mob_name = "unilib:mob_silkworm_normal",
            sci_name = sci_name,
            tamed_flag = not is_wild_flag,
        })

    end

end
