---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_settings.lua
--      Initialise the main table of settings from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.get_msetting(mob_type, mini_table_key)

    -- Original to unimobs
    -- Wrapper function to extract values from unimobs.petz_msetting, which is in the form
    --      petz_msetting[mob_type] = mini_table
    -- ...where "mob_type" is a string like "lion_normal"
    --
    -- If we try to access the key-value pairs in the "mini_table" directly, there's a risk that the
    --      "mini_table" doesn't exist at all, creating a crash; this function checks that
    --      "lion_normal" exists as key in unimobs.petz_msetting, before extracting the value
    --      matching "mini_table_key"

    if unimobs.petz_msetting[mob_type] == nil then
        return nil
    else
        return unimobs.petz_msetting[mob_type][mini_table_key]
    end

end

function unimobs.petz_api.initialise_msetting(mob_type, mini_table_key, mini_table_value)

    -- Original to unimobs
    -- Wrapper function to initialise a field in unimobs.petz_msetting, which is in the form
    --      petz_msetting[mob_type] = mini_table
    -- ...where "mob_type" is a string like "lion_normal"
    --
    -- The contents of unimobs.petz_msetting should be initialised by the the remix CSV. If a
    --      default value is required, a mob package can call this function to set that default
    --      value, in case the remix CSV didn't set a value at all
    -- However, this should be a rare occurence; compare
    --      unimobs.petz_api.initialise_custom_msetting(), which is called by mob packages in almost
    --      all cases, in order to set a default value
    --
    -- If unimobs.petz_msetting[mob_type] does not exist, it is created
    -- If unimobs.petz_msetting[mob_type][mini_table_key] already exists, it is not overwritten;
    --      this function returns false
    -- Otherwise, this function adds the specified key-value pair to the "mini_table", and returns
    --      true

    if unimobs.petz_msetting[mob_type] == nil then
        unimobs.petz_msetting[mob_type] = {}
    elseif unimobs.petz_msetting[mob_type][mini_table_key] ~= nil then
        return false
    end

    unimobs.petz_msetting[mob_type][mini_table_key] = mini_table_value
    return true

end

function unimobs.petz_api.check_msetting_by_group(mob_type, mini_table_key, check_value)

    -- Original to unimobs
    -- Wrapper function to test values from unimobs.petz_msetting, which is in the form
    --      petz_msetting[mob_type] = mini_table
    -- ...where "mob_type" is a string like "lion_normal"
    --
    -- If the specified "mob_type" or "mini_table_key" don't exist, we return false
    -- If the value corresponding to "mini_table_key" is a group name (e.g. "group:stick"), we
    --      assume that "check_value" is the name of an item (e.g. "unilib:item_stick_ordinary"),
    --      and return true if that item contains the group, false if not
    -- Otherwise, we just compare the value corresponding to "mini_table_key" directly, returning
    --      true if they're identical, false if not

    if unimobs.petz_msetting[mob_type] == nil then
        return false
    end

    local mini_table_value = unimobs.petz_msetting[mob_type][mini_table_key]
    if mini_table_value == nil then
        return false
    end

    if string.sub(mini_table_value, 1, 6) == "group:" then

        local group_name = string.sub(mini_table_value, 7)
        if core.get_item_group(check_value, group_name) > 0 then
            return true
        else
            return false
        end

    elseif mini_table_value == check_value then

        return true

    else

        return false

    end

end

function unimobs.petz_api.get_custom_msetting(mob_type, mini_table_key)

    -- Original to unimobs
    -- Wrapper function to extract values from the .custom_table field in unimobs.petz_msetting
    -- Table in the form
    --      petz_msetting[mob_type]["custom_table"] = mini_table
    -- ...where "mob_type" is a string like "lion_normal"
    --
    -- If we try to access the key-value pairs in the "mini_table" directly, there's a risk that the
    --      "mini_table" doesn't exist at all, creating a crash; this function checks that
    --      "lion_normal" exists as a key in unimobs.petz_msetting, before extracting the value
    --      matching "mini_table_key"

    if unimobs.petz_msetting[mob_type] == nil or
            unimobs.petz_msetting[mob_type]["custom_table"] == nil then
        return nil
    else
        return unimobs.petz_msetting[mob_type]["custom_table"][mini_table_key]
    end

end

function unimobs.petz_api.initialise_custom_msetting(mob_type, mini_table_key, mini_table_value)

    -- Original to unimobs
    -- Wrapper function to initialise a field of the .custom_table field in unimobs.petz_msetting
    -- Table in the form
    --      petz_msetting[mob_type]["custom_table"] = mini_table
    -- ...where "mob_type" is a string like "lion_normal"
    --
    -- The contents of unimobs.petz_msetting.custom_table should be initialised by the the remix
    --      CSV. If a default value is required, a mob package can call this function to set that
    --      default value, in case the remix CSV didn't set a value at all
    -- In almost all cases, mob packages should call this function to set a default value
    --
    -- If unimobs.petz_msetting[mob_type]["custom_table"] does not exist, it is created
    -- If unimobs.petz_msetting[mob_type]["custom_table"][mini_table_key] already exists, it is not
    --      overwritten; this function returns false
    -- Otherwise, this function adds the specified key-value pair to the .custom_table field, and
    --      returns true

    if unimobs.petz_msetting[mob_type] == nil then
        unimobs.petz_msetting[mob_type] = {}
    end

    if unimobs.petz_msetting[mob_type]["custom_table"] == nil then
        unimobs.petz_msetting[mob_type]["custom_table"] = {}
    elseif unimobs.petz_msetting[mob_type]["custom_table"][mini_table_key] ~= nil then
        return false
    end

    unimobs.petz_msetting[mob_type]["custom_table"][mini_table_key] = mini_table_value
    return true

end

