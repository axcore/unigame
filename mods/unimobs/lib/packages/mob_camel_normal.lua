---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_camel_normal = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_death_callback(self)

    -- Adapted from petz.on_die()
    -- On death, dismount from the camel and drop items

    unimobs.petz_api.remove_equipment_from_mountable_mob(self)

    -- If mounted, force a dismount
    if self.driver then
        unimobs.petz_api.force_dismount_player_from_mob(self.driver)
    end

end

local function on_rightclick_mob_callback(self, clicker, wielded_item, wielded_name, is_owner_flag)

    -- Adapted from petz.on_rightclick()

    if self.mob_type ~= "camel_normal" or
            not self.is_milkable_flag or
            not clicker:get_inventory() then

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

    -- Milk the camel
    unimobs.petz_api.extract_milk_from_mob(self, clicker, "unilib:bucket_steel_with_milk_camel")

    -- Do not apply the standard behaviour
    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_camel_normal.init()

    return {
        description = "Normal camel",
        depends = {"brain_herbivore", "bucket_steel_with_milk_camel", "item_bone_animal"},
    }

end

function unilib.pkg.mob_camel_normal.exec()

    -- Setup
    local p1 = {x = -0.125, y = -0.5, z = -0.4375}
    local p2 = {x = 0.25, y = 0.375, z = 0.375}
    local scale_factor = 2.7
    local baby_scale_factor = 0.5

    local cbox, cbox_baby =
            unimobs.petz_api.get_standard_collisionbox(p1, p2, scale_factor, baby_scale_factor)
    local visual_size = unimobs.petz_api.get_standard_visual_size(scale_factor)

    local mesh = "unilib_mob_camel_normal.b3d"

    local skin_init_list = {
        -- Normal skins
        {"brown_light", S("Light Brown"), 1},
        {"yellow", S("Yellow"), 1},
        {"beige", S("Beige"), 0.5},
        {"brown_dark", S("Dark Brown"), 0.1},
        {"grey", S("Grey"), 0.1},
        {"pink", S("Pink"), 0.05},
        {"red", S("Red"), 0.05},
        -- Rare mutations
        {"white", S("White"), 0},
    }
    local genetic_init_list = {
        -- Standard genes
        {"digestion", S("Digestion"), "range", 1, 3, 0, 12},
        {"docility", S("Docility"), "range", 1, 3, 0, 12},
        {"fertility", S("Fertility"), "range", 1, 3, 0, 12},
        -- Standard genes (genetic mutations)
        -- N.B. Higher than normal variability, because of the large number of camel skins
        {"variability", S("Variability"), "range", 3, 5, 0, 12},
        -- Standard genes (mounted mobs)
        {
            "mounted_forward_speed",
            S("Forward speed when mounted"),
            "range", 2, 4, 0, 12,
        },
        {
            "mounted_reverse_speed",
            S("Reverse speed when mounted"),
            "range", 1, 2, 0, 12,
        },
        {
            "mounted_speed_boost",
            S("Speed boost when mounted"),
            "range", 2, 4, 0, 12,
        },
    }

    local brain_func = unilib.pkg.brain_herbivore.brain
    local description = unilib.utils.brackets(S("Camel"), S("Normal"))
    local insertion_table = {
        subject = T(S("camel#subject")),
        subject_an = T(S("a camel#subject")),
        subject_the = T(S("the camel#subject")),
        object = T(S("camel#object")),
        object_an = T(S("a camel#object")),
        object_the = T(S("the camel#object")),
    }
    local is_wild_flag = false
    local sci_name = "Camelus dromedarius"
    local version = 1

    -- Register the entity
    unilib.register_entity("unilib:mob_camel_normal", {
        -- From petz:camel

        -- Base properties (original to unimobs)
        petz_compat_flag = true,
        class_type = "camel",
        -- (Was .type = "camel")
        mob_type = "camel_normal",
        generic_type = "camel_normal",

        description = description,
        sci_name = sci_name,

        -- Common properties
        initial_properties = {
--          backface_culling = false,
            collide_with_objects = true,
            collisionbox = cbox,
            makes_footstep_sound = false,
            mesh = mesh,
            physical = true,
            selectionbox = cbox,
            static_save = true,
            stepheight = 0.1,
            textures = unimobs.petz_api.compile_texture_list("camel_normal", skin_init_list),
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
            misc = "unilib_mob_camel_normal_grunting",
            moaning = "unilib_mob_camel_normal_moaning",
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
        can_groom_flag = true,
--      can_herd_flag = false,
--      can_jump_flag = false,
--      can_perch_flag = false,
--      can_pluck_flag = false,
--      can_swim_flag = false,
        capture_type = "lasso",
        default_rotation = unimobs.petz_const.rotate,
--      die_in_daylight_flag = false,
        drop_list = {
            {name = "unilib:item_bone_animal", chance = 5, min = 1, max = 1},
        },
--      dung_name = nil,
--      egg_name = nil,
        has_tamagotchi_mode_flag = true,
--      head_prop_table = nil,
--      hostile_to_players_flag = false,
--      igniter_immunity_flag = false,
--      is_baby_flag = nil,
--      is_boss_flag = false,
--      is_male_flag = nil,
--      is_mammal_flag = false,
        is_milkable_flag = true,
--      is_monster_flag = false,
        is_mountable_flag = true,
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
        -- N.B. No light restrictions in original code
        spawn_min_light = 12,
        spawn_max_height = unimobs.petz_api.get_custom_msetting("camel_normal", "spawn_max_height"),
        spawn_min_height = unimobs.petz_api.get_custom_msetting("camel_normal", "spawn_min_height"),
        straggle_type_list = {"camel_normal"},

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
        can_have_saddlebag_flag = true,
        -- N.B. Removed properties that were not used in the original petz code
--      terrain_type = 3,
        -- Petz mob-specific properties (shared with ponies)
        baby_scale_factor = baby_scale_factor,
        driver_attach_at = {x = 0.0625, y = 0.25, z = -0.3},
        -- N.B. Originally x = 0, y = 0, z = 0. Tweaked so that a mounted player can see where
        --      they're going, and because the mounted position isn't quite centred. If the model is
        --      ever changed, the original values could be restored
        driver_eye_offset = {x = 1.75, y = 5, z = 0},
        driver_scale = {x = 1 / visual_size.x, y = 1 / visual_size.y},
        scale_factor = scale_factor,

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
        mob_type = "camel_normal",
        mob_name = "unilib:mob_camel_normal",
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
            -- From petz:camel_set. Creates unilib:spawnegg_camel_normal
            mob_type = "camel_normal",
            orig_name = "petz:camel_set",

            replace_mode = mode,
            description = description,
            img = "unilib_spawnegg_camel_normal.png",
            mob_name = "unilib:mob_camel_normal",
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

    -- Extend the standard behaviour when this mob dies
    unimobs.petz_api.register_death_extension("camel_normal", on_death_callback)

end
