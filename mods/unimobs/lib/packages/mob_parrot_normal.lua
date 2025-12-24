---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mob_parrot_normal = {}

local S = unimobs.intllib
local T = unimobs.strip_tags
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local ceil = math.ceil

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_pluck_callback(self, clicker, wielded_item, wielded_name, is_owner_flag)

    -- Adapted from petz.pluck()
    -- Plucks a feather from the parrot
    -- Does not change the parrot's appearance, but plucked parrots cannot fly

    if self.mob_type ~= "parrot_normal" or
            not self.can_pluck_flag or
            self.is_plucked_flag or
            not is_owner_flag then

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

    unilib.pkg.shared_petz_feathers.pluck(self, clicker, "unilib:organ_feather_parrot")

    -- Do not apply the standard behaviour
    return true

end

local function on_unpluck_callback(self, clicker, wielded_item, wielded_name, is_owner_flag)

    -- Adapted from petz.feather()
    -- Restores a feather to a plucked parrot

    if self.mob_type ~= "parrot_normal" or
            not self.can_pluck_flag or
            not self.is_plucked_flag or
            not is_owner_flag then

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

    unilib.pkg.shared_petz_feathers.unpluck(self, clicker, "unilib:organ_feather_parrot")

    -- Do not apply the standard behaviour
    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mob_parrot_normal.init()

    return {
        description = "Normal parrot",
        notes = "Use shears on a parrot to obtain a feather, which also prevents the parrot" ..
                " from flying",
        depends = {"brain_flying", "food_parrot", "organ_feather_toucan", "shared_petz_feathers"},
    }

end

function unilib.pkg.mob_parrot_normal.exec()

    -- Setup
