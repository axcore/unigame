---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_butterfly_large = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_butterfly_large.init()

    return {
        description = "Large butterfly",
        depends = {"brain_flying", "vessel_bottle_glass_with_butterfly"},
    }

end

function unilib.pkg.mob_butterfly_large.exec()

    -- Setup
    local p1 = {x = -0.1875, y = -0.5, z = -0.0625}
    local p2 = {x = 0.25, y = 0, z = 0}
    local scale_factor = 1.0
    local baby_scale_factor = 0.5

    local cbox, cbox_baby =
            unimobs.petz_api.get_standard_collisionbox(p1, p2, scale_factor, baby_scale_factor)
    local visual_size = unimobs.petz_api.get_standard_visual_size(scale_factor)

    local mesh = "unilib_mob_butterfly_large.b3d"

    local skin_init_list = {
        -- Normal skins
        {"blue_dark", S("Dark Blue"), 1},
        {"blue_light", S("Light Blue"), 1},
        {"cyan", S("Cyan"), 1},
        {"green_dark", S("Dark Green"), 1},
        {"green_light", S("Light Green"), 1},
        {"lavender", S("Lavender"), 1},
        {"orange", S("Orange"), 1},
        {"pink", S("pink"), 1},
        {"purple", S("Purple"), 1},
        {"red", S("Red"), 0.1},
        {"white", S("White"), 0.01},
        {"yellow", S("Yellow"), 1},
    }
    local genetic_init_list = {
        -- Standard genes
        {"agility", S("Agility"), "range", 1, 3, 0, 12},
        {"loftiness", S("Loftiness"), "range", 1, 3, 0, 12},
        -- Standard genes (generic)
        {"generic", S("Beauty"), "range", 1, 3, 0, 12},
    }

    local brain_func = unilib.pkg.brain_flying.brain
    local description = unilib.utils.brackets(S("Butterfly"), S("Large"))
    local insertion_table = {
        subject = T(S("butterfly#subject")),
        subject_an = T(S("a butterfly#subject")),
        subject_the = T(S("the butterfly#subject")),
        object = T(S("butterfly#object")),
        object_an = T(S("a butterfly#object")),
        object_the = T(S("the butterfly#object")),
    }
    local is_wild_flag = false
    local sci_name = "Papilionoidea"
    local version = 1

    -- Register the entity
    unilib.register_entity("unilib:mob_butterfly_large", {
        -- From petz:butterfly

        -- Base properties (original to unimobs)
        petz_compat_flag = true,
        class_type = "butterfly",
        -- (Was .type = "butterfly")
        mob_type = "butterfly_large",
        generic_type = "butterfly_large",

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
            textures = unimobs.petz_api.compile_texture_list("butterfly_large", skin_init_list),
            visual = unimobs.petz_const.visual,
            visual_size = visual_size,
        },

        -- Mobkit API properties
        animation_table = {
            fly = {range = {x = 0, y = 6}, speed = 25, loop = true},
            run = {range = {x = 0, y = 6}, speed = 25, loop = true},
            stand = {
                {range = {x = 0, y = 0}, speed = 5, loop = true},
            },
            stand_fly = {range = {x = 0, y = 6}, speed = 25, loop = true},
            walk = {range = {x = 0, y = 6}, speed = 25, loop = true},
        },
--      armour_groups = nil,
        attack_table = {range = 0.5, damage_groups = {fleshy = 3}},
        bounciness = 0,
        brain_func = brain_func,
        buoyancy = 0.5,
        jump_height = 2.0,
        lung_capacity = 10,
        max_hp = 4,
        max_speed = 2.5,
--      physics_func = nil,
--      sounds = nil,
--      timeout = nil,
        view_range = 10,

        -- Petz non-dynamic properties
--      avoid_players_flag = false,
--      baby_type_list = nil,
--      can_alight_flag = false,
--      can_breed_flag = false,
--      can_climb_trees_flag = false,
--      can_clutch_flag = false,
        can_fly_flag = true,
        can_groom_flag = false,
--      can_herd_flag = false,
--      can_jump_flag = false,
--      can_perch_flag = false,
--      can_pluck_flag = false,
--      can_swim_flag = false,
        capture_type = "bug_net",
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
        max_roam_height = 4,
--      nest_empty_name = nil,
--      nest_full_name = nil,
        obeys_orders_flag = false,
--      parent_type_list = nil,
--      sleep_in_day_flag = false,
--      sleep_in_night_flag = false,
--      sleep_ratio = nil,
--      spawn_max_light = nil,
        -- N.B. No light restrictions in original code
        spawn_min_light = 12,
        spawn_max_height =
                unimobs.petz_api.get_custom_msetting("butterfly_large", "spawn_max_height"),
        spawn_min_height =
                unimobs.petz_api.get_custom_msetting("butterfly_large", "spawn_min_height"),
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

        -- Petz mob-specific properties (shared with moths)
        bottled_name = "unilib:vessel_bottle_glass_with_butterfly",

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
        mob_type = "butterfly_large",
        mob_name = "unilib:mob_butterfly_large",
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
            -- From petz:butterfly_set. Creates unilib:spawnegg_butterfly_large
            mob_type = "butterfly_large",
            orig_name = "petz:butterfly_set",

            replace_mode = mode,
            description = description,
            img = "unilib_spawnegg_butterfly_large.png",
            mob_name = "unilib:mob_butterfly_large",
            sci_name = sci_name,
            tamed_flag = not is_wild_flag,
        })

    end

end