function unimobs.petz_api.check_custom_msetting_by_group(mob_type, mini_table_key, check_value)

    -- Original to unimobs
    -- Wrapper function to test values from the .custom_table field in unimobs.petz_msetting
    -- Table in the form
    --      petz_msetting[mob_type]["custom_table"] = mini_table
    -- ...where "mob_type" is a string like "lion_normal"
    --
    -- If the specified "mob_type" or "mini_table_key" don't exist, we return false
    -- If the value corresponding to "mini_table_key" is a group name (e.g. "group:stick"), we
    --      assume that "check_value" is the name of an item (e.g. "unilib:item_stick_ordinary"),
    --      and return true if that item contains the group, false if not
    -- Otherwise, we just compare the value corresponding to "mini_table_key" directly, returning
    --      true if they're identical, false if not

    if unimobs.petz_msetting[mob_type] == nil or
            unimobs.petz_msetting[mob_type]["custom_table"] == nil then
        return nil
    end

    local mini_table_value = unimobs.petz_msetting[mob_type]["custom_table"][mini_table_key]
    if mini_table_value == nil then
        return false
    end

    if string.sub(mini_table_value, 1, 6) == "group:" then

        local group_name = string.sub(mini_table_value, 7)
        if core.get_item_group(check_value, group_name) > 0 then
            return true
        else
            return false
        end

    elseif mini_table_value == check_value then

        return true

    else

        return false

    end

end

function unimobs.petz_api.check_lookup_table_in_msetting(mob_type, mini_table_key, lookup_table_key)

    -- Original to unimobs
    -- Wrapper function to test whether the specified "lookup_table_key" exists in
    --      unimobs.petz_msetting, in the special situation in which the value corresponding to
    --      "mini_table_key" is a lookup table
    -- Table in the form
    --      petz_msetting[mob_type][mini_table][lookup_table]
    -- ...where "mob_type" is a string like "lion_normal", and "lookup_table" consists of a table
    --      of keys, whose values are irrelevant (in most cases, they should be set to true)
    --
    -- If we try to access the key-value pairs in the "lookup_table" directly, there's a risk that
    --      the "lookup_table" doesn't exist at all, creating a crash; this function checks that,
    --      before testing whether "lookup_table_key" exists in "lookup_table"

    if unimobs.petz_msetting[mob_type] == nil or
            unimobs.petz_msetting[mob_type][mini_table_key] == nil or
            unimobs.petz_msetting[mob_type][mini_table_key][lookup_table_key] == nil then
        return false
    else
        return true
    end

end

function unimobs.petz_api.check_lookup_table_in_msetting_by_group(
    mob_type, mini_table_key, lookup_table_key
)
    -- Original to unimobs
    -- Alternative to unimobs.petz_api.check_lookup_table_in_msetting(), in which we assume that the
    --      lookup table specified by "mob_type" and "mini_table_key" can contain either names of
    --      items (e.g. "unilib:item_stick_ordinary"), group names (e.g. "group:stick"), or some
    --      other arbitrary value
    --
    -- If the lookup table actually contains the specified "lookup_table_key", then return true, as
    --      before
    -- Otherwise, assume that "lookup_table_key" is the name of an item, and check the keys in that
    --      same table, returning true if a matching group is found

    if unimobs.petz_msetting[mob_type] == nil or
            unimobs.petz_msetting[mob_type][mini_table_key] == nil then
        return false
    elseif unimobs.petz_msetting[mob_type][mini_table_key][lookup_table_key] ~= nil then
        return true
    end

    for k, v in pairs(unimobs.petz_msetting[mob_type][mini_table_key]) do

        if string.sub(k, 1, 6) == "group:" then

            local group_name = string.sub(k, 7)
            if core.get_item_group(lookup_table_key, group_name) > 0 then
                return true
            end

        end

    end

    return false

end

---------------------------------------------------------------------------------------------------
-- Set up general settings
---------------------------------------------------------------------------------------------------

