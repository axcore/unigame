---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_pigeon_normal = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_pluck_callback(self, clicker, wielded_item, wielded_name, is_owner_flag)

    -- Adapted from petz.pluck()
    -- Plucks a feather from the pigeon
    -- Does not change the pigeon's appearance, but plucked pigeons cannot fly

    if self.mob_type ~= "pigeon_normal" or
            not self.can_pluck_flag or
            self.is_plucked_flag or
            not is_owner_flag then

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

    unilib.pkg.shared_petz_feathers.pluck(self, clicker, "unilib:organ_feather_pigeon")

    -- Do not apply the standard behaviour
    return true

end

local function on_unpluck_callback(self, clicker, wielded_item, wielded_name, is_owner_flag)

    -- Adapted from petz.feather()
    -- Restores a feather to a plucked pigeon

    if self.mob_type ~= "pigeon_normal" or
            not self.can_pluck_flag or
            not self.is_plucked_flag or
            not is_owner_flag then

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

    unilib.pkg.shared_petz_feathers.unpluck(self, clicker, "unilib:organ_feather_pigeon")

    -- Do not apply the standard behaviour
    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_pigeon_normal.init()

    return {
        description = "Normal pigeon",
        notes = "Use shears on a pigeon to obtain a feather, which also prevents the pigeon" ..
                " from flying",
        depends = {"brain_flying", "organ_feather_pigeon", "shared_petz_feathers"},
    }

end

function unilib.pkg.mob_pigeon_normal.exec()

    -- Setup
    local p1 = {x = -0.0625, y = -0.5, z = -0.125}
    local p2 = {x = 0.125, y = -0.125, z = 0.125}
    local scale_factor = 1.8
    local baby_scale_factor = 0.66

    local cbox, cbox_baby =
            unimobs.petz_api.get_standard_collisionbox(p1, p2, scale_factor, baby_scale_factor)
    local visual_size = unimobs.petz_api.get_standard_visual_size(scale_factor)

    local mesh = "unilib_mob_pigeon_normal.b3d"

    local skin_init_list = {
        -- Normal skins
        {"grey", S("Grey"), 1},
        {"brown_dark", S("Dark Brown"), 0.5},
        {"brown_pale", S("Pale Brown"), 0.5},
        {"white", S("White"), 0.5},
        {"black", S("Black"), 0.1},
        {"orange", S("Orange"), 0.1},
        {"red", S("Red"), 0.1},
        {"blue", S("Blue"), 0.05},
        -- Rare mutations
        {"purple", S("Purple"), 0},
    }
    local genetic_init_list = {
        -- Standard genes
        {"agility", S("Agility"), "range", 1, 3, 0, 12},
        {"digestion", S("Digestion"), "range", 1, 3, 0, 12},
        {"fertility", S("Fertility"), "range", 1, 3, 0, 12},
        {"loftiness", S("Loftiness"), "range", 1, 3, 0, 12},
        {"luckiness", S("Luckiness"), "range", 1, 3, 0, 12},
        -- Standard genes (genetic mutations)
        {"variability", S("Variability"), "range", 2, 4, 0, 12},
    }

    local brain_func = unilib.pkg.brain_flying.brain
    local description = unilib.utils.brackets(S("Pigeon"), S("Normal"))
    local insertion_table = {
        subject = T(S("pigeon#subject")),
        subject_an = T(S("a pigeon#subject")),
        subject_the = T(S("the pigeon#subject")),
        object = T(S("pigeon#object")),
        object_an = T(S("a pigeon#object")),
        object_the = T(S("the pigeon#object")),
    }
    local is_wild_flag = false
    local sci_name = "Columba livia domestica"
    local version = 1

    -- Register the entity
    unilib.register_entity("unilib:mob_pigeon_normal", {
        -- From petz:pigeon

        -- Base properties (original to unimobs)
        petz_compat_flag = true,
        class_type = "pigeon",
        -- (Was .type = "pigeon")
        mob_type = "pigeon_normal",
        generic_type = "pigeon_normal",

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
            textures = unimobs.petz_api.compile_texture_list("pigeon_normal", skin_init_list),
            visual = unimobs.petz_const.visual,
            visual_size = visual_size,
        },

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
            walk = {range = {x = 1, y = 12}, speed = 25, loop = true},
            stand_fly = {range = {x = 92, y = 98}, speed = 25, loop = true},
        },
--      armour_groups = nil,
        attack_table = {range = 0.5, damage_groups = {fleshy = 3}},
        bounciness = 0,
        brain_func = brain_func,
        buoyancy = 0.5,
        jump_height = 2.0,
        lung_capacity = 10,
        max_hp = 8,
        max_speed = 2.5,
--      physics_func = nil,
        sounds = {
            misc = "unilib_mob_pigeon_normal_coocoo",
            moaning = "unilib_mob_pigeon_normal_moaning",
        },
--      timeout = nil,
        view_range = 10,

        -- Petz non-dynamic properties
--      avoid_players_flag = false,
--      baby_type_list = nil,
--      can_alight_flag = false,
        -- N.B. In original code, .can_breed_flag = false
        can_breed_flag = true,
--      can_climb_trees_flag = false,
--      can_clutch_flag = false,
        can_fly_flag = true,
        can_groom_flag = false,
--      can_herd_flag = false,
--      can_jump_flag = false,
--      can_perch_flag = false,
        can_pluck_flag = true,
--      can_swim_flag = false,
        capture_type = "animal_net",
        default_rotation = unimobs.petz_const.rotate,
--      die_in_daylight_flag = false,
--      drop_list = nil,
--      dung_name = nil,
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
        max_roam_height = 5,
--      nest_empty_name = nil,
--      nest_full_name = nil,
        obeys_orders_flag = false,
--      parent_type_list = nil,
--      sleep_in_day_flag = false,
--      sleep_in_night_flag = false,
--      sleep_ratio = nil,
--      spawn_max_light = nil,
        -- N.B. No light restrictions in original code
        spawn_min_light = 10,
        spawn_max_height =
                unimobs.petz_api.get_custom_msetting("pigeon_normal", "spawn_max_height"),
        spawn_min_height =
                unimobs.petz_api.get_custom_msetting("pigeon_normal", "spawn_min_height"),
--      straggle_type_list = nil,

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
        mob_type = "pigeon_normal",
        mob_name = "unilib:mob_pigeon_normal",
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
            -- From petz:pigeon_set. Creates unilib:spawnegg_pigeon_normal
            mob_type = "pigeon_normal",
            orig_name = "petz:pigeon_set",

            replace_mode = mode,
            description = description,
            img = "unilib_spawnegg_pigeon_normal.png",
            mob_name = "unilib:mob_pigeon_normal",
            sci_name = sci_name,
            tamed_flag = not is_wild_flag,
        })

    end

    -- Override the standard behaviour when a mob is right-clicked while wielding these items
    for _, shears_name in ipairs(unimobs.petz_setting.shears_list) do
        unimobs.petz_api.register_rightclick_override(shears_name, on_pluck_callback)
    end

    unimobs.petz_api.register_rightclick_override(
        "unilib:organ_feather_pigeon", on_unpluck_callback
    )

end
