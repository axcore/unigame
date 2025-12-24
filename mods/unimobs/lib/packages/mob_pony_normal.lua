---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_pony_normal = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local sqrt = math.sqrt

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_death_callback(self)

    -- Adapted from petz.on_die()
    -- On death, dismount from the pony and drop items

    if self.mob_type ~= "pony_normal" then
        return {}
    end

    -- Drop saddle
    unimobs.petz_api.remove_equipment_from_mountable_mob(self)

    -- Drop horseshoes
    if self.horseshoe_count and
            self.horseshoe_count > 0 and
            unilib.global.pkg_executed_table["item_horseshoe_normal"] ~= nil then

        unimobs.kitz_api.make_mob_drop_single_item(
            self, ItemStack("unilib:item_horseshoe_normal " .. tostring(self.horseshoe_count))
        )

    end

    -- If mounted, force a dismount
    if self.driver then
        unimobs.petz_api.force_dismount_player_from_mob(self.driver)
    end

    -- If attached to a wagon, detach it
    if self.wagon then
        self.wagon:set_detach()
    end

end

local function on_formspec_click_callback(self)

    -- Adapted from code in petz/petz/api/api_forms.lua
    -- When the main mob formspec's extension button is clicked, drop the mob's horseshoes

    if self.mob_type ~= "pony_normal" then
        return
    end

    unimobs.petz_api.remove_horseshoes_from_mob(self)

end

local function on_formspec_draw_callback(self)

    -- Adapted from code in petz/petz/api/api_forms.lua
    -- Return a table of data used to draw the extension button, whenever the main mob's formspec
    --      is drawn

    if self.mob_type ~= "pony_normal" then
        return {}
    end

    if not self.horseshoe_count or self.horseshoe_count == 0 then

        return {
            reopen_flag = true,
            img = "unilib_item_horseshoe_normal.png",
            text = 0,
            tooltip = S("No horseshoes"),
        }

    else

        return {
            reopen_flag = true,
            img = "unilib_item_horseshoe_normal.png",
            text = tostring(self.horseshoe_count),
            tooltip = S("Drop horseshoes"),
        }

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_pony_normal.init()

    return {
        description = "Normal pony",
        depends = {"brain_herbivore", "item_bone_animal"},
        optional = "item_horseshoe_normal",
    }

end

