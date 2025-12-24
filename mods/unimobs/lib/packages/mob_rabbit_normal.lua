---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_rabbit_normal = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_rabbit_normal.init()

    return {
        description = "Normal rabbit",
        depends = {"brain_herbivore", "food_rabbit", "item_bone_animal", "organ_hide_rabbit"},
    }

end

function unilib.pkg.mob_rabbit_normal.exec()

    -- Setup
    local p1 = {x = -0.25, y = -0.5, z = -0.125}
    local p2 = {x = 0.25, y = -0.0625, z = 0.1875}
    local scale_factor = 1.3
    local baby_scale_factor = 0.5

    local cbox, cbox_baby =
            unimobs.petz_api.get_standard_collisionbox(p1, p2, scale_factor, baby_scale_factor)
    local visual_size = unimobs.petz_api.get_standard_visual_size(scale_factor)

    local mesh = "unilib_mob_rabbit_normal.b3d"

    local skin_init_list = {
        -- Normal skins
        {"black", S("Black"), 1},
        {"brown", S("Brown"), 1},
        {"grey", S("Grey"), 1},
        {"white", S("White"), 0.1},
        -- Rare mutations
        {"pink", S("Pink"), 0},
    }
    local genetic_init_list = {
        -- Standard genes
        {"digestion", S("Digestion"), "range", 1, 3, 0, 12},
        {"docility", S("Docility"), "range", 1, 3, 0, 12},
        {"fertility", S("Fertility"), "range", 1, 3, 0, 12},
        {"springiness", S("Springiness"), "range", 1, 3, 0, 12},
        -- Standard genes (genetic mutations)
        {"variability", S("Variability"), "range", 2, 4, 0, 12},
    }

    local brain_func = unilib.pkg.brain_herbivore.brain
    local description = unilib.utils.brackets(S("Rabbit"), S("Normal"))
    local insertion_table = {
        subject = T(S("rabbit#subject")),
        subject_an = T(S("a rabbit#subject")),
        subject_the = T(S("the rabbit#subject")),
        object = T(S("rabbit#object")),
        object_an = T(S("a rabbit#object")),
        object_the = T(S("the rabbit#object")),
    }
    local is_wild_flag = false
    local sci_name = "Oryctolagus cuniculus domesticus"
    local version = 1

    -- Register the entity
    unilib.register_entity("unilib:mob_rabbit_normal", {
        -- From petz:bunny

        -- Base properties (original to unimobs)
        petz_compat_flag = true,
        class_type = "rabbit",
        -- (Was .type = "bunny")
        mob_type = "rabbit_normal",
        generic_type = "rabbit_normal",

        description = description,
        sci_name = sci_name,

        -- Common properties
        initial_properties = {
--          backface_culling = false,
            collide_with_objects = true,
            collisionbox = cbox,
            makes_footstep_sound = false,
            mesh = mesh,
            physical = true,
            selectionbox = cbox,
            static_save = true,
            stepheight = 0.1,
            textures = unimobs.petz_api.compile_texture_list("rabbit_normal", skin_init_list),
            visual = unimobs.petz_const.visual,
            visual_size = visual_size,
        },

        -- Mobkit API properties
        animation_table = {
            jump = {range = {x = 114, y = 117}, speed = 5, loop = false},
            run = {range = {x = 13, y = 25}, speed = 25, loop = true},
            sit = {range = {x = 60, y = 73}, speed = 10, loop = false},
            sleep = {range = {x = 94, y = 113}, speed = 10, loop = false},
            stand = {
                {range = {x = 26, y = 46}, speed = 5, loop = true},
                {range = {x = 47, y = 59}, speed = 5, loop = true},
                {range = {x = 82, y = 94}, speed = 5, loop = true},
            },
            walk = {range = {x = 1, y = 12}, speed = 25, loop = true},
        },
--      armour_groups = nil,
        attack_table = {range = 0.5, damage_groups = {fleshy = 3}},
        bounciness = 0,
        brain_func = brain_func,
        buoyancy = 0.5,
        jump_height = 1.5,
        lung_capacity = 10,
        max_hp = 8,
        max_speed = 4.0,
--      physics_func = nil,
        sounds = {
            misc = {
                "unilib_mob_rabbit_normal_squeak_1",
                "unilib_mob_rabbit_normal_squeak_2",
                "unilib_mob_rabbit_normal_squeak_3",
            },
            moaning = "unilib_mob_rabbit_normal_moaning",
        },
--      timeout = nil,
        view_range = 10,

        -- Petz non-dynamic properties
--      avoid_players_flag = false,
--      baby_type_list = nil,
--      can_alight_flag = false,
        can_breed_flag = true,
--      can_climb_trees_flag = false,
--      can_clutch_flag = false,
--      can_fly_flag = false,
        can_groom_flag = true,
--      can_herd_flag = false,
        can_jump_flag = true,
--      can_perch_flag = false,
--      can_pluck_flag = false,
--      can_swim_flag = false,
        capture_type = "animal_net",
        default_rotation = unimobs.petz_const.rotate,
--      die_in_daylight_flag = false,
        drop_list = {
            {name = "unilib:food_rabbit_raw", chance = 1, min = 1, max = 1},
            {name = "unilib:organ_hide_rabbit", chance = 3, min = 1, max = 1},
            {name = "unilib:item_bone_animal", chance = 5, min = 1, max = 1},
        },
--      dung_name = nil,
--      egg_name = nil,
        has_tamagotchi_mode_flag = true,
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
        is_pet_flag = true,
        is_wild_flag = is_wild_flag,
        jump_chance = 10,
        jump_impulse = 1.2,
--      max_roam_height = nil,
--      nest_empty_name = nil,
--      nest_full_name = nil,
        obeys_orders_flag = true,
--      parent_type_list = nil,
--      sleep_in_day_flag = false,
        sleep_in_night_flag = true,
        sleep_ratio = 0.3,
--      spawn_max_light = nil,
        -- N.B. No light restrictions in original code
        spawn_min_light = 12,
        spawn_max_height =
                unimobs.petz_api.get_custom_msetting("rabbit_normal", "spawn_max_height"),
        spawn_min_height =
                unimobs.petz_api.get_custom_msetting("rabbit_normal", "spawn_min_height"),
        straggle_type_list = {"rabbit_normal"},

        -- Petz baby properties
        collisionbox_baby = cbox_baby,
        selectionbox_baby = cbox_baby,
        visual_size_baby = {
            x = visual_size.x * baby_scale_factor,
            y = visual_size.y * baby_scale_factor,
        },

        -- Petz replace properties
--      replace_data_list = nil,
--      replace_rate = nil,
--      replace_turf_flag = false,
--      replace_turf_offset = 0,

        -- Petz mob-specific properties

        -- Required callbacks

        get_staticdata = unimobs.mobkit_api.get_staticdata_callback,

        on_activate = function(self, staticdata, dtime_s)

            unimobs.mobkit_api.on_activate_callback(self, staticdata, dtime_s)
            unimobs.petz_api.set_mob_initial_properties(self, staticdata, dtime_s)

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
        mob_type = "rabbit_normal",
        mob_name = "unilib:mob_rabbit_normal",
        description = description,
        insertion_table = insertion_table,

        collisionbox = cbox,
        genetic_init_list = genetic_init_list,
        mesh = mesh,
        skin_init_list = skin_init_list,
        version = version,
        visual_size = visual_size,
    }) then

        unimobs.petz_api.register_spawnegg({
            -- From petz:bunny_set. Creates unilib:spawnegg_rabbit_normal
            mob_type = "rabbit_normal",
            orig_name = "petz:bunny_set",

            replace_mode = mode,
            description = description,
            img = "unilib_spawnegg_rabbit_normal.png",
            mob_name = "unilib:mob_rabbit_normal",
            sci_name = sci_name,
            tamed_flag = not is_wild_flag,
        })

    end

end
