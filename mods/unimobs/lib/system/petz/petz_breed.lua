---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_breed.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Localise math functions (for speed)
local ceil = math.ceil
local max = math.max
local min = math.min
local random = math.random

---------------------------------------------------------------------------------------------------
-- Local functions - misc (original to unimobs)
---------------------------------------------------------------------------------------------------

local function adjust_time_by_fertility(self, interval)

    -- Original to unimobs
    -- Reduces the default time interval for a pregnancy or the baby growth stage, "interval",
    --      depending on the value of the specified mob's "fertility" gene

    -- From comments in petz_settings.lua:
    -- Use a value of 0 to disable the "fertility" gene altogether
    if unimobs.petz_setting.genetic_fertility_factor == 0 then
        return interval
    end

    local genetic_value = self.genetic_table["fertility"]
    local data_table = unimobs.petz_api.get_genetic_range_table(self, "fertility")
    if genetic_value == nil or genetic_value == 0 or data_table == nil then
        return interval
    end

    local reduction_factor = unimobs.petz_setting.genetic_fertility_factor * (
        (genetic_value - data_table.overall_min) /
        (data_table.overall_max - data_table.overall_min)
    )

    -- i.e. if the interval is to be reduced by 15% (reduction_factor = 0.15), then multiply the
    --      specified "interval" by 0.85
    local new_interval = interval * (1 - reduction_factor)
    -- For aesthetics in the formspecs, return an integer value (minimum 1)
    return ceil(new_interval) or 1

end

---------------------------------------------------------------------------------------------------
-- Shared API functions - misc (original to unimobs)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.get_genetic_range(self, gene_type)

    -- Original to unimobs
    -- Convenience function to look up the current value of the specified gene in the specified mob
    --      according to its .genetic_table, and also the gene's minimum/maximum values
    --
    -- Returns three values, in the form:
    --      current_value, min_value, max_value
    -- If the specified "gene_type" isn't recognised, uses a fallback value of 1
    -- If the specified "gene_type" isn't of the category "range" (meaning that it isn't some value
    --      in a range between a minimum and maximum), then min_value and max_value have the same
    --      value as current_value

    if not self.petz_compat_flag then

        -- Fallback values
        return 1, 1, 1

    end

    local genetic_value = self.genetic_table[gene_type]
    if genetic_value == nil then
        return 1, 1, 1
    end

    local data_table = unimobs.petz_api.get_genetic_range_table(self, gene_type)
    if data_table == nil then

        -- Not a gene_type of the category "range"
        return genetic_value, genetic_value, genetic_value

    end

    return genetic_value, data_table.overall_min, data_table.overall_max

end

