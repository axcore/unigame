---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_register.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Localise math functions (for speed)
local random = math.random

local entity_ratio = 0.133

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_register.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.register_mob(data_table)

    -- Original to unimobs
    -- Called by every mob_X package that wants to use the kitz/petz APIs (i.e. all petz-compatible
    --      mobs)
    -- Registers the mob in the global variables unimobs.petz_global.mob_list and
    --      unimobs.petz_global.mob_table (replacing the original petz.settings.petz_list)
    -- Calling code should not register a spawn egg (via a call to
    --       unimobs.petz_api.register_spawnegg() ) unless this function returns true
    --
    -- data_table compulsory fields:
    --      mob_type (str): Matches the entity's .mob_type, e.g. "lion_normal"
    --      mob_name (str): Matches the entity name, e.g. "unilib:mob_lion_normal"
    --      description (str): Matches the entity's description, e.g. "Lion (Normal)"
    --      insertion_table (table): Table providing substitutions for visible translated text, in
    --          the form:
    --
    --          (Used as the subject of a sentence)
    --          .subject = "dog#subject"
    --          .subject_an = "a dog#subject"
    --          .subject_the = "the dog#subject"
    --          (Used as the object of a sentence)
    --          .object = "dog#object"
    --          .object_an = "a dog#object"
    --          .object_the = "the dog#object"
    --
    -- data_table optional fields:
    --      collisionbox (table): Standard Minetest collisionbox table
    --      genetic_init_list (list): List of mini-lists, in the format described by
    --          petz_init_prop.lua
    --      mesh (str): Filename of the mesh, e.g. "unilib_mob_lion_normal.b3d"
    --      skin_init_list (list): List of mini-lists, in the format described by petz_init_prop.lua
    --      version (int): Code version for this mob. Code in petz_init_prop.lua checks the value so
    --          that, in case of any major changes to the mob, old mob entities can be updated. When
    --          first written, mobs should have a .version with the value 1; later changes should be
    --          numbered 2, 3 etc. If not specified, 1 is used
    --      visual_size (table): Standard Minetest visual_size table
    --
    -- Return values:
    --      true on success, false on failure (for example, if a mob matching "mob_type" already
    --          exists)

    local mob_type = data_table.mob_type
    local mob_name = data_table.mob_name
    local description = data_table.description
    local insertion_table = data_table.insertion_table

    local collisionbox = data_table.collisionbox or nil
    local genetic_init_list = data_table.genetic_init_list or {}
    local mesh = data_table.mesh or nil
    local skin_init_list = data_table.skin_init_list or {}
    local version = data_table.version or 1
    local visual_size = data_table.visual_size or nil

    -- Quick check for duplicates
    if unimobs.petz_global.mob_table[mob_type] ~= nil then

        unilib.utils.show_error(
            "unimobs.petz_api.register_mob(): duplicate mob type",
            mob_type
        )

        return false

    end

    -- For genes of the category "range", compile a lookup table for the minimum/maximum values
    local genetic_range_table = {}
    for _, mini_list in ipairs(genetic_init_list) do

        -- Each mini-list is in the form
        --  { gene_type, gene_name, "default", initial_value }
        --  { gene_type, gene_name, "list", list_of_initial_values }
        --  { gene_type, gene_name, "range", initial_min, initial_max, overall_min, overall_max }
        if mini_list[3] == "range" then

            genetic_range_table[mini_list[1]] = {
                initial_min = mini_list[4],
                initial_max = mini_list[5],
                overall_min = mini_list[6],
                overall_max = mini_list[7],
            }

        end

    end

    -- Update global variables
    table.insert(unimobs.petz_global.mob_list, mob_type)
    unimobs.petz_global.mob_table[mob_type] = {
        mob_name = mob_name,
        description = description,
        insertion_table = insertion_table,

        collisionbox = collisionbox,
        genetic_init_list = genetic_init_list,
        genetic_range_table = genetic_range_table,
        mesh = mesh,
        skin_init_list = skin_init_list,
        version = version,
        visual_size = visual_size,
    }

    return true

end

