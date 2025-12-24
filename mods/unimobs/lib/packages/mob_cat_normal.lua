---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_cat_normal = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_cat_normal.init()

    return {
        description = "Normal cat",
        depends = {"brain_herbivore", "item_bone_animal"},
    }

end

function unilib.pkg.mob_cat_normal.exec()

    -- Setup
--  local mesh = "unilib_mob_cat_normal.b3d"

    local skin_init_list = {
        -- Normal skins
        {"black", S("Black"), 1},
        {"grey_dark", S("Dark Grey"), 1},
        {"yellow", S("Yellow"), 1},
        {"camel", S("Camel"), 0.5},
        {"grey_light", S("Light Grey"), 0.5},
        {"siamese", S("Siamese"), 0.5},
        {"brown_dark", S("Dark Brown"), 0.25},
        {"brown_light", S("Light Brown"), 0.25},
        {"ginger", S("Ginger"), 0.25},
        {"obsidian", S("Obsidian"), 0.1},
        {"smoky", S("Smoky"), 0.1},
        {"snowy", S("Snowy"), 0.1},
        {"chestnut", S("Chestnut"), 0.05},
        {"misty", S("Misty"), 0.05},
        {"olive", S("Olive"), 0.05},
        -- Rare mutations
        {"gina", S("Gina"), 0},
        {"lavender", S("Lavender"), 0},
        {"lemon", S("Lemon"), 0},
        {"mint", S("Mint"), 0},
        {"rose", S("Rose"), 0},

    }
    local genetic_init_list = {
        -- Standard genes
        {"agility", S("Agility"), "range", 1, 3, 0, 12},
        {"digestion", S("Digestion"), "range", 1, 3, 0, 12},
        {"docility", S("Docility"), "range", 1, 3, 0, 12},
--      {"fertility", S("Fertility"), "range", 1, 3, 0, 12},
        {"luckiness", S("Luckiness"), "range", 1, 3, 0, 12},
        {"springiness", S("Springiness"), "range", 1, 3, 0, 12},
        -- Standard genes (genetic mutations)
        {"variability", S("Variability"), "range", 2, 4, 0, 12},
    }

    local brain_func = unilib.pkg.brain_herbivore.brain
    local description = unilib.utils.brackets(S("Cat"), S("Normal"))
    local insertion_table = {
        subject = T(S("cat#subject")),
        subject_an = T(S("a cat#subject")),
        subject_the = T(S("the cat#subject")),
        object = T(S("cat#object")),
        object_an = T(S("a cat#object")),
        object_the = T(S("the cat#object")),
    }
    local is_wild_flag = false
    local sci_name = "Felis catus"
    local version = 1

    -- Register the entity and its spawnegg
    unimobs.petz_api.register_standard_mob({
        -- From petz:kitty
        mob_type = "cat_normal",
        orig_spawnegg_name = "petz:kitty_set",

        replace_mode = mode,
        insertion_table = insertion_table,
        version = version,

        def_table = {
            -- Base properties
            petz_compat_flag = true,
            class_type = "cat",
            -- (Was .type = "kitty")
            mob_type = "cat_normal",
            generic_type = "cat_normal",

            description = description,
            sci_name = sci_name,

            -- Common properties
--          backface_culling = false,
--          collide_with_objects = true,
            collisionbox = {
                p1 = {x = -0.0625, y = -0.5, z = -0.3125},
                p2 = {x = 0.125, y = -0.0625, z = 0.3125},
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
                sit = {range = {x = 60, y = 65}, speed = 5, loop = false},
                sleep = {range = {x = 81, y = 93}, speed = 10, loop = false},
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
            jump_height = 3,
--          lung_capacity = 10,
            max_hp = 18,
            max_speed = 2.0,
--          physics_func = nil,
            sounds = {
                misc = {
                    "unilib_mob_cat_normal_miaow_1",
                    "unilib_mob_cat_normal_miaow_2",
                    "unilib_mob_cat_normal_miaow_3",
                },
                moaning = "unilib_mob_cat_normal_moaning",
            },
--          timeout = nil,
            view_range = 10,

            -- Petz non-dynamic properties
--          avoid_players_flag = false,
--          baby_type_list = nil,
--          can_alight_flag = false,
            can_breed_flag = true,
--          can_climb_trees_flag = false,
--          can_clutch_flag = false,
--          can_fly_flag = false,
            can_groom_flag = true,
--          can_herd_flag = false,
--          can_jump_flag = false,
--          can_perch_flag = false,
--          can_pluck_flag = false,
--          can_swim_flag = false,
            capture_type = "animal_net",
--          default_rotation = unimobs.petz_const.rotate,
--          die_in_daylight_flag = false,
            drop_list = {
                {name = "unilib:item_bone_animal", chance = 5, min = 1, max = 1},
            },
--          dung_name = nil,
--          egg_name = nil,
            has_tamagotchi_mode_flag = true,
            head_prop_table = {
                -- N.B. .clamp_list not in original code
                clamp_list = {
                    -- Look up (-60) / straight ahead (-90) / down (-120)
                    {dim = "x", min = -60, max = 360, correction = -60},
                    {dim = "x", min = -360, max = -120, correction = -120},
                    -- Look left (-90) / straight ahead (0) / right (90)
                    {dim = "y", min = -360, max = -90, correction = -90},
                    {dim = "y", min = 90, max = 360, correction = 90},
                },
                eye_offset = -0.2,
                position = vector.new(0, 0.2908, -0.2908),
                -- (In degrees, normally values are -90, 0, 90)
                rotation_origin = vector.new(-90, 0, 0),
            },
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
--          max_roam_height = nil,
--          nest_empty_name = nil,
--          nest_full_name = nil,
            obeys_orders_flag = true,
--          parent_type_list = nil,
            sleep_in_day_flag = true,
--          sleep_in_night_flag = false,
            sleep_ratio = 0.3,
--          spawn_max_light = nil,
            -- N.B. No light restrictions in original code
            spawn_min_light = 12,
            spawn_max_height =
                    unimobs.petz_api.get_custom_msetting("cat_normal", "spawn_max_height"),
            spawn_min_height =
                    unimobs.petz_api.get_custom_msetting("cat_normal", "spawn_min_height"),
            straggle_type_list = {"cat_normal"},

            -- Petz mob-specific properties

            -- unimobs.petz_api.register_standard_mob() properties
            baby_scale_factor = 0.5,
            genetic_init_list = genetic_init_list,
            scale_factor = 2.0,
            skin_init_list = skin_init_list,
        },
    })

end