-- Was petz.settings.XXX
-- This table represents the default values of settings in petz/settings.lua, specified in that
--      file's "settings_def" table
-- Note that mob-specific settings are stored in unimobs.petz_msetting, and should be accessed via
--      a call to unimobs.petz_api.get_msetting(); see the comments in the "meta_petz_settings"
--      package
unimobs.petz_setting = {

    -- API settings
    -- N.B. The .type_api field has been removed; unimobs does not have different versions which are
    --      compatible with mobkit and mobs_redo, so this field is not required
--  type_api = core.settings:get("unimobs_petz_type_api") or "kitz",

    -- Settings specifying available mobs
    -- (N.B. .petz_list has been removed; use unimobs.petz_global.mob_table instead, which can be
    --      initialised via calls to unimobs.petz_api.register_mob() )
--  petz_list = core.settings:get("unimobs_petz_petz_list") or "",
    -- Whitespace-separated string of items, e.g. "lion_normal frog". Any mobs whose name
    --      (e.g. "unilib:mob_lion_normal") matches any of the items is removed from the world (see
    --      the code below for further details)
    remove_list = core.settings:get("unimobs_petz_remove_list") or "",
    -- (Was .disable_monsters)
    -- If true, monsters (mobs whose .is_monster_flag field is true) will not spawn
    disable_monsters_flag = core.settings:get_bool("unimobs_petz_disable_monsters_flag", false),

    -- Server cron task settings
    -- (Was .clear_mobs_time)
    -- If true, a cron job clears untamed mobs in the server from time to time; use the value 0 to
    --      disable it
    clear_untamed_mobs_interval =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_clear_untamed_mobs_interval") or 0,

    -- Behaviour settings
    -- (Was .speed_up)
    -- If true, some brain packages do fewer things, boosting overall performance; for example, in
    --      the "brain_herbivore" package, mobs will not search for a bowl or bale
    -- N.B. Default value was true in the original code
    streamline_behaviour_flag =
            core.settings:get_bool("unimobs_petz_streamline_behaviour_flag", false),
    -- (Not in original code)
    -- Flag set to true to enable the emergency suffocation recovery system (in the
    --      "mtb_rescue_suffocating_mob" package). If enabled, mobs trapped inside nodes are
    --      teleported to an adjacent node, but at the risk of them escaping from an enclosure
    enable_suffocation_recovery_flag =
            core.settings:get_bool("unimobs_petz_enable_suffocation_recovery_flag", true),
    -- (Not in original code)
    -- The "jump attack" behaviour is mobkit is less advanced than the one used in petz. If false,
    --      the "lqb_jump_attack" package uses the original code imported from mobkit; if true, it
    --      uses the more advanced code imported from petz
    use_petz_attack_flag = core.settings:get_bool("unimobs_petz_use_petz_attack_flag", true),

    -- Formspec settings
    -- (Not in original code)
    -- Flag set to true to show growth times (for babies and pregnant adults) in the main mob
    --      formspec
    show_formspec_time_flag = core.settings:get_bool("unimobs_petz_show_formspec_time_flag", true),
    -- Flag set to true to show the items used to repel, follow, feed, breed and capture mobs in the
    --      main mob formspec. Note that the actual items may be concealed (shown as "?") if
    --      unimobs.petz_setting.conceal_unused_items_flag is true
    show_formspec_items_flag =
            core.settings:get_bool("unimobs_petz_show_formspec_items_flag", true),
    -- In the main mob formspec, order buttons are usually shown in Tamagotchi Mode. Flag set to
    --      true to show the buttons for any mob which has the .obeys_orders_flag property
    force_formspec_orders_flag =
            core.settings:get_bool("unimobs_petz_force_formspec_orders_flag", true),
    -- (Not in original code)
    -- Flag set to true, if the item(s) used for repelling/following/feeding/breeding/capturing
    --      should be concealed in the mob's main formspec, until the player "discovers" them by
    --      using them. Note that items are never concealed in creative mode, regardless of the
    --      value of this flag
    conceal_unused_items_flag =
            core.settings:get_bool("unimobs_petz_conceal_unused_items_flag", false),

    -- Nametag background settings
    -- (Was .tag_background)
    -- Flag set to true to show nametag backgrounds
    enable_nametag_backgrounds_flag =
            core.settings:get_bool("unimobs_petz_enable_nametag_backgrounds_flag", false),

    -- Mob sound settings
    -- (Was .misc_sound_chance)
    -- How often mobs make one of their "misc" sounds at random
    random_sound_chance =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_random_sound_chance") or 50,
    -- Maximum hearing distance for mob sounds
    max_hear_distance = unimobs.mobkit_api.settings_get_int("unimobs_petz_max_hear_distance") or 8,

    -- Population control settings
    -- Maximum number of mobs that can be tamed by a player (use -1 for no limit)
    max_tamed_by_owner =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_max_tamed_by_owner") or -1,

    -- Mob spawning settings
    -- Average interval, in seconds, between spawn attempts for each player
    spawn_interval = unimobs.mobkit_api.settings_get_int("unimobs_petz_spawn_interval") or 30,
    -- (Was .spawn_chance)
    -- Default probability of spawning a mob, if there are no other objects in the area; value in
    --      the range 0-1. The "meta_petz_settings" package uses this value for any mobs which have
    --      a "custom_spawn_probability"
    -- N.B. In original code, this setting was ignored, and was given different values during
    --      initialisation - 0.3, 1.0 or 0.0
    spawn_probability =
            unimobs.mobkit_api.settings_get_float("unimobs_petz_spawn_probability") or 0.3,
    -- (Was .max_mobs)
    -- Max number of mobs in the active block range
    spawn_max_mobs = unimobs.mobkit_api.settings_get_int("unimobs_petz_spawn_max_mobs") or 60,
    -- (Was .max_per_species)
    -- Max number of mobs of the same mob type (matches .mob_type) in the active block range
    spawn_max_mobs_of_matching_type =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_spawn_max_mobs_of_matching_type") or
            10,
    -- (Was .no_spawn_in_protected)
    -- If true, mobs are not spawned in protected areas
    disable_spawn_in_protected_areas_flag =
            core.settings:get_bool("unimobs_petz_disable_spawn_in_protected_areas_flag", false),
    -- (Was .spawn_areas)
    -- If specified, a whitespace-separated string of items. Each item consists of two positions in
    --      the form (x,y,z);(x,y,z), e.g.
    --      "10,10,10;200,200,200 1000,1000,1000;1500,1500,1500"
    -- If specified, mobs only spawn in those areas; otherwise mobs can spawn anywhere
    exclusive_spawn_area_list = core.settings:get("unimobs_petz_exclusive_spawn_area_list") or "",

    -- Pathfinding settings
    -- (Was .jump_fences)
    -- If true, mobs can jump over fences
    enable_jump_over_fences_flag =
            core.settings:get_bool("unimobs_petz_enable_jump_over_fences_flag", false),
    -- (Was .out_doors)
    -- If true, mobs can pass through open doors and gates
    enable_pass_through_opening_flag =
            core.settings:get_bool("enable_pass_through_opening_flag", true),

    -- Default tame/lash/convert/replace settings
    -- (Not in original code)
    -- Default number of times needed to feed a mob, in order to tame it; minimum value 1
    -- N.B. replaces the original code's kitz.consts.DEFAULT_FEED_COUNT
    default_tame_count =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_default_tame_count") or 5,
    -- (Was .lashing_tame_count)
    -- Default number of times needed to lash a (wild) mob, in order to tame it; minimum value 1
    -- N.B. replaces the original code's petz.settings.lashing_tame_count
    default_lash_count =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_default_lash_count") or 3,
    -- (Not in original code)
    -- Default number of times needed to feed a mob, in order to convert it into another kind of
    --      mob; minimum value 1
    default_convert_count =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_default_convert_count") or 5,
    -- (Not in original code)
    -- Default number of times a mob needs to replace a node, in order to change its status (e.g.
    --      number of grass nodes to replace, in order for a sheep to regrow its wool or a cow to
    --      refill its milk); minimum value 1
    default_replace_count =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_default_replace_count") or 5,

    -- Breeding system settings
    -- (Was .pregnant_count)
    -- Default maximum number of pregnancies for any mob which doesn't specify its own value
    -- N.B. In original code, applied only to camels and ponies
    default_pregnancy_count =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_default_pregnancy_count") or 5,
    -- (Was .pregnancy_time)
    -- Time in seconds from the start of a pregnancy to the creation of the baby mob
    -- N.B. In original code, the interval is fixed; the name of this setting reflects the fact that
    --      the actual interval may be adjusted, depending on circumstances
    -- N.B. After a pregnancy, a female mob has a cooldown period which is typically half of this
    --      value
    default_pregnancy_interval =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_default_pregnancy_interval") or 300,
    -- (Was .growth_time)
    -- Time in seconds from the creation of the baby mob and its conversion into an adult
    default_baby_growth_interval =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_default_baby_growth_interval") or
            1200,
    -- (Not in original code)
    -- When breeding, the chance of producing a creature with a rare "mutation" skin. Must be an
    --      integer; a value of 200 represents a probability of 1/200 (0.5%)
    mutation_chance = unimobs.mobkit_api.settings_get_int("unimobs_petz_mutation_chance") or 200,
    -- (Not in original code)
    -- Breeding bonus. When a baby is produced, the chance of a ranged "gene" randomly receiving a
    --      +1 bonus (maximum one bonus per baby, use the value 0 to disable bonuses altogether)
    breeding_bonus_chance =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_breeding_bonus_chance") or 10,
    -- (Was .seed_only_owners)
    -- If true, only owners can use a syringe to extract seed from compatible mobs
    -- N.B. In the original code, this setting is ignored; unimobs code uses it as originally
    --      intended
    disable_non_owner_syringe_flag =
            core.settings:get_bool("unimobs_petz_disable_non_owner_syringe_flag", true),
    -- N.B. The .disable_syringe field has been removed; to disable the use of syringes, remove the
    --      "item_syringe_glass" package from your remix
--  disable_syringe = false,
--  disable_syringe = core.settings:get_bool("unimobs_petz_disable_syringe", false),

    -- Genetics system settings
    -- (Not in original code)
    -- If true, the "docility" gene is enabled (tamed mothers have a chance of giving birth to tamed
    --      adults); if false, tamed mothers always give birth to tamed babies
    enable_genetic_docility_flag =
            core.settings:get_bool("unimobs_petz_enable_genetic_docility_flag", true),
    -- (Not in original code)
    -- The maximum factor by which the mob's .max_speed can be improved with the "agility" gene.
    --      Mobs whose .max_speed doesn't exceed the default value specified in
    --      unimobs.petz_api.register_standard_mob() are not affected. Mounted speeds have separate
    --      genes, so they are not affected by the "agility" gene
    -- Use a value of 0 to disable the "agility" gene altogether
    genetic_agility_factor =
            unimobs.mobkit_api.settings_get_float("unimobs_petz_genetic_agility_factor") or 0.2,
    -- (Not in original code)
    -- The maximum factor by which the number of lashes required for taming a wild animal is
    --      reduced in mobs with the "compliance" gene
    -- (By default, 3 lashings are required, so a factor of 0.67 reduces that requirement to 1
    --      lashing)
    -- Use a value of 0 to disable the "compliance" gene altogether
    genetic_compliance_factor =
            unimobs.mobkit_api.settings_get_float("unimobs_petz_genetic_compliance_factor") or 0.67,
    -- (Not in original code)
    -- The maximum factor by which the amount of food required for taming, converting and replacing
    --      is reduced in mobs with the "digestion" gene
    -- (By default, 5 food items are required, so a factor of 0.4 reduces that requirement to 3
    --      food items)
    -- Use a value of 0 to disable the "digestion" gene altogether
    genetic_digestion_factor =
            unimobs.mobkit_api.settings_get_float("unimobs_petz_genetic_digestion_factor") or 0.4,
    -- (Not in original code)
    -- The maximum factor by which the pregnancy/growth times are reduced in mobs with the
    --      "fertility" gene. This value also increases the maximum number of pregnancies that a
    --      female mob can have
    -- Use a value of 0 to disable the "fertility" gene altogether
    genetic_fertility_factor =
            unimobs.mobkit_api.settings_get_float("unimobs_petz_genetic_fertility_factor") or 0.33,
    -- (Not in original code)
    -- The maximum factor by which the probability of producing dung can be improved with the
    --      "incontinence" gene
    -- Use a value of 0 to disable the "incontinence" gene altogether
    genetic_incontinence_factor =
            unimobs.mobkit_api.settings_get_float("unimobs_petz_genetic_incontinence_factor") or
            0.5,
    -- (Not in original code)
    -- The maximum factor by which the mob's .max_roam_height can be improved with the "loftiness"
    --      gene. Mobs whose .max_roam_height doesn't exceed the default value specified in
    --      unimobs.petz_api.register_standard_mob() are not affected
    -- Use a value of 0 to disable the "loftiness" gene altogether
    genetic_loftiness_factor =
            unimobs.mobkit_api.settings_get_float("unimobs_petz_genetic_loftiness_factor") or 1.0,
    -- (Not in original code)
    -- The maximum factor by which the probability of getting a breeding bonus can be improved with
    --      the "luckiness" gene
    -- Use a value of 0 to disable the "luckiness" gene altogether
    genetic_luckiness_factor =
            unimobs.mobkit_api.settings_get_float("unimobs_petz_genetic_luckiness_factor") or 0.2,
    -- (Not in original code)
    -- The maximum factor by which the mob's .view_range can be improved with the "perception" gene.
    --      Mobs whose .view_range doesn't exceed the default value specified in
    --      unimobs.petz_api.register_standard_mob() are not affected
    -- Use a value of 0 to disable the "perception" gene altogether
    genetic_perception_factor =
            unimobs.mobkit_api.settings_get_float("unimobs_petz_genetic_perception_factor") or 0.4,
    -- (Not in original code)
    -- The maximum factor by which the probability of laying an egg can be improved with the
    --      "productivity" gene. The value also increases the maximum number of eggs that can be
    --      laid. Cannot be used with ants
    -- Use a value of 0 to disable the "productivity" gene altogether
    genetic_productivity_factor =
            unimobs.mobkit_api.settings_get_float("unimobs_petz_genetic_productivity_factor") or
            0.33,
    -- (Not in original code)
    -- The maximum factor by which the mob's .jump_height can be improved with the "springiness"
    --      gene. Mobs whose .jump_height doesn't exceed the default value specified in
    --      unimobs.petz_api.register_standard_mob() are not affected
    -- Use a value of 0 to disable the "springiness" gene altogether
    genetic_springiness_factor =
            unimobs.mobkit_api.settings_get_float("unimobs_petz_genetic_springiness_factor") or 0.2,
    -- (Not in original code)
    -- The maximum factor by which the mob's .max_hp can be improved with the "toughness" gene. Mobs
    --      whose .max_hp doesn't exceed the default value specified in
    --      unimobs.petz_api.register_standard_mob() are not affected
    -- Use a value of 0 to disable the "toughness" gene altogether
    genetic_toughness_factor =
            unimobs.mobkit_api.settings_get_float("unimobs_petz_genetic_toughness_factor") or 0.2,
    -- (Not in original code)
    -- The maximum factor by which the probability of getting a mutation can be improved with the
    --      "variability" gene
    -- Use a value of 0 to disable the "variability" gene altogether
    genetic_variability_factor =
            unimobs.mobkit_api.settings_get_float("unimobs_petz_genetic_variability_factor") or
            0.25,

    -- Lifespan settings
    -- (Was .lifetime)
    -- Lifespan of mobs, in seconds. Use the value -1 to disable lifespans
    default_lifespan = unimobs.mobkit_api.settings_get_int("unimobs_petz_default_lifespan") or -1,
    -- (Was .lifetime_variability)
    -- Variability in individual lifespans; a value in the range 0-1
    lifespan_variability =
            unimobs.mobkit_api.settings_get_float("unimobs_petz_lifespan_variability") or 0.2,
    -- (Was .lifetime_only_non_tamed)
    -- If true, lifespans are disabled for all mobs with the property .is_tamed_flag = true
    disable_lifespan_for_tamed_mobs_flag =
            core.settings:get_bool("unimobs_petz_disable_lifespan_for_tamed_mobs_flag", false),
    -- (Was .lifetime_avoid_non_breedable)
    -- If true, lifespans are disabled for all mobs with the property .can_breed_flag = true
    disable_lifespan_for_breeding_mobs_flag =
            core.settings:get_bool("unimobs_petz_disable_lifespan_for_breeding_mobs_flag", false),

    -- Egg laying settings
    -- (Was .lay_egg_timing)
    -- Interval in seconds before laying eggs (subject to a random increase/decrease of up to 20%)
    -- The default value of 1200 equates to one egg per day
    lay_egg_interval = unimobs.mobkit_api.settings_get_int("unimobs_petz_lay_egg_interval") or 1200,
    -- Max eggs laid by any individual mob
    max_laid_eggs = unimobs.mobkit_api.settings_get_int("unimobs_petz_max_laid_eggs") or 10,
    -- (Was .hatch_egg_timing)
    -- Interval in seconds required to hatch an egg (subject to a random increase/decrease of up to
    --      20%)
    hatch_egg_interval =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_hatch_egg_interval") or 500,
    -- (Original to unimobs)
    -- Interval in seconds required to hatch a node egg (in the original code, produced only by ants
    --      and geckos; subject to a random increase/decrease of up to 20%)
    hatch_node_egg_interval =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_hatch_node_egg_interval") or 250,
    -- (Not in original code)
    -- The maximum size of a stack for mob eggs (minimum value 1)
    egg_stack_size = unimobs.mobkit_api.settings_get_int("unimobs_petz_egg_stack_size") or 16,

    -- Mob capture settings
    -- (Was .lasso)
    -- Whitespace-separated string of items that can be used as lassos (to capture compatible mobs)
    lasso_list = core.settings:get("unimobs_petz_lasso_list") or "unilib:tool_lasso_normal",
    -- (Not in original code)
    -- Whitespace-separated strings of items that can be used as nets (to capture compatible mobs).
    --      Includes compatibility with items from minetest_game and mobs_redo
    animal_net_list =
            core.settings:get("unimobs_petz_animal_net_list") or "unilib:item_net_animal mobs:net",
    bug_net_list = core.settings:get("unimobs_petz_bug_net_list") or
            "unilib:item_net_bug fireflies:bug_net",
    -- (Not in original code)
    -- Whitespace-separated string of items that can be used as lashes (to tame compatible mobs)
    lash_list = core.settings:get("unimobs_petz_lash_list") or "unilib:item_whip_obedience",
    -- (Was .rob_mobs)
    -- If true, lassos/nets can be used to capture mobs that belong to other players
    enable_mob_theft_flag = core.settings:get_bool("unimobs_petz_enable_mob_theft_flag", false),

    -- Shears settings
    -- (Was .shears)
    -- Whitespace-separated string of items that can be used as shears
    shears_list = core.settings:get("unimobs_petz_shears_list") or "unilib:tool_shears_steel",

    -- Damage settings
    -- (Was .check_enable_damage)
    -- If true, checks the engine's "enable_damage" setting; if that setting is false, disables
    --      damage for all mobs in unimobs.petz_global.mob_table
    disable_damage_in_peaceful_worlds_flag =
            core.settings:get_bool("unimobs_petz_disable_damage_in_peaceful_worlds_flag", false),
    -- (Was .no_damage_in_protected)
    -- If true, disables damage in protected areas for all mobs in unimobs.petz_global.mob_table
    disable_damage_in_protected_areas_flag =
            core.settings:get_bool("unimobs_petz_disable_damage_in_protected_areas_flag", false),
    -- Damage in air (for aquatic mobs)
    air_damage = unimobs.mobkit_api.settings_get_int("unimobs_petz_air_damage") or 1,
    -- Damage from fire, lava and other igniters
    igniter_damage = unimobs.mobkit_api.settings_get_int("unimobs_petz_igniter_damage") or 1,
    -- Amount of damage dealt by the Jack-O'-Lantern Grenade
    pumpkin_grenade_damage =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_pumpkin_grenade_damage") or 8,

    -- Combat/death aesthetics settings
    -- (Was .death_effect)
    -- If true, show particles when a mob dies
    enable_death_particles_flag =
            core.settings:get_bool("unimobs_petz_enable_death_particles_flag", true),
    -- (Was .colorize_punch)
    -- If true, the mob is colourised when punched
    colourise_on_punch_mob_flag =
            core.settings:get_bool("unimobs_petz_colourise_on_punch_mob_flag", true),
    -- (Was .punch_color)
    -- The colour to use, when colourising a punched mob
    punched_mob_colour = core.settings:get("unimobs_petz_punched_mob_colour") or "#FF0000",
    -- (Was .blood)
    -- If true, blood particles are displayed when a mob is punched. As in the original code, set to
    --      false by default for the benefit of younger players
    show_blood_on_punch_mob_flag =
            core.settings:get_bool("unimobs_petz_show_blood_on_punch_mob_flag", false),

    -- Fly behaviour settings
    -- (Was .fly_check_time)
    -- Interval in seconds between changes to a flying mob's behaviour (used by the "lqb_fly_wander"
    --      package)
    check_fly_behaviour_interval =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_check_fly_behaviour_interval") or 3,
    -- (Not in original code)
    -- Some birds (parrots and toucans) can perch on a player's shoulder; the interval in seconds
    --      after which the bird automatically detaches itself
    detach_from_shoulder_interval =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_detach_from_shoulder_interval") or
            120,

    -- "look_at" behaviour settings
    -- (Was .look_at)
    -- If true, enable the high-level behaviour, "hqb_look_at"
    enable_look_at_behaviour_flag =
            core.settings:get_bool("unimobs_petz_enable_look_at_behaviour_flag", true),
    -- (Was .look_at_random)
    -- Chance of engaging the "hqb_look_at" behaviour; a value of 10 corresponds to once per 10
    --      seconds
    look_at_behaviour_chance =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_look_at_behaviour_chance") or 10,

    -- Mountable mob settings (ponies, camels etc)
    -- (Was .pointable_driver)
    -- True if the "driver" of a pony (etc) is pointable
    mounted_driver_is_pointable_flag =
            core.settings:get_bool("unimobs_petz_mounted_driver_is_pointable_flag", true),
    -- (Was .gallop_time)
    -- Maximum time (in seconds) for gallop mode
    max_gallop_time = unimobs.mobkit_api.settings_get_int("unimobs_petz_max_gallop_time") or 20,
    -- (Was .gallop_recover_time)
    -- Recovery time (in seconds) after gallop mode
    gallop_recovery_time =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_gallop_recovery_time") or 60,
    -- (Not in original code)
    -- A value representing the absolute maximum speed of mounted creatures (ponies, camels) etc
    --      before any bonuses/penalties are applied (due to horseshoes, etc). The value is 10 by
    --      default; change it only if you really need a pony that can run unrealistically fast/slow
    --      (minimum value 0, representing the slowest possible speed)
    -- The minimum/maximum values specified in the mob's .genetic_init_list are relative to this
    --      value
    -- For example (and assuming that this value is still 10), if the range specified by
    --      .genetic_init_list is 0-10, then the creature's possible speeds are
    --      [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    -- If that range is changed to 0-5, then the creature's possible speeds are [0, 2, 4, 6, 8, 10].
    --      If that range is changed to 0-20, then the creature's possible speeds are
    --      [0, 0.5, 1, 1.5, ... ]
    max_mounted_speed = unimobs.mobkit_api.settings_get_int("unimobs_petz_max_mounted_speed") or 10,
    -- (Was .horseshoe_speedup)
    -- The increase in speed for ponies (etc) with horseshoes; a value of 0.2 represents a 20%
    --      increase in speed
    horseshoe_speed_increase =
            unimobs.mobkit_api.settings_get_float("unimobs_petz_horseshoe_speed_increase") or 0.2,

    -- Sleep settings
    -- (Was .sleeping)
    -- True to enable compatible mobs to fall asleep
    enable_sleeping_flag = core.settings:get_bool("unimobs_petz_enable_sleeping_flag", true),

    -- Herding and shepherding settings
    -- (Was .herding)
    -- If true, herdring behaviours are enabled
    enable_herding_flag = core.settings:get_bool("unimobs_petz_enable_herding_flag", true),
    -- (Not in original code)
    -- When spawning, the maximum herd size (for compatible creatures). To disable herds, use the
    --      value 1
    max_spawn_herd_size =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_max_spawn_herd_size") or 5,
    -- (Was .herding_timing)
    -- Chance of engaging the "mtb_find_herd" behaviour; a value of 3 corresponds to once per 3
    --      seconds
    herding_behaviour_chance =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_herding_behaviour_chance") or 3,
    -- (Was .herding_members_distance)
    -- Maximum distance between a mob and the nearest mob of the same type, before the herding
    --      behaviour can be engaged
    herding_max_distance =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_herding_max_distance") or 5,
    -- (Was .herding_shepherd_distance)
    -- Maximum distance between a mob and player wielding a shepherd's crook, before the following
    --      behaviour can be engaged
    shepherd_max_distance =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_shepherd_max_distance") or 5,

    -- Straggle behind parents settings
    -- (Was .parent_search)
    -- If true, baby mobs straggle (follow behind) their parents (in original code, only used by
    --      chickens; in unimobs, used by many different mobs)
    enable_straggle_flag = core.settings:get_bool("unimobs_petz_enable_straggle_flag", true),

    -- Trade settings
    -- (Was .selling)
    -- If true, enable mob trading
    enable_trade_flag = core.settings:get_bool("unimobs_petz_enable_trade_flag", true),
    -- (Not in original code)
    -- The maximum number of items that can be traded for a mob
    max_trade_items = unimobs.mobkit_api.settings_get_int("unimobs_petz_max_trade_items") or 99,
    -- (Was .selling_exchange_items)
    -- Whitespace-separated string of items. The specified items, if any, can be traded for mobs
    -- (N.B. .selling_exchange_items_list has been removed)
    trade_item_list = core.settings:get("unimobs_petz_trade_item_list") or "unilib:metal_copper_lump default:copper_lump unilib:metal_copper_ingot default:copper_ingot unilib:metal_iron_lump default:iron_lump unilib:metal_steel_ingot default:steel_ingot unilib:metal_gold_lump default:gold_lump unilib:metal_gold_ingot default:gold_ingot unilib:mineral_diamond_gem default:diamond",

    -- Dung settings
    -- (Was .poop)
    -- If true, mobs with the .dung_name property produce dung
    enable_dung_flag = core.settings:get_bool("unimobs_petz_enable_dung_flag", true),
    -- (Was .poop_rate)
    -- The average rate at which a compatible mob produces dung; a value in seconds
    average_dung_production_rate =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_average_dung_production_rate") or 600,
    -- (Was .poop_decay)
    -- The average rate at which dung decays; a value in seconds
    average_dung_decay_rate =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_average_dung_decay_rate") or 1200,

    -- Tamagotchi mode settings
    -- Applies to all mobs whose .is_tamed_flag and .init_tamagotchi_timer_flag properties are both
    --      true; it therefore applies to a much greater selection of mobs than the three mentioned
    --      in the original documentation
    -- When enabled, compatible mobs must be receive attention from a player. All compatible mobs
    --      must be fed. Some compatible mobs must be brushed, and others lashed. Failure to do this
    --      decreases the mob's "affinity" for its owner. When affinity reaches zero, the mob loses
    --      its ".is_tamed_flag = true" status
    -- Tamagotchi mode influences (hunger/brushing/lashing) don't apply when the mob is standing on
    --      certain nodes (see below)
    -- (Was .tamagochi_mode)
    -- If true, Tamagotchi Mode applies to compatible mobs
    enable_tamagotchi_mode_flag =
            core.settings:get_bool("unimobs_petz_enable_tamagotchi_mode_flag", true),
    -- (Was .tamagochi_check_time)
    -- The time in seconds between checks on Tamagotchi Mode influences for each mob. The default
    --      value, 2400, corresponds to two game days; meaning that a tamed creature must be fed/
    --      brushed/lashed at least once during that time
    tamagotchi_update_interval =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_tamagotchi_update_interval") or 2400,
    -- (Was .tamagochi_reduction_factor)
    -- Factor that can be increased or decreased from the default value of 0.3, in order to
    --      increase or decrease the rate at which the mob's affinity changes in Tamagotchi Mode
    tamagotchi_affinity_reduction_factor = unimobs.mobkit_api.settings_get_float(
        "unimobs_petz_tamagotchi_affinity_reduction_factor"
    ) or 0.3,
    -- (Was .tamagochi_punch_rate)
    -- The rate at which a mob's affinity decreases in Tamagotchi Mode, when punched by its owner.
    --      The default value of 0.3 represents a 30% decrease
    tamagotchi_punch_rate =
            unimobs.mobkit_api.settings_get_float("unimobs_petz_tamagotchi_punch_rate") or 0.3,
    -- (Was .tamagochi_feed_hunger_rate)
    -- The rate at which a mob's affinity AND hunger increase/reduces in Tamagotchi Mode, when fed
    --      (or not fed) by its owner. The default value of 0.3 represents a 30% change
    tamagotchi_feed_hunger_rate =
            unimobs.mobkit_api.settings_get_float("unimobs_petz_tamagotchi_feed_hunger_rate") or
            0.3,
    -- (Was .tamagochi_brush_rate, .tamagochi_beaver_oil_rate)
    -- The rate at which a mob's affinity increases/decreases in Tamagotchi Mode, when groomed (or
    --      not groomed) by its owner, using a brush or lotion. The default value of 0.2 represents
    --      a 20% change
    tamagotchi_groom_rate =
            unimobs.mobkit_api.settings_get_float("unimobs_petz_tamagotchi_groom_rate") or 0.2,
    -- (Was .tamagochi_lashing_rate)
    -- The rate at which a mob's affinity decreases in Tamagotchi Mode, when not lashed by its
    --      owner. The default value of 0.2 represents a 20% decrease
    tamagotchi_lash_rate =
            unimobs.mobkit_api.settings_get_float("unimobs_petz_tamagotchi_lash_rate") or 0.2,
    -- (Was .tamagochi_hungry_warning)
    -- The proportion of the mob's maximum health/affinity, below which a warning will be shown in
    --      Tamagotchi Mode (as particles). Use the value 0 to disable warnings
    tamagotchi_warning_rate =
            unimobs.mobkit_api.settings_get_float("unimobs_petz_tamagotchi_warning_rate") or 0.5,
    -- (Was .tamagochi_check_if_player_online)
    -- If true, Tamagotchi Mode only applies to a mob on a multi-player server, when the mob's owner
    --      is online
    tamagotchi_require_online_owner_flag =
            core.settings:get_bool("unimobs_petz_tamagotchi_require_online_owner_flag", true),
    -- (Was .tamagochi_safe_nodes)
    -- Whitespace-separated string of nodes (see the code below for an example value). Tamagotchi
    --      mode influences such as hunger don't apply to a mob when it's standing on of these nodes
    tamagotchi_safe_node_list = core.settings:get("unimobs_petz_tamagotchi_safe_node_list") or
            "unilib:unilib_misc_shelter_kennel_floor unilib:misc_shelter_cage_floor",

    -- Ant and bee settings
    -- N.B. Moved to unimobs.petz_msetting["ant_queen"].lay_egg_interval
