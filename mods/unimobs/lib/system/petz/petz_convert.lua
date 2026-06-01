---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_convert.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_convert.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.convert_mob(self, pname, wielded_name)

    -- From petz.convert()
    -- Called by unimobs.petz_api.on_rightclick_callback()
    -- Converts one type of mob to another (e.g. converts wolves to dogs, using a wielded bone)
    -- In unimobs.petz_msetting, the .convert_with_table (etc) fields specify the item needed to do
    --      the conversion (e.g. a bone), and the .convert_to field specifies the new mob (e.g. a
    --      wolf)
    -- "pname" is a compulsory argument, but "wielded_name" is optional

    self.convert_countdown = unimobs.mobkit_api.add_mob_memory(
        self, "convert_countdown", self.convert_countdown - 1
    )

    -- N.B. In creative mode, the mob would die before the countdown reaches 0, so require just one
    --      converting item
    if self.convert_countdown <= 0 or unilib.utils.is_creative(pname) then

        -- Enough items have been received (but we don't reset the countdown, as the original mob
        --      will be swapped for another)

        local pos = unimobs.petz_api.refine_spawn_position(self.mob_type, self.object:get_pos())

        local convert_to, converted_mob
        convert_to = unimobs.petz_api.get_msetting(self.mob_type, "convert_to")
        if convert_to ~= nil then
            converted_mob = core.add_entity(pos, convert_to)
        end

        if not converted_mob then

            -- The new mob was not created; artificially set the old mob's property so that the
            --      user can try again (perhaps after adjusting code and/or remix CSVs)
            self.convert_countdown = unimobs.mobkit_api.add_mob_memory(self, "convert_countdown", 1)

        else

            unimobs.kitz_api.make_sound(
                "object", converted_mob, "unilib_pop_petz", unimobs.petz_setting.max_hear_distance
            )

            local converted_luaent = converted_mob:get_luaentity()
            converted_luaent.is_tamed_flag =
                    unimobs.mobkit_api.add_mob_memory(converted_luaent, "is_tamed_flag", true)
            converted_luaent.owner =
                unimobs.mobkit_api.add_mob_memory(converted_luaent, "owner", pname)

            -- N.B. Set new mob properties for unimobs, replacing properties which were not used
            --      anywhere in the original code (see the comments in petz_init_prop.lua)
            converted_luaent.converted_from = unimobs.mobkit_api.add_mob_memory(
                converted_luaent, "converted_from", self.mob_type
            )

            -- ("wielded_name" is an optional argument to this function)
            if wielded_name then

                converted_luaent.converted_with = unimobs.mobkit_api.add_mob_memory(
                    converted_luaent, "converted_with", wielded_name
                )

            else

                converted_luaent.converted_with = unimobs.mobkit_api.add_mob_memory(
                    converted_luaent, "converted_with", nil
                )

            end

            -- Destory the original mob...
            unimobs.kitz_api.remove_mob(self)

            -- ...and show a confirmation
            core.chat_send_player(
                pname,
                unilib.utils.capitalise_translation(
                    S(
                        "@1 turns into @2",
                        unimobs.petz_api.get_insertion(self.mob_type, "subject_the"),
                        unimobs.petz_api.get_insertion(converted_luaent.mob_type, "object_an")
                    )
                )
            )

            -- Update awards, if available
            if unilib.global.pkg_executed_table["award_zoologist"] ~= nil then

                unilib.pkg.award_zoologist.on_mob_convert(
                    core.get_player_by_name(pname), self, converted_luaent
                )

            end

        end

    else

        core.chat_send_player(
            pname,
            unilib.utils.capitalise_translation(
                S(
                    "@1 is turning into another kind of creature",
                    unimobs.petz_api.get_insertion(self.mob_type, "subject_the")
                )
            )
        )

        unimobs.kitz_api.make_sound(
            "object",
            self.object,
            "unilib_mob_" .. self.generic_type .. "_moaning",
            unimobs.petz_setting.max_hear_distance
        )

        unimobs.petz_api.show_standard_particles(self.object:get_pos(), "heart")

    end

end