--  local mesh = "unilib_mob_parrot_normal.b3d"

    local skin_init_list = {
        -- Normal skins
        {"blue_yellow", S("Blue and Yellow"), 1},
        {"scarlet", S("Scarlet"), 1},
        {"military", S("Military"), 0.5},
        {"grey", S("Grey"), 0.1},
        {"hyacinth", S("Hyacinth"), 0.1},
    }
    local genetic_init_list = {
        -- Standard genes
        {"agility", S("Agility"), "range", 1, 3, 0, 12},
        {"digestion", S("Digestion"), "range", 1, 3, 0, 12},
        {"fertility", S("Fertility"), "range", 1, 3, 0, 12},
        {"loftiness", S("Loftiness"), "range", 1, 3, 0, 12},
        {"perception", S("Perception"), "range", 1, 3, 0, 12},
    }

    local brain_func = unilib.pkg.brain_flying.brain
    local description = unilib.utils.brackets(S("Parrot"), S("Normal"))
    local insertion_table = {
        subject = T(S("parrot#subject")),
        subject_an = T(S("a parrot#subject")),
        subject_the = T(S("the parrot#subject")),
        object = T(S("parrot#object")),
        object_an = T(S("a parrot#object")),
        object_the = T(S("the parrot#object")),
    }
    local is_wild_flag = false
    local sci_name = "Amazona spp."
    local version = 1

    -- Register the entity and its spawnegg
    unimobs.petz_api.register_standard_mob({
        -- From petz:parrot
        mob_type = "parrot_normal",
        orig_spawnegg_name = "petz:parrot_set",

        replace_mode = mode,
        insertion_table = insertion_table,
        version = version,

        def_table = {
            -- Base properties
            petz_compat_flag = true,
            class_type = "parrot",
            -- (Was .type = "parrot")
            mob_type = "parrot_normal",
            generic_type = "parrot_normal",

            description = description,
            sci_name = sci_name,

            -- Common properties
            backface_culling = false,
--          collide_with_objects = true,
            collisionbox = {
                p1 = {x = -0.125, y = -0.5, z = -0.125},
                p2 = {x = 0.0625, y = 0.125, z = 0.1875},
            },
--          makes_footstep_sound = false,
--          mesh = nil,
--          physical = true,
--          selectionbox = nil,
--          static_save = true,
--          stepheight = 0.1,
--          textures = nil,
--          visual = nil,
--          visual_size = nil,

            -- Mobkit API properties
            animation_table = {
                fly = {range = {x = 92, y = 98}, speed = 25, loop = true},
                run = {range =  {x = 13, y = 25}, speed = 25, loop = true},
                stand = {
                    {range = {x = 26, y = 46}, speed = 5, loop = true},
                    {range = {x = 47, y = 59}, speed = 5, loop = true},
                    {range = {x = 60, y = 70}, speed = 5, loop = true},
                    {range = {x = 71, y = 91}, speed = 5, loop = true},
                },
                stand_fly = {range = {x = 92, y = 98}, speed = 25, loop = true},
                walk = {range = {x = 1, y = 12}, speed = 25, loop = true},
            },
--          armour_groups = nil,
--          attack_table = {range = 0.5, damage_groups = {fleshy = 3}},
--          bounciness = 0,
            brain_func = brain_func,
--          buoyancy = 0.5,
            jump_height = 2.0,
--          lung_capacity = 10,
            max_hp = 8,
            max_speed = 2.5,
--          physics_func = nil,
            sounds = {
                misc = "unilib_mob_parrot_normal_chirp",
                moaning = "unilib_mob_parrot_normal_moaning",
            },
--          timeout = nil,
            view_range = 12,

            -- Petz non-dynamic properties
--          avoid_players_flag = false,
--          baby_type_list = nil,
            can_alight_flag = false,
            -- N.B. In original code, .can_breed_flag = false
            can_breed_flag = true,
--          can_climb_trees_flag = false,
--          can_clutch_flag = false,
            can_fly_flag = true,
            can_groom_flag = true,
--          can_herd_flag = false,
--          can_jump_flag = false,
            can_perch_flag = true,
            -- N.B. In the original code, .can_pluck_flag = false
            can_pluck_flag = true,
--          can_swim_flag = false,
            capture_type = "animal_net",
--          default_rotation = unimobs.petz_const.rotate,
--          die_in_daylight_flag = false,
            drop_list = {
                {name = "unilib:food_parrot_raw", chance = 3, min = 1, max = 1},
            },
--          dung_name = nil,
--          egg_name = nil,
            -- N.B. In the original code, has_tamagotchi_mode_flag = false
            has_tamagotchi_mode_flag = true,
--          head_prop_table = nil,
--          hostile_to_players_flag = false,
--          igniter_immunity_flag = false,
--          is_baby_flag = nil,
--          is_boss_flag = false,
--          is_male_flag = nil,
--          is_mammal_flag = false,
--          is_milkable_flag = false,
--          is_monster_flag = false,
--          is_mountable_flag = false,
            is_pet_flag = true,
            is_wild_flag = is_wild_flag,
--          jump_chance = nil,
--          jump_impulse = nil,
            max_roam_height = 5,
--          nest_empty_name = nil,
--          nest_full_name = nil,
            obeys_orders_flag = true,
--          parent_type_list = nil,
--          sleep_in_day_flag = false,
--          sleep_in_night_flag = false,
--          sleep_ratio = nil,
--          spawn_max_light = nil,
            -- N.B. No light restrictions in original code
            spawn_min_light = 10,
            spawn_max_height =
                    unimobs.petz_api.get_custom_msetting("parrot_normal", "spawn_max_height"),
            spawn_min_height =
                    unimobs.petz_api.get_custom_msetting("parrot_normal", "spawn_min_height"),
--          straggle_type_list = nil,

            -- Petz mob-specific properties
            -- Offsets used when perched on a player's shoulder
            perch_left_offset = {x = 0.5, y = -6.25, z = 0},
            perch_right_offset = {x = -0.5, y = -6.25, z = 0},
            -- Offsets used when perched on a bird stand
            perch_forward_offset = {x = 0, y = 1, z = -0.125},
            perch_reverse_offset = {x = 0, y = 0, z = 0.125},

            -- unimobs.petz_api.register_standard_mob() properties
            baby_scale_factor = 0.5,
            genetic_init_list = genetic_init_list,
            scale_factor = 1.0,
            skin_init_list = skin_init_list,

            -- Required callbacks (replace the standard versions)

            on_activate = function(self, staticdata, dtime_s)

                unimobs.mobkit_api.on_activate_callback(self, staticdata, dtime_s)
                unimobs.petz_api.set_mob_initial_properties(self, staticdata, dtime_s)

                -- N.B. When the bird is perched on a player's shoulder, and the game restarts, it
                --      is automatically detached and re-appears around the player's feet, partially
                --      under the surface
                -- We can correct for that, at the cost of allowing a bird which was placed on the
                --      ground by the player, and given the order to stay, to be allowed to fly away
                --      (this is not unrealistic; the player should have used a bird stand!)
                if self.status == "stand" then

                    local bird_pos = self.object:get_pos()
                    local under_pos = {x = bird_pos.x, y = bird_pos.y - 1, z = bird_pos.z}
                    local under_node = core.get_node(under_pos)

                    -- A bird perched on a bird stand is not actually attached to it, so there's no
                    --      need to act in that case
                    if under_node and under_node.name ~= "unilib:misc_stand_bird" then

                        -- Move the bird to the surface
                        self.object:set_pos({x = bird_pos.x, y = ceil(bird_pos.y), z = bird_pos.z})
                        -- Allow it to fly away
                        self.status = unimobs.mobkit_api.add_mob_memory(self, "status", nil)

                    end

                end

            end,
        },
    })

    -- Override the standard behaviour when a mob is right-clicked while wielding these items
    for _, shears_name in ipairs(unimobs.petz_setting.shears_list) do
        unimobs.petz_api.register_rightclick_override(shears_name, on_pluck_callback)
    end

    unimobs.petz_api.register_rightclick_override(
        "unilib:organ_feather_parrot", on_unpluck_callback
    )

end