function unilib.pkg.mob_pony_normal.exec()

    -- Setup
    local p1 = {x = -0.125, y = -0.5, z = -0.25}
    local p2 = {x = 0.0625, y = 0.125, z = 0.25}
    local scale_factor = 3.3
    local baby_scale_factor = 0.5

    local cbox, cbox_baby =
            unimobs.petz_api.get_standard_collisionbox(p1, p2, scale_factor, baby_scale_factor)
    local visual_size = unimobs.petz_api.get_standard_visual_size(scale_factor)

    local mesh = "unilib_mob_pony_normal.b3d"

    local skin_init_list = {
        -- Normal skins
        {"brown", S("Brown"), 1},
        {"white", S("White"), 1},
        {"yellow", S("Yellow"), 1},
        {"blackcurrant", S("Blackcurrant"), 0.5},
        {"grey_dotted", S("Dotted Grey"), 0.5},
        {"white_dotted", S("Dotted White"), 0.5},
        {"brown_light", S("Light Brown"), 0.25},
        {"cimarron", S("Cimarron"), 0.25},
        {"grey_light", S("Light Grey"), 0.25},
        {"black", S("Black Beauty"), 0.1},
        {"brown_dark", S("Dark Brown"), 0.1},
        {"grey_dark", S("Dark Grey"), 0.1},
        {"mahogany", S("Mahogany"), 0.1},
        {"cream", S("Cream"), 0.05},
        {"mustard", S("Mustard"), 0.05},
        {"orange", S("Orange"), 0.05},
        -- Rare mutations
        {"bluebell", S("Bluebell"), 0},
        {"lavender", S("Lavender"), 0},
        {"rainbow", S("Rainbow"), 0},
        {"strawberry", S("Strawberry"), 0},
    }
    local genetic_init_list = {
        -- Standard genes
        {"digestion", S("Digestion"), "range", 1, 3, 0, 12},
        {"docility", S("Docility"), "range", 1, 3, 0, 12},
        {"fertility", S("Fertility"), "range", 1, 3, 0, 12},
        {"luckiness", S("Luckiness"), "range", 1, 3, 0, 12},
        -- Standard genes (genetic mutations)
        -- N.B. Higher than normal variability, because of the large number of pony skins
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
    local description = unilib.utils.brackets(S("Pony"), S("Normal"))
    local insertion_table = {
        subject = T(S("pony#subject")),
        subject_an = T(S("a pony#subject")),
        subject_the = T(S("the pony#subject")),
        object = T(S("pony#object")),
        object_an = T(S("a pony#object")),
        object_the = T(S("the pony#object")),
    }
    local is_wild_flag = false
    local sci_name = "Equus ferus caballus"
    local version = 1

    -- Register the entity
    unilib.register_entity("unilib:mob_pony_normal", {
        -- From petz:pony

        -- Base properties (original to unimobs)
        petz_compat_flag = true,
        class_type = "pony",
        -- (Was .type = "pony")
        mob_type = "pony_normal",
        generic_type = "pony_normal",

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
            textures = unimobs.petz_api.compile_texture_list("pony_normal", skin_init_list),
            visual = unimobs.petz_const.visual,
            visual_size = visual_size,
        },

        -- Mobkit API properties
        animation_table = {
            run = {range = {x = 13, y = 25}, speed = 25, loop = true},
            still = {range = {x = 1, y = 1}, speed = 0, loop = true},
            stand = {
                {range = {x = 26, y = 46}, speed = 5, loop = true},
                {range = {x = 47, y = 59}, speed = 5, loop = true},
                {range = {x = 82, y = 94}, speed = 5, loop = true},
                {range = {x = 100, y = 112}, speed = 5, loop = false},
                {range = {x = 112, y = 118}, speed = 5, loop = false},
                {range = {x = 118, y = 124}, speed = 5, loop = false},
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
            misc = {
                "unilib_mob_pony_normal_blow_lips",
                "unilib_mob_pony_normal_neigh",
                "unilib_mob_pony_normal_snort",
                "unilib_mob_pony_normal_whinny",
            },
            moaning = "unilib_mob_pony_normal_moaning",
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
            {name = "unilib:item_bone_animal", chance = 6, min = 1, max = 1},
        },
--      dung_name = nil,
--      egg_name = nil,
        has_tamagotchi_mode_flag = true,
        head_prop_table = {
            -- N.B. .clamp_list not in original code
            clamp_list = {
                -- Look up (-60) / straight ahead (-90) / down (-120)
                {dim = "x", min = -60, max = 360, correction = -60},
                {dim = "x", min = -360, max = -120, correction = -120},
                -- Look left (0) / straight ahead (90) / right (180)
                {dim = "y", min = 180, max = 270, correction = 180},
                {dim = "y", min = 270, max = 360, correction = 0},
                -- Look left (0) / straight ahead (-90) / right (-180)
                {dim = "y", min = -180, max = -90, correction = -180},
                {dim = "y", min = -90, max = 0, correction = 0},
            },
            position = vector.new(-0.3878, 0.7757, 0),
            -- (In degrees, normally values are -90, 0, 90)
            rotation_origin = vector.new(-90, 90, 0),
        },
--      hostile_to_players_flag = false,
--      igniter_immunity_flag = false,
--      is_baby_flag = nil,
--      is_boss_flag = false,
--      is_male_flag = nil,
--      is_mammal_flag = false,
--      is_milkable_flag = false,
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
        spawn_max_height = unimobs.petz_api.get_custom_msetting("pony_normal", "spawn_max_height"),
        spawn_min_height = unimobs.petz_api.get_custom_msetting("pony_normal", "spawn_min_height"),
        straggle_type_list = {"pony_normal"},

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
        driver_wagon_attach_at = {x = -0.0325, y = -0.125, z = -0.625},
        driver_wagon_eye_offset = {x = 0, y = 0, z = -20},
        eat_hay_flag = true,
        -- N.B. Removed properties that were not used in the original petz code
--      skin_color_mutation = {"vanilla"},
--      terrain_type = 3,
        -- Petz mob-specific properties (shared with camels)
        baby_scale_factor = baby_scale_factor,
        driver_attach_at = {x = -0.0325, y = -0.125, z = -0.2},
        -- N.B. Originally x = 0, y = 0, z = 0. Tweaked so that a mounted player can see where
        --      they're going, and because the mounted position isn't quite centred. If the model is
        --      ever changed, the original values could be restored
        driver_eye_offset = {x = -1, y = 3, z = 0},
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

            -- N.B. When the pony is attached to a wagon, but not mounted by a player, then the
            --      wagon's wheels are not animated without these lines (which were absent in the
            --      original code)
            if self.wagon and not self.driver then

                local vel = self.object:get_velocity()
                if sqrt((vel.x ^ 2) + (vel.y ^ 2) + (vel.z ^ 2)) == 0 then
                    unimobs.petz_api.do_wagon_animation(self, "stand")
                else
                    unimobs.petz_api.do_wagon_animation(self, "roll")
                end

            end

        end,

        -- Petz callbacks

        on_deactivate = function(self)
            unimobs.petz_api.on_deactivate_callback(self)
        end,

        on_detach_child = function(self, child)

            -- (Callback unique to ponies)
            if self.wagon and not child:is_player() then

                -- N.B. The original code no longer works, because .visual_size (having been moved
                --      to .initial_properties) is not accessible in this way any more. Luckily the
                --      correct .visual_size values are still available here as a local variable
                --[[
                local child_luaent = child:get_luaentity()
                self.wagon:set_properties({
                    visual_size = child_luaent.visual_size
                })
                ]]--
                self.wagon:set_properties({
                    visual_size = visual_size,
                })

                -- Retain the wagon's rotation
                -- (N.B. This line was commented out in the original code, for unknown reasons)
                self.wagon:set_rotation(self.object:get_rotation())

                self.wagon = nil

            end

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
        mob_type = "pony_normal",
        mob_name = "unilib:mob_pony_normal",
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
            -- From petz:pony_set. Creates unilib:spawnegg_pony_normal
            mob_type = "pony_normal",
            orig_name = "petz:pony_set",

            replace_mode = mode,
            description = description,
            img = "unilib_spawnegg_pony_normal.png",
            mob_name = "unilib:mob_pony_normal",
            sci_name = sci_name,
            tamed_flag = not is_wild_flag,
        })

    end

    -- Extend the standard behaviour when this mob dies
    unimobs.petz_api.register_death_extension("pony_normal", on_death_callback)
    -- Extend the standard behaviour of the main formspec
    if unilib.global.pkg_executed_table["item_horseshoe_normal"] ~= nil then

        unimobs.petz_api.register_formspec_extension("pony_normal", {
            order_flag = false,
            click_func = on_formspec_click_callback,
            draw_func = on_formspec_draw_callback,
        })

    end

end
