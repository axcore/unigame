---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_sheep_normal = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local random = math.random

-- Simplified version of the standard "skin_init_list", containing only the first item in each
--      mini-list (populated below)
local skin_simple_list = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_compose_skin_callback(self)

    -- From petz.compose_texture()

    if self.mob_type ~= "sheep_normal" then
        return
    end

    if self.has_been_sheared_flag then

        return "unilib_mob_" .. self.mob_type .. "_" .. skin_simple_list[self.mob_texture_num] ..
                sheared_str .. "_sheared.png"

    elseif self.modified_colour then

        -- N.B. Fix error in original code, in which a dyed sheep lost its colour, upon being
        --      punched
        return unimobs.petz_api.get_mob_colourisation(self)

    else

        return "unilib_mob_" .. self.mob_type .. "_" .. skin_simple_list[self.mob_texture_num] ..
                ".png"

    end

end

local function on_replenish_mob_callback(self, clicker)

    -- From petz.lamb_wool_regrow()
    -- "clicker" is an optional argument, specified only when a player is the cause of the event
    --      (e.g. by feeding a sheep)

    -- Only regrow wool if the sheep has been sheared
    if self.mob_type ~= "sheep_normal" or not self.has_been_sheared_flag then
        return
    end

    -- The sheep regrows its wool when it replaces (by default) 5 grass nodes
    self.replace_countdown = unimobs.mobkit_api.add_mob_memory(
        self, "replace_countdown", self.replace_countdown - 1
    )

    -- N.B. In creative mode, the mob would die before the countdown reaches 0, so require just one
    --      action from a player
    if self.replace_countdown <= 0 or
            (clicker and unilib.utils.is_creative(clicker:get_player_name())) then

        -- Enough nodes have been replaced; reset the countdown, ready for the next shearing
        unimobs.petz_api.update_replace_countdown_from_genetics(self)

        -- Update mob properties (the sheep is now ready to be sheared again)
        self.has_been_sheared_flag =
                unimobs.mobkit_api.add_mob_memory(self, "has_been_sheared_flag", false)

        local sheep_texture = "unilib_mob_" .. self.mob_type .. "_" ..
                skin_simple_list[self.mob_texture_num] .. ".png"
        unimobs.petz_api.set_mob_properties(self, {textures = {sheep_texture}})

        -- Show particles because why not
        unimobs.petz_api.show_standard_particles(
            self.object:get_pos(), "hungry", "unilib_wool_white.png"
        )

    end

end

local function on_rightclick_mob_callback(self, clicker, wielded_item, wielded_name, is_owner_flag)

    -- Adapted from petz.lamb_wool_shave()
    -- Shear the sheep, to produce wool

    if self.mob_type ~= "sheep_normal" or
            not is_owner_flag or
            self.has_been_sheared_flag or
            not clicker:get_inventory() then

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

    local inv = clicker:get_inventory()

    local colour
    if not self.modified_colour then
        colour = skin_simple_list[self.mob_texture_num]
    else
        colour = self.modified_colour
    end

    local multiple = 1
    -- For maximum woolliness, there's a 25% chance of 3 wools; otherwise, for all values of
    --      woolliness, there's a 50% chance of 2 wools
    local current_val, min_val, max_val = unimobs.petz_api.get_genetic_range(self, "woolliness")
    if current_val >= max_val and random() < 0.25 then

        multiple = 3

    else

        local ratio = (current_val - min_val) / (max_val - min_val)
        if random() < (ratio * 0.50) then
            multiple = 2
        end

    end

    -- (N.B. The code below has already checked that the "wool_basic" package has been loaded)
    local new_stack = "unilib:wool_" .. colour .. " " .. multiple
    if inv:room_for_item("main", new_stack) then
        inv:add_item("main", new_stack)
    else
        core.add_item(self.object:get_pos(), new_stack)
    end

    unimobs.kitz_api.make_sound(
        "object",
        self.object,
        "unilib_mob_sheep_normal_moaning",
        unimobs.petz_setting.max_hear_distance
    )

    local sheep_texture = "unilib_mob_" .. self.mob_type .. "_" ..
            skin_simple_list[self.mob_texture_num] .. "_sheared.png"
    if not self.modified_colour then
        unimobs.petz_api.set_mob_properties(self, {textures = {sheep_texture}})
    else
        unimobs.petz_api.revert_mob_colourisation(self, sheep_texture)
    end

    self.has_been_sheared_flag =
            unimobs.mobkit_api.add_mob_memory(self, "has_been_sheared_flag", true)
    unimobs.petz_api.update_replace_countdown_from_genetics(self)

    if unimobs.setting.apply_tool_wear_flag and not unilib.utils.is_creative(pname) then

        wielded_item:add_wear(unimobs.constant.tool_wear)
        clicker:set_wielded_item(wielded_item)

    end

    if unilib.global.pkg_executed_table["mtb_show_fear"] ~= nil then
        unilib.pkg.mtb_show_fear.do_action(self, clicker:get_pos())
    end

    unimobs.kitz_api.make_sound(
        "object", self.object, "unilib_pop_petz", unimobs.petz_setting.max_hear_distance
    )

    -- Do not apply the standard behaviour
    return true

