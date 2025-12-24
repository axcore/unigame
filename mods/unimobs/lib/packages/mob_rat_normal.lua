---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_rat_normal = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_rat_normal.init()

    return {
        description = "Normal rat",
        depends = {"brain_predator", "item_bone_animal"},
    }

end

function unilib.pkg.mob_rat_normal.exec()

    -- Setup
--  local mesh = "unilib_mob_rat_normal.b3d"

    local skin_init_list = {
        -- Normal skins
        {"grey", S("Grey"), 1},
        {"black", S("Black"), 0.5},
        {"brown", S("Brown"), 0.5},
        {"silver", S("Silver"), 0.1},
        -- Rare mutations
        {"white", S("White"), 0},
    }
    local genetic_init_list = {
        -- Standard genes
        {"agility", S("Dexterity"), "range", 1, 3, 0, 12},
        {"digestion", S("Voraciousness"), "range", 1, 3, 0, 12},
        {"fertility", S("Abundance"), "range", 1, 3, 0, 12},
        {"toughness", S("Hardiness"), "range", 1, 3, 0, 12},
        -- Standard genes (genetic mutations)
        {"variability", S("Variability"), "range", 2, 4, 0, 12},
    }

    local brain_func = unilib.pkg.brain_predator.brain
    local description = unilib.utils.brackets(S("Rat"), S("Normal"))
    local insertion_table = {
        subject = T(S("rat#subject")),
        subject_an = T(S("a rat#subject")),
        subject_the = T(S("the rat#subject")),
        object = T(S("rat#object")),
        object_an = T(S("a rat#object")),
        object_the = T(S("the rat#object")),
    }
    local is_wild_flag = true
    local sci_name = "Rattus norvegicus domestica"
    local version = 1

    -- Register the entity and its spawnegg
    unimobs.petz_api.register_standard_mob({
        -- From petz:rat
        mob_type = "rat_normal",
        orig_spawnegg_name = "petz:rat_set",

        replace_mode = mode,
        insertion_table = insertion_table,
        version = version,

        def_table = {
            -- Base properties
            petz_compat_flag = true,
            class_type = "rat",
            -- (Was .type = "rat")
            mob_type = "rat_normal",
            generic_type = "rat_normal",

            description = description,
            sci_name = sci_name,

            -- Common properties
--          backface_culling = false,
--          collide_with_objects = true,
            collisionbox = {
                p1 = {x = -0.1875, y = -0.5, z = -0.1875},
                p2 = {x = 0.1875, y = -0.125, z = 0.1875},
            },
--          makes_footstep_sound = false,
--          mesh = nil,
--          physical = true,
            selectionbox = {
                p1 = {x = -0.1875, y = -0.5, z = -0.25},
                p2 = {x = 0.18755, y = -0.125, z = 0.375},
            },
--          static_save = true,
--          stepheight = 0.1,
--          textures = nil,
--          visual = nil,
--          visual_size = nil,

            -- Mobkit API properties
            animation_table = {
                run = {range = {x = 13, y = 25}, speed = 25, loop = true},
                stand = {
                    {range = {x = 26, y = 46}, speed = 5, loop = true},
                    {range = {x = 47, y = 59}, speed = 5, loop = true},
                    {range = {x = 82, y = 94}, speed = 5, loop = true},
                },
                walk = {range = {x = 1, y = 12}, speed = 25, loop = true},
            },
--          armour_groups = nil,
            attack_table = {range = 0.5, damage_groups = {fleshy = 7}},
--          bounciness = 0,
            brain_func = brain_func,
--          buoyancy = 0.5,
            jump_height = 2,
--          lung_capacity = 10,
            max_hp = 20,
            max_speed = 3.0,
--          physics_func = nil,
            sounds = {
                attack = "unilib_mob_rat_normal_squeak",
                misc = "unilib_mob_rat_normal_squeak",
            },
--          timeout = nil,
            view_range = 10,

            -- Petz non-dynamic properties
--          avoid_players_flag = false,
--          baby_type_list = nil,
--          can_alight_flag = false,
            -- N.B. In original code, .can_breed_flag = false
            can_breed_flag = true,
--          can_climb_trees_flag = false,
--          can_clutch_flag = false,
--          can_fly_flag = false,
--          can_groom_flag = false,
--          can_herd_flag = false,
--          can_jump_flag = false,
--          can_perch_flag = false,
--          can_pluck_flag = false,
--          can_swim_flag = false,
            capture_type = "animal_net",
            default_rotation = unimobs.petz_const.rotate,
--          die_in_daylight_flag = false,
            drop_list = {
                {name = "unilib:item_bone_animal", chance = 5, min = 1, max = 1},
            },
--          dung_name = nil,
--          egg_name = nil,
--          has_tamagotchi_mode_flag = false,
            head_prop_table = {
                position = vector.new(0, 0.2908, -0.2908),
                -- (In degrees, normally values are -90, 0, 90)
                rotation_origin = vector.new(-90, 0, 0),
                eye_offset = -0.2,
            },
            hostile_to_players_flag = true,
--          igniter_immunity_flag = false,
--          is_baby_flag = nil,
--          is_boss_flag = false,
--          is_male_flag = nil,
--          is_mammal_flag = false,
--          is_milkable_flag = false,
            is_monster_flag = true,
--          is_mountable_flag = false,
--          is_pet_flag = false,
            is_wild_flag = is_wild_flag,
--          jump_chance = nil,
--          jump_impulse = nil,
--          max_roam_height = nil,
--          nest_empty_name = nil,
--          nest_full_name = nil,
--          obeys_orders_flag = false,
--          parent_type_list = nil,
--          sleep_in_day_flag = false,
--          sleep_in_night_flag = false,
--          sleep_ratio = nil,
            -- N.B. No light restrictions in original code
            spawn_max_light = 4,
--          spawn_min_light = nil,
            spawn_max_height =
                    unimobs.petz_api.get_custom_msetting("rat_normal", "spawn_max_height"),
            spawn_min_height =
                    unimobs.petz_api.get_custom_msetting("rat_normal", "spawn_min_height"),
            straggle_type_list = {"rat_normal"},

            -- Petz mob-specific properties

            -- unimobs.petz_api.register_standard_mob() properties
            baby_scale_factor = 0.66,
            genetic_init_list = genetic_init_list,
            scale_factor = 1.2,
            skin_init_list = skin_init_list,
        },
    })

end
