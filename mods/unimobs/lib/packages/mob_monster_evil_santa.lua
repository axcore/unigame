---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_monster_evil_santa = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_monster_evil_santa.init()

    return {
        description = "Evil Santa (monster)",
        notes = "If this package is loaded, the monster only spawns during the IRL month of" ..
                " December (unless a different setting is specified by the remix)",
        depends = {
            "brain_monster",
            "container_present_christmas",
            "food_candy_cane_christmas",
            "food_cookie_gingerbread",
        },
    }

end

function unilib.pkg.mob_monster_evil_santa.exec()

    -- Setup
    local cbox = {-0.3, 0, -0.3, 0.3, 1.7, 0.3}
    local scale_factor = 1.0
    local visual_size = {
        x = 1 * scale_factor,
        y = 1 * scale_factor,
    }

    local mesh = "unilib_character.b3d"

    local skin_init_list = {
        -- Normal skins
        {"red", S("Red"), 1},
        {"white", S("White"), 0.1},
        {"purple", S("Purple"), 0.01},
    }
    local genetic_init_list = {
        -- Standard genes
        {"agility", S("Malevolent"), "range", 1, 3, 0, 12},
        {"luckiness", S("Supernatural"), "range", 1, 3, 0, 12},
        {"perception", S("Twisted"), "range", 1, 3, 0, 12},
        {"toughness", S("Cold-hearted"), "range", 1, 3, 0, 12},
    }

    local brain_func = unilib.pkg.brain_monster.brain
    local description = S("Evil Santa")
    local insertion_table = {
        subject = T(S("Evil Santa#subject")),
        subject_an = T(S("Evil Santa#subject")),
        subject_the = T(S("Evil Santa#subject")),
        object = T(S("Evil Santa#object")),
        object_an = T(S("Evil Santa#object")),
        object_the = T(S("Evil Santa#object")),
    }
    -- N.B. Fictional scientific name
    local is_wild_flag = true
    local sci_name = "Nictosanctus maleficus"
    local version = 1

    -- Initialise the .custom_table field of unimobs.petz_msetting, if the remix CSV has not
    --      already initialised it
    unimobs.petz_api.initialise_custom_msetting("monster_mr_pumpkin", "spawn_month", "christmas")

    -- Register the entity
    unilib.register_entity("unilib:mob_monster_evil_santa", {
        -- From petz:santa_killer

        -- Base properties (original to unimobs)
        petz_compat_flag = true,
        class_type = "monster",
        -- (Was .type = "santa_killer")
        mob_type = "monster_evil_santa",
        generic_type = "monster_evil_santa",

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
            textures = unimobs.petz_api.compile_texture_list("monster_evil_santa", skin_init_list),
            visual = unimobs.petz_const.visual,
            visual_size = visual_size,
        },

        -- Mobkit API properties
        animation_table = {
            sit = {range = {x = 81, y = 160}, speed = 5, loop = false},
            stand = {
                {range = {x = 0, y = 79}, speed = 5, loop = true},
            },
            walk = {range = {x = 168, y = 187}, speed = 30, loop = true},
        },
--      armour_groups = nil,
        attack_table = {range = 0.5, damage_groups = {fleshy = 9}},
        bounciness = 0,
        brain_func = brain_func,
        buoyancy = 0.5,
        jump_height = 1.5,
        lung_capacity = 10,
        max_hp = 50,
        max_speed = 1.5,
--      physics_func = nil,
        sounds = {
            attack = "unilib_mob_monster_evil_santa_laugh",
            die = "unilib_mob_monster_die",
            laugh = "unilib_mob_monster_evil_santa_laugh",
            misc = "unilib_mob_monster_evil_santa_misc",
        },
--      timeout = nil,
        view_range = 20,

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
--      can_pluck_flag = false,
--      can_swim_flag = false,
        capture_type = nil,
        default_rotation = unimobs.petz_const.rotate,
--      die_in_daylight_flag = false,
        drop_list = {
            {name = "unilib:container_present_christmas", chance = 3, min = 1, max = 1},
            {name = "unilib:food_cookie_gingerbread", chance = 1, min = 1, max = 6},
            {name = "unilib:food_candy_cane_christmas", chance = 1, min = 1, max = 6},
        },
--      dung_name = nil,
--      egg_name = nil,
        has_tamagotchi_mode_flag = false,
--      head_prop_table = nil,
        hostile_to_players_flag = true,
--      igniter_immunity_flag = false,
--      is_baby_flag = nil,
        is_boss_flag = true,
        -- N.B. Not inherently male in original code
        is_male_flag = true,
--      is_mammal_flag = false,
--      is_milkable_flag = false,
        is_monster_flag = true,
--      is_mountable_flag = false,
        is_pet_flag = false,
        is_wild_flag = is_wild_flag,
--      jump_chance = nil,
--      jump_impulse = nil,
--      max_roam_height = nil,
--      nest_empty_name = nil,
--      nest_full_name = nil,
        obeys_orders_flag = false,
--      parent_type_list = nil,
--      sleep_in_day_flag = false,
--      sleep_in_night_flag = false,
--      sleep_ratio = nil,
        -- N.B. No light restrictions in original code
        spawn_max_light = 2,
--      spawn_min_light = nil,
        spawn_max_height =
                unimobs.petz_api.get_custom_msetting("monster_evil_santa", "spawn_max_height"),
        spawn_min_height =
                unimobs.petz_api.get_custom_msetting("monster_evil_santa", "spawn_min_height"),
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
        mob_type = "monster_evil_santa",
        mob_name = "unilib:mob_monster_evil_santa",
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
            -- From petz:santa_killer_set. Creates unilib:spawnegg_monster_evil_santa
            mob_type = "monster_evil_santa",
            orig_name = "petz:santa_killer_set",

            replace_mode = mode,
            description = description,
            img = "unilib_spawnegg_monster_evil_santa.png",
            mob_name = "unilib:mob_monster_evil_santa",
            sci_name = sci_name,
            tamed_flag = not is_wild_flag,
        })

    end

end