end

function unilib.pkg.mob_sheep_normal.post()

    -- Refine .replace_data_list to remove non-existent nodes
    unimobs.kitz_api.refine_replace_data("unilib:mob_sheep_normal")

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_sheep_normal.init()

    return {
        description = "Normal sheep",
        notes = "Right-click with a dye in order to colourise the sheep",
        depends = {"brain_herbivore", "food_lamb_chop", "item_bone_animal", "misc_dung_normal"},
        optional = "wool_basic",
    }

end

function unilib.pkg.mob_sheep_normal.exec()

    -- Setup
    local p1 = {x = -0.0625, y = -0.5, z = -0.125}
    local p2 = {x = 0.125, y = -0.125, z = 0.1875}
    local scale_factor = 2.5
    local baby_scale_factor = 0.5

    local cbox, cbox_baby =
            unimobs.petz_api.get_standard_collisionbox(p1, p2, scale_factor, baby_scale_factor)
    local visual_size = unimobs.petz_api.get_standard_visual_size(scale_factor)

    local mesh = "unilib_mob_sheep_normal.b3d"

    local skin_init_list = {
        -- Normal skins
        {"white", S("White"), 1},
        {"grey", S("Grey"), 0.5},
        {"grey_dark", S("Dark Grey"), 0.1},
        {"brown", S("Brown"), 0.05},
        -- Rare mutations
        {"strawberry", S("Strawberry"), 0},
        {"vanilla", S("Vanilla"), 0},
    }
    local genetic_init_list = {
        -- Standard genes
        {"digestion", S("Digestion"), "range", 1, 3, 0, 12},
        {"docility", S("Docility"), "range", 1, 3, 0, 12},
        {"fertility", S("Fertility"), "range", 1, 3, 0, 12},
        {"incontinence", S("Incontinence"), "range", 1, 3, 0, 12},
--      {"luckiness", S("Luckiness"), "range", 1, 3, 0, 12},
        -- Standard genes (genetic mutations)
        {"variability", S("Variability"), "range", 2, 4, 0, 12},
        -- Custom genes
        -- Woolliness: increases the chances of getting multiple wools, when shearing sheep
        {"woolliness", S("Woolliness"), "range", 1, 3, 0, 12},
    }

    local brain_func = unilib.pkg.brain_herbivore.brain
    local description = unilib.utils.brackets(S("Sheep"), S("Normal"))
    local insertion_table = {
        subject = T(S("sheep#subject")),
        subject_an = T(S("a sheep#subject")),
        subject_the = T(S("the sheep#subject")),
        object = T(S("sheep#object")),
        object_an = T(S("a sheep#object")),
        object_the = T(S("the sheep#object")),
    }
    local is_wild_flag = false
    local sci_name = "Ovis aries"
    local version = 1

    -- (The callbacks above are much simpler, if the following simplified list is available)
    for _, mini_list in ipairs(skin_init_list) do
        table.insert(skin_simple_list, mini_list[1])
    end

    -- Initialise the .custom_table field of unimobs.petz_msetting, if the remix CSV has not
    --      already initialised it
    unimobs.petz_api.initialise_custom_msetting("sheep_normal", "is_dyeable", true)

    -- Register the entity
    unilib.register_entity("unilib:mob_sheep_normal", {
        -- From petz:lamb

        -- Base properties (original to unimobs)
        petz_compat_flag = true,
        class_type = "sheep",
        -- (Was .type = "lamb")
        mob_type = "sheep_normal",
        generic_type = "sheep_normal",

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
            textures = unimobs.petz_api.compile_texture_list("sheep_normal", skin_init_list),
            visual = unimobs.petz_const.visual,
            visual_size = visual_size,
        },

        -- Mobkit API properties
        animation_table = {
            run = {range = {x = 13, y = 25}, speed = 25, loop = true},
            stand = {
                {range = {x = 26, y = 46}, speed = 5, loop = true},
                {range = {x = 47, y = 59}, speed = 5, loop = true},
                {range = {x = 82, y = 94}, speed = 5, loop = true},
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
        max_hp = 8,
        max_speed = 2.0,
--      physics_func = nil,
        sounds = {
            misc = "unilib_mob_sheep_normal_bleat",
            moaning = "unilib_mob_sheep_normal_moaning",
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
        can_herd_flag = true,
--      can_jump_flag = false,
--      can_perch_flag = false,
--      can_pluck_flag = false,
--      can_swim_flag = false,
        capture_type = "lasso",
        default_rotation = unimobs.petz_const.rotate,
--      die_in_daylight_flag = false,
        drop_list = {
            {name = "unilib:food_lamb_chop_raw", chance = 1, min = 1, max = 1},
            {name = "unilib:item_bone_animal", chance = 5, min = 1, max = 1},
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
            eye_offset = -0.3,
            position = vector.new(-0.1939, 0.2908, 0),
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
        spawn_max_height = unimobs.petz_api.get_custom_msetting("sheep_normal", "spawn_max_height"),
        spawn_min_height = unimobs.petz_api.get_custom_msetting("sheep_normal", "spawn_min_height"),
        straggle_type_list = {"sheep_normal"},

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
        replace_data_list = {
            {"group:grass", "air", -1},
--          {"unilib:dirt_ordinary_with_turf", "unilib:dirt_ordinary", -2},
            {"default:dirt_with_grass", "default:dirt", -2},
        },
        -- N.B. .replace_rate = 10 in original code
        replace_rate = 25,
        replace_turf_flag = true,
        replace_turf_offset = -2,

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

        on_replace = function(self, pos, oldnode, newnode)
            on_replenish_mob_callback(self)
        end,

        on_rightclick = function(self, clicker)
            unimobs.petz_api.on_rightclick_callback(self, clicker)
        end,
    })

    if unimobs.petz_api.register_mob({
        mob_type = "sheep_normal",
        mob_name = "unilib:mob_sheep_normal",
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
            -- From petz:lamb_set. Creates unilib:spawnegg_sheep_normal
            mob_type = "sheep_normal",
            orig_name = "petz:lamb_set",

            replace_mode = mode,
            description = description,
            img = "unilib_spawnegg_sheep_normal.png",
            mob_name = "unilib:mob_sheep_normal",
            sci_name = sci_name,
            tamed_flag = not is_wild_flag,
        })

    end

    -- Add non-standard dynamic properties

    -- (Was .shaved)
    -- True if the mob has been sheared; value is set back to false when the shearing is reversed
    --      (e.g. when a sheep's wool grows back)
    unimobs.petz_api.add_dynamic_property("has_been_sheared_flag", "bool", false)
    -- (Was .colorized)
    -- Set by unimobs.petz_api.colourise_mob() and unimobs.petz_api.revert_mob_colourisation() when
    --      a mob is colourised (for example, by using dye on a sheep); otherwise nil
    -- Usually, a unilib standard dye colour like "red" or "green_dark", matching the colour group
    --      of the object used to colour the mob (e.g. the dye)
    unimobs.petz_api.add_dynamic_property("modified_colour", "str", nil)

    -- Override the standard skin
    unimobs.petz_api.register_texture_override("sheep_normal", on_compose_skin_callback)

    -- Override the standard behaviour when a mob is right-clicked while wielding these items
    if unilib.global.pkg_executed_table["wool_basic"] ~= nil then

        for _, shears_name in ipairs(unimobs.petz_setting.shears_list) do
            unimobs.petz_api.register_rightclick_override(shears_name, on_rightclick_mob_callback)
        end

    end

    -- Extend the standard behaviour when this mob is to be replenished
    unimobs.petz_api.register_replenish_extension("sheep_normal", on_replenish_mob_callback)

end
