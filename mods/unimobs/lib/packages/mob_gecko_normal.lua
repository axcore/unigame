---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_gecko_normal = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_gecko_normal.init()

    return {
        description = "Normal gecko",
        depends = "brain_herbivore",
        -- N.B. Laying eggs is optional, and occurs only when this package is loaded
        optional = "egg_gecko_normal",
    }

end

function unilib.pkg.mob_gecko_normal.exec()

    -- Setup
--  local mesh = "unilib_mob_gecko_normal.b3d"

    local skin_init_list = {
        -- Normal skins
        {"green", S("Green"), 1},
        {"yellow", S("Yellow"), 0.5},
        {"orange", S("Orange"), 0.1},
        {"blue", S("Blue"), 0.01},
    }
    local genetic_init_list = {
        -- Standard genes
        {"fertility", S("Camouflage"), "range", 1, 3, 0, 12},
        {"productivity", S("Slipperiness"), "range", 1, 3, 0, 12},
        -- Standard genes (generic)
        {"generic", S("Sticky toes"), "range", 1, 3, 0, 12},
    }

    local brain_func = unilib.pkg.brain_herbivore.brain
    local description = unilib.utils.brackets(S("Gecko"), S("Normal"))
    local insertion_table = {
        subject = T(S("gecko#subject")),
        subject_an = T(S("a gecko#subject")),
        subject_the = T(S("the gecko#subject")),
        object = T(S("gecko#object")),
        object_an = T(S("a gecko#object")),
        object_the = T(S("the gecko#object")),
    }
    local is_wild_flag = false
    local sci_name = "Hemidactylus frenatus"
    local version = 1

    -- Initialise the .custom_table field of unimobs.petz_msetting, if the remix CSV has not
    --      already initialised it
    unimobs.petz_api.initialise_custom_msetting("gecko_normal", "custom_max_laid_eggs", 1)

    -- Register the entity and its spawnegg
    unimobs.petz_api.register_standard_mob({
        -- From petz:gecko
        mob_type = "gecko_normal",
        orig_spawnegg_name = "petz:gecko_set",

        replace_mode = mode,
        insertion_table = insertion_table,
        version = version,

        def_table = {
            -- Base properties
            petz_compat_flag = true,
            class_type = "gecko",
            -- (Was .type = "gecko")
            mob_type = "gecko_normal",
            generic_type = "gecko_normal",

            description = description,
            sci_name = sci_name,

            -- Common properties
            backface_culling = false,
--          collide_with_objects = true,
            collisionbox = {
                p1 = {x = -0.125, y = -0.5, z = -0.125},
                p2 = {x = 0.125, y = -0.3125, z = 0.4375},
            },
--          makes_footstep_sound = false,
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
                idle = {range = {x = 0, y = 0}, speed = 25, loop = false},
                run = {range = {x = 13, y = 25}, speed = 25, loop = true},
                sleep = {range = {x = 62, y = 70}, speed = 10, loop = false},
                stand = {
                    {range = {x = 26, y = 46}, speed = 5, loop = true},
                    {range = {x = 47, y = 59}, speed = 5, loop = true},
                },
                walk = {range = {x = 1, y = 12}, speed = 25, loop = true},
            },
--          armour_groups = nil,
--          attack_table = {range = 0.5, damage_groups = {fleshy = 3}},
--          bounciness = 0,
            brain_func = brain_func,
--          buoyancy = 0.5,
--          jump_height = 5.0,
--          lung_capacity = 10,
--          max_hp = nil,
            max_speed = 2.0,
--          physics_func = nil,
--          sounds = nil,
--          timeout = nil,
--          view_range = 10,

            -- Petz non-dynamic properties
--          avoid_players_flag = false,
--          baby_type_list = nil,
--          can_alight_flag = false,
--          can_breed_flag = false,
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
--          default_rotation = unimobs.petz_const.rotate,
--          die_in_daylight_flag = false,
--          drop_list = nil,
--          dung_name = nil,
            egg_name = "unilib:egg_gecko_normal",
--          has_tamagotchi_mode_flag = false,
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
            is_pet_flag = false,
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
--          spawn_max_light = nil,
            -- N.B. No light restrictions in original code
            spawn_min_light = 12,
            spawn_max_height =
                    unimobs.petz_api.get_custom_msetting("gecko_normal", "spawn_max_height"),
            spawn_min_height =
                    unimobs.petz_api.get_custom_msetting("gecko_normal", "spawn_min_height"),
--          straggle_type_list = nil,

            -- Petz mob-specific properties
            -- (N.B. removed the .egg property from the original code; gecko eggs are now produced
            --      in a separate package)

            -- unimobs.petz_api.register_standard_mob() properties
            genetic_init_list = genetic_init_list,
            scale_factor = 1.0,
            skin_init_list = skin_init_list,
        },
    })

end
