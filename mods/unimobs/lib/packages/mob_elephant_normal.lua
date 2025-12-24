---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_elephant_normal = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_elephant_normal.init()

    return {
        description = "Normal elephant",
        depends = {"brain_herbivore", "item_bone_animal", "organ_tusk_elephant"},
    }

end

function unilib.pkg.mob_elephant_normal.exec()

    -- Setup
    local p1 = {x = -0.125, y = -0.5, z = -0.3125}
    local p2 = {x = 0.1875, y = -0.0625, z = 0.25}
    local baby_scale_factor = 0.5

    local variant_table = {
        male = {
            mob_type = "elephant_normal_male",
            orig_spawnegg_name = "petz:elephant_set",

            description = unilib.utils.brackets(S("Elephant"), S("Normal male")),
            extra_offset = -1,
            is_male_flag = true,
            mesh = "unilib_mob_elephant_normal_male.b3d",
            scale_factor = 4.5,
            skin_init_list = {
                -- Normal skins
                {"grey", S("Grey"), 1},
                -- Rare mutations
                {"white", S("White"), 0},
            },
        },
        female = {
            mob_type = "elephant_normal_female",
            orig_spawnegg_name = "petz:elephant_female_set",

            description = unilib.utils.brackets(S("Elephant"), S("Normal female")),
            extra_offset = 0,
            is_male_flag = false,
            mesh = "unilib_mob_elephant_normal_male.b3d",
            scale_factor = 3.75,
            skin_init_list = {
                -- Normal skins
                {"brown", S("Brown"), 1},
                -- Rare mutations
                {"white", S("White"), 0},
            },
        },
    }

    for _, variant in ipairs({"male", "female"}) do

        local mob_type = variant_table[variant]["mob_type"]

        local scale_factor = variant_table[variant]["scale_factor"]
        local cbox, cbox_baby =
                unimobs.petz_api.get_standard_collisionbox(p1, p2, scale_factor, baby_scale_factor)
        local visual_size = unimobs.petz_api.get_standard_visual_size(scale_factor)

        local mesh = variant_table[variant]["mesh"]

        local skin_init_list = variant_table[variant]["skin_init_list"]
        local genetic_init_list = {
            -- Standard genes
            {"digestion", S("Trunk size"), "range", 1, 3, 0, 12},
            {"luckiness", S("Memory"), "range", 1, 3, 0, 12},
            {"toughness", S("Grumpiness"), "range", 1, 3, 0, 12},
            -- Standard genes (genetic mutations)
            {"variability", S("Loyalty"), "range", 2, 4, 0, 12},
        }

        local brain_func = unilib.pkg.brain_herbivore.brain
        local description = variant_table[variant]["description"]
        local insertion_table = {
            subject = T(S("elephant#subject")),
            subject_an = T(S("an elephant#subject")),
            subject_the = T(S("the elephant#subject")),
            object = T(S("elephant#object")),
            object_an = T(S("an elephant#object")),
            object_the = T(S("the elephant#object")),
        }
        local is_wild_flag = false
        local sci_name = "Loxodonta africana"
        local version = 1

        -- Register the entity
        unilib.register_entity("unilib:mob_" .. mob_type, {
            -- From petz:elephant, petz:elephant_female

            -- Base properties (original to unimobs)
            petz_compat_flag = true,
            class_type = "elephant",
            -- (Was .type = "elephant" for all variants)
            mob_type = mob_type,
            generic_type = "elephant_generic",

            description = description,
            sci_name = sci_name,

            -- Common properties
            initial_properties = {
--              backface_culling = false,
                collide_with_objects = true,
                collisionbox = cbox,
                makes_footstep_sound = true,
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
                run = {range = {x = 13, y = 25}, speed = 20, loop = true},
                stand = {
                    {range = {x = 26, y = 46}, speed = 5, loop = true},
                    {range = {x = 47, y = 59}, speed = 5, loop = true},
                    {range = {x = 81, y = 101}, speed = 5, loop = true},
                    {range = {x = 101, y = 121}, speed = 5, loop = true},
                },
                walk = {range = {x = 1, y = 12}, speed = 20, loop = true},
            },
--          armour_groups = nil,
            attack_table = {range = 0.5, damage_groups = {fleshy = 3}},
            bounciness = 0,
            brain_func = brain_func,
            buoyancy = 0.5,
            jump_height = 1.5,
            lung_capacity = 10,
            max_hp = 40,
            max_speed = 2.0,
--          physics_func = nil,
            sounds = {
                misc = "unilib_mob_elephant_normal_trumpeting",
                moaning = "unilib_mob_elephant_normal_moaning",
            },
--          timeout = nil,
            view_range = 10,

            -- Petz non-dynamic properties
--          avoid_players_flag = false,
            baby_type_list = {"elephant_normal_female", "elephant_normal_male"},
--          can_alight_flag = false,
            can_breed_flag = true,
--          can_climb_trees_flag = false,
--          can_clutch_flag = false,
--          can_fly_flag = false,
            -- N.B. In original code, .can_groom_flag = true
            can_groom_flag = false,
--          can_herd_flag = false,
--          can_jump_flag = false,
--          can_perch_flag = false,
--          can_pluck_flag = false,
--          can_swim_flag = false,
            capture_type = "lasso",
            default_rotation = unimobs.petz_const.rotate,
--          die_in_daylight_flag = false,
            drop_list = {
                {name = "unilib:organ_tusk_elephant", chance = 1, min = 2, max = 2},
                {name = "unilib:item_bone_animal", chance = 3, min = 1, max = 2},
            },
--          dung_name = nil,
--          egg_name = nil,
            -- N.B. In original code, .has_tamagotchi_mode_flag = true
            has_tamagotchi_mode_flag = false,
--          head_prop_table = nil,
            hostile_to_players_flag = true,
--          igniter_immunity_flag = false,
--          is_baby_flag = nil,
--          is_boss_flag = false,
            is_male_flag = variant_table[variant]["is_male_flag"],
--          is_mammal_flag = false,
--          is_milkable_flag = false,
--          is_monster_flag = false,
--          is_mountable_flag = false,
            is_pet_flag = true,
            is_wild_flag = is_wild_flag,
--          jump_chance = nil,
--          jump_impulse = nil,
--          max_roam_height = nil,
--          nest_empty_name = nil,
--          nest_full_name = nil,
            -- N.B. In original code, .obeys_orders_flag = true
            obeys_orders_flag = false,
--          parent_type_list = nil,
--          sleep_in_day_flag = false,
--          sleep_in_night_flag = false,
--          sleep_ratio = nil,
--          spawn_max_light = nil,
            -- N.B. No light restrictions in original code
            spawn_min_light = 12,
            spawn_max_height = unimobs.petz_api.get_custom_msetting(mob_type, "spawn_max_height"),
            spawn_min_height = unimobs.petz_api.get_custom_msetting(mob_type, "spawn_min_height"),
            straggle_type_list = {"elephant_normal_female", "elephant_normal_male"},

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
            -- N.B. In original code, elephants only replace dry grass. That's still the case in a
            --      world using minetest_game dirt-with-turf nodes, but in a world with unilib
            --      nodes, all dirt-with-turf nodes can be replaced
            replace_data_list = {
                {
                    "group:grass",
                    "air",
                    (-1 + variant_table[variant]["extra_offset"]),
                },
--              {
--                  "unilib:dirt_ordinary_with_turf_dry",
--                  "unilib:dirt_ordinary",
--                  (-2 + variant_table[variant]["extra_offset"]),
--              },
                {
                    "default:dirt_with_dry_grass",
                    "default:dirt",
                    (-2 + variant_table[variant]["extra_offset"]),
                },
            },
            -- N.B. .replace_rate = 10 in original code
            replace_rate = 40,
            replace_turf_flag = true,
            replace_turf_offset = (-2 + variant_table[variant]["extra_offset"]),

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
                -- From petz:elephant_set, petz:elephant_female_set. Creates
                --      unilib:spawnegg_elephant_normal_male, unilib:spawnegg_elephant_normal_female
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

    end

end

function unilib.pkg.mob_elephant_normal.post()

    -- Refine .replace_data_list to remove non-existent nodes
    for _, variant in ipairs({"male", "female"}) do
        unimobs.kitz_api.refine_replace_data("unilib:mob_elephant_normal_" .. variant)
    end

end
