---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_tarantula_normal = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local random = math.random

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_punch_mob_callback(self, puncher, time_from_last_punch, tool_capabilities, dir)

    -- Adapted from petz.on_punch()
    -- Randomly throw cobwebs at the attacking player

    if random(1, 5) == 1 then

        unilib.pkg.shared_petz_projectiles.spawn_projectile(
            self.object, 20, "unilib:entity_misc_projectile_cobweb"
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_tarantula_normal.init()

    return {
        description = "Normal tarantula",
        depends = {
            "brain_monster",
            "item_string_ordinary",
            "organ_eye_spider",
            "shared_petz_projectiles",
        },
        optional = "misc_projectile_cobweb",
    }

end

function unilib.pkg.mob_tarantula_normal.exec()

    -- Setup
--  local mesh = "unilib_mob_tarantula_normal.b3d"

    local skin_init_list = {
        -- Normal skins
        {"black", S("Black"), 1},
        {"orange", S("Orange"), 1},
        {"red", S("Red"), 0.5},
        {"blue", S("Blue"), 0.1},
    }
    local genetic_init_list = {
        -- Standard genes
        {"agility", S("Agility"), "range", 1, 3, 0, 12},
        {"perception", S("Perception"), "range", 1, 3, 0, 12},
        {"springiness", S("Springiness"), "range", 1, 3, 0, 12},
        {"toughness", S("Toughness"), "range", 1, 3, 0, 12},
    }

    local brain_func = unilib.pkg.brain_monster.brain
    local description = unilib.utils.brackets(S("Tarantula"), S("Normal"))
    local insertion_table = {
        subject = T(S("tarantula#subject")),
        subject_an = T(S("a tarantula#subject")),
        subject_the = T(S("the tarantula#subject")),
        object = T(S("tarantula#object")),
        object_an = T(S("a tarantula#object")),
        object_the = T(S("the tarantula#object")),
    }
    local is_wild_flag = true
    local sci_name = "Theraphosa blondi"
    local version = 1

    -- Register the entity and its spawnegg
    unimobs.petz_api.register_standard_mob({
        -- From petz:tarantula
        mob_type = "tarantula_normal",
        orig_spawnegg_name = "petz:tarantula_set",

        replace_mode = mode,
        insertion_table = insertion_table,
        version = version,

        def_table = {
            -- Base properties
            petz_compat_flag = true,
            class_type = "tarantula",
            -- (Was .type = "tarantula")
            mob_type = "tarantula_normal",
            generic_type = "tarantula_normal",

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
                p1 = {x = -0.25, y = -0.5, z = -0.25},
                p2 = {x = 0.3125, y = -0.25, z = 0.3125},
            },
--          static_save = true,
--          stepheight = 0.1,
--          textures = nil,
--          visual = nil,
--          visual_size = nil,

            -- Mobkit API properties
            animation_table = {
                attack = {range = {x = 34, y = 40}, speed = 30, loop = false},
                stand = {range = {x = 23, y = 34}, speed = 5, loop = true},
                walk = {range = {x = 1, y = 21}, speed = 30, loop = true},
            },
--          armour_groups = nil,
            attack_table = {range = 0.5, damage_groups = {fleshy = 9}},
--          bounciness = 0,
            brain_func = brain_func,
--          buoyancy = 0.5,
            jump_height = 2.1,
--          lung_capacity = 10,
            max_hp = 30,
            max_speed = 1.5,
--          physics_func = nil,
            sounds = {
                attack = "unilib_mob_tarantula_normal_attack",
            },
--          timeout = nil,
            view_range = 10,

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
            default_rotation = unimobs.petz_const.rotate,
            -- N.B. false in original code
            die_in_daylight_flag = true,
            drop_list = {
                {name = "unilib:item_string_ordinary", chance = 3, min = 1, max = 1},
                {name = "unilib:organ_eye_spider", chance = 3, min = 1, max = 1},
            },
--          dung_name = nil,
--          egg_name = nil,
--          has_tamagotchi_mode_flag = false,
            head_prop_table = {
                eye_offset = -0.2,
                position = vector.new(0, 0.2908, -0.2908),
                -- (In degrees, normally values are -90, 0, 90)
                rotation_origin = vector.new(-90, 0, 0),
            },
            hostile_to_players_flag = true,
--          igniter_immunity_flag = false,
--          is_baby_flag = nil,
            is_boss_flag = true,
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
            spawn_max_light = 2,
--          spawn_min_light = nil,
            spawn_max_height =
                    unimobs.petz_api.get_custom_msetting("tarantula_normal", "spawn_max_height"),
            spawn_min_height =
                    unimobs.petz_api.get_custom_msetting("tarantula_normal", "spawn_min_height"),
--          straggle_type_list = nil,

            -- Petz mob-specific properties

            -- unimobs.petz_api.register_standard_mob() properties
            baby_scale_factor = 0.66,
            genetic_init_list = genetic_init_list,
            scale_factor = 1.85,
            skin_init_list = skin_init_list,
        }
    })

    -- Extend the standard behaviour when this mob is punched
    if unilib.global.pkg_executed_table["misc_projectile_cobweb"] ~= nil then
        unimobs.petz_api.register_punch_mob_extension("tarantula_normal", on_punch_mob_callback)
    end

end
