---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_init_prop.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Localise math functions (for speed)
local ceil = math.ceil
local random = math.random

-- Table of mob types, and the extension callback to call whenever
--      unimobs.petz_api.set_mob_initial_properties() is called
-- Note also that the callbacks do not need to return any special value; all callbacks matching the
--      specified "mob_type" are called
-- Table in the form
--      extension_table[mob_type] = list_of_callbacks
local extension_table = {}

-- Was petz.dyn_prop
-- Table of "dynamic" mob properties - namely, those that must be stored when a mob is captured
--      (entity is converted to a spawn egg), and restored when the mob is placed back in the world
--      (spawn egg is converted to an entity)
-- This table initially lists the "standard" dynamic properties and their initial values. Mob
--      packages can add new properties by calling unimobs.petz_api.add_dynamic_property()
-- Note that all dynamic properties apply to all mobs, and that initial values are the same for all
--      mobs, regardless of type/species
local dynamic_prop_table = {

    -- Overwritten by unimobs.petz_api.register_standard_mob() / mob packages

    -- N.B. The default flag values are nil, not false - see comments in petz_register.lua
    is_baby_flag = {type = "bool", default = nil},
    is_male_flag = {type = "bool", default = nil},

    -- Not overwritten by unimobs.petz_api.register_standard_mob() / mob packages

    -- (Basic properties)

    -- (Original to unimobs)
    -- The code version for this entity, matching the value in unimobs.petz_global.mob_table at the
    --      time the mob was created
    -- The default value, specified here, is 1. The initial value of a new mob entity's .version is
    --      set in the call to initialise_new_mob() below. Code in reinitialise_old_mob() checks
    --      that an existing entity's version is the latest one, and applies changes if not
    version = {type = "num", default = 1},
    -- (Was .captured)
    -- Set to true when a mob is captured, then back to false when it is released (e.g. by placing a
    --      spawnegg)
    is_captured_flag = {type = "bool", default = false},
    -- (N.B. .child has been removed, fixing a bug in the original code, which checked the property
    --      but never actually set it; use .is_baby_flag instead)
    -- (Was .dead)
    -- True if the mob is dead (the entity is not removed from the world immediately)
    -- Must NOT be set directly; instead, call unimobs.petz_api.handle_mob_death()
    is_dead_flag = {type = "bool", default = false},
    -- (Was .tamed)
    -- True if the mob has been tamed by a player
    is_tamed_flag = {type = "bool", default = false},
    -- (Was .lifetime)
    -- The mob's lifespan, in seconds (or nil when no lifespan applies)
    lifespan = {type = "num", default = nil},
    -- The name of the player that is the mob's owner (because they tamed it or traded for it)
    owner = {type = "str", default = nil},

    -- (Breeding properties)

    -- (Was .growth_time)
    -- The age (in seconds) of a baby mob
    baby_growth_time = {type = "num", default = 0},
    -- (Original to unimobs)
    -- The maximum age of a baby mob, derived from
    --      unimobs.petz_setting.default_baby_growth_interval (with some adjustments, depending on
    --      circumstances)
    -- When .baby_growth_time exceeds this value, the baby is converted into an adult
    baby_growth_max_time = {type = "num", default = 0},
    -- (Was .father_genes, .father_veloc_stats)
    -- Table of values representing characteristics of the father, which are to be combined with
    --      characteristics of the mother, when she gives birth to a baby mob
    -- Note that in unimobs, two tables from the original code are combined into one; they contained
    --      only information about the parent's skin colours and speed stats
    father_genetic_table = {type = "table", default = {}},
    -- (Was .genes)
    -- Table of values representing characteristics of the mob, which were inherited from the father
    --      and mother
    genetic_table = {type = "table", default = {}},
    -- (Was .eggs_count)
    -- The number of eggs laid by the mob; used to check the maximum, when required
    egg_count = {type = "num", default = 0},
    -- (Original to unimobs)
    -- The number of breeding events that produced this mob; set to 0 for a mob that spawns
    --      naturally, 1 for its children, 2 for its grandchildren, and so on
    generation_count = {type = "num", default = 0},
    -- (Was .pregnant_count. In original code, used only by camels and ponies; in unimobs, used by
    --      everything, even males)
    -- The number of pregnancies that the mob can have. When the value reaches 0, no more
    --      pregnancies are possible. Ignored for male mobs
    pregnancy_countdown =
            {type = "num", default = unimobs.petz_setting.default_pregnancy_count},
    -- (Was .is_pregnant)
    -- True when the mob is pregnant
    is_pregnant_flag = {type = "bool", default = false},
    -- The length of time (in seconds) for a pregnancy
    pregnant_time = {type = "num", default = 0},
    -- (Original to unimobs)
    -- The maximum length of a pregnancy, derived from
    --      unimobs.petz_setting.default_pregnancy_interval (with some adjustments, depending on
    --      circumstances)
    -- When .pregnant_time exceeds this value, the baby is born (or not)
    pregnant_max_time = {type = "num", default = 0},
    -- (Original to unimobs)
    -- True when a female mob is in a cooldown period, after a pregnancy (successful or not). During
    --      the cooldown, the mob cannot be in rut or be pregnant
    is_in_cooldown_flag = {type = "bool", default = false},
    -- (Original to unimobs)
    -- The length of the cooldown period (in seconds)
    cooldown_time = {type = "num", default = 0},
    -- (Original to unimobs)
    -- The maximum length of the cooldown period, derived from half the value of
    --      unimobs.petz_setting.default_pregnancy_interval (with some adjustments, depending on
    --      circumstances)
    -- When .cooldown_time exceeds this value, the mob is able to breed again
    cooldown_max_time = {type = "num", default = 0},
    -- (Was .is_rut)
    -- True when the mob is in rut, i.e. searching for a mate, following a call to
    --      unimobs.petz_api.stimulate_mob_breeding()
    is_in_rut_flag = {type = "bool", default = false},

    -- (Combat properties)

    -- (Was .warn_attack)
    -- True if the mob was attacked by (any) player, usually triggering a hostile response
    -- Note that the "mtb_attack_player" package sets this property to true for any mobs that
    --      attack in packs (such as wolves)
    -- N.B. As described in the comments in reinitialise_old_mob(),
    --      .was_attacked_by_player_flag and .was_killed_by_player_flag are not set with
    --      unimobs.mobkit_api.add_mob_memory()
    was_attacked_by_player_flag = {type = "bool", default = false},
    -- (Was .was_killed_by_player)
    -- True if the mob was killed by (any) player
    was_killed_by_player_flag = {type = "bool", default = false},

    -- (Convert properties)

    -- (Was .convert)
    -- The item with which the mob was converted from one type into another. The original code did
    --      not use this property anywhere; in unimobs, the value is set during the call to
    --      unimobs.petz_api.convert_mob(), in case anything needs it
    converted_with = {type = "str", default = nil},
    -- (Was .convert_to)
    -- The mob type from which this mob was converted. The original code did not use this property
    --      anywhere; in unimobs, the value is set during the call to
    --      unimobs.petz_api.convert_mob(), in case anything needs it
    converted_from = {type = "str", default = nil},
    -- (Was .convert_count)
    -- The number of times more that the player must use an item (e.g. a bone) to convert a mob
    --      (e.g. a wolf) from one type to another (e.g. a dog). When the value reaches 0, the mob
    --      is converted
    convert_countdown = {type = "num", default = unimobs.petz_setting.default_convert_count},

    -- (Feed/replace properties)

    -- (Was .food_count)
    -- Number of times the mob must still be fed, in order to tame it; when the value reaches 0,
    --      the mob is tamed (and the value is set back to the maximum, ready for future feeding in
    --      case the owner abandons their tamed creature)
    feed_countdown = {type = "num", default = unimobs.petz_setting.default_tame_count},
    -- (Was .food_count_wool)
    -- Number of times the mob must replace a node (e.g. when a sheep eats grass); when the value
    --      reaches 0, the mob is replenished  (and the value is set back to the maximum, ready for
    --      future replacing in case the owner abandons their tamed creature)
    -- In unimobs, this property is available to all mobs that need it; they must provide code in
    --      their .on_replace() callback to update the value (see the "mob_sheep_normal" package for
    --      an example)
    -- Updating .replace_countdown is handled automatically for mobs with the .is_milkable_flag
    --      property (so, for example, the "mob_cow_normal" package doesn't have its own
    --      .on_replace() callback)
    replace_countdown = {type = "num", default = unimobs.petz_setting.default_replace_count},

    -- (Formspec properties)

    -- (Was .back_home)
    -- True when a mob's owner gives the mob a dreamcatcher, and enables the "Automatic go home"
    --      button in its main formspec; if the mob wanders too far from the specified home
    --      position, it is automatically teleported back
    back_home_flag = {type = "bool", default = false},
    -- (Was .home_pos)
    -- The mob's specified home position, when .back_home_flag is enabled
    back_home_pos = {type = "table", default = nil},
    -- (Was .dreamcatcher)
    -- True if the mob has been given a dreamcatcher by a player
    has_dreamcatcher_flag = {type = "bool", default = false},
    -- (Was .muted)
    -- True when the player enables the "Muted" button in the mob's main formspec; the mob will not
    --      make random "misc" sounds (because of a call to unimobs.kitz_api.make_misc_sound() ),
    --      but other sounds will still be made
    is_muted_flag = {type = "bool", default = false},
    -- (Was .tag)
    -- The nametag allocated to the mob by its owner (if any)
    nametag = {type = "str", default = ""},
    -- (Was .show_tag)
    -- True when the player enables the "Nametag visible/invisible" button in the mob's main
    --      formspec; the mob's .nametag is visible in the world
    show_nametag_flag = {type = "bool", default = false},

    -- (Misc properties)

    -- (Was .herding)
    -- True when the player enables the "Herding" button in the mob's main formspec; the mob looks
    --      for other creatures of the same type
    is_herding_flag = {type = "bool", default = false},
    -- (Was .milked)
    -- True when the mob (e.g. a cow) has been milked; the value is set back to false when the mob
    --      is ready to be milked again
    has_been_milked_flag = {type = "bool", default = false},
    -- Used with various sleep behaviours to set the beginning and end of a mob's sleep period
    sleep_start_time = {type = "num", default = nil},
    sleep_end_time = {type = "num", default = nil},
    -- (Was .square_ball_attached)
    -- True if any kind of small item is "clutched" to the mob (e.g. a square ball being carried by
    --      a dog in its mouth)
    -- N.B. As described in the comments in unimobs.petz_api.attach_clutchable_item(),
    --      .clutched_item_flag and .clutched_item_luaent are not set with
    --      unimobs.mobkit_api.add_mob_memory()
    clutched_item_flag = {type = "bool", default = false},
    -- The luaentity of the item clutched by the mob, if .clutched_item_flag is true
    clutched_item_luaent = {type = "str", default = nil},

    -- (Mob-specific properties)

    -- (Was .beehive)
    -- Applies to bees. The position of their hive, if ones exists
    -- N.B. Now a non-standard dynamic property, declared by the "mob_bee_misc" package
--  beehive_pos = {type = "pos", default = nil},
    -- (Original to unimobs, replacing the .create_anthill and .create_beehive, two properties that
    --      were not listed in this section, or in unimobs.petz_api.register_standard_mob(), or in
    --      the ant/bee packages, but which were created out of thin air code in
    --      unimobs.petz_api.set_initial_properties() )
    -- True for any mob that should found a colony, because the random delay has already expired
    create_colony_flag = {type = "bool", default = false},
    -- (Was .anthill_founded)
    -- True for any mob that has founded a colony. In original code, was used only for queen ants,
    --      so that each queen ant could found only one anthill; in unimobs, it's available for any
    --      comparable creature
    colony_created_flag = {type = "bool", default = false},
    -- (Was .plucked)
    -- True if feathers have been plucked from the mob. When true, it cannot fly (because of code
    --      in the "brain_flying" package). In original code, only ducks could be plucked; in
    --      unimobs, any mob whose .can_pluck_flag is true can be plucked
    is_plucked_flag = {type = "bool", default = false},

    -- (Mounted mob properties)

    -- The player who is mounted on a mob (e.g. a pony or camel)
    -- N.B. As explained in the comments in reinitialise_old_mob(), the .driver property is not set
    --      using unimobs.mobkit_api.add_mob_memory()
    driver = {type = "player", default = nil},
    -- The wagon entity which is currently attached to a mob (e.g. a pony)
    -- N.B. An undocumented property in original code
    -- N.B. As explained in the comments in reinitialise_old_mob(), the .wagon property is not set
    --      using unimobs.mobkit_api.add_mob_memory()
    wagon = {type = "entity", default = nil},
    -- (Was .horseshoes)
    -- Number of horseshoes given to a suitable mob (e.g. ponies); the mob's speed increases for
    --      every horseshoe given. The hard-coded maximum value is (obviously) 4
    horseshoe_count = {type = "num", default = 0},
    -- (Original to unimobs)
    -- The name of the item used as a horseshoe. Each mounted mob must have only one type of
    --      horseshoe at a time
    horseshoe_name = {type = "str", default = nil},
    -- (Was .saddle, a boolean value)
    -- If the mob has been given a saddle by a player, the name of the saddle (e.g.
    --      "unilib:item_saddle_normal"); otherwise nil
    saddle_name = {type = "str", default = nil},
    -- (Was .saddlebag, a boolean value)
    -- If the mob has been given a saddle-bag by a player, the name of the saddle-bag (e.g.
    --      "unilib:item_saddlebag_normal"); otherwise nil
    saddlebag_name = {type = "str", default = nil},
    -- Code in petz_mount.lua creates a single detached inventory for saddle-bags; when that
    --      inventory is visible (for example, when the player clicks the saddle-bag icon in the
    --      mob's main formspec), the detached inventory is populated with the contents of this
    --      table
    saddlebag_inventory = {type = "table", default = {}},
    -- (Was .max_speed_forward)
    -- Current forward speed for a mounted mob (e.g. a pony); described in the original code as a
    --      "maximum", but it's really more of a speed limit (since adding horseshoes can increase
    --      this value)
    -- Note that the original value (enuncumbered by the presence of horseshoes) for this property
    --      and for .mounted_reverse_speed, .mounted_speed_boost can be found in self.genetic_table
    -- Note that the range of values for this property and for .mounted_reverse_speed,
    --      .mounted_speed_boost is specified by the setting .max_mounted_speed (10 by default)
    mounted_forward_speed = {type = "num", default = 1},
    -- (Was .max_speed_reverse)
    -- Current reverse speed for a mounted mob (e.g. a pony)
    mounted_reverse_speed = {type = "num", default = 1},
    -- (Was .accel)
    -- Speed boost/penalty for a mounted mob (e.g. a pony). Despite its original name, it is an
    --      increase/decrease in velocity, not an actual acceleration. It is used, for example, to
    --      set a higher speed when galloping
    mounted_speed_boost = {type = "num", default = 1},

    -- (Mounted mob gallop properties)

    -- (Was .gallop)
    -- True when a mounted pony (etc) is is gallop mode (is moving more quickly than usual); false
    ---     otherwise
    -- N.B. As explained in the comments in reinitialise_old_mob(), these properties are not set
    --      using unimobs.mobkit_api.add_mob_memory()
    gallop_mode_flag = {type = "bool", default = false},
    -- (Was .gallop_time)
    -- How long (in seconds) the pony (etc) has been in gallop mode; when the value exceeds
    --      unimobs.petz_setting.max_gallop_time, gallop mode is disabled (and
    --      .gallop_mode_exhaustion_flag is set to true)
    gallop_mode_time = {type = "num", default = 0},
    -- (Was .gallop_exhausted)
    -- Flag set to true when gallop mode is disabled; set back to false after
    --      unimobs.petz_setting.gallop_recovery_time has elapsed)
    gallop_mode_exhaustion_flag = {type = "bool", default = false},
    -- N.B. The original .gallop_recover_time property was not used anywhere in the original code,
    --      so it has been removed)
