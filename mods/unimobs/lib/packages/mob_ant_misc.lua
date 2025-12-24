---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_ant_misc = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_rightclick_mob_callback(self, clicker, wielded_item, wielded_name, is_owner_flag)

    -- Adapted from petz.feed_queen_ant()

    if self.mob_type ~= "ant_queen" then

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

    wielded_item:take_item()
    clicker:set_wielded_item(wielded_item)
    self.egg_count = unimobs.mobkit_api.add_mob_memory(self, "egg_count", 0)

    core.chat_send_player(clicker:get_player_name(), S("The queen ant will now produce eggs again"))

    -- Do not apply the standard behaviour
    return true

end

local function on_init_mob_callback(self)

    -- Adapted from petz.set_initial_properties()

    if self.mob_type ~= "ant_queen" then
        return false
    end

    -- Set a delay before creating an anthill
    local interval = unimobs.petz_setting.establish_colony_interval
    core.after(unimobs.petz_api.get_random_interval(interval), function()

        if unimobs.mobkit_api.is_object_alive(self.object) then

            self.create_colony_flag =
                    unimobs.mobkit_api.add_mob_memory(self, "create_colony_flag", true)

        end

    end, self)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_ant_misc.init()

    return {
        description = "Miscellaneous ants",
        -- N.B. Laying eggs is NOT optional for ants, so "egg_ant_generic" is a hard dependency
        depends = {"brain_ant", "egg_ant_generic", "organ_ant_misc"},
    }

end

