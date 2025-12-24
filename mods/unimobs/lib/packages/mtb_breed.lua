---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_breed = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_breed.do_action(self)

    -- Adapted from petz.bh_breed()
    -- Called by several brain packages
    -- The specified mob must be male. If there is a suitable female nearby, she is impregnated

    -- The male ("self") searches for a female
    if self.can_breed_flag and self.is_in_rut_flag and self.is_male_flag then

        local female_name = "unilib:mob_" .. self.mob_type
        if self.parent_type_list ~= nil and #self.parent_type_list == 2 then

            -- N.B. .parent_type_list has a restricted usage; if specified, it must be in the form
            --      { FEMALE_TYPE, MALE_TYPE }
            female_name = "unilib:mob_" .. self.parent_type_list[1]

        end

        local female_obj = unimobs.mobkit_api.get_closest_entity(self, female_name)
        if female_obj then

            local female_luaent = female_obj:get_luaentity()
            if female_luaent and
                    female_luaent.is_in_rut_flag and
                    not female_luaent.is_pregnant_flag and
                    not female_luaent.is_male_flag then

                local max_mating_distance = unimobs.petz_api.get_msetting(
                    self.mob_type, "max_mating_distance"
                ) or 1

                -- If the female is nearby, impregnate her
                if vector.distance(self.object:get_pos(), female_luaent.object:get_pos()) <=
                        max_mating_distance then
                    unimobs.petz_api.breed_mob_naturally(female_luaent, self)
                end

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_breed.init()

    return {
        description = "Standard mob meta-behaviour: a male mob breeds with a nearby female mob",
    }

end
