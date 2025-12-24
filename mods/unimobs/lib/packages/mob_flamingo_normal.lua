---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_flamingo_normal = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_pluck_callback(self, clicker, wielded_item, wielded_name, is_owner_flag)

    -- Adapted from petz.pluck()
    -- Plucks a feather from the flamingo
    -- Does not change the flamingo's appearance, but plucked flamingoes cannot fly

    if self.mob_type ~= "flamingo_normal" or
            not self.can_pluck_flag or
            self.is_plucked_flag or
            not is_owner_flag then

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

    unilib.pkg.shared_petz_feathers.pluck(self, clicker, "unilib:organ_feather_flamingo")

    -- Do not apply the standard behaviour
    return true

end

local function on_unpluck_callback(self, clicker, wielded_item, wielded_name, is_owner_flag)

    -- Adapted from petz.feather()
    -- Restores a feather to a plucked flamingo

    if self.mob_type ~= "flamingo_normal" or
            not self.can_pluck_flag or
            not self.is_plucked_flag or
            not is_owner_flag then

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

    unilib.pkg.shared_petz_feathers.unpluck(self, clicker, "unilib:organ_feather_flamingo")

    -- Do not apply the standard behaviour
    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_flamingo_normal.init()

    return {
        description = "Normal flamingo",
        notes = "Use shears on a flamingo to obtain a feather, which also prevents the flamingo" ..
                " from flying",
        depends = {"brain_flying", "organ_feather_flamingo", "shared_petz_feathers"},
    }

end

function unilib.pkg.mob_flamingo_normal.exec()

    -- Setup
--  local mesh = "unilib_mob_flamingo_normal.b3d"

    local skin_init_list = {
        -- Normal skins
        {"pink", S("Pink"), 1},
        {"white", S("White"), 0.1},
    }
    local genetic_init_list = {
        -- Standard genes
        {"agility", S("Agility"), "range", 1, 3, 0, 12},
        {"digestion", S("Digestion"), "range", 1, 3, 0, 12},
        {"loftiness", S("Loftiness"), "range", 1, 3, 0, 12},
    }

    local brain_func = unilib.pkg.brain_flying.brain
    local description = unilib.utils.brackets(S("Flamingo"), S("Normal"))
    local insertion_table = {
        subject = T(S("flamingo#subject")),
        subject_an = T(S("a flamingo#subject")),
        subject_the = T(S("the flamingo#subject")),
        object = T(S("flamingo#object")),
        object_an = T(S("a flamingo#object")),
        object_the = T(S("the flamingo#object")),
    }
    local is_wild_flag = false
    local sci_name = "Phoenicopterus ruber"
    local version = 1

    -- Register the entity and its spawnegg
    unimobs.petz_api.register_standard_mob({
        -- From petz:flamingo
        mob_type = "flamingo_normal",
        orig_spawnegg_name = "petz:flamingo_set",

        replace_mode = mode,
        insertion_table = insertion_table,
        version = version,

        def_table = {
            -- Base properties
            petz_compat_flag = true,
            class_type = "flamingo",
            -- (Was .type = "flamingo")
            mob_type = "flamingo_normal",
            generic_type = "flamingo_normal",

            description = description,
            sci_name = sci_name,

            -- Common properties
--          backface_culling = false,
--          collide_with_objects = true,
            collisionbox = {
                p1 = {x = -0.1875, y = -0.5, z = -0.125},
                p2 = {x = 0.1875, y = 0.125, z = 0.1875},
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
                fly = {range = {x = 92, y = 98}, speed = 25, loop = true},
                run = {range = {x = 13, y = 25}, speed = 25, loop = true},
                stand = {
                    {range = {x = 26, y = 46}, speed = 5, loop = true},
                    {range = {x = 47, y = 59}, speed = 5, loop = true},
                    {range = {x = 60, y = 70}, speed = 5, loop = true},
                    {range = {x = 71, y = 91}, speed = 5, loop = true},
                },
                stand_fly = {range = {x = 92, y = 98}, speed = 25, loop = true},
                walk = {range = {x = 1, y = 12}, speed = 25, loop = true},
            },
--          armour_groups = nil,
--          attack_table = {range = 0.5, damage_groups = {fleshy = 3}},
--          bounciness = 0,
            brain_func = brain_func,
--          buoyancy = 0.5,
--          jump_height = nil,
--          lung_capacity = 10,
--          max_hp = nil,
            max_speed = 2.0,
--          physics_func = nil,
            sounds = {
                misc = {
                    "unilib_mob_flamingo_normal_chirp_1",
                    "unilib_mob_flamingo_normal_chirp_2",
                },
            },
--          timeout = nil,
--          view_range = nil,

            -- Petz non-dynamic properties
--          avoid_players_flag = false,
--          baby_type_list = nil,
            can_alight_flag = true,
            -- N.B. In original code, .can_breed_flag = false
            can_breed_flag = true,
--          can_climb_trees_flag = false,
--          can_clutch_flag = false,
            can_fly_flag = true,
--          can_groom_flag = false,
--          can_herd_flag = false,
--          can_jump_flag = false,
--          can_perch_flag = false,
            can_pluck_flag = true,
--          can_swim_flag = false,
            capture_type = "lasso",
--          default_rotation = unimobs.petz_const.rotate,
--          die_in_daylight_flag = false,
--          drop_list = nil,
--          dung_name = nil,
--          egg_name = nil,
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
            max_roam_height = 8,
--          nest_empty_name = nil,
--          nest_full_name = nil,
--          obeys_orders_flag = false,
--          parent_type_list = nil,
--          sleep_in_day_flag = false,
--          sleep_in_night_flag = false,
--          sleep_ratio = nil,
--          spawn_max_light = nil,
            -- N.B. No light restrictions in original code
            spawn_min_light = 10,
            spawn_max_height =
                    unimobs.petz_api.get_custom_msetting("flamingo_normal", "spawn_max_height"),
            spawn_min_height =
                    unimobs.petz_api.get_custom_msetting("flamingo_normal", "spawn_min_height"),
--          straggle_type_list = nil,

            -- Petz mob-specific properties
            -- Used by the "brain_flying" package to decide how often to take off, and the
            --      "lqb_fly_wander" package to decide how often to land
            fly_chance = 60,

            -- unimobs.petz_api.register_standard_mob() properties
            baby_scale_factor = 0.5,
            genetic_init_list = genetic_init_list,
            scale_factor = 1.0,
            skin_init_list = skin_init_list,
        },
    })

    -- Override the standard behaviour when a mob is right-clicked while wielding these items
    for _, shears_name in ipairs(unimobs.petz_setting.shears_list) do
        unimobs.petz_api.register_rightclick_override(shears_name, on_pluck_callback)
    end

    unimobs.petz_api.register_rightclick_override(
        "unilib:organ_feather_flamingo", on_unpluck_callback
    )

end
