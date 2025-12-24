---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_wolf_normal = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_wolf_normal.init()

    return {
        description = "Normal wolf",
        notes = "Assuming that the remix still specifies it, wolves can be converted into dogs" ..
                " with animal bones",
        depends = {"brain_predator", "organ_fur_wolf", "organ_jaw_wolf"},
        -- N.B. If the shared package is loaded, wolves can (rarely) infect players with the Curse
        --      of Lycanthropy
        optional = "shared_petz_lycanthropy",
    }

end

function unilib.pkg.mob_wolf_normal.exec()

    -- Setup
    local p1 = {x = -0.125, y = -0.5, z = -0.3125}
    local p2 = {x = 0.1875, y = 0.0625, z = 0.375}
    local scale_factor = 1.8
    local baby_scale_factor = 0.5

    local cbox, cbox_baby =
            unimobs.petz_api.get_standard_collisionbox(p1, p2, scale_factor, baby_scale_factor)
    local visual_size = unimobs.petz_api.get_standard_visual_size(scale_factor)

    local mesh = "unilib_mob_wolf_normal.b3d"

    local skin_init_list = {
        -- Normal skins
        {"grey", S("Grey"), 1},
        {"grey_dark", S("Dark Grey"), 0.5},
        {"brown", S("Brown"), 0.1},
        -- Rare mutations
        {"black", S("Black"), 0},
        {"white", S("White"), 0},
    }
    local genetic_init_list = {
        -- Standard genes
        {"agility", S("Agility"), "range", 1, 3, 0, 12},
        {"compliance", S("Compliance"), "range", 1, 3, 0, 12},
        {"digestion", S("Digestion"), "range", 1, 3, 0, 12},
--      {"fertility", S("Fertility"), "range", 1, 3, 0, 12},
        {"perception", S("Perception"), "range", 1, 3, 0, 12},
        {"toughness", S("Toughness"), "range", 1, 3, 0, 12},
        -- Standard genes (genetic mutations)
        {"variability", S("Variability"), "range", 2, 4, 0, 12},
    }

    local brain_func = unilib.pkg.brain_predator.brain
    local description = unilib.utils.brackets(S("Wolf"), S("Normal"))
    local insertion_table = {
        subject = T(S("wolf#subject")),
        subject_an = T(S("a wolf#subject")),
        subject_the = T(S("the wolf#subject")),
        object = T(S("wolf#object")),
        object_an = T(S("a wolf#object")),
        object_the = T(S("the wolf#object")),
    }
    local is_wild_flag = true
    local sci_name = "Canis lupus"
    local version = 1

    -- Register the entity
    unilib.register_entity("unilib:mob_wolf_normal", {
        -- From petz:wolf

        -- Base properties (original to unimobs)
        petz_compat_flag = true,
        class_type = "wolf",
        -- (Was .type = "wolf")
        mob_type = "wolf_normal",
        generic_type = "wolf_normal",

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
            textures = unimobs.petz_api.compile_texture_list("wolf_normal", skin_init_list),
            visual = unimobs.petz_const.visual,
            visual_size = visual_size,
        },

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
--      armour_groups = nil,
        attack_table = {range = 0.5, damage_groups = {fleshy = 7}},
        bounciness = 0,
        brain_func = brain_func,
        buoyancy = 0.5,
        jump_height = 2.0,
        lung_capacity = 10,
        max_hp = 20,
        max_speed = 2.3,
--      physics_func = nil,
        sounds = {
            misc = "unilib_mob_wolf_normal_howl",
            moaning = "unilib_mob_wolf_normal_moaning",
        },
--      timeout = nil,
        view_range = 10,

        -- Petz non-dynamic properties
        avoid_players_flag = true,
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
            {name = "unilib:organ_fur_wolf", chance = 5, min = 1, max = 1},
            {name = "unilib:organ_jaw_wolf", chance = 5, min = 1, max = 1},
        },
--      dung_name = nil,
--      egg_name = nil,
        has_tamagotchi_mode_flag = true,
--      head_prop_table = nil,
        hostile_to_players_flag = false,
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
        obeys_orders_flag = true,
--      parent_type_list = nil,
--      sleep_in_day_flag = false,
--      sleep_in_night_flag = false,
--      sleep_ratio = nil,
--      spawn_max_light = nil,
--      spawn_min_light = nil,
        spawn_max_height = unimobs.petz_api.get_custom_msetting("wolf_normal", "spawn_max_height"),
        spawn_min_height = unimobs.petz_api.get_custom_msetting("wolf_normal", "spawn_min_height"),
        straggle_type_list = {"wolf_normal"},

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
        pack_attack_mode_flag = true,

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
        mob_type = "wolf_normal",
        mob_name = "unilib:mob_wolf_normal",
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
            -- From petz:wolf_set. Creates unilib:spawnegg_wolf_normal
            mob_type = "wolf_normal",
            orig_name = "petz:wolf_set",

            replace_mode = mode,
            description = description,
            img = "unilib_spawnegg_wolf_normal.png",
            mob_name = "unilib:mob_wolf_normal",
            sci_name = sci_name,
            tamed_flag = not is_wild_flag,
        })

    end

end
