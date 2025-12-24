---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_chicken_hen = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_pluck_callback(self, clicker, wielded_item, wielded_name, is_owner_flag)

    -- Adapted from petz.pluck()
    -- Plucks a feather from the chicken
    -- Does not change the chicken's appearance, but plucked chickens cannot fly

    if self.mob_type ~= "chicken_hen" or
            not self.can_pluck_flag or
            self.is_plucked_flag or
            not is_owner_flag then

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

    unilib.pkg.shared_petz_feathers.pluck(self, clicker, "unilib:organ_feather_chicken")

    -- Do not apply the standard behaviour
    return true

end

local function on_unpluck_callback(self, clicker, wielded_item, wielded_name, is_owner_flag)

    -- Adapted from petz.feather()
    -- Restores a feather to a plucked chicken

    if self.mob_type ~= "chicken_hen" or
            not self.can_pluck_flag or
            not self.is_plucked_flag or
            not is_owner_flag then

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

    unilib.pkg.shared_petz_feathers.unpluck(self, clicker, "unilib:organ_feather_chicken")

    -- Do not apply the standard behaviour
    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_chicken_hen.init()

    return {
        description = "Hen",
        notes = "Hens require an empty nest, in order to lay eggs; it is not necessary to feed" ..
                " them (as with many other creatures). Use shears on a hen to obtain a feather",
        depends = {
            "brain_herbivore",
            "food_chicken",
            "item_bone_animal",
            "misc_nest",
            "organ_feather_chicken",
            "shared_petz_feathers",
        },
        -- N.B. Laying eggs is optional, and occurs only when this package is loaded
        optional = "egg_chicken_normal",
    }

end

