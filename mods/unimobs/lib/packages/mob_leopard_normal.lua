---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_leopard_normal = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_leopard_normal.init()

    return {
        description = "Normal leopard",
        depends = {"brain_predator", "item_bone_animal", "organ_skin_leopard_normal"},
    }

end

function unilib.pkg.mob_leopard_normal.exec()

    -- Setup
    local p1 = {x = -0.0625, y = -0.5, z = -0.375}
    local p2 = {x = 0.125, y = 0, z = 0.375}
    local scale_factor = 2.0
    local baby_scale_factor = 0.5

    local cbox, cbox_baby =
            unimobs.petz_api.get_standard_collisionbox(p1, p2, scale_factor, baby_scale_factor)
    local visual_size = unimobs.petz_api.get_standard_visual_size(scale_factor)

    local mesh = "unilib_mob_leopard_normal.b3d"

    local skin_init_list = {
        -- Normal skins
        {"eyes_green", S("Green-Eyed"), 1},
        {"eyes_blue", S("Blue-Eyed"), 0.1},
        -- Rare mutations
        {"black", S("Black"), 0},
    }
    local genetic_init_list = {
        -- Standard genes
        {"agility", S("Agility"), "range", 1, 3, 0, 12},
        {"compliance", S("Compliance"), "range", 1, 3, 0, 12},
        {"digestion", S("Digestion"), "range", 1, 3, 0, 12},
        {"perception", S("Perception"), "range", 1, 3, 0, 12},
        {"toughness", S("Toughness"), "range", 1, 3, 0, 12},
        -- Standard genes (genetic mutations)
        {"variability", S("Variability"), "range", 2, 4, 0, 12},
    }

    local brain_func = unilib.pkg.brain_predator.brain
    local description = unilib.utils.brackets(S("Leopard"), S("Normal"))
    local insertion_table = {
        subject = T(S("leopard#subject")),
        subject_an = T(S("a leopard#subject")),
        subject_the = T(S("the leopard#subject")),
        object = T(S("leopard#object")),
        object_an = T(S("a leopard#object")),
        object_the = T(S("the leopard#object")),
    }
    local is_wild_flag = true
    local sci_name = "Panthera pardus"
    local version = 1

    -- Register the entity
    unilib.register_entity("unilib:mob_leopard_normal", {
        -- From petz:leopard

        -- Base properties (original to unimobs)
        petz_compat_flag = true,
        class_type = "leopard",
        -- (Was .type = "leopard")
        mob_type = "leopard_normal",
        generic_type = "leopard_normal",

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
            textures = unimobs.petz_api.compile_texture_list("leopard_normal", skin_init_list),
            visual = unimobs.petz_const.visual,
            visual_size = visual_size,
        },

        -- Mobkit API properties
        animation_table = {
            attack = {range = {x = 72, y = 84}, speed = 5, loop = false},
            run = {range = {x = 13, y = 25}, speed = 25, loop = true},
            sit = {range = {x = 60, y = 65}, speed = 5, loop = false},
            stand = {
                {range = {x = 26, y = 46}, speed = 5, loop = true},
                {range = {x = 47, y = 59}, speed = 5, loop = true},
                {range = {x = 82, y = 94}, speed = 5, loop = true},
            },
            walk = {range = {x = 1, y = 12}, speed = 25, loop = true},
        },
--      armour_groups = nil,
        attack_table = {range = 0.5, damage_groups = {fleshy = 9}},
        bounciness = 0,
        brain_func = brain_func,
        buoyancy = 0.5,
        jump_height = 1.5,
        lung_capacity = 10,
        max_hp = 25,
        max_speed = 4.0,
--      physics_func = nil,
        sounds = {
            attack = "unilib_mob_leopard_normal_attack",
            misc = "unilib_mob_leopard_normal_roar",
            moaning = "unilib_mob_leopard_normal_moaning",
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
        -- N.B. In original code, .can_groom_flag = true
        can_groom_flag = false,
--      can_herd_flag = false,
--      can_jump_flag = false,
--      can_perch_flag = false,
--      can_pluck_flag = false,
--      can_swim_flag = false,
        capture_type = "lasso",
        default_rotation = unimobs.petz_const.rotate,
--      die_in_daylight_flag = false,
        drop_list = {
            {name = "unilib:item_bone_animal", chance = 5, min = 1, max = 1},
            {name = "unilib:organ_skin_leopard_normal", chance = 3, min = 1, max = 1},
        },
--      dung_name = nil,
--      egg_name = nil,
        -- N.B. In original code, .has_tamagotchi_mode_flag = true
        has_tamagotchi_mode_flag = false,
--      head_prop_table = nil,
        hostile_to_players_flag = true,
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
--      jump_chance = nil,
--      jump_impulse = nil,
--      max_roam_height = nil,
--      nest_empty_name = nil,
--      nest_full_name = nil,
        -- N.B. In original code, .obeys_orders_flag = true
        obeys_orders_flag = false,
--      parent_type_list = nil,
--      sleep_in_day_flag = false,
--      sleep_in_night_flag = false,
--      sleep_ratio = nil,
--      spawn_max_light = nil,
        -- N.B. No light restrictions in original code
        spawn_min_light = 12,
        spawn_max_height =
                unimobs.petz_api.get_custom_msetting("leopard_normal", "spawn_max_height"),
        spawn_min_height =
                unimobs.petz_api.get_custom_msetting("leopard_normal", "spawn_min_height"),
        straggle_type_list = {"leopard_normal"},

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
        mob_type = "leopard_normal",
        mob_name = "unilib:mob_leopard_normal",
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
            -- From petz:leopard_set. Creates unilib:spawnegg_leopard_normal
            mob_type = "leopard_normal",
            orig_name = "petz:leopard_set",

            replace_mode = mode,
            description = description,
            img = "unilib_spawnegg_leopard_normal.png",
            mob_name = "unilib:mob_leopard_normal",
            sci_name = sci_name,
            tamed_flag = not is_wild_flag,
        })

    end

end