--  gallop_recovery_time = {type = "num", default = unimobs.petz_setting.gallop_recovery_time},

    -- (Skin properties)

    -- (Was .shaved)
    -- True if the mob has been sheared; value is set back to false when the shearing is reversed
    --      (e.g. when a sheep's wool grows back)
    -- N.B. Now a non-standard dynamic property, declared by the "mob_sheep_normal" package
--  has_been_sheared_flag = {type = "bool", default = false},
    -- (Was .colorized)
    -- Set by unimobs.petz_api.colourise_mob() and unimobs.petz_api.revert_mob_colourisation() when
    --      a mob is colourised (for example, by using dye on a sheep); otherwise nil
    -- Usually, a unilib standard dye colour like "red" or "green_dark", matching the colour group
    --      of the object used to colour the mob (e.g. the dye)
    -- N.B. Now a non-standard dynamic property, declared by the "mob_sheep_normal" package
--  modified_colour = {type = "str", default = nil},

    -- (Status properties)

    -- A string describing the mob's current state or behaviour; checking this single value is much
    --      simpler than examining both behaviour queues
    -- In original code, was set to the values "alight", "climb", "repel", "follow", "guard",
    --      "jump", "sleep" and "stand", or nil when none of those states apply
    status = {type = "str", default = nil},
    -- The previous value of .status, before the current value was set; used when that value needs
    --      to be restored at some point in the future
    -- In original code, it was used when .status was set to "sleep"
    previous_status = {type = "str", default = nil},

    -- (Tamagotchi mode properties)

    -- Value in the range 0-100, representing a tamed creature's love/loyalty for its owner; used
    --      only in Tamagotchi Mode
    affinity = {type = "num", default = 100},
    -- (Was .brushed)
    -- True for any mob which the player has groomed with some kind of brush. In the original code,
    --      referred to the item that is now "unilib:item_hairbrush"; in unimobs, it's available for
    --      any comparable brush
    brush_applied_flag = {type = "bool", default = false},
    -- (Was .init_tamagochi_timer, moved from petz_register.lua)
    -- Flag set to true or false by various parts of the code, whenever the timer must be run
    --      (tamagotchi_mode_timer() in petz_tamagotchi.lua)
    -- Code below sets this flag to true, when the mob's .has_tamagotchi_mode_flag is true)
    init_tamagotchi_timer_flag = {type = "bool", default = false},
    -- (Was .lashed)
    -- True for any mob on which the player has applied some kind of lash. In the original code,
    --      referred to the item that is now "unilib:item_whip_obedience"; in unimobs, it's
    --      available for any compatible lash
    lash_applied_flag = {type = "bool", default = false},
    -- (Was .lashing_count)
    -- Number of times the mob must still be lashed, in order to tame it; when the value reaches 0,
    --      the mob is tamed (and the value is set back to the maximum, ready for future lashing in
    --      case the owner abandons their tamed creature)
    lash_countdown = {type = "num", default = unimobs.petz_setting.default_lash_count},
    -- (Was .beaver_oil_applied)
    -- True for any mob which the player has groomed with some kind of lotion (as an alternative to
    --      brushing). In the original code, referred to beaver oil; in unimobs, it's available for
    --      any comparable lotion. Compare the .brush_applied_flag property
    lotion_applied_flag = {type = "bool", default = false},
    -- (Was .fed)
    -- Used in Tamagotchi Mode (only); true when the mob has been recently fed, false otherwise
    has_been_fed_flag = {type = "bool", default = true},

    -- (Trade properties)

    -- (Was .for_sale)
    -- True when the tamed mob has been marked as "for sale" by its owner
    for_sale_flag = {type = "bool", default = false},
    -- (Was .exchange_item_index)
    -- An index in unimobs.petz_setting.trade_item_list, corresponding to the item that a mob's
    --      owner wants, in exchange for the mob (when it has been marked as "for sale")
    trade_item_index = {type = "num", default = 1},
    -- (Was .exchange_item_amount)
    -- The amount of items the mob's owner wants, in exchange for the mob (when it has been marked
    --      as "for sale")
    trade_item_amount = {type = "num", default = 1},

}

