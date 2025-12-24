---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_beaver_normal = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local ceil = math.ceil
local random = math.random

-- Chance of building a dam, before genetics are taken into account
local default_build_chance = 60000
-- The factor by which the building time is reduced, with optimal genetics
local genetic_factor = 0.6

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_beaver_normal.create_dam(self, pos)

    -- From petz.create_dam()
    -- Called by the "brain_semiaquatic" package when it's time for a beaver to build a dam at the
    --      specified "pos"

    -- A beaver can create only one dam
    if unimobs.petz_api.get_custom_msetting("beaver_normal", "can_create_beaver_dam") and
            not self.dam_created then

        -- Dam building times can be reduced, depending on the "dam_building" gene
        local build_chance = default_build_chance
        local genetic_value = self.genetic_table["dam_building"]
        local data_table = unimobs.petz_api.get_genetic_range_table(self, "dam_building")
        if genetic_value ~= nil and genetic_value > 0 and data_table ~= nil then

            local reduction_factor = genetic_factor * (
                (genetic_value - data_table.overall_min) /
                (data_table.overall_max - data_table.overall_min)
            )

            build_chance = ceil(build_chance * (1 - reduction_factor))

        end

        -- Chance of the dam being created
        if random(1, build_chance) > 1 then
            return false
        end

        -- Check if there is water below, for when the beaver is still terrestrial but floating on
        --      the surface of the water
        local pos_underwater = {x = pos.x, y = pos.y - 4.5, z = pos.z}
        local under_name = core.get_node(pos_underwater).name
        if under_name == "unilib:sand_ordinary" or under_name == "default:sand" then

            core.place_schematic(
                {x = pos.x, y = pos.y - 2.0, z = pos.z},
                unimobs.path_mod .. "/mts/unilib_misc_dam_beaver.mts",
                -- N.B. Replaced incorrect numeric value in original code
                "0",
                nil,
                true
            )

            self.dam_created = true
            return true

        end

    end

    return false

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_beaver_normal.init()

    return {
        description = "Normal beaver",
        depends = {"brain_semiaquatic", "item_bone_animal", "organ_fur_beaver"},
        -- Beavers create dams in ordinary sand
        optional = "sand_ordinary",
    }

end

function unilib.pkg.mob_beaver_normal.exec()

    -- Setup
    local p1 = {x = -0.125, y = -0.5, z = -0.1875}
    local p2 = {x = 0.1875, y = -0.0625, z = 0.375}
    local scale_factor = 1.8
    local baby_scale_factor = 0.5

    local cbox, cbox_baby =
            unimobs.petz_api.get_standard_collisionbox(p1, p2, scale_factor, baby_scale_factor)
    local visual_size = unimobs.petz_api.get_standard_visual_size(scale_factor)

    local mesh = "unilib_mob_beaver_normal.b3d"

    local skin_init_list = {
        -- Normal skins
        {"brown", S("Brown"), 1},
        {"red", S("Red"), 0.1},
        {"yellow", S("Yellow"), 0.1},
        {"white", S("White"), 0.05},
    }
    local genetic_init_list = {
        -- Standard genes
        {"digestion", S("Timber chewing"), "range", 1, 3, 0, 12},
        {"fertility", S("Devotion"), "range", 1, 3, 0, 12},
        -- Custom genes
        -- Dam building: reduces the amount of time required to build a dam by up to 50%
        {"dam_building", S("Industriousness"), "range", 1, 3, 0, 12},
    }

    local brain_func = unilib.pkg.brain_semiaquatic.brain
    local description = unilib.utils.brackets(S("Beaver"), S("Normal"))
    local insertion_table = {
        subject = T(S("beaver#subject")),
        subject_an = T(S("a beaver#subject")),
        subject_the = T(S("the beaver#subject")),
        object = T(S("beaver#object")),
        object_an = T(S("a beaver#object")),
        object_the = T(S("the beaver#object")),
    }
    local is_wild_flag = false
    local sci_name = "Castor canadensis"
    local version = 1

    -- Initialise the .custom_table field of unimobs.petz_msetting, if the remix CSV has not
    --      already initialised it
    unimobs.petz_api.initialise_custom_msetting("beaver_normal", "can_create_beaver_dam", true)

    -- Register the entity
    unilib.register_entity("unilib:mob_beaver_normal", {
        -- From petz:beaver

        -- Base properties (original to unimobs)
        petz_compat_flag = true,
        class_type = "beaver",
        -- (Was .type = "beaver")
        mob_type = "beaver_normal",
        generic_type = "beaver_normal",

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
            textures = unimobs.petz_api.compile_texture_list("beaver_normal", skin_init_list),
            visual = unimobs.petz_const.visual,
            visual_size = visual_size,
        },

        -- Mobkit API properties
        animation_table = {
            def = {range = {x = 96, y = 116}, speed = 25, loop = true},
            run = {range = {x = 13, y = 25}, speed = 25, loop = true},
            sit = {range = {x = 60, y = 81}, speed = 5, loop = false},
            stand = {
                {range = {x = 26, y = 46}, speed = 5, loop = true},
                {range = {x = 46, y = 60}, speed = 5, loop = true},
                {range = {x = 82, y = 95}, speed = 5, loop = true},
            },
            walk = {range = {x = 1, y = 12}, speed = 25, loop = true},
        },
--      armour_groups = nil,
        attack_table = {range = 0.5, damage_groups = {fleshy = 7}},
        bounciness = 0,
        brain_func = brain_func,
        buoyancy = 1.1,
        jump_height = 1.5,
--      lung_capacity = nil,
        max_hp = 15,
        max_speed = 1.0,
--      physics_func = nil,
        sounds = {
            misc = "unilib_mob_beaver_normal_misc",
            moaning = "unilib_mob_beaver_normal_moaning",
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
--      can_fly_flag = false,
        can_groom_flag = false,
--      can_herd_flag = false,
--      can_jump_flag = false,
--      can_perch_flag = false,
--      can_pluck_flag = false,
        can_swim_flag = true,
        capture_type = "lasso",
        default_rotation = unimobs.petz_const.rotate,
--      die_in_daylight_flag = false,
        drop_list = {
            {name = "unilib:item_bone_animal", chance = 5, min = 1, max = 1},
            {name = "unilib:organ_fur_beaver", chance = 1, min = 1, max = 1},
        },
--      dung_name = nil,
--      egg_name = nil,
        has_tamagotchi_mode_flag = false,
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
--      spawn_max_light = nil,
        -- N.B. No light restrictions in original code
        spawn_min_light = 12,
        spawn_max_height =
                unimobs.petz_api.get_custom_msetting("beaver_normal", "spawn_max_height"),
        spawn_min_height =
                unimobs.petz_api.get_custom_msetting("beaver_normal", "spawn_min_height"),
        straggle_type_list = {"beaver_normal"},

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
        mob_type = "beaver_normal",
        mob_name = "unilib:mob_beaver_normal",
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
            -- From petz:beaver_set. Creates unilib:spawnegg_beaver_normal
            mob_type = "beaver_normal",
            orig_name = "petz:beaver_set",

            replace_mode = mode,
            description = description,
            img = "unilib_spawnegg_beaver_normal.png",
            mob_name = "unilib:mob_beaver_normal",
            sci_name = sci_name,
            tamed_flag = not is_wild_flag,
        })

    end

end