function unilib.pkg.mob_chicken_hen.exec()

    -- Setup
    local p1 = {x = -0.0625, y = -0.5, z = -0.125}
    local p2 = {x = 0.125, y = -0.125, z = 0.1875}
    local scale_factor = 2.1

    local cbox = unimobs.petz_api.get_standard_collisionbox(p1, p2, scale_factor, nil)
    local visual_size = unimobs.petz_api.get_standard_visual_size(scale_factor)

    local mesh = "unilib_mob_chicken_hen.b3d"

    local skin_init_list = {
        -- Normal skins
        {"white", S("White"), 1},
        {"brown", S("Brown"), 0.5},
        {"grey", S("Grey"), 0.1},
    }
    local genetic_init_list = {
        -- Standard genes
        {"digestion", S("Digestion"), "range", 1, 3, 0, 12},
        {"docility", S("Docility"), "range", 1, 3, 0, 12},
        {"fertility", S("Fertility"), "range", 1, 3, 0, 12},
        {"productivity", S("Productivity"), "range", 1, 3, 0, 12},
    }

    local brain_func = unilib.pkg.brain_herbivore.brain
    local description = unilib.utils.brackets(S("Chicken"), S("Hen"))
    local insertion_table = {
        subject = T(S("hen#subject")),
        subject_an = T(S("a hen#subject")),
        subject_the = T(S("the hen#subject")),
        object = T(S("hen#object")),
        object_an = T(S("a hen#object")),
        object_the = T(S("the hen#object")),
    }
    local is_wild_flag = false
    local sci_name = "Gallus gallus domesticus"
    local version = 1

    -- Register the entity
    unilib.register_entity("unilib:mob_chicken_hen", {
        -- From petz:hen

        -- Base properties (original to unimobs)
        petz_compat_flag = true,
        class_type = "chicken",
        -- (Was .type = "hen")
        mob_type = "chicken_hen",
        generic_type = "chicken_hen",

        description = description,
        sci_name = sci_name,

        -- Common properties
        initial_properties = {
            backface_culling = false,
            collide_with_objects = true,
            collisionbox = cbox,
--          makes_footstep_sound = false,
            mesh = mesh,
            physical = true,
            selectionbox = cbox,
            static_save = true,
            stepheight = 0.1,
            textures = unimobs.petz_api.compile_texture_list("chicken_hen", skin_init_list),
            visual = unimobs.petz_const.visual,
            visual_size = visual_size,
        },

        -- Mobkit API properties
        animation_table = {
            run = {range = {x = 13, y = 25}, speed = 25, loop = true},
            stand = {
                {range = {x = 26, y = 46}, speed = 5, loop = true},
                {range = {x = 47, y = 59}, speed = 5, loop = true},
                {range = {x = 60, y = 70}, speed = 5, loop = true},
                {range = {x = 71, y = 91}, speed = 5, loop = true},
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
        max_speed = 2.0,
--      physics_func = nil,
        sounds = {
            misc = {
                -- N.B. Sound file misnamed "petz_hen.ogg" in original mod
                "unilib_mob_chicken_hen_cluck_1",
                "unilib_mob_chicken_hen_cluck_2",
                "unilib_mob_chicken_hen_cluck_3",
            },
            -- N.B. Original mod provides this sound file, but it was not used in code
            moaning = "unilib_mob_chicken_hen_moaning",
        },
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
        can_pluck_flag = true,
--      can_swim_flag = false,
        capture_type = "animal_net",
        default_rotation = unimobs.petz_const.rotate,
--      die_in_daylight_flag = false,
        drop_list = {
            {name = "unilib:food_chicken_raw", chance = 3, min = 1, max = 1},
            {name = "unilib:item_bone_animal", chance = 6, min = 1, max = 1},
        },
--      dung_name = nil,
        egg_name = "unilib:egg_chicken_normal",
        has_tamagotchi_mode_flag = false,
--      head_prop_table = nil,
--      hostile_to_players_flag = false,
--      igniter_immunity_flag = false,
        is_baby_flag = false,
--      is_boss_flag = false,
        is_male_flag = false,
--      is_mammal_flag = false,
--      is_milkable_flag = false,
--      is_monster_flag = false,
--      is_mountable_flag = false,
        is_pet_flag = true,
        is_wild_flag = is_wild_flag,
--      jump_chance = nil,
--      jump_impulse = nil,
--      max_roam_height = nil,
        nest_empty_name = "unilib:misc_nest",
        nest_full_name = "unilib:misc_nest_with_egg_chicken_normal",
        obeys_orders_flag = false,
--      parent_type_list = nil,
--      sleep_in_day_flag = false,
--      sleep_in_night_flag = false,
--      sleep_ratio = nil,
--      spawn_max_light = nil,
        -- N.B. No light restrictions in original code
        spawn_min_light = 12,
        spawn_max_height = unimobs.petz_api.get_custom_msetting("chicken_hen", "spawn_max_height"),
        spawn_min_height = unimobs.petz_api.get_custom_msetting("chicken_hen", "spawn_min_height"),
--      straggle_type_list = nil,

        -- Petz baby properties
--      collisionbox_baby = nil,
--      selectionbox_baby = nil,
--      visual_size_baby = nil,

        -- Petz replace properties
--      replace_data_list = nil,
--      replace_rate = nil,
--      replace_turf_flag = false,
--      replace_turf_offset = 0,

        -- Petz mob-specific properties (shared with all chickens)
        is_aggressive_flag = false,

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
        mob_type = "chicken_hen",
        mob_name = "unilib:mob_chicken_hen",
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
            -- From petz:hen_set. Creates unilib:spawnegg_chicken_hen
            mob_type = "chicken_hen",
            orig_name = "petz:hen_set",

            replace_mode = mode,
            description = description,
            img = "unilib_spawnegg_chicken_hen.png",
            mob_name = "unilib:mob_chicken_hen",
            sci_name = sci_name,
            tamed_flag = not is_wild_flag,
        })

    end

    -- Override the standard behaviour when a mob is right-clicked while wielding these items
    for _, shears_name in ipairs(unimobs.petz_setting.shears_list) do
        unimobs.petz_api.register_rightclick_override(shears_name, on_pluck_callback)
    end

    unimobs.petz_api.register_rightclick_override(
        "unilib:organ_feather_chicken", on_unpluck_callback
    )

end