-- Lookup table of value types used in "dynamic_prop_table"
local prop_type_table = {
    bool = true,
    entity = true,
    num = true,
    player = true,
    pos = true,
    ["str"] = true,
    ["table"] = true,
}

---------------------------------------------------------------------------------------------------
-- Local functions - initialise new mobs (from petz/petz/api/api_init_prop.lua)
---------------------------------------------------------------------------------------------------

local function set_random_gender(self)

    -- Adapted from code in petz.set_initial_properties()
    -- Sets the value of self.is_male_flag

    local is_male_flag = false
    if random(1, 2) == 1 then
        is_male_flag = true
    end

    self.is_male_flag = unimobs.mobkit_api.add_mob_memory(self, "is_male_flag", is_male_flag)

end

local function get_random_skin(self, chance_total, skin_compound_list)

    -- Original to unimobs
    -- Choose a random skin, returning the skin number
    -- In case of failure, choose the first skin as a fallback

    -- Choose a skin at random
    local rnd = random() * chance_total
    for i, mini_list in ipairs(skin_compound_list) do

        if rnd < mini_list[2] then
            return mini_list[1]
        end

    end

    -- Emergency fallback
    return 1

end

local function set_inherited_skin(
    self, static_data_table, born_as_baby_flag, chance_total, skin_compound_list, mutation_list
)
    -- Adapted from code in petz.set_initial_properties()
    -- Choose a skin, taking into account the mob's parents (if any). On rare occasions, select a
    --      random mutation (ignoring the traits of the mob's parents)
    -- In case of failure, do not set any skin; the subsequent call to set_random_skin() will choose
    --      one
    --
    -- In petz/unimobs, skin inheritance works like this:
    --
    -- Every mob has two skin "genes", which we call A and B
    -- For naturally-spawning mobs, the genes are selected at random, so some mobs will have
    --      identical A and B genes (this happens more often, for mobs that have fewer available
    --      skins)
    -- For mobs produced by breeding, the A gene is inherited from the father, and the B gene is
    --      inherited from the mother. When inheriting the gene, one of the parent's genes is chosen
    --      at random (so a baby's A gene may be inherited from the father's B gene, or his A gene)
    -- When selecting a random mutation, inheritance is ignored; the mutation skin is chosen at
    --      random from those available
    --
    -- When it's time to assign a visible skin to a mob, a skin matching the A or B gene is chosen
    --      at random; the other gene is not used (but it still passed to any offspring)

    -- Decide whether a mutation skin should be used in this case
    local genetic_mutation_flag = false
    if #mutation_list > 0 then

        local mutation_chance = unimobs.petz_setting.mutation_chance

        -- Increase the chance of a mutation according to the "variability" gene
        local genetic_value = self.genetic_table["variability"]
        local data_table = unimobs.petz_api.get_genetic_range_table(self, "variability")
        if genetic_value ~= nil and genetic_value > 0 and data_table ~= nil then

            local improve_factor = unimobs.petz_setting.genetic_variability_factor * (
                (genetic_value - data_table.overall_min) /
                (data_table.overall_max - data_table.overall_min)
            )

            mutation_chance = ceil(mutation_chance * (1 - improve_factor))

        end

        if random(1, mutation_chance) == 1 then
            genetic_mutation_flag = true
        end

    end

    -- (The "genes" are actually numbers, representing the number of the corresponding skin)
    local skin_a_num, skin_b_num

    if not genetic_mutation_flag then

        -- Select a normal skin
        if not born_as_baby_flag or static_data_table.genetic_table == nil then

            skin_a_num = get_random_skin(self, chance_total, skin_compound_list)
            skin_b_num = get_random_skin(self, chance_total, skin_compound_list)

        else

            if random(1, 2) == 1 then
                skin_a_num = static_data_table.genetic_table.father_skin_a_num
            else
                skin_a_num = static_data_table.genetic_table.father_skin_b_num
            end

            if random(1, 2) == 1 then
                skin_b_num = static_data_table.genetic_table.mother_skin_a_num
            else
                skin_b_num = static_data_table.genetic_table.mother_skin_b_num
            end

        end

        -- Choose one of the "genes" for this mob's skin
        -- Original code chose whichever skin appeared first in the list
        -- In unimobs, each skin already has a probability associated with it, and that probability
        --  `   has already been taken into account (during the call to get_random_skin() )
        -- Therefore, we can assign each gene a 50% chance
        if random(1, 2) == 1 then
            self.mob_texture_num = skin_a_num
        else
            self.mob_texture_num = skin_b_num
        end

    else

        -- Select a mutation skin
        local mutation_num = #skin_compound_list + random(1, #mutation_list)

        skin_a_num = mutation_num
        skin_b_num = mutation_num
        self.mob_texture_num = mutation_num

    end

    unimobs.petz_api.set_heritable_traits(
        self,
        {skin_a_num = skin_a_num, skin_b_num = skin_b_num}
    )

end

local function parse_skin_init_list(skin_init_list)

    -- Original to unimmobs
    -- Parse the specified "skin_init_list", whose format is described in the comments in
    --      set_skin()
    -- Returns three values to be used as arguments in calls to other functions (and which are also
    --      described in the comments to set_skin() )

    local skin_compound_list = {}
    local mutation_list = {}
    local chance_total = 0

    for i, mini_list in ipairs(skin_init_list) do

        if mini_list[3] > 0 then

            chance_total = chance_total + mini_list[3]
            table.insert(skin_compound_list, {i, chance_total})

        else

            table.insert(mutation_list, mini_list[1])

        end

    end

    return chance_total, skin_compound_list, mutation_list

end

local function set_skin(self, static_data_table, born_as_baby_flag)

    -- Adapted from code in petz.set_initial_properties()
    -- Sets the value of self.mob_texture_num, as well as handling skin inheritance

    -- Import the initial list of skins for this mob and their relative probabilities
    if not unimobs.petz_global.mob_table[self.mob_type] or
            not unimobs.petz_global.mob_table[self.mob_type]["skin_init_list"] then

        -- Emergency fallback
        self.mob_texture_num = 1
        return

    end

    -- List of mini-lists, each one representing a different skin
    -- Each mini-list is in the form
    --      { skin_type, displayable_skin_name, relative_probability }
    -- The "relative_probability" determines how often each skin will generate in naturally-spawning
    --      mobs. Any values may be used, but most unimobs use 1 for common skins, and fractional
    --      values for less common skins (0.5, 0.1, 0.05, 0.01 etc)
    -- Some skins are "rare mutations", meaning that they never occur in naturally-spawning mobs,
    --      and occur only rarely as a result of breeding (at the rate specified by the setting
    --      unimobs.mutation_chance)
    -- In these mini-lists, rare mutations are marked with a "relative_probability" of 0, meaning
    --      that are never assigned by this function
    -- Note that the mini-lists should be ordered by probability, such that the most probably skins
    --      are listed first, the least probable last (and any mutations occur at the end of the
    --      list)
    local skin_init_list = unimobs.petz_global.mob_table[self.mob_type]["skin_init_list"]

    -- Compile a weighted list of skins and their compound probabilities
    -- "skin_compound_list" is a list of mini-lists, each in the form
    --      { skin_num, compound_probability }
    -- For example,
    --      First skin has "relative_probability" of 1, so "compound_probability" is 1
    --      Second skin has "relative_probability" of 0.5, so "compound_probability" is
    --          1 + 0.5 = 1.5
    --      Third skin has "relative_probability" of 0.1, so "compound_probability" is
    --          1.5 + 0. = 1.6
    --      Fourth skin has "relative_probability", meaning it's a mutation; so it is NOT added to
    --          this list
    --      Then we can select one skin at random, by choosing a random value between 0 and
    --          "chance_total", 1.6
    -- We also receive a separate list of mutation skin numbers (may be an empty list)
    local chance_total, skin_compound_list, mutation_list = parse_skin_init_list(skin_init_list)

    -- For mobs that can breed, skins are an inheritable trait
    if self.can_breed_flag then

        set_inherited_skin(
            self,
            static_data_table,
            born_as_baby_flag,
            chance_total,
            skin_compound_list,
            mutation_list
        )

    end

    -- If no skin has been set, choose one at random
    if not self.mob_texture_num then
        self.mob_texture_num = get_random_skin(self, chance_total, skin_compound_list)
    end

    -- Set the memory to the match the value of the property
    self.mob_texture_num = unimobs.mobkit_api.add_mob_memory(
        self, "mob_texture_num", self.mob_texture_num or 1
    )

end

local function set_genetics(self)

    -- Original to unimobs
    -- For naturally-spawning mobs, set the initial values of other heritable traits

    -- Import the initial list of genetics for this mob
    if not unimobs.petz_global.mob_table[self.mob_type] or
            not unimobs.petz_global.mob_table[self.mob_type]["genetic_init_list"] then
        return
    end

    -- List of mini-lists, each one representing a different "gene" and its initial values (skins
    --      are handled by the earlier call to set_skin() )
    -- Each mini-list is in the form
    --      { gene_type, gene_name, "default", initial_value }
    --      { gene_type, gene_name, "list", list_of_initial_values }
    --      { gene_type, gene_name, "range", initial_min, initial_max, overall_min, overall_max }
    -- All values are compulsory, except "overall_min" (default minimum is 0) and "overall_max"
    --      (default maximum is unlimited)
    -- "gene_type" is a unique name for the gene
    -- "gene_name" is a translated string suitable for display in formspecs. The default form of
    --      each gene's "gene_name" is listed below, but each mob can use any string for its
    --      "gene_name" (e.g. frogs use "Sliminess" to describe their luckiness gene)
    -- For hidden genes, use nil (or an empty string) as the "gene_name"
    --
    -- Genes have been divided arbitrarily into two types, standard and custom. In general, standard
    --      genes apply to multiple types of creature and are used by unimobs system code. In
    --      general, custom genes apply to a single type of creature and are used only by that
    --      creature's package code. (These are not hard rules.)
    -- All standard genes are listed below:
    --
    --      generic                     [Generic trait]
    --          Can be used by any creature for a gene that doesn't affect the creature's behaviour
    --              in any way (it's up to the player to discover which genes actually modify the
    --              creature's behaviour). To add additional generic genes for a particual mob, just
    --              call them "generic_2", "generic_3" and so on "generic"
    --
    --
    --      agility                     [Agility]
    --          Used by any suitable creature. Increases the mob's maximum speed (the increase being
    --              specified by unimobs.petz_setting.genetic_agility_factor). Mounted speeds have
    --              separate genes, so they are not affected by the "agility" gene
    --      compliance                  [Compliance]
    --          Used by suitable mobs whose .is_wild_flag is true. Reduces the number of lashes
    --              required for creatures to be tamed. A mob with maximum compliance has the number
    --              reduced by a factor of 0.67 by default (specified by
    --              unimobs.petz_setting.genetic_compliance_factor)
    --      digestion                   [Digestion]
    --          Used by any suitable creature. Reduces the amount of food items required for
    --              creatures to be tamed, converted or to replace nodes (e.g. eat grass). A mob
    --              with maximum digestion has the amount reduced by a factor of 0.4 by default
    --              (specified by unimobs.petz_setting.genetic_digestion_factor)
    --      docility                    [Docility]
    --          Used by any suitable creature. Sets the chance that a tamed (female) adult will give
    --              birth to a tamed baby (the default behaviour is for the baby to be untamed).
    --              Ignored when unimobs.petz_setting.enable_genetic_docility_flag is false, in
    --              which case all tamed mothers produce tamed babies
    --      fertility                   [Fertility]
    --          Used by any suitable creature. Reduces the time interval for pregnancy and growth.
    --              A mob with maximum fertility has the interval reduced by a factor of 0.33 by
    --              default (specified by unimobs.petz_setting.genetic_fertility_factor). Also
    --              increases the maximum number of pregnancies
    --      incontinence                [Incontinence]
    --          Used by any creature that produces dung. Increases the rate at which dung is
    --              produced (the improvement is specified by
    --              unimobs.petz_setting.genetic_incontinence_factor)
    --      loftiness                   [Loftiness]
    --          Used by any suitable creature (including climbing creatures like chimps, as well as
    --              birds). Increases the mob's maximum roaming height (the increase being specified
    --              by unimobs.petz_setting.genetic_loftiness_factor)
    --      luckiness                   [Luckiness]
    --          Used by any suitable creature, but should probably be used for a smaller range of
    --              creatures than other genes (e.g. cats are lucky, but dogs are not). Improves the
    --              probability of a ranged gene receiving a +1 bonus when a baby is produced (the
    --              improvement is specified by unimobs.petz_setting.genetic_luckiness_factor)
    --      mounted_forward_speed       [Forward speed when mounted]
    --      mounted_reverse_speed       [Reverse speed when mounted]
    --      mounted_speed_boost         [Speed boost when mounted]
    --          Used by mounted creatures (ponies and camels) to vary the creature's speed while
    --              mounted
    --          The "speed boost" is a number, a proportion of which is added to the creature's
    --              velocity - 100% when galloping, 50% when riding forwads, 25% when riding
    --              backwards
    --      perception                  [Perception]
    --          Should be used sparingly with creatures with good eyesight - wolves, lions, maybe
    --              even dogs. Increases the mob's view range (the increase being specified by
    --              unimobs.petz_setting.genetic_perception_factor
    --      productivity                [Productivity]
    --          Used by any creature that lays eggs. Improves the probability of laying an egg,
    --              whenever it's possible to lay one (the improvement is specified by
    --              unimobs.petz_setting.genetic_productivity_factor). The value also increases the
    --              maximum number of eggs that can be laid. When used, should be used with both
    --              males, females and babies. Cannot be used with ants
    --      springiness                 [Springiness]
    --          Should be used sparingly with creatures which jump a lot - frogs, kangaroos, maybe
    --              even cats - because it might allow a mob to escape an enclosure constructed for
    --              it by players. Increases the mob's jump height (the increase being specified by
    --              unimobs.petz_setting.genetic_springiness_factor)
    --      toughness                   [Toughness]
    --          Used by any suitable creature. Increases the mob's maximum HP (the increase being
    --              specified by unimobs.petz_setting.genetic_toughness_factor)
    --      variability                 [Genetic variability]
    --          Used by any creature that has mutations. Improves the probability of a mutation
    --              occuring when a baby is produced (the improvement is specified by
    --              unimobs.petz_setting.genetic_variability_factor)
    --
    -- All custom genes used by unimobs are listed below. If you write new packages, you can specify
    --      new genes; in that case, the "gene_type" should start with an underline to prevent name
    --      clashes with future versions of unimobs (which will not use names starting with
    --      underlines)
    --
    --      woolliness                  [Woolliness]
    --          Used by sheep. The higher the value, the greater the chance that shearing the sheep
    --              will produce multiple wools

    local genetic_init_list = unimobs.petz_global.mob_table[self.mob_type]["genetic_init_list"]

    -- Compile this mob's table of genetics
    local genetic_table = {}
    for _, mini_list in ipairs(genetic_init_list) do

        local gene_type = mini_list[1]
        local category = mini_list[3]

        if category == "default" and mini_list[4] ~= nil then

            genetic_table[gene_type] = mini_list[4]

        elseif category == "list" and mini_list[4] ~= nil and type(mini_list[4]) == "table" then

            local index = random(1, #mini_list[4])
            genetic_table[gene_type] = mini_list[4][index]

        elseif category == "range" and mini_list[4] ~= nil and mini_list[5] ~= nil then

            genetic_table[gene_type] = random(mini_list[4], mini_list[5])

        end

    end

    -- Store the genetics
    unimobs.petz_api.set_heritable_traits(self, genetic_table)

end

local function initialise_new_mob(self, static_data_table, born_as_baby_flag)

    -- Adapted from code in petz.set_initial_properties()
    -- Sets the initial properties for a mob, in the following situation:
    --      1. A new mob has spawned (because of a call to unimobs.petz_api.spawn_mob() )

    -- Import the default values for all "dynamic" mob properties
    for prop_name, mini_table in pairs(dynamic_prop_table) do

        -- N.B. Fixed disastrous bug in original code, in which table properties in
        --      "dynamic_prop_table" specified an empty table, which was then shared by all mobs
        -- Note that the initial value of a table property may be an empty table or nil, so we must
        --      check for that
        if mini_table.type == "table" and type(mini_table.default) == "table" then
            self[prop_name] = {}
        else
            self[prop_name] = mini_table.default
        end

    end

    -- Set the current code version for the mob
    local version = unimobs.petz_global.mob_table[self.mob_type]["version"]
    if version then
        self["version"] = version
    end

    -- Set a random gender for any mob whose gender is not specified by the entity definition (and
    --      is therefore fixed, e.g. queen bees, female elephants)
    -- N.B. The override table is specified when some code wants to create a mob with pre-defined
    --      characteristics (see the "admin_tool_mob_spawner" package for an example)
    if static_data_table and
            static_data_table.override_table and
            static_data_table.override_table.is_male_flag ~= nil then
        self.is_male_flag = static_data_table.override_table.is_male_flag
    elseif self.is_male_flag == nil then
        set_random_gender(self)
    end

    -- Set the mob's skin
    if static_data_table and
            static_data_table.override_table and
            static_data_table.override_table.mob_texture_num ~= nil then
        self.mob_texture_num = static_data_table.override_table.mob_texture_num
    else
        set_skin(self, static_data_table, born_as_baby_flag)
    end

    -- For naturally-spawning mobs, set the initial values of other heritable traits
    if not born_as_baby_flag then

        set_genetics(self)
        unimobs.petz_api.update_mob_properties_from_genetics(self)

    else

        -- Set up the mob's conversion countdown property, using either the value supplied by
        --      mob_settings.csv (if any), or the default value (if not)
        self.convert_countdown = unimobs.mobkit_api.add_mob_memory(
            self,
            "convert_countdown",
            (
                unimobs.petz_api.get_msetting(self.mob_type, "custom_convert_count") or
                unimobs.petz_setting.default_convert_count
            )
        )

        -- Set the mob's feed/tame countdown property
        self.feed_countdown = unimobs.mobkit_api.add_mob_memory(
            self,
            "feed_countdown",
            (
                unimobs.petz_api.get_msetting(self.mob_type, "custom_tame_count") or
                unimobs.petz_setting.default_tame_count
            )
        )

    end

    -- Initialise Tamagotchi Mode
    if self.init_tamagotchi_timer_flag then
        unimobs.petz_api.init_tamagotchi_timer(self)
    end

    -- Initialise sleep cycles
    unimobs.petz_api.calculate_sleep_times(self)

end

---------------------------------------------------------------------------------------------------
-- Local functions - reinitialise/recover old mobs (from petz/petz/api/api_init_prop.lua)
---------------------------------------------------------------------------------------------------

local function reinitialise_old_mob(self, static_data_table)

    -- Adapted from code in petz.set_initial_properties(), load_vars() and .cleanup_prop()
    -- Sets the initial properties for a mob, in the following situation:
    --      2. A mob already exists (must be re-initialised because the game has just re-started)

    -- If this mob has marked for removal in settings, then remove it
    for _, item in ipairs(unimobs.petz_global.mob_remove_list) do

        if item == self.mob_type then

            self.object:remove()
            return

        end

    end

    -- Restore the values of dynamic properties, using either the values stored in the mob's memory
    --      or the default values specified above
    for prop_name, mini_table in pairs(dynamic_prop_table) do

        -- N.B. Fixed disastrous bug in original code, in which table properties in
        --      "dynamic_prop_table" specified an empty table, which was then shared by all mobs
        -- Note that the initial value of a table property may be an empty table or nil, so we must
        --      check for that
        self[prop_name] = unimobs.mobkit_api.recall_mob_memory(self, prop_name)
        if not self[prop_name] then

            if mini_table.type == "table" and type(mini_table.default) == "table" then
                self[prop_name] = {}
            else
                self[prop_name] = mini_table.default
            end

        end

    end

    -- Apply mob code changes
    local version = unimobs.petz_global.mob_table[self.mob_type]["version"]
    if version > self["version"] then

        -- At the moment, there are no changes to apply; here is some sample code using an imaginary
        --      mob property
        --[[
        if self.mob_type == "goat_normal" then
            self.fluffiness = "very"
        end
        ]]--

        self["version"] = version

    end

    -- Reset sleep start/end times for any mobs that need it
    if not self.sleep_start_time or not self.sleep_end_time then
        unimobs.petz_api.calculate_sleep_times(self)
    end

    -- Reset attack warnings. As these flags are reset on every restart, there's no need to use
    --      unimobs.mobkit_api.add_mob_memory()
    self.was_attacked_by_player_flag = false
    self.was_killed_by_player_flag = false

    -- The values of a few non-dynamic properties are changed because of genetics; they're not saved
    --      when the game shuts down, so the changes must be re-applied on every restart
    if self.genetic_table["agility"] then
        unimobs.petz_api.update_max_speed_from_genetics(self)
    end
    if self.genetic_table["loftiness"] then
        unimobs.petz_api.update_max_roam_height_from_genetics(self)
    end
    if self.genetic_table["perception"] then
        unimobs.petz_api.update_view_range_from_genetics(self)
    end
    if self.genetic_table["springiness"] then
        unimobs.petz_api.update_jump_height_from_genetics(self)
    end
    if self.genetic_table["toughness"] then
        unimobs.petz_api.update_max_hp_from_genetics(self)
    end

    -- Remove the mob's driver and/or attached wagon. As this happens whenever the game restarts,
    --      it's not necessary to set self.driver or self.wagon (and other related properties) using
    --      unimobs.mobkit_api.add_mob_memory()
    self.driver = nil
    self.wagon = nil

    -- If no mob texture has been set, use the emergency fallback one
    if not self.mob_texture_num then
        self.mob_texture_num = unimobs.mobkit_api.add_mob_memory(self, "mob_texture_num", 1)
    end

end

local function recover_old_mob_from_spawnegg(self, static_data_table)

    -- Adapted from code in petz.set_initial_properties()
    -- Sets the initial properties for a mob, in the following situation:
    --      3. A spawn egg has been placed (must be converted into a mob, and its metadata
    --          transferred to the new mob)

    -- Mark the mob as no longer being in a captured state
    self.is_captured_flag = unimobs.mobkit_api.add_mob_memory(self, "is_captured_flag", false)

    -- Restore the values of dynamic properties, temporarily stored as the spawn egg's metadata
    for prop_name, mini_table in pairs(dynamic_prop_table) do

        local prop_value
        if mini_table["type"] == "str" then

            prop_value = static_data_table["memory_table"][prop_name]

        -- N.B. Original code used the type "int", but some properties are now fractional
        elseif mini_table["type"] == "num" then

            prop_value = tonumber(static_data_table["memory_table"][prop_name])

        elseif mini_table["type"] == "bool" then

            prop_value = core.is_yes(static_data_table["memory_table"][prop_name])

        elseif mini_table["type"] == "table" then

            prop_value = static_data_table["memory_table"][prop_name]

        -- N.B. Original code did not check for "pos"; of course it doesn't matter, because
        --      "prop_value"'s value does not change
--      elseif mini_table["type"] == "player" or mini_table["type"] == "pos" then
--          prop_value = nil

        end

        -- N.B. Fixed disastrous bug in original code, in which table properties in
        --      "dynamic_prop_table" specified an empty table, which was then shared by all mobs
        self[prop_name] = unimobs.mobkit_api.add_mob_memory(self, prop_name, prop_value)
        if not self[prop_name] then

            -- Note that the initial value of a table property may be an empty table or nil, so we
            --      must check for that
            if mini_table.type == "table" and type(mini_table.default) == "table" then
                self[prop_name] = {}
            else
                self[prop_name] = mini_table.default
            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Local functions - other (from petz/petz/api/api_init_prop.lua)
---------------------------------------------------------------------------------------------------

local function set_entity_texture(self)

    -- Adapted from code in petz.set_initial_properties()
    -- The mob's skin having been chosen, we can now set the entity's texture

    -- Compose the texture
    local texture = unimobs.petz_api.compose_skin_texture(self)

    -- Apply the texture
    local prop_table = {}
    prop_table.textures = {texture}
    self.object:set_properties(prop_table)

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (original to unimobs)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.add_dynamic_property(prop_name, prop_type, default_val)

    -- Original to unimobs
    -- Called by mob packages to add a property to "dynamic_prop_table" (the standard table of
    --      dynamic properties)
    -- Duplicate "prop_name" values are ignored
    -- "prop_type" should be one of the following values: "bool", "entity", "num", "player", "pos",
    --      "str" or "table"; if another type is specified, the property is ignored
    -- Note that "num" replaces the original code's "int"

    if dynamic_prop_table[prop_name] == nil and prop_type_table[prop_type] ~= nil then
        dynamic_prop_table[prop_name] = {type = prop_type, default = default_val}
    end

end

function unimobs.petz_api.register_initial_extension(mob_type, callback)

    -- Original to unimobs
    -- Called by any package which wants to extend the standard behaviour, when a mob's initial
    --      properties are being set

    if extension_table[mob_type] == nil then
        extension_table[mob_type] = { callback }
    else
        table.insert(extension_table[mob_type], callback)
    end

end

function unimobs.petz_api.adjust_mounted_value(self, gene_type)

    -- Original to unimobs
    -- A mounted creature's speed is represented as a value in the range 0-10, by default (the
    --      setting .max_mounted_speed specifies the limit of 10)
    -- However, the values stored in the creature's .genetic_table have an arbitrary minimum and
    --      maximum (so the range might be 0-10, or perhaps 0-12, or perhaps 10-25)
    -- This function converts a value in this arbitrary range, into a value in the range 0-10 (or
    --      whatever the maximum specified by the setting is)

    local genetic_speed = self.genetic_table[gene_type]
    local data_table = unimobs.petz_api.get_genetic_range_table(self, gene_type)
    if data_table == nil then

        -- Emergency fallback
        return 1

    end

    local factor = (data_table.overall_max - data_table.overall_min) /
            unimobs.petz_setting.max_mounted_speed
    return (genetic_speed - data_table.overall_min) / factor

end

function unimobs.petz_api.update_convert_countdown_from_genetics(self)

    -- Original to unimobs
    -- Called by unimobs.petz_api.update_mob_properties_from_genetics(), and by code in
    --      reinitialise_old_mob() in order to set the property back to its correct value

    local genetic_value = self.genetic_table["digestion"]
    local data_table = unimobs.petz_api.get_genetic_range_table(self, "digestion")
    if genetic_value ~= nil and genetic_value > 0 and data_table ~= nil then

        local max_countdown =
                unimobs.petz_api.get_msetting(self.mob_type, "custom_convert_count") or
                unimobs.petz_setting.default_convert_count

        local reduction_factor = unimobs.petz_setting.genetic_digestion_factor * (
            (genetic_value - data_table.overall_min) /
            (data_table.overall_max - data_table.overall_min)
        )

        self.convert_countdown = unimobs.mobkit_api.add_mob_memory(
            self,
            "convert_countdown",
            ceil(max_countdown * (1 - reduction_factor))
        )

    end

end

function unimobs.petz_api.update_feed_countdown_from_genetics(self)

    -- Original to unimobs
    -- Called by unimobs.petz_api.update_mob_properties_from_genetics(), and by
    --      unimobs.kitz_api.tame_mob() when a creature is tamed, in order to reset the property
    --      from 0 to its original (maximum) value

    local genetic_value = self.genetic_table["digestion"]
    local data_table = unimobs.petz_api.get_genetic_range_table(self, "digestion")
    if genetic_value ~= nil and genetic_value > 0 and data_table ~= nil then

        local max_countdown =
                unimobs.petz_api.get_msetting(self.mob_type, "custom_tame_count") or
                unimobs.petz_setting.default_tame_count

        local reduction_factor = unimobs.petz_setting.genetic_digestion_factor * (
            (genetic_value - data_table.overall_min) /
            (data_table.overall_max - data_table.overall_min)
        )

        self.feed_countdown = unimobs.mobkit_api.add_mob_memory(
            self,
            "feed_countdown",
            ceil(max_countdown * (1 - reduction_factor))
        )

    end

end

function unimobs.petz_api.update_jump_height_from_genetics(self)

    -- Original to unimobs
    -- Called by unimobs.petz_api.update_mob_properties_from_genetics(), and by code in
    --      reinitialise_old_mob() in order to set the property back to its correct value

    local genetic_value = self.genetic_table["springiness"]
    local data_table = unimobs.petz_api.get_genetic_range_table(self, "springiness")
    -- (The default value listed in unimobs.petz_api.register_standard_mob() is 1)
    if genetic_value ~= nil and
            genetic_value > 0 and
            data_table ~= nil and
            self.jump_height ~= nil and
            self.jump_height > 1 then

        local ratio = unimobs.petz_setting.genetic_springiness_factor * (
            (genetic_value - data_table.overall_min) /
            (data_table.overall_max - data_table.overall_min)
        )

        self.jump_height = self.jump_height + (self.jump_height * ratio)

    end

end

function unimobs.petz_api.update_lash_countdown_from_genetics(self)

    -- Original to unimobs
    -- Called by unimobs.petz_api.update_mob_properties_from_genetics(), and by
    --      unimobs.petz_api.tame_mob_with_lash() when a creature is tamed, in order to reset the
    --      property from 0 to its original (maximum) value

    local genetic_value = self.genetic_table["compliance"]
    local data_table = unimobs.petz_api.get_genetic_range_table(self, "compliance")
    if genetic_value ~= nil and genetic_value > 0 and data_table ~= nil then

        local reduction_factor = unimobs.petz_setting.genetic_compliance_factor * (
            (genetic_value - data_table.overall_min) /
            (data_table.overall_max - data_table.overall_min)
        )

        self.lash_countdown = unimobs.mobkit_api.add_mob_memory(
            self,
            "lash_countdown",
            ceil(unimobs.petz_setting.default_lash_count * (1 - reduction_factor))
        )

    end

end

function unimobs.petz_api.update_max_hp_from_genetics(self)

    -- Original to unimobs
    -- Called by unimobs.petz_api.update_mob_properties_from_genetics(), and by code in
    --      reinitialise_old_mob() in order to set the property back to its correct value

    local genetic_value = self.genetic_table["toughness"]
    local data_table = unimobs.petz_api.get_genetic_range_table(self, "toughness")
    -- (The default value listed in unimobs.petz_api.register_standard_mob() is 10)
    if genetic_value ~= nil and
            genetic_value > 0 and
            data_table ~= nil and
            self.max_hp ~= nil and
            self.max_hp > 10 then

        local ratio = unimobs.petz_setting.genetic_agility_factor * (
            (genetic_value - data_table.overall_min) /
            (data_table.overall_max - data_table.overall_min)
        )

        self.max_hp = ceil(self.max_hp + (self.max_hp * ratio))

    end

end

function unimobs.petz_api.update_max_roam_height_from_genetics(self)

    -- Original to unimobs
    -- Called by unimobs.petz_api.update_mob_properties_from_genetics(), and by code in
    --      reinitialise_old_mob() in order to set the property back to its correct value

    local genetic_value = self.genetic_table["loftiness"]
    local data_table = unimobs.petz_api.get_genetic_range_table(self, "loftiness")
    -- (The default value listed in unimobs.petz_api.register_standard_mob() is 5, but some
    --      creatures use negative values)
    if genetic_value ~= nil and
            genetic_value > 0 and
            data_table ~= nil and
            self.max_roam_height ~= nil and
            self.max_roam_height ~= 0 then

        local ratio = unimobs.petz_setting.genetic_loftiness_factor * (
            (genetic_value - data_table.overall_min) /
            (data_table.overall_max - data_table.overall_min)
        )

        self.max_roam_height = ceil(self.max_roam_height + (self.max_roam_height * ratio))

    end


end

function unimobs.petz_api.update_max_speed_from_genetics(self)

    -- Original to unimobs
    -- Called by unimobs.petz_api.update_mob_properties_from_genetics(), and by code in
    --      reinitialise_old_mob() in order to set the property back to its correct value

    local genetic_value = self.genetic_table["agility"]
    local data_table = unimobs.petz_api.get_genetic_range_table(self, "agility")
    -- (The default value listed in unimobs.petz_api.register_standard_mob() is 1)
    if genetic_value ~= nil and
            genetic_value > 0 and
            data_table ~= nil and
            self.max_speed ~= nil and
            self.max_speed > 1 then

        local ratio = unimobs.petz_setting.genetic_agility_factor * (
            (genetic_value - data_table.overall_min) /
            (data_table.overall_max - data_table.overall_min)
        )

        self.max_speed = self.max_speed + (self.max_speed * ratio)

    end

end

function unimobs.petz_api.update_pregnancy_countdown_from_genetics(self)

    -- Original to unimobs
    -- Called by unimobs.petz_api.update_mob_properties_from_genetics(), and by code in
    --      reinitialise_old_mob() in order to set the property back to its correct value

    local genetic_value = self.genetic_table["fertility"]
    local data_table = unimobs.petz_api.get_genetic_range_table(self, "fertility")
    if genetic_value ~= nil and genetic_value > 0 and data_table ~= nil then

        -- Don't increase the maximum pregnancy count unless the mob's fertility is at least 50% of
        --      its maximum value
        local ratio = (genetic_value - data_table.overall_min) /
                (data_table.overall_max - data_table.overall_min)
        if ratio >= 0.5 then

            local increase = ceil(
                unimobs.petz_setting.default_pregnancy_count *
                unimobs.petz_setting.genetic_fertility_factor *
                ratio
            )

            self.pregnancy_countdown = unimobs.mobkit_api.add_mob_memory(
                self,
                "pregnancy_countdown",
                unimobs.petz_setting.default_pregnancy_count + increase
            )

        end

    end

end

function unimobs.petz_api.update_replace_countdown_from_genetics(self)

    -- Original to unimobs
    -- Called by unimobs.petz_api.update_mob_properties_from_genetics(), and by code in
    --      petz_replenish.lua (and similar package callbacks) when a creature is replenished, in
    --      order to reset the property from 0 to its original (maximum) value

    local genetic_value = self.genetic_table["digestion"]
    local data_table = unimobs.petz_api.get_genetic_range_table(self, "digestion")
    if genetic_value ~= nil and genetic_value > 0 and data_table ~= nil then

        local reduction_factor = unimobs.petz_setting.genetic_digestion_factor * (
            (genetic_value - data_table.overall_min) /
            (data_table.overall_max - data_table.overall_min)
        )

        self.replace_countdown = unimobs.mobkit_api.add_mob_memory(
            self,
            "replace_countdown",
            ceil(unimobs.petz_setting.default_replace_count * (1 - reduction_factor))
        )

    end

end

function unimobs.petz_api.update_view_range_from_genetics(self)

    -- Original to unimobs
    -- Called by unimobs.petz_api.update_mob_properties_from_genetics(), and by code in
    --      reinitialise_old_mob() in order to set the property back to its correct value

    local genetic_value = self.genetic_table["perception"]
    local data_table = unimobs.petz_api.get_genetic_range_table(self, "perception")
    -- (The default value listed in unimobs.petz_api.register_standard_mob() is 10)
    if genetic_value ~= nil and
            genetic_value > 0 and
            data_table ~= nil and
            self.view_range ~= nil and
            self.view_range > 10 then

        local ratio = unimobs.petz_setting.genetic_perception_factor * (
            (genetic_value - data_table.overall_min) /
            (data_table.overall_max - data_table.overall_min)
        )

        self.view_range = ceil(self.view_range + (self.view_range * ratio))

    end

end

function unimobs.petz_api.update_mob_properties_from_genetics(self)

    -- Original to unimobs
    -- Replaces the initial values of various mob properties, depending on the mob's .genetic_table

    -- "agility"
    if self.genetic_table["agility"] then
        unimobs.petz_api.update_max_speed_from_genetics(self)
    end

    -- "compliance"
    if self.genetic_table["compliance"] then
        unimobs.petz_api.update_lash_countdown_from_genetics(self)
    end

    -- "digestion"
    if self.genetic_table["digestion"] then

        unimobs.petz_api.update_feed_countdown_from_genetics(self)
        unimobs.petz_api.update_replace_countdown_from_genetics(self)
        unimobs.petz_api.update_convert_countdown_from_genetics(self)

    end

    -- "fertility"
    if self.genetic_table["fertility"] and not self.is_male_flag then
        unimobs.petz_api.update_pregnancy_countdown_from_genetics(self)
    end

    -- "loftiness"
    if self.genetic_table["loftiness"] then
        unimobs.petz_api.update_max_roam_height_from_genetics(self)
    end

    -- "mounted_forward_speed"
    -- "mounted_reverse_speed"
    -- "mounted_speed_boost"
    if self.is_mountable_flag then

        local speed_bonus =
                (self.horseshoe_count or 0) * unimobs.petz_setting.horseshoe_speed_increase

        if self.genetic_table["mounted_forward_speed"] then

            self.mounted_forward_speed = unimobs.mobkit_api.add_mob_memory(
                self,
                "mounted_forward_speed",
                unimobs.petz_api.adjust_mounted_value(self, "mounted_forward_speed") + speed_bonus
            )

        end

        if self.genetic_table["mounted_reverse_speed"] then

            self.mounted_reverse_speed = unimobs.mobkit_api.add_mob_memory(
                self,
                "mounted_reverse_speed",
                unimobs.petz_api.adjust_mounted_value(self, "mounted_reverse_speed") + speed_bonus
            )

        end

        if self.genetic_table["mounted_speed_boost"] then

            self.mounted_speed_boost = unimobs.mobkit_api.add_mob_memory(
                self,
                "mounted_speed_boost",
                unimobs.petz_api.adjust_mounted_value(self, "mounted_speed_boost") + speed_bonus
            )

        end

    end

    -- "perception"
    if self.genetic_table["perception"] then
        unimobs.petz_api.update_view_range_from_genetics(self)
    end

    -- "springiness"
    if self.genetic_table["springiness"] then
        unimobs.petz_api.update_jump_height_from_genetics(self)
    end

    -- "toughness"
    if self.genetic_table["toughness"] then

        unimobs.petz_api.update_max_hp_from_genetics(self)
        self.hp = unimobs.mobkit_api.add_mob_memory(self, "hp", self.max_hp)

    end

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_init_prop.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.set_mob_initial_properties(self, staticdata, dtime_s)

    -- From petz.set_initial_properties()
    -- Called by .on_activate() for each mob
    -- Sets the initial properties for a mob, in the following situations:
    --      1. A new mob has spawned (because of a call to unimobs.petz_api.spawn_mob() )
    --      2. A mob already exists (must be re-initialised because the game has just re-started)
    --      3. A spawn egg has been placed (must be converted into a mob, and its metadata
    --          transferred to the new mob)

    local static_data_table = core.deserialize(staticdata)

    local captured_mob_flag = false
    local born_as_baby_flag = false
    if static_data_table and
            static_data_table["memory"] and
            static_data_table["memory"]["is_captured_flag"] then
        captured_mob_flag = true
    elseif static_data_table and static_data_table["born_as_baby_flag"] then
        born_as_baby_flag = true
    end

    if not self.mob_texture_num and not captured_mob_flag then

        -- 1. A new mob has spawned
        initialise_new_mob(self, static_data_table, born_as_baby_flag)

    elseif not captured_mob_flag then

        -- 2. A mob already exists
        reinitialise_old_mob(self, static_data_table)

    else

        -- 3. A spawn egg has been placed
        recover_old_mob_from_spawnegg(self, static_data_table)

    end

    -- All properties having been restored, we can now check that the mob is not dead
    if self.is_dead_flag then

        self.object:remove()
        return

    end

    -- The mob's skin having been chosen, we can now set the entity's texture
    if self.mob_texture_num then
        set_entity_texture(self)
    end

    -- Special handling for colourised creatures (e.g. dyed sheep)
    if self.modified_colour and not self.has_been_sheared_flag then
        unimobs.petz_api.colourise_mob(self, self.modified_colour)
    end

    -- Special handling for mobs with horseshoes
    if self.horseshoe_count and self.horseshoe_count > 0 and not captured_mob_flag then

        unimobs.petz_api.apply_horseshoe_speed_bonus(
            self, (self.horseshoe_count * unimobs.petz_setting.horseshoe_speed_increase)
        )

    end

    -- Set the size of baby mobs
    if self.can_breed_flag then

        if born_as_baby_flag then
            self.is_baby_flag = unimobs.mobkit_api.add_mob_memory(self, "is_baby_flag", true)
        end

        if self.is_baby_flag then

            unimobs.petz_api.set_mob_properties(self, {
                collisionbox = self.collisionbox_baby,
                -- N.B. .selectionbox missing in original code
                selectionbox = self.selectionbox_baby,
                visual_size = self.visual_size_baby,
            })

        end

    end

    -- Handle nametags
    if self.is_pet_flag and self.is_tamed_flag then
        unimobs.petz_api.update_mob_nametag(self)
    end

    -- Initialise the Tamagotchi Mode timer, if the mob is compatible
    if self.has_tamagotchi_mode_flag then

        self.init_tamagotchi_timer_flag =
                unimobs.mobkit_api.add_mob_memory(self, "init_tamagotchi_timer_flag", true)

    end

    -- Process extension callbacks
    local callback_list = extension_table[self.mob_type]
    if callback_list ~= nil then

        for _, callback in ipairs(callback_list) do
            callback(self)
        end

    end

    -- Engage the mob's first behaviour
    if self.status then

        if self.status == "stand" and
                unilib.global.pkg_executed_table["mtb_order_stand_here"] ~= nil then
            unilib.pkg.mtb_order_stand_here.do_action(self)
        elseif self.status == "guard" and
                unilib.global.pkg_executed_table["mtb_order_guard"] ~= nil then
            unilib.pkg.mtb_order_guard.do_action(self)
        elseif self.status == "sleep" then
            self.status = unimobs.mobkit_api.add_mob_memory(self, "status", nil)
        elseif self.status == "alight" and
                unilib.global.pkg_executed_table["mtb_fly_alight"] ~= nil then
            unilib.pkg.mtb_fly_alight.do_action(self, 0, "alight")
        else
            self.status = unimobs.mobkit_api.add_mob_memory(self, "status", nil)
        end

    end

end