--  lay_antegg_timing =
--          unimobs.mobkit_api.settings_get_int("unimobs_petz_lay_antegg_timing") or 1200,
    -- N.B. Moved to unimobs.petz_msetting["ant_queen"].max_laid_eggs
--  ant_max_laid_eggs = unimobs.mobkit_api.settings_get_int("unimobs_petz_ant_max_laid_eggs") or 50,
    -- N.B. Moved to unimobs.petz_msetting["ant_queen"].max_population
--  ant_population = unimobs.mobkit_api.settings_get_int("unimobs_petz_ant_population") or 5,
    -- (Not in original code)
    -- Interval in seconds required to establish a colony (ant nest or bee hive, subject to a random
    --      increase/decrease of up to 20%)
    establish_colony_interval =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_establish_colony_interval") or 120,

    -- Beehive settings
    -- (Was .initial_honey_beehive)
    -- Amount of honey in a newly-constructed beehive
    beehive_initial_honey =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_beehive_initial_honey") or 3,
    -- (Original to unimobs)
    -- Maximum amount of pollen in a beehive; when the actual amount of pollen reaches this value,
    --      it's converted into 1 honey. The original code generated 1 honey for every flower
    --      visited by a returning bee; unimobs generates (by default) 1 honey for every 3 flowers
    --      visited. To restore the original behaviour, use the value 1
    beehive_max_pollen =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_beehive_max_pollen") or 3,
    -- (Was .max_honey_beehive)
    -- Maximum amount of honey in a beehive
    beehive_max_honey = unimobs.mobkit_api.settings_get_int("unimobs_petz_beehive_max_honey") or 10,
    -- (Was .max_bees_beehive)
    -- Maximum number of bees attached to a beehive
    beehive_max_bees = unimobs.mobkit_api.settings_get_int("unimobs_petz_beehive_max_bees") or 3,
    -- (Was .bee_outing_ratio)
    -- Chance that a bee will leave the hive to find pollen, every time the check is performed. A
    --      value of 1 means that the bee leaves immediately
    beehive_dispatch_chance =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_beehive_dispatch_chance") or 20,
    -- (Was .worker_bee_delay)
    -- The time in seconds between a beehive, artificially crafted by the player, being placed in
    --      the world, and a worker bee being automatically created for it
    beehive_create_first_worker_delay =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_beehive_create_first_worker_delay") or
            300,
    -- (Original to unimobs)
    -- Average time in seconds, after which a worker bee without a hive dies. Use the value 0 to
    --      force a worker bee's death immediately after the destruction of its hive
    beehive_doomed_worker_delay =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_beehive_doomed_worker_delay") or 30,
    -- (Was .protect_beehive)
    -- Flag set to true, if beehives "belong" to the player that placed them
    beehive_protected_flag = core.settings:get_bool("unimobs_petz_beehive_protected_flag", false),

    -- Misc item settings
    -- (Was .cobweb_decay)
    -- Non-randomised interval after which thrown cobwebs disappear, in seconds
    cobweb_decay_interval =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_cobweb_decay_interval") or 1200,
    -- (Was .back_home_distance)
    -- Used with tamed mobs which have dreamcatchers, when the player has enabled the "Automatic go
    --      home" button in the mob's main formspec. If the distance between the specified home
    --      position and the mob's current position is greater than this value, then the mob is
    --      automatically teleported back to the specified home position
    -- The same value is available for use elsewhere in any code that wants to call
    --      unimobs.petz_api.teleport_mob_back_home()
    teleport_back_home_distance =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_teleport_back_home_distance") or 50,
    -- (Was .disable_kennel)
    -- If true, placement of mob shelters is disabled (but its constituent blocks will still exist
    --      in the game). In the original code, this setting was used only with dog kennels (see the
    --      "misc_shelter_kennel" package for the intended usage)
    disable_shelter_placement_flag =
            core.settings:get_bool("unimobs_petz_disable_shelter_placement_flag", false),
    -- N.B. Moved to a local variable in the "machine_wheel_spinning" package