---------------------------------------------------------------------------------------------------
-- Shared API functions - misc (from petz/petz/api/api_breed.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.compose_pregnant_icon(self)

    -- From petz.compose_pregnant_icon()
    -- Returns a combined image, consisting of the spawn egg with a heart overlay in one corner

    return "[combine:16x16:0,0=unilib_spawnegg_" .. self.mob_type ..
            ".png:0,0=unilib_gui_petz_pregnant_overlay.png"

end

function unimobs.petz_api.get_genetic_range_table(self, gene_type)

    -- Original to unimobs
    -- Convenience function to extract a table of values from unimobs.petz_global.mob_table, giving
    --      the minimum/maximum values for genes of the category "range"
    -- Returns nil if the table doesn't exist; otherwise returns a table in the form:
    --
    --      {
    --          initial_min = value,
    --          initial_max = value,
    --          overall_min = value,
    --          overall_max = value,
    --      }

    if not self.petz_compat_flag then
        return
    end

    local data_table = unimobs.petz_global.mob_table[self.mob_type]
    if data_table == nil or data_table["genetic_range_table"][gene_type] == nil then
        return
    else
        return data_table["genetic_range_table"][gene_type]
    end

end

function unimobs.petz_api.is_mob_fertile(self)

    -- From petz.is_fertile()
    -- Returns true if the mob can become pregnant, or false if it has had too many pregnancies
    --      already
    -- This function must be called in context (in other words, having already checked other
    --      properties such as .is_male_flag); this function only checks self.pregnancy_countdown

    if self.pregnancy_countdown > 0 then
        return true
    else
        return false
    end

end

---------------------------------------------------------------------------------------------------
-- Shared API functions - initiate breeding (from petz/petz/api/api_breed.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.stimulate_mob_breeding(self, clicker, wielded_item, wielded_name)

    -- From petz.breed()
    -- Called by unimobs.petz_api.on_rightclick_callback() when the mob is right-clicked with a
    --      suitable item
    -- Puts the mob into "search for a mate" (rut) mode
    -- "wielded_item" is optional; if specified, it is consumed

    local is_fertile_flag = unimobs.petz_api.is_mob_fertile(self)

    if is_fertile_flag and not self.is_in_rut_flag and not self.is_pregnant_flag then

        if wielded_item then

            wielded_item:take_item()
            clicker:set_wielded_item(wielded_item)

        end

        self.is_in_rut_flag = unimobs.mobkit_api.add_mob_memory(self, "is_in_rut_flag", true)

        unimobs.petz_api.show_standard_particles(self.object:get_pos(), "heart")
        unimobs.kitz_api.make_sound(
            "object",
            self.object,
            "unilib_mob_" .. self.generic_type .. "_moaning",
            unimobs.petz_setting.max_hear_distance
        )

        -- Register the discovery of the correct feeding item
        unimobs.kitz_api.register_discovered_item(clicker, self.mob_type, "breed", wielded_name)

    else

        local pname = clicker:get_player_name()
        if self.is_in_rut_flag then
            core.chat_send_player(pname, S("This creature is already searching for a mate"))
        elseif not is_fertile_flag then
            core.chat_send_player(pname, S("This creature is infertile"))
        elseif self.is_pregnant_flag then
            core.chat_send_player(pname, S("This creature is already pregnant"))
        end

    end

end

function unimobs.petz_api.breed_mob_naturally(mother, father)

    -- Adapted from petz.bh_breed()
    -- Called from unilib.pkg.mtb_breed.do_action() when a male is close enough to a female to
    --      impregnate her (and when both are ready for breeding)

    -- Update properties
    father.is_in_rut_flag = unimobs.mobkit_api.add_mob_memory(father, "is_in_rut_flag", false)

    mother.is_in_rut_flag = unimobs.mobkit_api.add_mob_memory(mother, "is_in_rut_flag", false)
    mother.is_pregnant_flag = unimobs.mobkit_api.add_mob_memory(mother, "is_pregnant_flag", true)
    mother.pregnancy_countdown = unimobs.mobkit_api.add_mob_memory(
        mother, "pregnancy_countdown", mother.pregnancy_countdown - 1
    )

    mother.pregnant_max_time = unimobs.mobkit_api.add_mob_memory(
        mother,
        "pregnant_max_time",
        adjust_time_by_fertility(mother, unimobs.petz_setting.default_pregnancy_interval)
    )

    -- The mother receives a copy of the father's "genes", for later use when the baby mob is
    --      generated
    unimobs.petz_api.set_heritable_traits_from_father(mother, father.genetic_table)

    unimobs.petz_api.show_standard_particles(
        mother.object:get_pos(),
        "pregnant",
        unimobs.petz_api.compose_pregnant_icon(mother)
    )

end

function unimobs.petz_api.breed_mob_with_implement(mother, father_genetic_table)

    -- Adapted from petz.pony_breed()
    -- Alternative to unimobs.petz_api.breed_mob_naturally(), when the impregnation is done with an
    --      implement (such as a syringe)
    -- "father_genetic_table" is a table of "genes" to be passed to the mother, for later use when
    --      the baby mob is generated

    mother.is_pregnant_flag = unimobs.mobkit_api.add_mob_memory(mother, "is_pregnant_flag", true)
    mother.pregnancy_countdown = unimobs.mobkit_api.add_mob_memory(
        mother, "pregnancy_countdown", mother.pregnancy_countdown - 1
    )
    mother.pregnant_max_time = unimobs.mobkit_api.add_mob_memory(
        mother,
        "pregnant_max_time",
        adjust_time_by_fertility(mother, unimobs.petz_setting.default_pregnancy_interval)
    )

    unimobs.petz_api.set_heritable_traits_from_father(mother, father_genetic_table)

    -- N.B. Fixed broken particle effect name in original code
    unimobs.petz_api.show_standard_particles(
        mother.object:get_pos(), "pregnant", unimobs.petz_api.compose_pregnant_icon(mother)
    )

end

function unimobs.petz_api.interrupt_mob_breeding(self, clicker)

    -- Original to unimobs
    -- Called by code in the "admin_tool_mob_interrupter" package
    -- Cancels a mob's rut mode or the mob's pregnancy

    local pname = clicker:get_player_name()
    if self.is_in_rut_flag then

        self.is_in_rut_flag = unimobs.mobkit_api.add_mob_memory(self, "is_in_rut_flag", false)
        core.chat_send_player(pname, S("This creature is no longer looking for a mate"))

    elseif self.is_pregnant_flag then

        self.is_pregnant_flag = unimobs.mobkit_api.add_mob_memory(self, "is_pregnant_flag", false)
        self.pregnancy_countdown = unimobs.mobkit_api.add_mob_memory(
            self, "pregnancy_countdown", self.pregnancy_countdown + 1
        )
        self.pregnant_time = unimobs.mobkit_api.add_mob_memory(self, "pregnant_time", 0)
        self.pregnant_max_time = unimobs.mobkit_api.add_mob_memory(self, "pregnant_max_time", 0)
        core.chat_send_player(pname, S("This creature is no longer pregnant"))

    elseif self.is_in_cooldown_flag then

        self.is_in_cooldown_flag = unimobs.mobkit_api.add_mob_memory(
            self, "is_in_cooldown_flag", false
        )
        core.chat_send_player(pname, S("This creature is no longer recovering from pregnancy"))

    end

end

---------------------------------------------------------------------------------------------------
-- Shared API functions - handle pregnancy (from petz/petz/api/api_breed.lua)
---------------------------------------------------------------------------------------------------

local function adjust_pos_for_new_mob(self)

    -- Adapted from petz.childbirth() and .growth_timer()

    local pos = self.object:get_pos()
    pos.y = pos.y + 1.01

    return pos

end

local function inherit_genetics_from_parents(self, baby_entity)

    -- Original to unimobs
    -- Set the baby mob's genetics from the father (self.father_genetic_table) and mother (a copy
    --      of which is already in self.genetic_table)

    -- Import the initial list of genetics for this mob
    local mob_type = baby_entity.mob_type
    if not unimobs.petz_global.mob_table[mob_type] or
            not unimobs.petz_global.mob_table[mob_type]["genetic_init_list"] then
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
    -- "gene_type" is a unique name for the gene, and "gene_name" is a translated string suitable
    --      for display in formspecs
    bonus_list = {}

    local genetic_init_list = unimobs.petz_global.mob_table[mob_type]["genetic_init_list"]
    for _, mini_list in ipairs(genetic_init_list) do

        local gene_type = mini_list[1]
        local category = mini_list[3]
        local initial_min = mini_list[4]
        local overall_min = mini_list[6] or 0
        local overall_max = mini_list[7]

        if category == "default" or category == "list" then

            -- Randomly inherit either the father's or mother's "gene". If by any chance the "gene"
            --      is missing from either parent, then just inherit from the other parent
            -- (The mother's "genes" are already in self.genetic_table, so we only need to modify it
            --      when inheriting from the father)
            if self.genetic_table[gene_type] ~= nil and
                    self.father_genetic_table[gene_type] ~= nil then

                if random(1, 2) == 1 then
                    baby_entity.genetic_table[gene_type] = self.father_genetic_table[gene_type]
                end

            elseif self.father_genetic_table[gene_type] ~= nil then

                baby_entity.genetic_table[gene_type] = self.father_genetic_table[gene_type]

            elseif self.genetic_table[gene_type] == nil then

                -- Emergency fallback, use the initial_value
                baby_entity.genetic_table[gene_type] = initial_min

            end

        -- For "range" values, randomly increase, decrease or retain the value (so that the player
        --      must breed many generations, in order to get the best stats)
        -- N.B. Not in original code: once in a blue moon, give it a bonus point
        elseif category == "range" then

            -- For ranged numerical values, the base value is not larger or smaller than the range
            --      specified by the parents
            local mother_val = self.genetic_table[gene_type]
            local father_val = self.father_genetic_table[gene_type]
            local base_val

            if mother_val ~= nil and father_val ~= nil then
                base_val = random(min(mother_val, father_val), max(mother_val, father_val))
            elseif father_val ~= nil then
                base_val = father_val
            else
                base_val = mother_val or initial_mi
            end

            -- On top of that, apply a random variation (so that the final value can be outside the
            --      range specified by the parents)
            local new_value = base_val + random(-1, 1)

            -- The final value must not exceed the overall minimum/maximum
            if new_value < overall_min then
                new_value = overall_min
            elseif overall_max ~= nil and new_value > overall_max then
                new_value = overall_max
            end

            baby_entity.genetic_table[gene_type] = new_value

            -- This "gene" is elligible for a breeding bonus
            table.insert(bonus_list, gene_type)

        end

    end

    -- Occasionally apply a breeding bonus to "range" genes
    --[[
    if unimobs.petz_setting.breeding_bonus_chance > 0 and
            #bonus_list > 0 and
            random(1, unimobs.petz_setting.breeding_bonus_chance) then

        local bonus_gene_type = bonus_list[random(1, #bonus_list)]
        baby_entity.genetic_table[bonus_gene_type] = baby_entity.genetic_table[bonus_gene_type] + 1

    end
    ]]--
    if unimobs.petz_setting.breeding_bonus_chance > 0 and #bonus_list > 0 then

        -- The luckiness gene can improve the chances of receiving a breeding bonus (a little)
        local chance = unimobs.petz_setting.breeding_bonus_chance

        local genetic_value = self.genetic_table["luckiness"]
        local data_table = unimobs.petz_api.get_genetic_range_table(self, "luckiness")
        if genetic_value ~= nil and genetic_value > 0 and data_table ~= nil then

            local reduction_factor = unimobs.petz_setting.genetic_luckiness_factor * (
                (genetic_value - data_table.overall_min) /
                (data_table.overall_max - data_table.overall_min)
            )

            -- If the value is to be reduced by 15% (reduction factor = 0.15), then multiply it by
            --      0.85
            chance = chance * (1 - reduction_factor)

        end

        if random(1, chance) then

            local bonus_gene_type = bonus_list[random(1, #bonus_list)]
            baby_entity.genetic_table[bonus_gene_type] =
                    baby_entity.genetic_table[bonus_gene_type] + 1

        end

    end

end

local function update_mob_properties_after_pregnancy(self)

    -- Was end_pregnancy()

    self.is_pregnant_flag = unimobs.mobkit_api.add_mob_memory(self, "is_pregnant_flag", false)
    self.pregnant_time = unimobs.mobkit_api.add_mob_memory(self, "pregnant_time", 0)
    self.pregnant_max_time = unimobs.mobkit_api.add_mob_memory(self, "pregnant_max_time", 0)

end

local function create_baby_entity(self)

    -- From petz.childbirth()
    -- Called by unimobs.petz_api.pregnant_timer() to create the baby entity from the specified
    --      mother mob ("self")
    -- Returns the entity, or nil on failure

    local baby_name = "unilib:mob_" .. self.mob_type
    if self.baby_type_list ~= nil and #self.baby_type_list > 0 then
        baby_name = "unilib:mob_" .. self.baby_type_list[random(1, #self.baby_type_list)]
    end

    -- Prepare the baby mob's properties
    local baby_prop_table = {}
    baby_prop_table.born_as_baby_flag = true
    baby_prop_table.genetic_table = {}

    -- Prepare the properties for skins
    -- As described in the comments in petz_init_prop.lua, the choice of skin is inherited from
    --      parents; in the unlikely case that the parents table of genes are missing, use fallback
    --      values
    if self.father_genetic_table then

        baby_prop_table.genetic_table.father_skin_a_num = self.father_genetic_table.skin_a_num
        baby_prop_table.genetic_table.father_skin_b_num = self.father_genetic_table.skin_b_num

    else

        -- Fallback values. Original code chose a random skin, but that makes mutation skins much
        --      more probable; just use the default skin
        baby_prop_table.genetic_table.father_skin_a_num = 1
        baby_prop_table.genetic_table.father_skin_b_num = 1

    end

    if self and self.genetic_table then

        baby_prop_table.genetic_table.mother_skin_a_num = self.genetic_table.skin_a_num
        baby_prop_table.genetic_table.mother_skin_b_num = self.genetic_table.skin_b_num

    else

        baby_prop_table.genetic_table.mother_skin_a_num = 1
        baby_prop_table.genetic_table.mother_skin_b_num = 1

    end

    local pos = adjust_pos_for_new_mob(self)

    -- Create the baby mob
    local baby_obj = core.add_entity(pos, baby_name, core.serialize(baby_prop_table))
    if baby_obj then

        update_mob_properties_after_pregnancy(self)

        unimobs.kitz_api.make_sound(
            "object", baby_obj, "unilib_pop_petz", unimobs.petz_setting.max_hear_distance
        )

        -- Retrieve the corresponding entity, and tweak its properties
        local baby_luaent = baby_obj:get_luaentity()

        baby_luaent.is_baby_flag =
                unimobs.mobkit_api.add_mob_memory(baby_luaent, "is_baby_flag", true)
        baby_luaent.generation_count = unimobs.mobkit_api.add_mob_memory(
            baby_luaent, "generation_count", baby_luaent.generation_count + 1
        )
        baby_luaent.baby_growth_max_time = unimobs.mobkit_api.add_mob_memory(
            baby_luaent,
            "baby_growth_max_time",
            adjust_time_by_fertility(
                baby_luaent,
                unimobs.petz_setting.default_baby_growth_interval
            )
        )

        --[[
        -- A tamed parent produces a tamed baby
        if self.owner ~= nil and self.owner ~= "" then

            baby_luaent.is_tamed_flag =
                    unimobs.mobkit_api.add_mob_memory(baby_luaent, "is_tamed_flag", true)
            baby_luaent.owner =
                    unimobs.mobkit_api.add_mob_memory(baby_luaent, "owner", self.owner)

        end
        ]]--
        -- If the setting is enabled, a tamed mother has a chance to produce a tamed baby; if the
        --      setting is disabled, tamed mothers always produce tamed babies
        if self.owner ~= nil and self.owner ~= "" then

            local tame_baby_flag = false
            if not unimobs.petz_setting.enable_genetic_docility_flag then

                tame_baby_flag = true

            else

                local genetic_value = self.genetic_table["docility"]
                local data_table = unimobs.petz_api.get_genetic_range_table(self, "docility")

                -- N.B. Since the setting is true, mothers without the "docility" gene never produce
                --      tamed babies
                if genetic_value ~= nil and data_table ~= nil then

                    if genetic_value >= data_table.overall_max or random() < (
                        (genetic_value - data_table.overall_min) /
                        (data_table.overall_max - data_table.overall_min)
                    ) then
                        tame_baby_flag = true
                    end

                end

            end

            if tame_baby_flag then

                baby_luaent.is_tamed_flag =
                        unimobs.mobkit_api.add_mob_memory(baby_luaent, "is_tamed_flag", true)
                baby_luaent.owner =
                        unimobs.mobkit_api.add_mob_memory(baby_luaent, "owner", self.owner)

            end

        end

        return baby_luaent

    else

        return nil

    end

end

function unimobs.petz_api.pregnant_timer(self, dtime)

    -- From petz.pregnant_timer()
    -- Called by unimobs.petz_api.on_step_callback() at regular intervals
    -- When it's time to end the pregnancy, create the baby mob

    -- N.B. Not in original code - check the mob is still pregnant, for example because of a call to
    --      unimobs.petz_api.interrupt_mob_breeding()
    if not self.is_pregnant_flag then

        update_mob_properties_after_pregnancy(self)
        return

    end

    -- Original code
    self.pregnant_time =
            unimobs.mobkit_api.add_mob_memory(self, "pregnant_time", self.pregnant_time + dtime)
    if self.pregnant_time >= self.pregnant_max_time then

        local baby_entity = create_baby_entity(self)
        if not baby_entity then

            core.chat_send_player(
                self.owner or "",
                unilib.utils.capitalise_translation(
                    S(
                        "@1 has miscarried",
                        unimobs.petz_api.get_insertion(self.mob_type, "subject_the")
                    )
                )
            )

            update_mob_properties_after_pregnancy(self)

        else

            inherit_genetics_from_parents(self, baby_entity)
            unimobs.petz_api.update_mob_properties_from_genetics(baby_entity)

        end

        -- Whether or not a baby was produced, initiate a cooldown period (but note that there's no
        --      cooldown period initated in the code above)
        -- Note also that the cooldown period if half the pregnancy time
        self.is_in_cooldown_flag =
                unimobs.mobkit_api.add_mob_memory(self, "is_in_cooldown_flag", true)
        self.cooldown_max_time = unimobs.mobkit_api.add_mob_memory(
            self,
            "cooldown_max_time",
            (adjust_time_by_fertility(self, unimobs.petz_setting.default_pregnancy_interval) / 2)
        )

    end

end

---------------------------------------------------------------------------------------------------
-- Shared API functions - handle cooldowns (original to unimobs)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.cooldown_timer(self, dtime)

    -- Original to unimobs
    -- Called by unimobs.petz_api.on_step_callback() at regular intervals
    -- When it's time to end the cooldown period (following a pregnancy), update the female mob's
    --      properties

    -- N.B. Not in original code - check the mob is still in a cooldown, for example because of a
    --      call to unimobs.petz_api.interrupt_mob_breeding()
    if not self.is_in_cooldown_flag then

        self.is_in_cooldown_flag =
                unimobs.mobkit_api.add_mob_memory(self, "is_in_cooldown_flag", false)
        return

    end

    -- Original code
    self.cooldown_time =
            unimobs.mobkit_api.add_mob_memory(self, "cooldown_time", self.cooldown_time + dtime)
    if self.cooldown_time >= self.cooldown_max_time then

        self.is_in_cooldown_flag =
                unimobs.mobkit_api.add_mob_memory(self, "is_in_cooldown_flag", false)
        self.cooldown_max_time =
                unimobs.mobkit_api.add_mob_memory(self, "cooldown_max_time", 0)

    end

end

---------------------------------------------------------------------------------------------------
-- Shared API functions - handle baby growth (from petz/petz/api/api_breed.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.growth_timer(self, dtime)

    -- From petz.growth_timer()
    -- Called by unimobs.petz_api.on_step_callback() at regular intervals
    -- When it's time to convert the baby into an adult, go ahead and convert it

    self.baby_growth_time = unimobs.mobkit_api.add_mob_memory(
        self, "baby_growth_time", (self.baby_growth_time or 0) + dtime
    )
    if self.baby_growth_time >= self.baby_growth_max_time then

        self.is_baby_flag = unimobs.mobkit_api.add_mob_memory(self, "is_baby_flag", false)
        self.baby_growth_max_time =
                unimobs.mobkit_api.add_mob_memory(self, "baby_growth_max_time", 0)

        local pos = adjust_pos_for_new_mob(self)
        self.object:set_pos(pos)

        -- N.B. Unlike the original code, if the baby's mob type is to be the same as the parent
        --      then we don't need to replace the entity
        local new_mob_type = self.mob_type
        if self.parent_type_list ~= nil and #self.parent_type_list == 2 then

            -- N.B. .parent_type_list has a restricted usage; if specified, it must be in the form
            --      { FEMALE_TYPE, MALE_TYPE }
            if self.is_male_flag then
                new_mob_type = self.parent_type_list[2]
            else
                new_mob_type = self.parent_type_list[1]
            end

        end

        local obj
        if new_mob_type ~= self.mob_type then

            -- Baby and adult have a different mob type; the previous entity must be replaced with
            --      a new one
            local old_owner = self.owner
            local old_genetic_table = self.genetic_table
            local old_generation_count = self.generation_count

            unimobs.kitz_api.remove_mob(self)

            obj = core.add_entity(pos, "unilib:mob_" .. new_mob_type)
            if not obj then
                return
            end

            -- Preserve ownership (just as we do during calls to create_baby_entity() )
            -- (N.B. This did not happen in the original code)
            local luaent = obj:get_luaentity()
            if old_owner ~= nil and old_owner ~= "" then

                luaent.is_tamed_flag =
                        unimobs.mobkit_api.add_mob_memory(luaent, "is_tamed_flag", true)
                luaent.owner = unimobs.mobkit_api.add_mob_memory(luaent, "owner", old_owner)

            end

            -- Preserve genetics, as far as possible
            -- The functions set_genetics() and .update_mob_properties_from_genetics() (both in
            --      petz_init_prop.lua) have already been called; overwrite them with any "genes"
            --      that existed in the baby mob
            local genetic_init_list =
                    unimobs.petz_global.mob_table[new_mob_type]["genetic_init_list"]
            if genetic_init_list then

                local new_genetic_table = {}
                for _, mini_list in ipairs(genetic_init_list) do

                    local gene_type = mini_list[1]
                    if old_genetic_table[gene_type] ~= nil and
                            luaent.genetic_table[gene_type] ~= nil then
                        new_genetic_table[gene_type] = old_genetic_table[gene_type]
                    end

                end

                -- (Doesn't matter if "new_genetic_table" is empty)
                unimobs.petz_api.set_heritable_traits(luaent, new_genetic_table)

            end

            -- Preserve the generation count
            if old_generation_count ~= nil and old_generation_count > 0 then

                luaent.generation_count = unimobs.mobkit_api.add_mob_memory(
                    luaent, "generation_count", old_generation_count
                )

            end

        else

            -- Baby and adult have the same mob type; no need to replace the entity
            obj = self.object
            unimobs.petz_api.set_mob_properties(self, {
                collisionbox =
                        unimobs.petz_global.mob_table[self.mob_type]["collisionbox"],
                jump = false,
                is_baby_flag = false,
                visual_size = unimobs.petz_global.mob_table[self.mob_type]["visual_size"],
            })

        end

        local vel = obj:get_velocity()
        vel.y = vel.y + 4.0
        obj:set_velocity(vel)

        unimobs.kitz_api.make_sound(
            "object", obj, "unilib_pop_petz", unimobs.petz_setting.max_hear_distance
        )

    end

end

---------------------------------------------------------------------------------------------------
-- Shared API functions - update heritable traits (from petz/petz/api/api_breed.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.set_heritable_traits(self, data_table)

    -- Original to unimobs
    -- Convenience function for adding key-value pairs to the mob's .genetic_table, and the memory
    --      associated with it

    for key, value in pairs(data_table) do
        self.genetic_table[key] = value
    end

    unimobs.mobkit_api.add_mob_memory(self, "genetic_table", self.genetic_table)

end

function unimobs.petz_api.set_heritable_traits_from_father(self, data_table)

    -- Oriqinal to unimobs
    -- Convenience function for adding key-value pairs to the mob's .father_genetic_table, and the
    --      memory associated with it

    for key, value in pairs(data_table) do
        self.father_genetic_table[key] = value
    end

    unimobs.mobkit_api.add_mob_memory(self, "father_genetic_table", self.father_genetic_table)

end
