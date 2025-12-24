---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_chimpanzee_normal = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_chimpanzee_normal.init()

    return {
        description = "Normal chimpanzee",
        depends = {"brain_herbivore", "item_bone_animal"},
    }

end

function unilib.pkg.mob_chimpanzee_normal.exec()

    -- Setup
--  local mesh = "unilib_mob_chimpanzee_normal.b3d"

    local skin_init_list = {
        -- Normal skins
        {"black", S("Black"), 1},
        {"brown", S("Brown"), 1},
        {"red", S("Red"), 0.1},
        {"white", S("White"), 0.01},
    }
    local genetic_init_list = {
        -- Standard genes
        {"agility", S("Agility"), "range", 1, 3, 0, 12},
        {"digestion", S("Digestion"), "range", 1, 3, 0, 12},
        {"loftiness", S("Loftiness"), "range", 1, 3, 0, 12},
        {"luckiness", S("Luckiness"), "range", 1, 3, 0, 12},
        {"springiness", S("Springiness"), "range", 1, 3, 0, 12},
    }

    local brain_func = unilib.pkg.brain_herbivore.brain
    local description = unilib.utils.brackets(S("Chimpanzee"), S("Normal"))
    local insertion_table = {
        subject = T(S("chimpanzee#subject")),
        subject_an = T(S("a chimpanzee#subject")),
        subject_the = T(S("the chimpanzee#subject")),
        object = T(S("chimpanzee#object")),
        object_an = T(S("a chimpanzee#object")),
        object_the = T(S("the chimpanzee#object")),
    }
    local is_wild_flag = false
    local sci_name = "Pan troglodytes"
    local version = 1

    -- Register the entity and its spawnegg
    unimobs.petz_api.register_standard_mob({
        -- From petz:chimp
        mob_type = "chimpanzee_normal",
        orig_spawnegg_name = "petz:chimp_set",

        replace_mode = mode,
        insertion_table = insertion_table,
        version = version,

        def_table = {
            -- Base properties
            petz_compat_flag = true,
            class_type = "chimpanzee",
            -- (Was .type = "chimp")
            mob_type = "chimpanzee_normal",
            generic_type = "chimpanzee_normal",

            description = description,
            sci_name = sci_name,

            -- Common properties
--          backface_culling = false,
--          collide_with_objects = true,
            collisionbox = {
                p1 = {x = -0.25, y = -0.5, z = -0.125},
                p2 = {x = 0.1875, y = -0.125, z = 0.3125},
            },
            makes_footstep_sound = true,
--          mesh = nil,
--          physical = true,
--          selectionbox = nil,
--          static_save = true,
--          stepheight = 0.1,
--          textures = nil,
--          visual = nil,
--          visual_size = nil,

            -- Mobkit API properties
            animation_table = {
                climb = {range = {x = 78, y = 90}, speed = 5, loop = true},
                hang = {range = {x = 63, y = 75}, speed = 5, loop = true},
                run = {range = {x = 1, y = 12}, speed = 25, loop = true},
                sit = {range = {x = 51, y = 60}, speed = 5, loop = true},
                stand = {
                    {range = {x = 12, y = 24}, speed = 5, loop = true},
                    {range = {x = 24, y = 36}, speed = 10, loop = true},
                    {range = {x = 36, y = 48}, speed = 10, loop = true},
                },
                walk = {range = {x = 1, y = 12}, speed = 25, loop = true},
            },
--          armour_groups = nil,
--          attack_table = {range = 0.5, damage_groups = {fleshy = 3}},
--          bounciness = 0,
            brain_func = brain_func,
--          buoyancy = 0.5,
            jump_height = 5.0,
--          lung_capacity = 10,
            max_hp = 8,
            max_speed = 2.0,
--          physics_func = nil,
            sounds = {
                misc = {
                    "unilib_mob_chimpanzee_normal_hoo_1",
                    "unilib_mob_chimpanzee_normal_hoo_2",
                    -- N.B. Original mod provides this sound file, but it was not used in code
                    "unilib_mob_chimpanzee_normal_hoo_3",
                },
                moaning = "unilib_mob_chimpanzee_normal_moaning",
            },
--          timeout = nil,
            view_range = 10,

            -- Petz non-dynamic properties
--          avoid_players_flag = false,
--          baby_type_list = nil,
--          can_alight_flag = false,
            -- N.B. In original code, .can_breed_flag = false
            can_breed_flag = true,
            can_climb_trees_flag = true,
--          can_clutch_flag = false,
--          can_fly_flag = false,
            can_groom_flag = true,
--          can_herd_flag = false,
--          can_jump_flag = false,
--          can_perch_flag = false,
--          can_pluck_flag = false,
--          can_swim_flag = false,
            capture_type = "lasso",
--          default_rotation = unimobs.petz_const.rotate,
--          die_in_daylight_flag = false,
            drop_list = {
                {name = "unilib:item_bone_animal", chance = 4, min = 1, max = 1},
            },
--          dung_name = nil,
--          egg_name = nil,
            has_tamagotchi_mode_flag = true,
--          head_prop_table = nil,
--          hostile_to_players_flag = false,
--          igniter_immunity_flag = false,
--          is_baby_flag = nil,
--          is_boss_flag = false,
--          is_male_flag = nil,
--          is_mammal_flag = false,
--          is_milkable_flag = false,
--          is_monster_flag = false,
--          is_mountable_flag = false,
            is_pet_flag = true,
            is_wild_flag = is_wild_flag,
--          jump_chance = nil,
--          jump_impulse = nil,
            -- N.B. .max_roam_height = nil in original code
            max_roam_height = 8,
--          nest_empty_name = nil,
--          nest_full_name = nil,
            obeys_orders_flag = true,
--          parent_type_list = nil,
--          sleep_in_day_flag = false,
--          sleep_in_night_flag = false,
--          sleep_ratio = nil,
--          spawn_max_light = nil,
            -- N.B. No light restrictions in original code
            spawn_min_light = 12,
            spawn_max_height =
                    unimobs.petz_api.get_custom_msetting("chimpanzee_normal", "spawn_max_height"),
            spawn_min_height =
                    unimobs.petz_api.get_custom_msetting("chimpanzee_normal", "spawn_min_height"),
            straggle_type_list = {"chimpanzee_normal"},

            -- Petz mob-specific properties

            -- unimobs.petz_api.register_standard_mob() properties
            baby_scale_factor = 0.5,
            genetic_init_list = genetic_init_list,
            -- N.B. 2.0 in original code
            scale_factor = 2.5,
            skin_init_list = skin_init_list,
        },
    })

end