function unilib.pkg.mob_ant_misc.exec()

    -- Setup
    local p1 = {x = -0.1875, y = -0.5, z = -0.3125}
    local p2 = {x = 0.25, y = 0.0625, z = 0.3125}
    local variant_table = {
        queen = {
            mob_type = "ant_queen",
            colony_type = "queen",
            orig_spawnegg_name = "petz:queen_ant_set",

            description = unilib.utils.brackets(S("Ant"), S("Queen Ant")),
            drop_list = {
                {name = "unilib:organ_ant_head", chance = 3, min = 1, max = 1},
                {name = "unilib:organ_ant_body", chance = 3, min = 1, max = 1},
                {name = "unilib:organ_ant_leg", chance = 3, min = 1, max = 6},
            },
            egg_name = "unilib:egg_ant_generic",
            forbidden_spawn_flag = false,
            hostile_to_players_flag = false,
            mesh = "unilib_mob_ant_generic.b3d",
            scale_factor = 0.875,
            skin_init_list = {
                -- Normal skins
                {"default", S("Default"), 1},
            }
        },
        warrior = {
            mob_type = "ant_warrior",
            colony_type = "warrior",
            orig_spawnegg_name = "petz:warrior_ant_set",

            description = unilib.utils.brackets(S("Ant"), S("Warrior Ant")),
            drop_list = {},
            egg_name = nil,
            forbidden_spawn_flag = true,
            hostile_to_players_flag = true,
            mesh = "unilib_mob_ant_warrior.b3d",
            scale_factor = 0.575,
            skin_init_list = {
                -- Normal skins
                {"default", S("Default"), 1},
            }
        },
        worker = {
            mob_type = "ant_worker",
            colony_type = "worker",
            orig_spawnegg_name = "petz:ant_set",

            description = unilib.utils.brackets(S("Ant"), S("Worker Ant")),
            drop_list = {},
            egg_name = nil,
            forbidden_spawn_flag = true,
            hostile_to_players_flag = false,
            mesh = "unilib_mob_ant_generic.b3d",
            scale_factor = 0.375,
            skin_init_list = {
                -- Normal skins
                {"default", S("Default"), 1},
            }
        },
    }

    -- Initialise the .custom_table field of unimobs.petz_msetting, if the remix CSV has not
    --      already initialised it
    unimobs.petz_api.initialise_custom_msetting("ant_queen", "custom_lay_egg_interval", 1200)
    unimobs.petz_api.initialise_custom_msetting("ant_queen", "custom_max_laid_eggs", 50)
    unimobs.petz_api.initialise_custom_msetting("ant_queen", "max_population", 5)

    for _, variant in ipairs({"worker", "warrior", "queen"}) do

        local mob_type = variant_table[variant]["mob_type"]

        local scale_factor = variant_table[variant]["scale_factor"]
        local cbox = unimobs.petz_api.get_standard_collisionbox(p1, p2, scale_factor, nil)
        local visual_size = unimobs.petz_api.get_standard_visual_size(scale_factor)

        local mesh = variant_table[variant]["mesh"]

        local skin_init_list = variant_table[variant]["skin_init_list"]
        -- N.B. No genetic traits because of non-standard breeding system
        local genetic_init_list = {}

        local brain_func = unilib.pkg.brain_ant.brain
        local description = variant_table[variant]["description"]
        local insertion_table = {
            subject = T(S("ant#subject")),
            subject_an = T(S("an ant#subject")),
            subject_the = T(S("the ant#subject")),
            object = T(S("ant#object")),
            object_an = T(S("an ant#object")),
            object_the = T(S("the ant#object")),
        }
        local is_wild_flag = true
        local sci_name = "Lasius niger"
        local version = 1

        -- Register the entity
        unilib.register_entity("unilib:mob_" .. mob_type, {
            -- From petz:ant, petz:warrior_ant, petz:queen_ant

            -- Base properties (original to unimobs)
            petz_compat_flag = true,
            class_type = "ant",
            -- (Was .type = "ant" for all variants)
            mob_type = mob_type,
            generic_type = "ant_generic",

            description = description,
            sci_name = sci_name,

            -- Common properties
            initial_properties = {
--              backface_culling = false,
                collide_with_objects = true,
                collisionbox = cbox,
--              makes_footstep_sound = false,
                mesh = mesh,
                physical = true,
                selectionbox = cbox,
                static_save = true,
                stepheight = 0.1,
                textures = unimobs.petz_api.compile_texture_list(mob_type, skin_init_list),
                visual = unimobs.petz_const.visual,
                visual_size = visual_size,
            },

            -- Mobkit API properties
            animation_table = {
                fly = {range = {x = 92, y = 98}, speed = 30, loop = true},
                run = {range = {x = 13, y = 25}, speed = 20, loop = true},
                stand = {
                    {range = {x = 26, y = 46}, speed = 5, loop = true},
                    {range = {x = 47, y = 59}, speed = 5, loop = true},
                    {range = {x = 60, y = 70}, speed = 5, loop = true},
                    {range = {x = 71, y = 91}, speed = 5, loop = true},
                },
                stand_fly = {range = {x = 92, y = 98}, speed = 30, loop = true},
                walk = {range = {x = 1, y = 12}, speed = 20, loop = true},
            },
--          armour_groups = nil,
            attack_table = {range = 0.5, damage_groups = {fleshy = 3}},
            bounciness = 0,
            brain_func = brain_func,
            buoyancy = 0.5,
            jump_height = 2.0,
            lung_capacity = 10,
            max_hp = 2,
            max_speed = 3.5,
--          physics_func = nil,
--          sounds = nil,
--          timeout = nil,
            view_range = 10,

            -- Petz non-dynamic properties
            avoid_players_flag = false,
--          baby_type_list = nil,
--          can_alight_flag = false,
--          can_breed_flag = false,
--          can_climb_trees_flag = false,
--          can_clutch_flag = false,
            can_fly_flag = false,
            can_groom_flag = false,
--          can_herd_flag = false,
--          can_jump_flag = false,
--          can_perch_flag = false,
--          can_pluck_flag = false,
--          can_swim_flag = false,
            capture_type = "bug_net",
            default_rotation = unimobs.petz_const.rotate,
--          die_in_daylight_flag = false,
            drop_list = variant_table[variant]["drop_list"],
--          dung_name = nil,
            egg_name = variant_table[variant]["egg_name"],
            has_tamagotchi_mode_flag = false,
--          head_prop_table = nil,
            hostile_to_players_flag = variant_table[variant]["hostile_to_players_flag"],
--          igniter_immunity_flag = false,
--          is_baby_flag = nil,
--          is_boss_flag = false,
--          is_male_flag = nil,
--          is_mammal_flag = false,
--          is_milkable_flag = false,
--          is_monster_flag = false,
--          is_mountable_flag = false,
            is_pet_flag = false,
            is_wild_flag = is_wild_flag,
--          jump_chance = nil,
--          jump_impulse = nil,
            max_roam_height = 5,
--          nest_empty_name = nil,
--          nest_full_name = nil,
            obeys_orders_flag = false,
--          parent_type_list = nil,
--          sleep_in_day_flag = false,
--          sleep_in_night_flag = false,
--          sleep_ratio = nil,
--          spawn_max_light = nil,
--          spawn_min_light = nil,
            spawn_max_height = unimobs.petz_api.get_custom_msetting(mob_type, "spawn_max_height"),
            spawn_min_height = unimobs.petz_api.get_custom_msetting(mob_type, "spawn_min_height"),
--          straggle_type_list = nil,

            -- Petz baby properties
--          collisionbox_baby = nil,
--          selectionbox_baby = nil,
--          visual_size_baby = nil,

            -- Petz replace properties
--          replace_data_list = nil,
--          replace_rate = nil,
--          replace_turf_flag = false,
--          replace_turf_offset = 0,

            -- Petz mob-specific properties (shared with bees)
            colony_type = variant_table[variant]["colony_type"],

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
            mob_type = mob_type,
            mob_name = "unilib:mob_" .. mob_type,
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
                -- From petz:ant_set, petz:warrior_ant_set, petz:queen_ant_set. Creates
                --      unilib:spawnegg_ant_worker, unilib:spawnegg_ant_warrior,
                --      unilib:spawnegg_ant_queen
                mob_type = mob_type,
                orig_name = variant_table[variant]["orig_spawnegg_name"],

                replace_mode = mode,
                description = description,
                img = "unilib_spawnegg_" .. mob_type .. ".png",
                mob_name = "unilib:mob_" .. mob_type,
                sci_name = sci_name,
                tamed_flag = not is_wild_flag,
            })

        end

        -- Queens can spawn naturally, but workers/warriors cannot
        if variant_table[variant]["forbidden_spawn_flag"] then
            unimobs.global.forbidden_spawn_table[mob_type] = true
        end

    end

    -- Override the standard behaviour when queens are being initialised
    unimobs.petz_api.register_initial_extension("ant_queen", on_init_mob_callback)

    -- Override the standard behaviour when a mob is right-clicked while wielding this item
    unimobs.petz_api.register_rightclick_override(
        "unilib:crop_wheat_seed", on_rightclick_mob_callback
    )
    unimobs.petz_api.register_rightclick_override(
        "farming:seed_wheat", on_rightclick_mob_callback
    )

end
