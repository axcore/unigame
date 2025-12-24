---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_cow_normal = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_rightclick_mob_callback(self, clicker, wielded_item, wielded_name, is_owner_flag)

    -- Adapted from petz.on_rightclick()

    if self.mob_type ~= "cow_normal" or
            not self.is_milkable_flag or
            not clicker:get_inventory() then

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

    -- Milk the cow
    unimobs.petz_api.extract_milk_from_mob(self, clicker, "unilib:bucket_steel_with_milk_cow")

    -- Do not apply the standard behaviour
    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_cow_normal.init()

    return {
        description = "Normal cow",
        depends = {
            "brain_herbivore",
            "bucket_steel_with_milk_cow",
            "food_beef_steak",
            "item_bone_animal",
            "misc_dung_normal",
            "organ_leather_normal",
        },
    }

end

function unilib.pkg.mob_cow_normal.exec()

    -- Setup
    local p1 = {x = -0.0625, y = -0.5, z = -0.1875}
    local p2 = {x = 0.125, y = -0.0625, z = 0.1875}
    local scale_factor = 4.5
    local baby_scale_factor = 0.5

    local cbox, cbox_baby =
            unimobs.petz_api.get_standard_collisionbox(p1, p2, scale_factor, baby_scale_factor)
    local visual_size = unimobs.petz_api.get_standard_visual_size(scale_factor)

    local mesh = "unilib_mob_cow_normal.b3d"

    local skin_init_list = {
        -- Normal skins
        {"black_white", S("Black and White"), 1},
        {"brown_white", S("Brown and White"), 1},
        {"brown", S("Brown"), 0.5},
        {"white_black", S("White and Black"), 0.5},
        {"white_brown", S("White and Brown"), 0.5},
        {"grey", S("Grey"), 0.1},
    }
    local genetic_init_list = {
        -- Standard genes
        {"digestion", S("Digestion"), "range", 1, 3, 0, 12},
        {"docility", S("Docility"), "range", 1, 3, 0, 12},
        {"fertility", S("Fertility"), "range", 1, 3, 0, 12},
        {"incontinence", S("Incontinence"), "range", 1, 3, 0, 12},
    }

    local brain_func = unilib.pkg.brain_herbivore.brain
    local description = unilib.utils.brackets(S("Cow"), S("Normal"))
    local insertion_table = {
        subject = T(S("cow#subject")),
        subject_an = T(S("a cow#subject")),
        subject_the = T(S("the cow#subject")),
        object = T(S("cow#object")),
        object_an = T(S("a cow#object")),
        object_the = T(S("the cow#object")),
    }
    local is_wild_flag = false
    local sci_name = "Bos taurus"
    local version = 1

    -- Register the entity
    unilib.register_entity("unilib:mob_cow_normal", {
        -- From petz:calf

        -- Base properties (original to unimobs)
        petz_compat_flag = true,
        class_type = "cow",
        -- (Was .type = "calf")
        mob_type = "cow_normal",
        generic_type = "cow_normal",

        description = description,
        sci_name = sci_name,

        -- Common properties
        initial_properties = {
--          backface_culling = false,
            collide_with_objects = true,
            collisionbox = cbox,
            makes_footstep_sound = true,
            mesh = mesh,
            physical = true,
            selectionbox = cbox,
            static_save = true,
            stepheight = 0.1,
            textures = unimobs.petz_api.compile_texture_list("cow_normal", skin_init_list),
            visual = unimobs.petz_const.visual,
            visual_size = visual_size,
        },

        -- Mobkit API properties
        animation_table = {
            run = {range = {x = 13, y = 25}, speed = 25, loop = true},
            stand = {
                {range = {x = 26, y = 46}, speed = 5, loop = true},
                {range = {x = 47, y = 59}, speed = 5, loop = true},
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
        max_hp = 15,
        max_speed = 2.0,
--      physics_func = nil,
        sounds = {
            misc = {"unilib_mob_cow_normal_moo_1", "unilib_mob_cow_normal_moo_2"},
            moaning = "unilib_mob_cow_normal_moaning",
        },
--      timeout = nil,
        view_range = 10,

        -- Petz non-dynamic properties
--      avoid_players_flag = false,
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
            {name = "unilib:food_beef_steak_raw", chance = 1, min = 1, max = 1},
            {name = "unilib:organ_leather_normal", chance = 2, min = 1, max = 1},
            {name = "unilib:item_bone_animal", chance = 4, min = 1, max = 1},
        },
        dung_name = "unilib:misc_dung_normal",
--      egg_name = nil,
        has_tamagotchi_mode_flag = false,
        head_prop_table = {
            -- N.B. .clamp_list not in original code
            clamp_list = {
                -- Look up (-60) / straight ahead (-90) / down (-120)
                {dim = "x", min = -60, max = 360, correction = -60},
                {dim = "x", min = -360, max = -120, correction = -120},
                -- Look left (0) / straight ahead (90) / right (180)
                {dim = "y", min = -90, max = 0, correction = 0},
                {dim = "y", min = 180, max = 360, correction = 180},
            },
            eye_offset = -0.5,
            position = vector.new(-0.1939, 0.4848, 0),
            -- (In degrees, normally values are -90, 0, 90)
            rotation_origin = vector.new(-90, 90, 0),
        },
--      hostile_to_players_flag = false,
--      igniter_immunity_flag = false,
--      is_baby_flag = nil,
--      is_boss_flag = false,
--      is_male_flag = nil,
--      is_mammal_flag = false,
        is_milkable_flag = true,
--      is_monster_flag = false,
--      is_mountable_flag = false,
        is_pet_flag = true,
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
--      spawn_max_light = nil,
        -- N.B. No light restrictions in original code
        spawn_min_light = 12,
        spawn_max_height = unimobs.petz_api.get_custom_msetting("cow_normal", "spawn_max_height"),
        spawn_min_height = unimobs.petz_api.get_custom_msetting("cow_normal", "spawn_min_height"),
        straggle_type_list = {"cow_normal"},

        -- Petz baby properties
        collisionbox_baby = cbox_baby,
        selectionbox_baby = cbox_baby,
        visual_size_baby = {
            x = visual_size.x * baby_scale_factor,
            y = visual_size.y * baby_scale_factor,
        },

        -- Petz replace properties (N.B. .replace_offset has been removed)
        -- N.B. unilib's dirt-with-turf node is commented out, because it's handled by
        --      .replace_turf_flag = true
        -- N.B. Offsets in original code seem to be wrong, so they have been replaced (originally,
        --      -1 for grass and -2 for dirt-with-turf)
        replace_data_list = {
            {"group:grass", "air", -2},
--          {"unilib:dirt_ordinary_with_turf", "unilib:dirt_ordinary", -3},
            {"default:dirt_with_grass", "default:dirt", -3},
        },
        -- N.B. .replace_rate = 10 in original code
        replace_rate = 30,
        replace_turf_flag = true,
        replace_turf_offset = -3,

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
        mob_type = "cow_normal",
        mob_name = "unilib:mob_cow_normal",
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
            -- From petz:calf_set. Creates unilib:spawnegg_cow_normal
            mob_type = "cow_normal",
            orig_name = "petz:calf_set",

            replace_mode = mode,
            description = description,
            img = "unilib_spawnegg_cow_normal.png",
            mob_name = "unilib:mob_cow_normal",
            sci_name = sci_name,
            tamed_flag = not is_wild_flag,
        })

    end

    -- Override the standard behaviour when a mob is right-clicked while wielding this item
    unimobs.petz_api.register_rightclick_override(
        "unilib:bucket_steel_empty", on_rightclick_mob_callback
    )

    unimobs.petz_api.register_rightclick_override(
        "bucket:bucket_empty", on_rightclick_mob_callback
    )

end

function unilib.pkg.mob_cow_normal.post()

    -- Refine .replace_data_list to remove non-existent nodes
    unimobs.kitz_api.refine_replace_data("unilib:mob_cow_normal")

end
