---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_fish_tropical = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_fish_tropical.generate_spritesheets(container_name, all_flag)

    -- Change to the original code - the spritesheet entities are only generated if needed, for
    --      example by a call to this function from the "misc_tank_fish" package
    -- "container_name" is the node in which the entity is used, e.g. "unilib:misc_tank_fish"
    -- "all_flag", if true, generates spritesheet entities for all skins; otherwise only the
    --      spritesheet entity from the original code is generated
    -- Returns a list of "skin_type"s used; the first skin in the list is the default one

    local skin_list = {"yellow_blue"}
    if all_flag then

        local data_table = unimobs.petz_global.mob_table["fish_tropical"]
        for _, mini_list in ipairs(data_table.skin_init_list) do

            if mini_list[1] ~= "yellow_blue" then
                table.insert(skin_list, mini_list[1])
            end

        end

    end

    for _, skin_type in ipairs(skin_list) do

        unilib.register_entity("unilib:mob_fish_tropical_" .. skin_type .. "_sprite_entity", {
            -- From petz:tropicalfish_entity_sprite
            initial_properties = {
                collisionbox = {0},
                initial_sprite_basepos = {x = 0, y = 0},
                physical = false,
                spritediv = {x = 1, y = 16},
                textures = {"unilib_mob_fish_tropical_" .. skin_type .. "_spritesheet.png"},
                visual = "sprite",
                visual_size = {x = 0.8, y = 0.8},
            },

            groups = {fishtank = 1},

            on_activate = function(self, staticdata)

                local pos = self.object:get_pos()
                if core.get_node(pos).name ~= container_name then
                    unimobs.kitz_api.remove_mob(self)
                end

            end,
        })

    end

    return skin_list

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_fish_tropical.init()

    return {
        description = "Tropical fish",
        depends = {"brain_aquatic", "coral_block_brown"},
        -- (This fish is compatible with the fish tank, if available)
        optional = "misc_tank_fish",
    }

end