--  silk_to_bobbin = unimobs.mobkit_api.settings_get_int("unimobs_petz_silk_to_bobbin") or 3,

    -- Curse of Lycanthropy settings
    -- (N.B. .lycanthropy has been removed; load or don't load the "shared_petz_lycanthropy"
    --      package instead
    -- (Was .lycanthropy_infection_chance_by_wolf)
    -- Chance of a wolf infecting a player with the Curse of Lycanthropy
    lycanthropy_wolf_infection_chance =
            unimobs.mobkit_api.settings_get_int("unimobs_petz_lycanthropy_wolf_infection_chance") or
            200,
    -- (Was .lycanthropy_infection_chance_by_werewolf)
    -- Chance of a werewolf infecting a player with the Curse of Lycanthropy
    lycanthropy_werewolf_infection_chance = unimobs.mobkit_api.settings_get_int(
        "unimobs_petz_lycanthropy_werewolf_infection_chance"
    ) or 10,
    -- Players infected with the Curse of Lycanthropy take less damage; a value of 0.5 represents
    --      a reduction of 50% in the amount of damage taken
    lycanthropy_damage_reduction_factor = unimobs.mobkit_api.settings_get_float(
        "unimobs_petz_lycanthropy_damage_reduction_factor"
    ) or 0.5,
}