function unimobs.petz_api.register_standard_mob(data_table)

    -- From petz.register()
    -- Registers a mob entity using standard properties. Also registers the mob's spawn egg
    -- (Some packages will call this function; but most mob packages register their own entity)
    --
    -- data_table compulsory fields:
    --      mob_type (str): e.g. "gecko_normal"
    --      orig_spawnegg_name (str): e.g. "petz:gecko_set"
    --      def_table (table): Entity definition table for the mob
    --      insertion_table (table): Table providing substitutions for visible translated text, in
    --          the form described in unimobs.petz_api.register_mob()
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      version (int): Code version for this mob. Code in petz_init_prop.lua checks the value so
    --          that, in case of any major changes to the mob, old mob entities can be updated. When
    --          first written, mobs should have a .version with the value 1; later changes should be
    --          numbered 2, 3 etc. If not specified, 1 is used

    local mob_type = data_table.mob_type
    local orig_spawnegg_name = data_table.orig_spawnegg_name
    local def_table = data_table.def_table
    local insertion_table = data_table.insertion_table

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local version = data_table.version or 1

    local full_name = "unilib:mob_" .. mob_type
    local mesh = def_table.mesh or "unilib_mob_" .. mob_type .. ".b3d"

    local visual_size_table, visual_size_baby_table
    visual_size_table = {
        x = unimobs.petz_const.visual_size.x * (def_table.scale_factor or 1),
        y = unimobs.petz_const.visual_size.y * (def_table.scale_factor or 1),
    }
    if def_table.can_breed_flag then

        visual_size_baby_table = {
            x = visual_size_table.x * (def_table.baby_scale_factor or 0.5),
            y = visual_size_table.y * (def_table.baby_scale_factor or 0.5),
        }

    end

    local cbox, cbox_baby
    if def_table.collisionbox then

        cbox, cbox_baby = unimobs.petz_api.get_standard_collisionbox(
            def_table.collisionbox.p1,
            def_table.collisionbox.p2,
            def_table.scale_factor,
            def_table.baby_scale_factor
        )

    end

    local sbox, sbox_baby
    if def_table.selectionbox then

        if cbox then

            sbox = cbox
            sbox_baby = cbox_baby

        else

            -- (The returned collisionboxes can also be used as selectionboxes, when required)
            sbox, sbox_baby = unimobs.petz_api.get_standard_collisionbox(
                def_table.selectionbox.p1,
                def_table.selectionbox.p2,
                def_table.scale_factor,
                def_table.baby_scale_factor
            )

        end

    end

    -- N.B. Removed; there is no valid reason for calling code to specify a .replace field in this
    --      format
    --[[
    local replace_data_list, replace_rate, replace_turf_flag
    if def_table.replace then

        replace_data_list = def_table.replace.replace_data_list
        replace_rate = def_table.replace.replace_rate
        replace_turf_flag = def_table.replace.replace_turf_flag
        replace_turf_offset = def_table.replace.replace_turf_offset

    end
    ]]--

    if unimobs.petz_api.register_mob({
        mob_type = mob_type,
        mob_name = "unilib:mob_" .. mob_type,
        description = def_table.description,
        insertion_table = insertion_table,

        collisionbox = cbox,
        genetic_init_list = def_table.genetic_init_list,
        mesh = mesh,
        skin_init_list = def_table.skin_init_list,
        version = version,
        visual_size = visual_size_table,
    }) then

        unimobs.petz_api.register_spawnegg({
            mob_type = mob_type,
            orig_name = orig_spawnegg_name,

            replace_mode = replace_mode,
            description = def_table.description,
            img = "unilib_spawnegg_".. mob_type .. ".png",
            mob_name = full_name,
            sci_name = def_table.sci_name,
            tamed_flag = not def_table.is_wild_flag,
        })

        -- N.B. The call to unimobs.petz_api.register_egg_node() no longer happens from here;
        --      instead, it should occur in a separate package (see the "egg_gecko_normal" package
        --      for an example)

    end

    -- Register the entity
    unilib.register_entity(full_name, {

        -- Base properties (original to unimobs)

        -- Flag that definitively establishes this mob as being compatible with the Petz API (true)
        --      or not (false). Ideally, all mobs should have this property
        petz_compat_flag = true,
        -- The class of creature. In most cases, this is synonymous with its species, though
        --      monsters mostly use the class "monster". For most creatures, it's the first word in
        --      "mob_type" (e.g. "cat", "bear", "monster")
        class_type = def_table.class_type or mob_type,
        -- (Was .type)
        -- A unique name for each type of creature; it is guaranteed to match the name of the
        --      entity itself, e.g. "frog_normal" matches "unilib:mob_frog_normal"
        mob_type = mob_type,
        -- The same unique name, occasionally tweaked to match the names of media files (especially
        --      sound files); some mobs with multiple variants (e.g. bees) share the same set of
        --      media files
        generic_type = def_table.generic_type or mob_type,

        -- Long description for the creature, already translated, e.g. S("Normal Dog")
        description = def_table.description or mob_type,
        -- Scientific name for the creature, not translated, e.g. "Felis catus"
        sci_name = def_table.sci_name or mob_type,

        -- Common properties
        initial_properties = {
            backface_culling = def_table.backface_culling or false,
            collide_with_objects = def_table.collide_with_objects or true,
            collisionbox = cbox,
            makes_footstep_sound = def_table.makes_footstep_sound or false,
            mesh = mesh,
            physical = def_table.physical or true,
            selectionbox = sbox or cbox,
            static_save = def_table.static_save or true,
            stepheight = def_table.stepheight or 0.1,
            textures = unimobs.petz_api.compile_texture_list(mob_type, def_table.skin_init_list),
            visual = unimobs.petz_const.visual,
            visual_size = visual_size_table,
        },

        -- Mobkit API properties (see the notes in unilib/lib/system/mobkit/mobkit.api)
        -- (Was .animation)
        animation_table = def_table.animation_table or nil,
        -- (Was .armor_groups)
        armour_groups = def_table.armour_groups or nil,
        -- (Was .attack)
        attack_table = def_table.attack_table or nil,
        -- (Was .springiness; was not mentioned in the original Mobkit API, but should have been.
        --      Used in collisions to determine the rebound, if any)
        bounciness = def_table.bounciness or 0,
        -- (Was .logic. If no callback is specified, the mob will be motionless)
        brain_func = def_table.brain_func or nil,
        -- (Portion of hitbox submerged)
        -- 0.5 is a common value. Use 1 for controlled buoyancy (fish, submarines etc), greater than
        --      1 for drowning, or less than 0 for Minecraft-like water trampolining
        buoyancy = def_table.buoyancy or 0.5,
        -- (Maximum jump height)
        jump_height = def_table.jump_height or 1,
        -- (Lung capacity in seconds)
        lung_capacity = def_table.lung_capacity or 10,
        -- (Maximum HP; not the same as the engine's .hp_max)
        max_hp = def_table.max_hp or 10,
        -- (Maximum speed in m/s)
        max_speed = def_table.max_speed or 1,
        -- (Was .physics. Callback handling movement)
        physics_func = def_table.physics_func or nil,
        -- N.B. Many mobs in the original petz code used a value of . sounds that does NOT match one
        --      of the three formats listed in the original mobkit API document, namely
        --          [name] { list of string filenames }
        -- unimobs code (specifically unimobs.mobkit_api.do_entity_sound() ) has been updated to
        --      recognise all four formats
        sounds = def_table.sounds or nil,
        -- (N.B. No .timeout in original code. Time after which the entity is removed)
--      timeout = nil,
        view_range = def_table.view_range or 10,

        -- Kitz properties (set in the call to unimobs.kitz_api.register_active_mob)
        _id = nil,

        -- Petz non-dynamic properties
        -- (Was .avoid_player; not in the original version of this function)
        -- If true, will run away from nearby players, rather than attack them without provocation,
        --      overriding the value of .hostile_to_players_flag
        -- Applies only to mobs whose behaviour includes the ability to attack (see the comments for
        --      .hostile_to_players_flag)
        -- For example, normal wolves use the "brain_predator" package for their logic. Their
        --      .avoid_players_flag is set to true, so the value of their .hostile_to_players_flag
        --      is irrelevant: they will attack players only when provoked
        avoid_players_flag = def_table.avoid_players_flag or false,
        -- (Original to unimobs)
        -- List of mob types for the babies of this mob
        -- Intended for creatures represented by two distinct entities: an adult/baby male and an
        --      adult/baby female (such as the elephants in the original code, which in unimobs are
        --      "elephant_normal_male" and "elephant_normal_female")
        -- For creatures represented by three distinct entities, representing an adult male, adult
        --      female and baby of either gender (such as the chickens in the original code), use
        --      the .parent_type_list property
        -- This property has a less restricted usage than .parent_type_list. If specified, it
        --      can contain any number of items. The babies need not be of the same species as the
        --      parent (but if not, you must pay careful attention to the genetics of the mobs,
        --      which must be compatible)
        baby_type_list = def_table.baby_type_list or nil,
        -- (Was .can_alight)
        -- Applies to flying mobs. If true, the mob can stand and walk on the ground
        can_alight_flag = def_table.can_alight_flag or false,
        -- (Was .breed)
        -- If true, the mob can breed using the standard mechanism (of being fed by item(s)
        --      specified in the remix CSV)
        -- Note that, in unimobs, many more mobs are breedable than in the original code
        -- This flag should be false for mobs that should not be bred under any circumstances, e.g.
        --      - Monsters: Werewolves, Mr Pumpkin, Evil Santa, tarantulas
        --      - Mobs that breed by laying eggs: chickens, ducks, geckos, penguins
        --      - Mobs that are converted from other mobs: dogs
        --      - Mobs which exist for the player to catch: fish, dolphins, butterflies
        --      - Mobs which breed using other mechanisms (if at all): ants, bees, moths, silkworms
        can_breed_flag = def_table.can_breed_flag or false,
        -- (Was .is_arboreal)
        -- If true, can climb trees (e.g. chimpanzees have this property)
        can_climb_trees_flag = def_table.can_climb_trees_flag or false,
        -- (Original to unimobs)
        -- If true, the mob can "clutch" suitable small items (e.g. a dog can pick up balls in its
        --      mouth). All "clutchable" items are registered via a call to
        --      unimobs.petz_api.register_clutchable_item()
        can_clutch_flag = def_table.can_clutch_flag or false,
        -- (Was .can_fly)
        -- If true, the mob can fly
        can_fly_flag = def_table.can_fly_flag or false,
        -- (Was .can_be_brushed)
        -- If true, the mob can be brushed (with a hairbrush) or rubbed with lotion (e.g. beaver
        --      oil). In Tamagotchi Mode, both brushing and rubbing increase the mob's affinity for
        --      its owner; otherwise, the mob can be brushed or rubbed, but its properties are
        --      unaffected
        -- Note that, even though grooming will work on mobs that don't have Tamagotchi Mode, there
        --      are no mobs which have grooming but not Tamagotchi Mode (and vice-versa)
        can_groom_flag = def_table.can_groom_flag or false,
        -- (Was .herd; not in the original version of this function)
        -- If true, the creature can join herds of similar animals, and follow shepherds (players
        --      wielding a shepherd's crook)
        can_herd_flag = def_table.can_herd_flag or nil,
        -- (Was .can_jump; not in the original version of this function)
        -- If true, the mob can jump (see also .jump_chance, .jump_impulse)
        can_jump_flag = def_table.can_jump_flag or false,
        -- (Was .can_perch)
        -- If true, the mob can be placed on a bird stand or similar item
        can_perch_flag = def_table.can_perch_flag or false,
        -- (Was .feathered, a boolean)
        -- True if a feather can be plucked from the mob
        can_pluck_flag = def_table.can_pluck_flag or false,
        -- (Was .can_swin, a typo in the original code. Not in the original version of this
        --      function)
        -- If true, the mob can swim. The value of this property affects mob behaviours. When false
        --      and placed in water, the mob will take damage and eventually die
        can_swim_flag = def_table.can_swim_flag or false,
        -- (Was .capture_item)
        -- Specifies the type of item that can capture the mob. Supported values are "lasso",
        --      "animal_net", "bug_net" or nil for any mob that can't be captured
        capture_type = def_table.capture_type or nil,
        -- (Was .rotate)
        -- Value set to unimobs.petz_const.rotate (i.e. 0) for all mobs; in original code (and also
        --      in unimobs) it is used to set the correct rotation for a mob mounted by a player
        default_rotation = unimobs.petz_const.rotate,
        -- (Was .die_at_daylight)
        -- Flag set to true if the mob should die in daylight (specifically, in light levels
        --      greater than self.spawn_max_light)
        die_in_daylight_flag = def_table.die_in_daylight_flag or false,
         -- (Was .drops)
        -- List of mini-tables specifying one or more items dropped by this mob. Mini-tables in the
        --      form specified by unimobs.kitz_api.make_mob_drop_multiple_items()
        drop_list = def_table.drop_list,
        -- (Was .dung, a boolean)
        -- Specifies the item that is produced as dung from time to time (e.g.
        --      "unilib:misc_dung_normal"); if not specified, dung is never produced
        dung_name = def_table.dung_name or nil,
        -- (Original to unimobs)
        -- The name of the egg (e.g. "unilib:egg_chicken_normal"); nil if this mob doesn't lay eggs
        egg_name = def_table.egg_name or nil,
        -- (N.B. The .follow property has been removed; use the new .follow_item_table and
        --      .feed_item_table properties instead)
--      follow = unimobs.petz_api.get_msetting(mob_type, "follow"),
        -- (Was .has_affinity)
        -- If true, Tamagotchi Mode (if enabled generally) applies to this mob
        -- Note that in the original code, some mobs had Tamagotchi Mode, but not affinity (or
        --      vice-versa, see dolphins/parrots). In unimobs, that's not the case; all mobs with
        --      Tamagotchi Mode also have affinity
        -- Note that Tamagotchi Mode is enabled for fewer mobs, than was the case in the original
        --      petz code (for reasons of realism)
        has_tamagotchi_mode_flag = def_table.has_tamagotchi_mode_flag or false,
        -- (Was .head)
        -- Table of values used to animate the mob's head (or nil, if no special animations are
        --      required); see the "mob_sheep_normal" package for an example
        head_prop_table = def_table.head_prop_table or nil,
        -- (Was .attack_player)
        -- If true, will attack nearby players without provocation (as long as the mob's behaviour
        --      includes the ability to attack; for example, mobs using the "brain_predator" package
        --      for their logic are able to attack, but mobs using the "brain_herbivore" package are
        --      not)
        hostile_to_players_flag = def_table.hostile_to_players_flag or false,
        -- (Original to unimobs)
        -- If true, the mob doesn't take damage from igniters (fire, lava etc)
        igniter_immunity_flag = def_table.igniter_immunity_flag or false,
        -- (N.B. .init_tamagotchi_timer_flag has been moved to petz_init_prop.lua)
        -- (Was .is_baby)
        -- Flag initially set to true for all mobs that are inherently babies, and false for all
        --      mobs that are inherently adults, but set to nil (not false) otherwise. The value is
        --      subsequently set to true or false when the mob is initialised
        is_baby_flag = def_table.is_baby_flag or false,
        -- (Was .is_boss)
        -- If true, the mob is a "boss" monster; in the original code, true for mob_monster_X and
        --      mob_tarantula_normal, but not true for mob_rat_normal
        -- N.B. No part of the original code uses this setting, but it's available if required
        is_boss_flag = def_table.is_boss_flag or false,
        -- (Was .is_male)
        -- Flag initially set to true for all mobs that are inherently male, and to false for all
        --      mobs that are inherently female, but set to nil (not false) otherwise
        -- Code in petz_init_prop.lua will randomly change a nil value to true for half of all mobs
        --      spawning in the world (or placed as spawn eggs), and false for the other half,
        --      creating a gender balance
        is_male_flag = def_table.is_male_flag or nil,
        -- (Was .is_mammal; not in the original version of this function)
        -- If true, the mob is a mammal. Aquatic mobs which are not mammals will suffocate in the
        --      air
        is_mammal_flag = def_table.is_mammal_flag or false,
        -- (Was .milkable)
        -- True for mobs that can be milked
        is_milkable_flag = def_table.is_milkable_flag or false,
        -- (Was .is_monster)
        -- If true, the mob is an "ordinary" monster; in the original code, is true for
        --      mob_monster_X, mob_tarantula_normal AND mob_rat_normal (compare .is_boss_flag)
        is_monster_flag = def_table.is_monster_flag or false,
        -- (Was .is_mountable)
        -- If true, the mob can be mounted (ridden); in the original code, is true only for ponies
        --      and camels
        is_mountable_flag = def_table.is_mountable_flag or false,
        -- (Was .is_pet)
        -- It is not clear, in the original code, what this value is supposed to represent, but it
        --  has the following effects:
        --      - if true, herbivores will not flee from players ("brain_herbivore" package)
        --      - if true, hunger and grooming are required in Tamagotchi Mode
        --      - if true, tamed mobs cannot be captured by other players (depending on other
        --              settings)
        --      - if true, dreamcatchers can be used on the mob (depending on other settings)
        --      - if true, nametags can be used on the mob
        is_pet_flag = def_table.is_pet_flag or false,
        -- (Was .is_wild)
        -- If true, the mob is a wild animal. These mobs have changes in behaviour, such as
        --      requiring a lash to be tamed, and having the ability to "guard" the player (an order
        --      in the mob's main formspec)
        is_wild_flag = def_table.is_wild_flag or false,
        -- (Was .jump_ratio; not in the original version of this function)
        -- Value used only with mobs whose .can_jump_flag is true, and which live on land (and are
        --      therefore using the "hqb_terrestrial_jump" behaviour; in original code, frogs and
        --      rabbits)
        -- Chance of engaging the "hqb_terrestrial_jump" behaviour; a value of 10 corresponds
        --      to once in every 10 occasions, when a jump is possible
        jump_chance = def_table.jump_chance or nil,
        -- (N.B. .jump_impulse not in the original version of this function)
        -- Value used only with mobs whose .can_jump_flag is true, and which live on land (and are
        --      therefore using the "hqb_terrestrial_jump" behaviour; in original code, frogs and
        --      rabbits)
        -- Affects the magnitude of the jump, relative to the mob's .max_speed; so frogs
        --      (impulse 4.0) jump about the same height as rabbits (impulse 1.2)
        jump_impulse = def_table.jump_impulse or nil,
        -- (Was .lay_eggs in the original code; the nul value was sometimes false, sometimes nil)
        -- Value describing the types of eggs produced by compatible mobs; valid values are "item",
        --      "node" or "nest" (or nil for mobs that don't lay eggs)
        lay_eggs_mode = def_table.lay_eggs_mode or nil,
        -- (Was .max_height)
        -- Specifies the maximum height for mob roaming (specifically, for the "lqb_fly_wander"
        --      package). Does not specify the maximum spawn height; see .spawn_max_height for that
        max_roam_height = def_table.max_roam_height or 5,
        -- (Original to unimobs)
        -- The name of the empty nest in which this mob lays an egg, e.g. "unilib:misc_nest"; nil
        --      if this mob doesn't require a nest, or doesn't lay eggs at all
        nest_empty_name = def_table.nest_empty_name or nil,
        -- (Original to unimobs)
        -- The name of the full nest in which this mob has laid en egg, e.g.
        --      "unilib:misc_nest_with_egg_duck_normal"); nil if this mob doesn't require a nest, or
        --      doesn't lay eggs at all
        nest_full_name = def_table.nest_full_name or nil,
        -- (N.B. .mutation has been removed)
        -- (Was .give_orders)
        -- If true, the mob can be given orders in its main formspec
        obeys_orders_flag = def_table.obeys_orders_flag or false,
        -- (Was .parents)
        -- List of mob types for the parents of this mob
        -- Intended for creatures represented by three distinct entities: an adult male, adult
        --      female and baby of either gender (such as the chickens in the original code, which
        --      in unimobs are "chicken_rooster", "chicken_hen" and "chicken_chicklet")
        -- For creatures represented by two distinct entities, representing adult/baby males and
        --      adult/baby females (such as the elephants in the original code), use the
        --      .baby_type_list property
        -- In unimobs, this property has a more restricted usage than the original code. If
        --      specified, it should contain exactly two items, the female and male types (in that
        --      order), so that a female baby can grow into a female adult
        parent_type_list = def_table.parent_type_list or nil,
        -- (N.B. .skin_colors has been removed)
        -- (Was .sleep_at_day)
        -- True if the mob can sleep during the day
        sleep_in_day_flag = def_table.sleep_in_day_flag or false,
        -- (Was .sleep_at_night)
        -- True if the mob can sleep during the night
        sleep_in_night_flag = def_table.sleep_in_night_flag or false,
        -- Proportion of each 24-hour period spent asleep; e.g. 0.3 means 60% of the night (or day)
        sleep_ratio = def_table.sleep_ratio or 0.3,
        -- (Was .max_daylight_level)
        -- Maximum light in which the mob will spawn
        spawn_max_light = def_table.spawn_max_light or nil,
        -- (Was .min_daylight_level)
        -- Minimum light in which the mob will spawn
        spawn_min_light = def_table.spawn_min_light or nil,
        -- Value automatically set according to the remix CSV; used only by penguins in the original
        --      code
        spawn_max_height = def_table.spawn_max_height or nil,
        -- Value automatically set according to the remix CSV; not in the original version of this
        --      function
        spawn_min_height = def_table.spawn_min_height or nil,
        -- (Original to unimobs)
        -- List of mob types that this mob straggles (follows behind); can be set for suitable
        --      creatures (e.g. puppies follow their parents) and not set for unsuitable creatures
        --      (e.g. baby tarantulas don't need to follow their parents)
        -- The items on this list are checked in order, so if the father and mother are represented
        --      by different mobs (e.g. chickens, elephants), the mother should probaby be listed
        --      first
        -- Straggling is implemented by a limited range of brain packages: by default,
        --      "brain_predator", "brain_herbivore" and "brain_flying" (though you can add it to
        --      your own brain packages, if you want)
        -- In those brain packages, babies follow adults (only), and straggling does not happen at
        --      all if the .enable_straggle_flag and .streamline_behaviour_flag settings are not
        --      true
        -- N.B. Original code used the old .parents (now .parent_type_list) property for the same
        --      purpose
        straggle_type_list = def_table.straggle_type_list or nil,

        -- Petz baby properties (used for any babies produced by this mob)
        collisionbox_baby = cbox_baby,
        selectionbox_baby = sbox_baby or cbox_baby,
        visual_size_baby = visual_size_baby_table,

        -- Petz replace properties (see unimobs.kitz_api.make_mob_replace_node() )
        replace_data_list = def_table.replace_data_list or nil,
        replace_rate = def_table.replace_rate or nil,
        replace_turf_flag = def_table.replace_turf_flag or false,
        replace_turf_offset = def_table.replace_turf_offset or 0,

        -- Petz mob-specific properties
        -- (Used by camel_normal, pony_normal)
        baby_scale_factor = def_table.baby_scale_factor or nil,
        -- (Was .bottled. Used by butterfly_large, moth_normal)
        bottled_name = def_table.bottled_name or nil,
        -- (Was .has_saddlebag in original code; used by camel_normal)
        can_have_saddlebag_flag = def_table.can_have_saddlebag_flag or false,
        -- (Replaces the original fields .ant_type, which was a string, and .queen, which was a
        --      flag. Used by ant_misc, bee_misc)
        colony_type = def_table.colony_type or nil,
        -- (Used by camel_normal, pony_normal)
        driver_attach_at = def_table.driver_attach_at or nil,
        -- (Used by camel_normal, pony_normal)
        driver_eye_offset = def_table.driver_eye_offset or nil,
        -- (Used by camel_normal, pony_normal)
        driver_scale = def_table.driver_scale or nil,
        -- (Used by pony_normal)
        driver_wagon_attach_at = def_table.driver_wagon_attach_at or nil,
        -- (Used by pony_normal)
        driver_wagon_eye_offset = def_table.driver_wagon_eye_offset or nil,
        -- (Was .eat_hay. Used by pony_normal)
        eat_hay_flag = def_table.eat_hay_flag or false,
        -- (Was .fly_rate. Used by flamingo_normal)
        fly_chance = def_table.fly_chance or 60,
        -- (Was .aggressive. Used by chicken_rooster, chicken_hen, chicken_chicklet)
        is_aggressive_flag = def_table.is_aggressive_flag or false,
        -- (Was .attack_kamikaze. Used by bee_misc)
        kamikaze_attack_mode_flag = def_table.kamikaze_attack_mode_flag or false,
        -- (Was .attack_pack. Used by wolf_normal)
        pack_attack_mode_flag = def_table.pack_attack_mode_flag or false,
        -- (Original to unimobs, used by parrot_normal, toucan_normal)
        perch_left_offset = def_table.perch_left_offset or nil,
        perch_right_offset = def_table.perch_right_offset or nil,
        perch_forward_offset = def_table.perch_forward_offset or nil,
        perch_reverse_offset = def_table.perch_reverse_offset or nil,
        -- (Used by camel_normal, pony_normal)
        scale_factor = def_table.scale_factor or nil,
        -- (Was .spawn_at_night. Used by bat_normal)
        spawn_at_night_flag = def_table.spawn_at_night_flag or false,

        -- Required callbacks
        -- N.B. In the original code, callbacks could not be passed to this function (see the
        --      "mob_parrot_normal" package for a code example)

        get_staticdata = def_table.get_staticdata or unimobs.mobkit_api.get_staticdata_callback,

        on_activate = def_table.on_activate or function(self, staticdata, dtime_s)

            unimobs.mobkit_api.on_activate_callback(self, staticdata, dtime_s)
            unimobs.petz_api.set_mob_initial_properties(self, staticdata, dtime_s)

        end,

        on_step = def_table.on_step or function(self, dtime)

            unimobs.mobkit_api.on_step_callback(self, dtime)
            unimobs.petz_api.on_step_callback(self, dtime)

        end,

        -- Petz callbacks

        on_deactivate = def_table.on_deactivate or function(self)
            unimobs.petz_api.on_deactivate_callback(self)
        end,

        on_punch = def_table.on_punch or function(
            self, puncher, time_from_last_punch, tool_capabilities, dir
        )
            unimobs.petz_api.on_punch_callback(
                self, puncher, time_from_last_punch, tool_capabilities, dir
            )

        end,

        on_rightclick = def_table.on_rightclick or function(self, clicker)
            unimobs.petz_api.on_rightclick_callback(self, clicker)
        end,
    })

end

function unimobs.petz_api.register_spawnegg(data_table)

    -- From petz:register_egg()
    -- Creates a spawn egg for the specified mob
    --
    -- data_table compulsory fields:
    --      mob_type (str): e.g. "lion_normal"
    --      orig_name (str): e.g. "petz:lion_set"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Lion (Normal)"
    --      img (str): e.g. "unilib_spawnegg_lion_normal.png"
    --      mob_name (str): e.g. "unilib:mob_lion_normal"
    --      sci_name (str): e.g. "Felis catus"
    --      tamed_flag (bool): e.g. true

    local mob_type = data_table.mob_type
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Unidentified Spawn Egg")
    local img = data_table.img or "unilib_spawnegg_" .. mob_type .. ".png"
    local mob_name = data_table.mob_name or "unilib:mob_" .. mob_type
    local sci_name = data_table.sci_name or nil
    local tamed_flag = data_table.tamed_flag or false

    local full_name = "unilib:spawnegg_" .. mob_type
    if tamed_flag then
        description = unilib.utils.brackets(description, S("tamed"))
    end

    if sci_name then
        description = unilib.utils.annotate(description, sci_name)
    end

    -- If "mob_name" matches any of the strings in unimobs.petz_global.mob_remove_list, then the
    --      spawn egg should not be created
    for _, item in ipairs(unimobs.petz_global.mob_remove_list) do

        if string.find(mob_name, item) then
            return
        end

    end

    -- Register the new spawn egg containing information about the mob
    unilib.register_craftitem(full_name, orig_name, replace_mode, {
        description = description,
        inventory_image = img,
        -- N.B. In original code, .spawn_egg = 2
        groups = {spawnegg = 1},

        mob_type = mob_type,
        stack_max = 1,

        on_place = function(itemstack, placer, pointed_thing)

            -- Are we clicking on something with an existing .on_rightclick() function?
            local under_node = core.get_node(pointed_thing.under)
            local under_def_table = core.registered_nodes[under_node.name]
            if under_def_table and under_def_table.on_rightclick then

                return under_def_table.on_rightclick(
                    pointed_thing.under, under_node, placer, itemstack
                )

            end

            local spawn_pos = pointed_thing.above
            if spawn_pos and not core.is_protected(spawn_pos, placer:get_player_name()) then

                if not core.registered_entities[mob_name] then
                    return
                end

                local corrected_spawn_pos =
                        unimobs.petz_api.refine_spawn_position(mob_type, spawn_pos)
                if corrected_spawn_pos then

                    -- Convert the spawn egg to a mob entity
                    local luaent = unimobs.petz_api.release_mob(
                        placer, itemstack, mob_name, corrected_spawn_pos
                    )

                    -- N.B. When the creature is placed, it appears a little above the actual
                    --      surface (a nice visual effect)
                    -- Non-flying creatures quickly fall to the surface, but flying creatures do
                    --      not, instead hovering for some seconds until their first behaviour kicks
                    --      in (not a nice visual effect at all; it's because the "brain_flying"
                    --      package cancels the effects of gravity)
                    -- We can compensate for this by artificially giving the mob a downward
                    --      acceleration, when appropriate
                    if luaent and luaent.can_fly_flag and not luaent.is_plucked_flag then

                        -- Only fall if there's a node directly beneath the mob
                        local under_node = core.get_node({
                            x = corrected_spawn_pos.x,
                            y = corrected_spawn_pos.y - 2,
                            z = corrected_spawn_pos.z,
                        })
                        if under_node and
                                under_node.name ~= "air" and
                                under_node.name ~= "ignore" then

                            -- This acceleration is visually about the same as the one experience
                            --      by, for example, a pony
                            luaent.object:set_acceleration({x = 0, y = -100, z = 0})

                        end

                    end

                elseif core.is_player(placer) then

                    core.chat_send_player(
                        placer:get_player_name(), S("You cannot put the creature there")
                    )

                end

            end

            return itemstack

        end,
    })

    -- Update global variables
    unimobs.global.spawnegg_lookup_table[mob_name] = full_name

    return full_name

end

function unimobs.petz_api.register_egg_node(data_table)

    -- From petz.register__egg()
    -- Registers an egg in the form of a node
    -- (In the original mod code, this function was only called for gecko eggs)
    --
    -- data_table compulsory fields:
    --      mob_type (str): e.g. "gecko_normal"
    --      orig_name (str): e.g. "petz:gecko_egg"
    --      drawtype (str): e.g. "nodebox"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      baby_max (int): The maximum number of baby mobs produced by each egg (default is 1,
    --          otherwise a random number of eggs between 1 and the maximum is produced; use the
    --          value 0 to prevent eggs from producing any babies)
    --      baby_name (str): If not specified, "unilib:mob_TYPE", where TYPE is data_table.mob_type
    --      description (str): e.g. "Normal Gecko Egg"
    --      mesh (str or nil): The mesh to use, if any
    --      node_box (table): Standard Minetest nodebox

    local mob_type = data_table.mob_type
    local orig_name = data_table.orig_name
    local drawtype = data_table.drawtype

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local baby_max = data_table.baby_max or 1
    local baby_name = data_table.baby_name or "unilib:mob_" .. mob_type
    local description = data_table.description or S("Unidentified Egg")
    local mesh = data_table.mesh or nil
    local node_box = data_table.node_box or nil

    local full_name = "unilib:egg_" .. mob_type

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {"unilib_egg_" .. mob_type .. ".png"},
        groups = {bendy = 2, cracky = 1, falling_node = 1, snappy = 1},
        sounds = unilib.global.sound_table.wood,

        drawtype = drawtype,
        inventory_image = "unilib_egg_" .. mob_type .. "_inv.png",
        mesh = mesh,
        node_box = node_box,
        paramtype = "light",
        visual_scale = 1.0,

        on_construct = function(pos)

            local timer = core.get_node_timer(pos)
            timer:start(
                unimobs.petz_api.get_random_interval(unimobs.petz_setting.hatch_node_egg_interval)
            )

        end,

        on_timer = function(pos)

            if not core.registered_entities[baby_name] or baby_max < 1 then
                return
            end

            -- Generate the first baby
            core.set_node(pos, {name = "air"})
            core.add_entity(pos, baby_name)

            -- Randomly generate additional babies, if permitted
            local baby_count = random(1, baby_max)
            if baby_count > 1 then

                for i = 2, baby_count do

                    -- (The false flag generates a list of 8 positions, 1 in each compass direction)
                    local adjacent_list =
                            unimobs.kitz_api.get_list_of_adjacent_node_positions(pos, false)

                    local this_pos = adjacent_list[random(1, 8)]
                    if core.get_node(this_pos) and core.get_node(this_pos).name == "air" then
                        core.add_entity(this_pos, baby_name)
                    end

                end

            end

            return false

        end
    })

end

function unimobs.petz_api.register_egg_entity(data_table)

    -- Original to unimobs
    -- Registers an egg in the form of an entity, which is converted to a craftitem when picked up
    --      by the player
    -- (This solves the problem of penguin eggs in the original code, which are spawned as
    --      craftitems, and which therefore never hatch)
    --
    -- data_table compulsory fields:
    --      mob_type (str): e.g. "penguin_normal"
    --      orig_name (str): e.g. The name of the original craftitem, e.g. "petz:penguin_egg"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      baby_name (str): If not specified, "unilib:mob_TYPE", where TYPE is data_table.mob_type
    --      description (str): e.g. "Normal Penguin Egg"
    --      satiation (int): The value used in the call to unilib.cuisine.eat_on_use() when the
    --          craftitem is eaten by the player; 1 if not specified
    --      scale_factor (float): a value of 1 is approximately the same height as a node; 0.5 is
    --          approximately half the height of a node, and so on. Default value is 0.5

    local mob_type = data_table.mob_type
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local baby_name = data_table.baby_name or "unilib:mob_" .. mob_type
    local description = data_table.description or S("Unidentified Egg")
    local satiation = data_table.satiation or 1
    local scale_factor = data_table.scale_factor or 0.5

    local full_name = "unilib:egg_" .. mob_type
    local img = "unilib_egg_" .. mob_type .. ".png"
    local cbox_size = 0.5 * scale_factor

    local y_offset = 0
    if scale_factor ~= 1 then
        y_offset = (1 - scale_factor) / 2
    end

    -- Define the craftitem
    unilib.register_craftitem(full_name, orig_name, replace_mode, {
        description = description,
        inventory_image = img,
        groups = {flammable = 2, food = 2, food_egg = 1},

        -- N.B. No .stack_max in original code's penguin egg; added for consistency with chicken and
        --      duck eggs
        stack_max = unimobs.petz_setting.egg_stack_size,
        wield_image = img,

        on_place = function(itemstack, placer, pointed_thing)

            -- When the craftitem is placed, it's converted to an entity
            if pointed_thing.type ~= "node" then
                return itemstack
            end

            core.add_entity(pointed_thing.above, full_name)
            itemstack:take_item()
            return itemstack

        end,

        on_use = unilib.cuisine.eat_on_use(full_name, satiation),
    })

    -- Define the entity. It has the same name as the craftitem (instead of being in the form
    --      "unilib.entity_X") to simplify code in unimobs.petz_api.lay_egg()
    unilib.register_entity(full_name, {
        initial_properties = {
            collide_with_objects = true,
            collisionbox = {-cbox_size, -cbox_size, -cbox_size, cbox_size, cbox_size, cbox_size},
            physical = true,
            -- N.B. Can't set .static_save to true, because when the game is re-started, the egg
            --      will spawn one node lower (because of y_offset)
            static_save = false,
            textures = {img},
            visual = "sprite",
            visual_size = unimobs.petz_api.get_standard_visual_size(scale_factor * entity_ratio),
        },

        timer = 0,

        on_activate = function(self, staticdata, dtime_s)

            -- When placed on the ground, adjust the y position so that the egg appears to be
            --      touching the surface, rather than floating above it
            local pos = self.object:get_pos()
            pos.y = pos.y - y_offset
            self.object:set_pos(pos)

        end,

        on_punch = function(self, puncher)

            -- When the entity is punched, it's converted to a craftitem
            if puncher and puncher:is_player() then

                local inv = puncher:get_inventory()
                local item = ItemStack(full_name)

                if inv:room_for_item("main", item) then

                    inv:add_item("main", item)

                else

                    local pos = puncher:get_pos()
                    core.add_item(pos, item)

                end

                self.object:remove()

            end

        end,

        on_step = function(self, dtime)

            -- Hatch the egg
            self.timer = self.timer + dtime
            if self.timer > unimobs.petz_api.get_random_interval(
                unimobs.petz_setting.hatch_egg_interval
            ) then

                -- Hatch only if a parent is nearby (to simulate tending to the egg); otherwise
                --      self-destruct (to simulate a dropped craftitem despawning)
                if unimobs.mobkit_api.get_random_nearby_entity(self, baby_name) then

                    -- Cancel the y-offset applied in the code above
                    local pos = self.object:get_pos()
                    pos.y = pos.y + y_offset

                    -- Spawn the mob
                    core.add_entity(pos, baby_name)

                end

                -- Remove the egg, whether or not it hatched
                self.object:remove()

            end

        end,
    })

end
