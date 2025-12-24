---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_dolphin_bottlenose = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_dolphin_bottlenose.init()

    return {
        description = "Bottlenose dolphin",
        depends = {"brain_aquatic", "coral_rooted_cyan"},
        optional = {"coral_rooted_green", "coral_rooted_pink"},
    }

end

function unilib.pkg.mob_dolphin_bottlenose.exec()

    -- Setup
    local p1 = {x = -0.25, y = -0.5, z = -0.3125}
    local p2 = {x = 0.1875, y = -0.125, z = 0.3125}
    local scale_factor = 2.0
    local baby_scale_factor = 0.5

    local cbox, cbox_baby =
            unimobs.petz_api.get_standard_collisionbox(p1, p2, scale_factor, baby_scale_factor)
    local visual_size = unimobs.petz_api.get_standard_visual_size(scale_factor)

    local mesh = "unilib_mob_dolphin_bottlenose.b3d"

    local skin_init_list = {
        -- Normal skins
        {"blue_light", S("Light Blue"), 1},
        {"blue_dark", S("Dark Blue"), 0.1},
        {"black", S("Black"), 0.05},
        {"pink", S("Pink"), 0.01},
    }
    local genetic_init_list = {
        -- Standard genes
        {"agility", S("Swimming speed"), "range", 1, 3, 0, 12},
        {"digestion", S("Fishing skill"), "range", 1, 3, 0, 12},
        {"luckiness", S("Playfulness"), "range", 1, 3, 0, 12},
        {"perception", S("Intelligence"), "range", 1, 3, 0, 12},
    }

    local brain_func = unilib.pkg.brain_aquatic.brain
    local description = unilib.utils.brackets(S("Dolphin"), S("Bottlenose Dolphin"))
    local insertion_table = {
        subject = T(S("dolphin#subject")),
        subject_an = T(S("a dolphin#subject")),
        subject_the = T(S("the dolphin#subject")),
        object = T(S("dolphin#object")),
        object_an = T(S("a dolphin#object")),
        object_the = T(S("the dolphin#object")),
    }
    local is_wild_flag = false
    local sci_name = "Tursiops truncatus"
    local version = 1

    -- Register the entity
    unilib.register_entity("unilib:mob_dolphin_bottlenose", {
        -- From petz:dolphin

        -- Base properties (original to unimobs)
        petz_compat_flag = true,
        class_type = "dolphin",
        -- (Was .type = "dolphin")
        mob_type = "dolphin_bottlenose",
        generic_type = "dolphin_bottlenose",

        description = description,
        sci_name = sci_name,

        -- (Standard entity properties)
        groups = {fish = 1},

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
            textures = unimobs.petz_api.compile_texture_list("dolphin_bottlenose", skin_init_list),
            visual = unimobs.petz_const.visual,
            visual_size = visual_size,
        },

        -- Mobkit API properties
        animation_table = {
            def = {range = {x = 1, y = 13}, speed = 20, loop = true},
            stand = {
                {range = {x = 13, y = 25}, speed = 5, loop = true},
                {range = {x = 28, y = 43}, speed = 5, loop = true},
            },
        },
--      armour_groups = nil,
--      attack_table = nil,
        bounciness = 0,
        brain_func = brain_func,
        buoyancy = 0.5,
        jump_height = 2.0,
        lung_capacity = 32767,
        max_hp = 12,
        max_speed = 2.5,
--      physics_func = nil,
        sounds = {
            misc = "unilib_mob_dolphin_bottlenose_clicking",
            moaning = "unilib_mob_dolphin_bottlenose_moaning",
        },
--      timeout = nil,
        view_range = 12,

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
        can_jump_flag = true,
--      can_perch_flag = false,
--      can_pluck_flag = false,
        can_swim_flag = true,
        capture_type = "lasso",
        default_rotation = unimobs.petz_const.rotate,
--      die_in_daylight_flag = false,
        -- N.B. The .drop_list field is usually overwritten by code in the .post() function below
        drop_list = {
            {name = "unilib:coral_rooted_cyan", chance = 5, min = 1, max = 1},
        },
--      dung_name = nil,
--      egg_name = nil,
        -- N.B. In the original code, has_tamagotchi_mode_flag = true
        has_tamagotchi_mode_flag = false,
--      head_prop_table = nil,
--      hostile_to_players_flag = false,
--      igniter_immunity_flag = false,
--      is_baby_flag = nil,
--      is_boss_flag = false,
--      is_male_flag = nil,
        is_mammal_flag = true,
--      is_milkable_flag = false,
--      is_monster_flag = false,
--      is_mountable_flag = false,
        is_pet_flag = true,
        is_wild_flag = is_wild_flag,
--      jump_chance = nil,
--      jump_impulse = nil,
        max_roam_height = -2,
--      nest_empty_name = nil,
--      nest_full_name = nil,
        -- N.B. In original code, .obeys_orders_flag = true
        obeys_orders_flag = false,
--      parent_type_list = nil,
--      sleep_in_day_flag = false,
--      sleep_in_night_flag = false,
--      sleep_ratio = nil,
--      spawn_max_light = nil,
--      spawn_min_light = nil,
        spawn_max_height =
                unimobs.petz_api.get_custom_msetting("dolphin_bottlenose", "spawn_max_height"),
        spawn_min_height =
                unimobs.petz_api.get_custom_msetting("dolphin_bottlenose", "spawn_min_height"),
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
        mob_type = "dolphin_bottlenose",
        mob_name = "unilib:mob_dolphin_bottlenose",
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
            -- From petz:dolphin_set. Creates unilib:spawnegg_dolphin_bottlenose
            mob_type = "dolphin_bottlenose",
            orig_name = "petz:dolphin_set",

            replace_mode = mode,
            description = description,
            img = "unilib_spawnegg_dolphin_bottlenose.png",
            mob_name = "unilib:mob_dolphin_bottlenose",
            sci_name = sci_name,
            tamed_flag = not is_wild_flag,
        })

    end

end

function unilib.pkg.mob_dolphin_bottlenose.post()

    -- Original to unimobs
    -- Update the entity prototype to include unilib's list of catchable raw fish, and some bonus
    --      corals

    local entity_table = core.registered_entities["unilib:mob_dolphin_bottlenose"]
    local fish_count = #unilib.global.fishing_fish_list
    if not entity_table or fish_count == 0 then
        return
    end

    -- For each fish, unilib.global.fishing_fish_list provides a .rarity value, e.g. 1 for the
    --      most common fish, 0.01 for rare fish
    -- unimobs.kitz_api.make_mob_drop_multiple_items() uses a .chance value, where 1 means the item
    --      is certain to be dropped, and 10 means the item has a 10% probability of being dropped
    -- Convert one to the other in a format that means each dolphin will drop one item (on average)
    local drop_list = {}
    for _, mini_table in ipairs(unilib.global.fishing_fish_list) do

        table.insert(drop_list, {
            name = mini_table.full_name,
            -- e.g. 50 fish, this fish has 0.1 rarity, so its chance of being dropped is 1/500
            chance = (fish_count * (1 / mini_table.rarity)),
            min = 1,
            max = 1,
        })

    end

    -- In addition, there's a 10% chance of dropping each type of coral that's available
    for _, coral_type in ipairs({"cyan", "green", "pink"}) do

        if unilib.global.pkg_executed_table["coral_rooted_" .. coral_type] ~= nil then

            table.insert(drop_list, {
                name = "unilib:coral_rooted_" .. coral_type,
                chance = 10,
                min = 1,
                max = 1,
            })

        end

    end

    entity_table.drop_list = drop_list

end
