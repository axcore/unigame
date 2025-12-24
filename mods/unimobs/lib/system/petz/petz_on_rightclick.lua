---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_on_rightclick.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Table of items, and the override functions to call when a mob is right-clicked with those items
-- Table in the form
--      override_table[wielded_name] = list_of_callbacks
-- Each callback should return either true or false:
--      true: action taken; do not do anything else
--      false: no action taken; process other overrides (if any), then do the standard behaviour
local override_table = {}

---------------------------------------------------------------------------------------------------
-- Shared API functions (original to unimobs)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.register_rightclick_override(wielded_name, callback)

    -- Original to unimobs
    -- Called by any package which wants to override the standard behaviour, when a mob is
    --      right-clicked with "wielded_name"

    if override_table[wielded_name] == nil then
        override_table[wielded_name] = { callback }
    else
        table.insert(override_table[wielded_name], callback)
    end

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_on_rightclick.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.on_rightclick_callback(self, clicker)

    -- From petz.on_rightclick()
    -- Standard .on_rightclick() callback for all petz-compatible mob entities

    if not clicker:is_player() then
        return false
    end

    local pname = clicker:get_player_name()

    local is_owner_flag
    if self.owner == pname then
        is_owner_flag = true
    else
        is_owner_flag = false
    end

    local wielded_item = clicker:get_wielded_item()
    local wielded_name = wielded_item:get_name()
    local show_form_flag = false
    local buy_flag = false

    -- Process overrides specified by calls to unimobs.petz_api.register_rightclick_override()
    local callback_list = override_table[wielded_name]
    if callback_list ~= nil then

        for _, callback in ipairs(callback_list) do

            if callback(self, clicker, wielded_item, wielded_name, is_owner_flag) == true then

                -- Override applied; do not apply any more overrides, and do not apply the standard
                --      behaviour
                return

            end

        end

    end

    -- No overrides were applied, so now apply the standard behaviour

    -- Handle feeding
    if unimobs.kitz_api.feed_mob(
        self,
        clicker,
        unimobs.petz_setting.tamagotchi_feed_hunger_rate,
        unilib.utils.capitalise_translation(
            S(
                "@1 is at full health (@2)",
                unimobs.petz_api.get_insertion(self.mob_type, "subject_the"),
                tostring(self.max_hp)
            )
        ),
        "moaning"
    ) then

        if unimobs.kitz_api.tame_mob(
            self,
            (
                unimobs.petz_api.get_msetting(self.mob_type, "custom_tame_count") or
                unimobs.petz_setting.default_tame_count
            ),
            pname,
            unilib.utils.capitalise_translation(
                S(
                    "@1 has been tamed!",
                    unimobs.petz_api.get_insertion(self.mob_type, "subject_the")
                )
            ),
            {
                max = unimobs.petz_setting.max_tamed_by_owner,
                count = #unimobs.kitz_api.get_active_mobs_by_owner(pname),
                msg = S(
                    "You cannot tame any more creatures! (maximum: @1)",
                    tostring(unimobs.petz_setting.max_tamed_by_owner)
                ),
            }
        ) then
            unimobs.petz_api.update_tamagotchi_mob_after_tame(self)
        end

        if self.is_tamed_flag then
            unimobs.petz_api.update_mob_nametag(self)
        end

        if unimobs.petz_setting.enable_tamagotchi_mode_flag and not self.has_been_fed_flag then
            unimobs.petz_api.update_tamagotchi_mob_after_feed(self)
        end

        -- Replenish the mob's milk, wool (etc), or do nothing
        unimobs.petz_api.replenish_mob(self, clicker)

    -- Handle conversions from one mob type to another
    elseif not unimobs.petz_api.get_msetting(self.mob_type, "convert_with_none_flag") and
            not unimobs.petz_api.is_string_empty(
                unimobs.petz_api.get_msetting(self.mob_type, "convert_to") or ""
            ) and unimobs.petz_api.check_lookup_table_in_msetting_by_group(
                self.mob_type, "convert_with_table", wielded_name
            ) then

        -- Convert one type of mob to another (e.g. converts wolves to dogs, using a bone)
        unimobs.petz_api.convert_mob(self, pname, wielded_name)

    -- Handle capturing mobs
    -- Note that when unimobs.petz_api.can_capture_mob_with_item() returns false it's a non-fatal
    --      error, but when unimobs.petz_api.can_capture_mob() returns it's a fatal error
    elseif unimobs.petz_api.can_capture_mob_with_item(self, wielded_name) then

        if not unimobs.petz_api.can_capture_mob(self, clicker, wielded_name, true) then
            return
        end

        -- The mob can be captured
        if self.owner == nil or
                self.owner == "" or
                (not is_owner_flag and unimobs.petz_setting.enable_mob_theft_flag) then

            unimobs.kitz_api.set_mob_owner(self, pname)
            unimobs.petz_api.update_tamagotchi_mob_after_tame(self)

        end

        unimobs.petz_api.capture_mob(self, clicker, wielded_name, true)

        if unimobs.setting.apply_tool_wear_flag and not unilib.utils.is_creative(pname) then

            wielded_item:add_wear(unimobs.constant.tool_wear)
            clicker:set_wielded_item(wielded_item)

        end

        core.chat_send_player(
            pname,
            unilib.utils.capitalise_translation(
                S(
                    "Your @1 has been captured",
                    unimobs.petz_api.get_insertion(self.mob_type, "subject")
                )
            )
        )

    -- Handle breeding
    elseif self.can_breed_flag and
            unimobs.petz_api.check_lookup_table_in_msetting_by_group(
                self.mob_type, "breed_item_table", wielded_name
            ) and not self.is_baby_flag then

        unimobs.petz_api.stimulate_mob_breeding(self, clicker, wielded_item)

    -- Handle colourised textures
    elseif unimobs.petz_api.get_custom_msetting(self.mob_type, "is_dyeable") and
            core.get_item_group(wielded_name, "dye") > 0  then

        local colour_group = unimobs.petz_api.get_colour_group(wielded_name)
        if colour_group and not self.has_been_sheared_flag then
            unimobs.petz_api.colourise_mob(self, colour_group)
        end

    -- Decide which formspec, if any, should be displayed for the mob
    elseif unimobs.petz_setting.enable_trade_flag and
            not core.is_singleplayer() and
            self.for_sale_flag and
            self.owner and
            self.owner ~= pname then

        show_form_flag = true
        buy_flag = true

    elseif is_owner_flag then

        if self.is_mountable_flag then

            show_form_flag = not unimobs.petz_api.interact_with_mountable_mob(
                self, clicker, wielded_item, wielded_name
            )

        else

            show_form_flag = true

        end

    end

    -- Show a formspec, if required
    if show_form_flag then

        unimobs.petz_global.formspec_player_table[pname] = self

        if not buy_flag then

            core.show_formspec(
                pname,
                "unilib:form_unimobs_standard_mob",
                unimobs.petz_api.create_standard_mob_form(pname)
            )

        else

            core.show_formspec(
                pname,
                "unilib:form_unimobs_buy_mob",
                unimobs.petz_api.create_buy_mob_form(pname)
            )

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Setup code (from petz/petz/api/api_on_rightclick.lua)
---------------------------------------------------------------------------------------------------

core.register_on_leaveplayer(function(player)
    unimobs.petz_global.formspec_player_table[player:get_player_name()] = nil
end)
