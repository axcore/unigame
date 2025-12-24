---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_moth_normal = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local random = math.random

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function lay_eggs(self)

    -- From petz.init_lay_eggs()
    -- Called periodically by the moths's .on_activate() callback, and then by this function
    --      recursively, to lay eggs

    local min_time = unimobs.petz_api.get_custom_msetting("moth_normal", "lay_egg_min_time")
    local max_time = unimobs.petz_api.get_custom_msetting("moth_normal", "lay_egg_max_time")

    core.after(random(min_time, max_time), function()

        if not unimobs.mobkit_api.is_object_alive(self) or self.egg_count > 0 then
            return
        end

        unilib.pkg.mtb_fly_alight.do_action(self, 0, "stand")

        core.after(10.0, function()

            if not unimobs.mobkit_api.is_object_alive(self) then
                return
            end

            local pos = self.object:get_pos()
            if core.get_node(pos) and core.get_node(pos).name ~= "air" then
                return
            end

            local spawnegg_flag = false
            local below_node = unimobs.petz_api.get_node_at_named_location(self, "below")
            if below_node then

                local lay_egg_on_node = unimobs.petz_api.get_custom_msetting(
                    "silkworm_normal", "lay_egg_on_node"
                )

                if string.sub(lay_egg_on_node, 1, 5) == "group" then

                    local node_group =
                            core.get_item_group(below_node.name, string.sub(lay_egg_on_node, 7))
                    if node_group > 0 then
                        spawnegg_flag = true
                    end

                else

                    if below_node.name == lay_egg_on_node then
                        spawnegg_flag = true
                    end

                end

            end

            if spawnegg_flag then

                core.set_node(pos, {name = "unilib:egg_silkworm_normal"})
                self.egg_count =
                        unimobs.mobkit_api.add_mob_memory(self, "egg_count", self.egg_count + 1)

            else

                -- If laying eggs fails, call this function recursively in order to try again
                --      later
                lay_eggs(self)

            end

            unilib.pkg.mtb_order_autonomy.do_action(self)

        end, self)

    end, self)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_moth_normal.init()

    return {
        description = "Normal moth",
        depends = {
            "brain_flying",
            "egg_silkworm_normal",
            "mtb_fly_alight",
            "mtb_order_autonomy",
            "vessel_bottle_glass_with_moth",
        },
    }

end

function unilib.pkg.mob_moth_normal.exec()

    -- Setup
    local p1 = {x = -0.25, y = -0.5, z = -0.4375}
    local p2 = {x = 0.3125, y = -0.1875, z = 0.1875}
    local scale_factor = 1.0

    local cbox = unimobs.petz_api.get_standard_collisionbox(p1, p2, scale_factor, nil)
    local visual_size = unimobs.petz_api.get_standard_visual_size(scale_factor)

    local mesh = "unilib_mob_moth_normal.b3d"

    local skin_init_list = {
        -- Normal skins
        {"yellow", S("Yellow"), 1},
        {"orange", S("Orange"), 0.5},
        {"red", S("Red"), 0.5},
        {"green", S("Green"), 0.1},
    }
    -- N.B. No genetic traits because of non-standard breeding system
    local genetic_init_list = {}

    local brain_func = unilib.pkg.brain_flying.brain
    local description = unilib.utils.brackets(S("Moth"), S("Normal"))
    local insertion_table = {
        subject = T(S("moth#subject")),
        subject_an = T(S("a moth#subject")),
        subject_the = T(S("the moth#subject")),
        object = T(S("moth#object")),
        object_an = T(S("a moth#object")),
        object_the = T(S("the moth#object")),
    }
    local is_wild_flag = false
    local sci_name = "Bombyx mori"
    local version = 1

    -- Initialise the .custom_table field of unimobs.petz_msetting, if the remix CSV has not
    --      already initialised it
    unimobs.petz_api.initialise_custom_msetting("moth_normal", "lay_egg_max_time", 240)
    unimobs.petz_api.initialise_custom_msetting("moth_normal", "lay_egg_min_time", 150)

    -- Register the entity
    unilib.register_entity("unilib:mob_moth_normal", {
        -- From petz:moth

        -- Base properties (original to unimobs)
        petz_compat_flag = true,
        class_type = "moth",
        -- (Was .type = "moth")
        mob_type = "moth_normal",
        generic_type = "moth_normal",

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
            textures = unimobs.petz_api.compile_texture_list("moth_normal", skin_init_list),
            visual = unimobs.petz_const.visual,
            visual_size = visual_size,
        },

        -- Mobkit API properties
        animation_table = {
            fly = {range = {x = 92, y = 98}, speed = 25, loop = true},
            run = {range = {x = 13, y = 25}, speed = 25, loop = true},
            stand = {
                {range = {x = 26, y = 46}, speed = 5, loop = true},
                {range = {x = 47, y = 59}, speed = 5, loop = true},
                {range = {x = 60, y = 70}, speed = 5, loop = true},
                {range = {x = 71, y = 91}, speed = 5, loop = true},
            },
            stand_fly = {range = {x = 92, y = 98}, speed = 25, loop = true},
            walk = {range = {x = 1, y = 12}, speed = 25, loop = true},
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
        sounds = {
            misc = "unilib_mob_moth_normal_chirp",
            moaning = "unilib_mob_moth_normal_moaning",
        },
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
        -- N.B. In the original code, die_in_daylight_flag = false (even though the original README
        --      claimed that moths died in direct sunlight)
        die_in_daylight_flag = true,
--      drop_list = nil,
--      dung_name = nil,
        -- N.B. Silkworm eggs, laid by moths, are handled in the lay_eggs() function above, so there
        --      is no need to set .egg_name
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
        max_roam_height = 3,
--      nest_empty_name = nil,
--      nest_full_name = nil,
        obeys_orders_flag = false,
--      parent_type_list = nil,
--      sleep_in_day_flag = false,
--      sleep_in_night_flag = false,
--      sleep_ratio = nil,
        -- N.B. No light restrictions in original code
        spawn_max_light = 4,
--      spawn_min_light = nil,
        spawn_max_height = unimobs.petz_api.get_custom_msetting("moth_normal", "spawn_max_height"),
        spawn_min_height = unimobs.petz_api.get_custom_msetting("moth_normal", "spawn_min_height"),
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

        -- Petz mob-specific properties (shared with butterflies)
        bottled_name = "unilib:vessel_bottle_glass_with_moth",

        -- Required callbacks

        get_staticdata = unimobs.mobkit_api.get_staticdata_callback,

        on_activate = function(self, staticdata, dtime_s)

            unimobs.mobkit_api.on_activate_callback(self, staticdata, dtime_s)
            unimobs.petz_api.set_mob_initial_properties(self, staticdata, dtime_s)
            lay_eggs(self)

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
        mob_type = "moth_normal",
        mob_name = "unilib:mob_moth_normal",
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
            -- From petz:moth_set. Creates unilib:spawnegg_moth_normal
            mob_type = "moth_normal",
            orig_name = "petz:moth_set",

            replace_mode = mode,
            description = description,
            img = "unilib_spawnegg_moth_normal.png",
            mob_name = "unilib:mob_moth_normal",
            sci_name = sci_name,
            tamed_flag = not is_wild_flag,
        })

    end

end