function unilib.pkg.mob_fish_tropical.exec()

    -- Setup
    local p1 = {x = -0.125, y = -0.5, z = -0.1875}
    local p2 = {x = 0.1875, y = 0.1875, z = 0.375}
    local scale_factor = 1.5
    local baby_scale_factor = 0.66

    local cbox, cbox_baby =
            unimobs.petz_api.get_standard_collisionbox(p1, p2, scale_factor, baby_scale_factor)
    local visual_size = unimobs.petz_api.get_standard_visual_size(scale_factor)

    local mesh = "unilib_mob_fish_tropical.b3d"

    local skin_init_list = {
        -- Normal skins
        {"black_orange", S("Black and Orange"), 1},
        {"blue_black", S("Blue and Black"), 1},
        {"blue_red", S("Blue and Red"), 1},
        {"blue_yellow", S("Blue and Yellow"), 1},
        {"green_blue", S("Green and Blue"), 1},
        {"purple_orange", S("Purple and Orange"), 1},
        {"purple_white", S("Purple and White"), 1},
        {"red_orange", S("Red and Orange"), 1},
        {"red_white", S("Red and White"), 1},
        {"white_blue", S("White and Blue"), 1},
        {"white_purple", S("White and Purple"), 1},
        {"white_red", S("White and Red"), 1},
        {"yellow_orange", S("Yellow and Orange"), 1},
        {"yellow_blue", S("Yellow and Blue"), 1},
        {"white_black", S("White and Black"), 0.1},
        {"green_yellow", S("Green and Yellow"), 0.01},
    }
    local genetic_init_list = {
        -- Standard genes
        {"agility", S("Evasiveness"), "range", 1, 3, 0, 12},
        {"fertility", S("Scaliness"), "range", 1, 3, 0, 12},
        {"luckiness", S("Colourful"), "range", 1, 3, 0, 12},
    }

    local brain_func = unilib.pkg.brain_aquatic.brain
    local description = unilib.utils.brackets(S("Fish"), S("Tropical"))
    local insertion_table = {
        subject = T(S("tropical fish#subject")),
        subject_an = T(S("a tropical fish#subject")),
        subject_the = T(S("the tropical fish#subject")),
        object = T(S("tropical fish#object")),
        object_an = T(S("a tropical fish#object")),
        object_the = T(S("the tropical fish#object")),
    }
    local is_wild_flag = false
    -- N.B. Not possible to use a single scientific name
    local sci_name = nil
    local version = 1

    -- Register the entity
    unilib.register_entity("unilib:mob_fish_tropical", {
        -- From petz:tropicalfish

        -- Base properties (original to unimobs)
        petz_compat_flag = true,
        class_type = "fish",
        -- (Was .type = "tropicalfish")
        mob_type = "fish_tropical",
        generic_type = "fish_tropical",

        description = description,
        sci_name = sci_name,

        -- (Standard entity properties)
        groups = {fish = 1, fishtank = 1},

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
            textures = unimobs.petz_api.compile_texture_list("fish_tropical", skin_init_list),
            visual = unimobs.petz_const.visual,
            visual_size = visual_size,
        },

        -- Mobkit API properties
        animation_table = {
            def = {range = {x = 1, y = 13}, speed = 20, loop = true},
            stand = {
                {range = {x = 13, y = 25}, speed = 5, loop = true},
            },
        },
--      armour_groups = nil,
--      attack_table = nil,
        bounciness = 0,
        brain_func = brain_func,
        buoyancy = 1.1,
        jump_height = 0,
--      lung_capacity = nil,
        max_hp = 4,
        max_speed = 1.5,
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
--      can_fly_flag = false,
        can_groom_flag = false,
--      can_herd_flag = false,
        can_jump_flag = false,
--      can_perch_flag = false,
--      can_pluck_flag = false,
        can_swim_flag = true,
        capture_type = "animal_net",
        default_rotation = unimobs.petz_const.rotate,
--      die_in_daylight_flag = false,
        drop_list = {
            {name = "unilib:coral_block_brown", chance = 5, min = 1, max = 1},
        },
--      dung_name = nil,
--      egg_name = nil,
        has_tamagotchi_mode_flag = false,
--      head_prop_table = nil,
--      hostile_to_players_flag = false,
--      igniter_immunity_flag = false,
--      is_baby_flag = nil,
--      is_boss_flag = false,
--      is_male_flag = nil,
        is_mammal_flag = false,
--      is_milkable_flag = false,
--      is_monster_flag = false,
--      is_mountable_flag = false,
        is_pet_flag = false,
        is_wild_flag = is_wild_flag,
--      jump_chance = nil,
--      jump_impulse = nil,
        max_roam_height = -2,
--      nest_empty_name = nil,
--      nest_full_name = nil,
        obeys_orders_flag = false,
--      parent_type_list = nil,
--      sleep_in_day_flag = false,
--      sleep_in_night_flag = false,
--      sleep_ratio = nil,
--      spawn_max_light = nil,
--      spawn_min_light = nil,
        spawn_max_height =
                unimobs.petz_api.get_custom_msetting("fish_tropical", "spawn_max_height"),
        spawn_min_height =
                unimobs.petz_api.get_custom_msetting("fish_tropical", "spawn_min_height"),
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
        mob_type = "fish_tropical",
        mob_name = "unilib:mob_fish_tropical",
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
            -- From petz:tropicalfish_set. Creates unilib:spawnegg_fish_tropical
            mob_type = "fish_tropical",
            orig_name = "petz:tropicalfish_set",

            replace_mode = mode,
            description = description,
            img = "unilib_spawnegg_fish_tropical.png",
            mob_name = "unilib:mob_fish_tropical",
            sci_name = sci_name,
            tamed_flag = not is_wild_flag,
        })

    end

end
