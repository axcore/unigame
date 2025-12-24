---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_on_step.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Localise math functions (for speed)
local random = math.random

-- Textures to use as particles, when a mob has low affinity. An extra texture, in addition to this
--      list, is used to show hunger
local affinity_img_list = {
    "unilib_item_hairbrush.png",
    "unilib_ingredient_oil_beaver.png",
    "unilib_gui_petz_heartbreak.png",
}
local affinity_img_count = #affinity_img_list
-- The rates at which health and affinity warnings are shown (in Tamagotchi Mode); by using slightly
--      different values, we don't always show them at the same time
-- (In original code, the value was 2)
local health_warning_rate = 4
local affinity_warning_rate = 5

-- Table of entity IDs, and the particle texture chosen at random. Key-value pairs are added to
--      this table for a short time, replacing the original code's undocumented mob property
--      .temp_tamagotchi_img
local particle_table = {}

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_on_step.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.on_step_callback(self, dtime)

    -- From petz.on_step()
    -- Standard .on_step() callback for all petz-compatible mob entities

    local on_step_time = 1

    -- Check once per second (only)
    if unimobs.mobkit_api.check_main_timer(self, on_step_time) and not self.is_dead_flag then

        if self.init_tamagotchi_timer_flag then
            unimobs.petz_api.init_tamagotchi_timer(self)
        end

        if self.is_pregnant_flag then
            unimobs.petz_api.pregnant_timer(self, on_step_time)
        elseif self.is_in_cooldown_flag then
            unimobs.petz_api.cooldown_timer(self, on_step_time)
        elseif self.is_baby_flag then
            unimobs.petz_api.growth_timer(self, on_step_time)
        end

        if self.gallop_mode_flag then
            unimobs.petz_api.check_gallop_mode(self, on_step_time)
        end

        local lifespan = unimobs.petz_api.check_lifespan(self)
        if lifespan then
            unimobs.petz_api.lifespan_timer(self, lifespan, on_step_time)
        end

        if self.has_dreamcatcher_flag and self.back_home_flag then
            unimobs.petz_api.teleport_mob_back_home(self)
        end

        -- In Tamagotchi Mode, check health and affinity, showing particle effects when one or both
        --      needs the player's attention
        -- Note a potential source of confusion: both health and affinity can be increased by
        --      feeding the mob. Here, the icon used for low health has been changed to make the
        --      distinction a little clearer
        if unimobs.petz_setting.enable_tamagotchi_mode_flag and
                self.owner and
                self.is_pet_flag and
                unimobs.petz_setting.tamagotchi_warning_rate > 0 and
                self.status ~= "sleep" then

            -- Handle health
            if (self.hp / self.max_hp) <= unimobs.petz_setting.tamagotchi_warning_rate and
                    not unimobs.petz_api.get_msetting(self.mob_type, "feed_item_none_flag") and
                    unimobs.mobkit_api.check_main_timer(self, health_warning_rate) then

                unimobs.petz_api.show_standard_particles(
                    self.object:get_pos(), "hungry", "unilib_particle_petz_health.png"
                )

            end

            -- Handle affinity
            if (self.affinity / 100) <= unimobs.petz_setting.tamagotchi_warning_rate and
                    unimobs.mobkit_api.check_main_timer(self, affinity_warning_rate) then

                -- (Affinity can be increased by feeding the mob, or by grooming it with brushes and
                --      lotions, so use a random image)
                local img = affinity_img_list[random(1, affinity_img_count + 1)]
                if not img then

                    -- Decide which texture to show (but only need to do it once)
                    if not particle_table[self._id] then

                        -- (When the remix CSV specifies multiple items, use only the first one)
                        local feed_item =
                                unimobs.petz_api.get_msetting(self.mob_type, "feed_item_first")

                        if feed_item == nil or
                                feed_item == "" or
                                string.sub(feed_item, 1, 6) == "group:" or
                                not core.registered_items[feed_item] or
                                not core.registered_items[feed_item].inventory_image then
                            img = "unilib_misc_bowl_pet_inv.png"
                        else
                            img = core.registered_items[feed_item].inventory_image
                        end

                        -- (Was self.tmp_follow_texture)
                        particle_table[self._id] = img

                    else

                        img = particle_table[self._id]
                        particle_table[self._id] = nil

                    end

                end

                unimobs.petz_api.show_standard_particles(
                    self.object:get_pos(),
                    "hungry",
                    img
                )

            end

        end

    end

end
