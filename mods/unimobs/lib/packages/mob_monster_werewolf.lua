---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_monster_werewolf = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_monster_werewolf.init()

    return {
        description = "Werewolf (monster)",
        depends = {"brain_monster", "organ_fur_wolf", "organ_jaw_wolf"},
        -- N.B. If the shared package is loaded, werewolves can infect players with the Curse of
        --      Lycanthropy
        optional = "shared_petz_lycanthropy",
    }

end

function unilib.pkg.mob_monster_werewolf.exec()

    -- Setup
    local scale_factor = 1.0
    local cbox = {-0.3, 0, -0.3, 0.3, 1.7, 0.3}
    local visual_size = {
        x = 1 * scale_factor,
        y = 1 * scale_factor,
    }

    local mesh = "unilib_mob_monster_werewolf.b3d"

    local skin_init_list = {}
    if unilib.global.pkg_executed_table["shared_petz_lycanthropy"] == nil then

        skin_init_list = {
            -- Normal skins
            {"grey_dark", S("Dark Grey"), 1},
            {"grey", S("Grey"), 0.5},
            {"brown", S("Brown"), 0.1},
            {"black", S("Black"), 0.01},
        }

    else

        -- If the "shared_petz_lycanthropy" package has not been modified, this will create a
        --      "skin_init_list" that's identical to the one just above
        for _, mini_table in ipairs(unilib.pkg.shared_petz_lycanthropy.clan_list) do

            table.insert(
                skin_init_list,
                {mini_table.part_name, mini_table.part_description, mini_table.probability}
            )

        end

    end

    local genetic_init_list = {
        -- Standard genes
        {"agility", S("Beastly"), "range", 1, 3, 0, 12},
        {"luckiness", S("Supernatural"), "range", 1, 3, 0, 12},
        {"perception", S("Instinct"), "range", 1, 3, 0, 12},
        {"toughness", S("Ferocious"), "range", 1, 3, 0, 12},
    }

    local brain_func = unilib.pkg.brain_monster.brain
    local description = S("Werewolf")
    local insertion_table = {
        subject = T(S("werewolf#subject")),
        subject_an = T(S("a werewolf#subject")),
        subject_the = T(S("the werewolf#subject")),
        object = T(S("werewolf#object")),
        object_an = T(S("a werewolf#object")),
        object_the = T(S("the werewolf#object")),
    }
    -- N.B. Fictional scientific name
    local is_wild_flag = true
    local sci_name = "Lupanthropus nocturnalis"
    local version = 1

    -- Register the entity
    unilib.register_entity("unilib:mob_monster_werewolf", {
        -- From petz:werewolf

        -- Base properties (original to unimobs)
        petz_compat_flag = true,
        class_type = "monster",
        -- (Was .type = "werewolf")
        mob_type = "monster_werewolf",
        generic_type = "monster_werewolf",

        description = description,
        sci_name = sci_name,

        -- Common properties
        initial_properties = {
--          backface_culling = false,c
            collide_with_objects = true,
            collisionbox = cbox,
--          makes_footstep_sound = false,
            mesh = mesh,
            physical = true,
--          selectionbox = nil,
            static_save = true,
            stepheight = 0.1,
            textures = unimobs.petz_api.compile_texture_list("monster_werewolf", skin_init_list),
            visual = unimobs.petz_const.visual,
            visual_size = visual_size,
        },

        -- Mobkit API properties
        animation_table = {
            run = {range = {x = 168, y = 187}, speed = 30, loop = true},
            stand = {range = {x = 0, y = 79}, speed = 30, loop = true},
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
            attack = "unilib_mob_monster_werewolf_attack",
            die = "unilib_mob_monster_die",
            misc = "unilib_mob_monster_werewolf_howl",
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
            {name = "unilib:organ_fur_wolf", chance = 5, min = 1, max = 1},
            {name = "unilib:organ_jaw_wolf", chance = 5, min = 1, max = 1},
        },
--      dung_name = nil,
--      egg_name = nil,
        has_tamagotchi_mode_flag = false,
--      head_prop_table = nil,
        hostile_to_players_flag = true,
--      igniter_immunity_flag = false,
--      is_baby_flag = nil,
        is_boss_flag = true,
--      is_male_flag = nil,
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
                unimobs.petz_api.get_custom_msetting("monster_werewolf", "spawn_max_height"),
        spawn_min_height =
                unimobs.petz_api.get_custom_msetting("monster_werewolf", "spawn_min_height"),
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
        mob_type = "monster_werewolf",
        mob_name = "unilib:mob_monster_werewolf",
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
            -- From petz:werewolf_set. Creates unilib:spawnegg_monster_werewolf
            mob_type = "monster_werewolf",
            orig_name = "petz:werewolf_set",

            replace_mode = mode,
            description = description,
            img = "unilib_spawnegg_monster_werewolf.png",
            mob_name = "unilib:mob_monster_werewolf",
            sci_name = sci_name,
            tamed_flag = not is_wild_flag,
        })

    end

end