-- Convert whitespace-separated strings into lists
-- (The .exclusive_spawn_area_list field, commented out in the original code's petz.conf, did not
--      exist in petz.settings at that point; but it does exist in our unimobs.petz_setting)
for _, setting in ipairs({
    "exclusive_spawn_area_list",
    "lasso_list",
    "animal_net_list",
    "bug_net_list",
    "lash_list",
    "remove_list",
    "shears_list",
    "tamagotchi_safe_node_list",
    "trade_item_list",
}) do

    local new_list = {}
    for item in string.gmatch(unimobs.petz_setting[setting], "%S+") do
        table.insert(new_list, item)
    end

    unimobs.petz_setting[setting] = new_list

end

-- (Need to wait for other mods to load, before checking that the specified items actually exist)
core.after(0.1, function()

    -- unimobs.petz_setting.trade_item_list might be a long list (compared to other lists of items
    --      which might contain only one or two items)
    -- We can make code elsewhere a bit simpler, by removing anything that doesn't exist in the game
    local new_list = {}
    for _, full_name in ipairs(unimobs.petz_setting.trade_item_list) do

        local def_table = core.registered_items[full_name]
        if def_table and def_table.description then
            table.insert(new_list, full_name)
        end

    end

    unimobs.petz_setting.trade_item_list = new_list

    -- N.B. Fix a bug in original code: if there's nothing in the exchange list, then don't let
    --      code elsewhere (particularly the form code) trade anyhting
    if #new_list == 0 then
        unimobs.petz_setting.enable_trade_flag = false
    end

end)

-- The contents of the .remove_list setting are added to the global variable
for _, item in ipairs(unimobs.petz_setting.remove_list) do
    table.insert(unimobs.petz_global.mob_remove_list, item)
end
